import io.threadcso._
import scala.math._
import scala.collection.mutable._
import scala.language.postfixOps

/* A trait that specifies what a matrix multiplier is */
trait Multiplier{
  def multiply(n: Int,
      a: Array[Array[Int]],
      b: Array[Array[Int]]) : Array[Array[Int]]
}

/* A multiplier that operates sequentially */
object Sequential_multiplier extends Multiplier{
  def multiply(n: Int,
      a: Array[Array[Int]],
      b: Array[Array[Int]]) = {
    require(a.size == n && b.size == n &&
      a(0).size == n && b(0).size == n)

    val c = Array.fill(n)(Array.fill(n)(0))
    for(i <- 0 until n)
      for(k <- 0 until n){
        c(i)(k) = 0
        for(j <- 0 until n)
          c(i)(k) += a(i)(j) * b(j)(k)
      }
    c
  }
}

/* This is a Gen-eric Par-allel Mult-iplier.
 * This multiplier considers computing the inner
 * products of some rows and some columns a task.
 * I have not defined the collector here, as there are two
 * different ways of collecting, with different performance
 * benefits. */
abstract class Gen_par_mult(nChunks: Int, nWorkers: Int)
        extends Multiplier{
  /* Task(ileft, iright, kleft, kright) represents that we should
   * calculate the submatrix that contains positions (i, k) that satisfy
   * ileft <= i < iright && kleft <= k < kright */
  case class Task(ileft: Int, iright:Int, kleft:Int, kright:Int)

  /* TaskAnswer(i, j, r) represents that
   * c(i)(j) should be r */
  case class TaskAnswer(i: Int, j: Int, res: Int)

  /* A bag of tasks. It splits the lines and columns into sets of chunks,
   * computes the cartesian product of these, and assigns each
   * pair of line chunk and column chunk to a task. */
  private class BagOfTasks(n: Int, nChunks: Int){
    private val toWorkers = OneMany[Task]

    // This process spawns the tasks
    private def server = proc {
      val chunkSz = (n + nChunks - 1) / nChunks

      // I'll divide the rows / columns into chunks of size "chunkSz".
      val chunks = Array.fill(nChunks)(List[Int]())

      for(i <- 0 until n by chunkSz)
        for(k <- 0 until n by chunkSz){
          /* This bucket contains lines from i to min(i + chunkSz, n)
           * and columns from k to min(k + chunkSz, n) */
          toWorkers!(Task(i, min(i+chunkSz, n), k, min(k+chunkSz, n)))
        }

      toWorkers.closeOut()
    }

    // get a task from the bag
    def getTask: Task = toWorkers?

    server.fork
  }

  /* This represents a generic collector */
  trait Collector{
    // add a TaskAnswer to the result
    def add(ta: TaskAnswer)

    // get the result matrix
    def get: Array[Array[Int]]
  }

  /* This worker will repeatedly find a task that consist of a range
   * of lines and columns, compute their inner products,
   * then tell the collector to set the corresponding
   * values in the output matrix to their correct values.
   * I allow it to see a and b as these are constant 
   * throughout, and thus introduce no races */
  private def worker(n: Int, a: Array[Array[Int]], b: Array[Array[Int]],
        bag: BagOfTasks, col: Collector) = proc {
    repeat{
      val Task(ileft, iright, kleft, kright) = bag.getTask
      /* For all lines in our range */
      for(i <- ileft until iright)
        /* and all columns in our range */
        for(k <- kleft until kright){
          /* compute the inner product, storing it in res */
          var res = 0
          for(j <- 0 until n)
            res += a(i)(j) * b(j)(k)
          /* and output it to the collector */
          col.add(TaskAnswer(i, k, res))
        }
    }
  }

  // This abstract function will return a collector for an n by n matrix
  def mk_collector(n: Int): Collector

  // This simply puts all the components defined so far together,
  // in order to multiply two n by n matrices.
  def multiply(n: Int,

      a: Array[Array[Int]],
      b: Array[Array[Int]]) = {
    require(a.size == n && b.size == n &&
      a(0).size == n && b(0).size == n)

    val bag = new BagOfTasks(n, nChunks)
    val col = mk_collector(n)
    val workers = || (for (i <- 0 until nWorkers) yield worker(n, a, b, bag, col))
    workers()
    col.get
  }
}


/* This indirect parallel multiplier will use a collector
 * that accumulates the information from the workers
 * via messages (i.e. indirectly), writing them one by one
 * to the output matrix. */
class Indirect_par_mult(nChunks: Int, nWorkers: Int)
    extends Gen_par_mult(nChunks, nWorkers){
  /* This collector accumulates the information from the various
   * workers, then relays it to the client process. */
  class MessageCollector(n: Int) extends Collector{
    // This stores the comunication from the workers to the collector
    private val toCollector = ManyOne[TaskAnswer]

    // This stores the communication from the collector to the
    // client process
    private val result_chan = OneOne[Array[Array[Int]]]

    // Through this, a worker can signal that is has completed its task,
    // yielding a certain result.
    def add(ta: TaskAnswer) = toCollector!ta

    // This lets the client process find the result.
    def get = result_chan?

    // This process waits until all tasks are done, then signals the result
    // through result_chan.
    private def server = proc{
      val c = Array.fill(n)(Array.fill(n)(0))
      for(i <- 0 until n * n){
        val TaskAnswer(i, j, r) = toCollector?()
        c(i)(j) = r
      }
      result_chan!c
    }

    server.fork
  }

  def mk_collector(n: Int) = new MessageCollector(n)
}


/* This direct parallel multiplier will use a collector
 * that allows workers to directly write their results
 * without the use of messages. This is quite faster,
 * and does not lead to race conditions, since the
 * vaious tasks are always output-disjoint. */
class Direct_par_mult(nChunks: Int, nWorkers: Int)
    extends Gen_par_mult(nChunks, nWorkers){
  /* This collector allows direct access to the matrix c.
   * This does not lead to race conditions, as each task
   * is output-disjoint, and because the main function
   * waits for all workers to terminate before calling
   * get. */
  class DirectCollector(n: Int) extends Collector{
    private val c = Array.fill(n)(Array.fill(n)(0))
    def add(ta: TaskAnswer) = {
      val TaskAnswer(i, j, res) = ta
      c(i)(j) = res
    }

    def get = c
  }

  def mk_collector(n: Int) = new DirectCollector(n)
}


object Q7 extends App{
  val n = 2000
  val nWorkers = 4
  var nChunks = 4

  // This tests a multiplier m on two n by n matrices.
  // It returns the number of nanoseconds used.
  def test_multiplier(m: Multiplier): Long = {
    val a = Array.fill(n)(Array.fill(n)(scala.util.Random.nextInt(123)))
    val b = Array.fill(n)(Array.fill(n)(scala.util.Random.nextInt(123)))


    val t0 = System.nanoTime()
    val c = m.multiply(n, a, b)
    val t1 = System.nanoTime()
    val cc = Sequential_multiplier.multiply(n, a, b)

    for(i <- 0 until n)
      for(j <- 0 until n)
        assert(c(i)(j) == cc(i)(j), "Multiplier faulty")

    t1 - t0
  }

  if(args.size < 2){
    println("Need at least two arguments")
    println("Give argument help for help")
  }
  else{
    nChunks = args(1).toInt
    val time = args(0) match{
      case "help" =>{
        println("To use, pass two arguments. The first is one of: ")
        println("   sequential: sequential multiplier")
        println("   indirect: indirect parallel multiplier")
        println("   direct: direct parallel multiplier")
        println("The second is: number of chunks to split the lines / columns into")
        0
      }
      case "sequential" =>
        test_multiplier(Sequential_multiplier)
      case "direct" =>
        test_multiplier(new Direct_par_mult(nChunks, nWorkers))
      case "indirect" =>
        test_multiplier(new Indirect_par_mult(nChunks, nWorkers))
      case _ => {
        println("Bad argument")
        0
      }
    }
    println("Total time: " + time)
  }
  exit()
}
