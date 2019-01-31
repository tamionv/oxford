import io.threadcso._
import scala.math._
import scala.collection.mutable._

object Sorter{
  /* This is the component specified by the question.
   * Out represents a channel through which the
   * output is written, and left/right have the
   * meaning defined in the question. */
  def sorting_component(out: ![Int], left: ?[Int], right: ![Int])
      = proc {

    // buffer represents the maximal value that we have seen so far.
    // It is set to None if and only if we have seen no
    // integers so far. Otherwise it is set to Some x, where
    // x is the maximal value seen so far.
    var buffer: Option[Int] = None

    // Until left is closed:
    repeat{
      // Read a value x from left
      val x = left?()

      // Now, based on the state of buffer:
      buffer match {
        // If we have seen nothing, then store x in buffer
        case None => buffer = Some (x)
        // Otherwise, if the largest value seen so far is y
        case Some(y) => {
          // Store max(x, y) in buffer
          buffer = Some (max(x, y))
          // And transmit min(x, y) through right
          right!min(x, y)
        }
      }
    }

    // Once left is closed, we close right
    right.closeOut()

    // and output the largest value we have seen.
    out!buffer.get
  }

  // This procedure sorts the Array it is given,
  // returning a sorted copy of the input,
  // using the method described in the question.
  def parallel_sort(a: Array[Int]) = {
    val n = a.size

    // These are the channels between components
    val inner_channels = Array.fill(n + 1)(OneOne[Int])

    // These are the channels through which the components
    // communicate with the testing function.
    val output_channels = Array.fill(n)(OneOne[Int])

    // This will contain the result of sorting.
    val results = ArrayBuffer.fill(n)(0)

    // This process copies a into the first inner channel, then closes it:
    val input_process = proc {
      for(x <- a)
        inner_channels(0)!x
      inner_channels(0).closeOut
    }

    // This is a process that runs all the sorting components
    // in parallel.
    val components = || (for(i <- 0 until n) yield
      sorting_component(
        output_channels(n - i - 1),
        inner_channels(i),
        inner_channels(i+1)))

    // This process will write the values in the
    // output channels to results.
    val output_process = || (for(i <- 0 until n) yield
      proc { results(i) = output_channels(i)?() })

    // the overall system
    val system = input_process ||
      components ||
      output_process

    run(system)

    results
  }
}

//This will test Sorter.
object Q6 extends App{
  var nr_tests = 0
  var test_size = 0
  try{
    println("Input number of tests: ")
    nr_tests = readInt
    println("Input test size: ")
    test_size = readInt
  }
  catch{
    case _ : Throwable => {
      println("Expected integer input, defaulting to 100 tests of size 100")
      nr_tests = 100
      test_size = 100
    }
  }

  val t0 = System.nanoTime()
  for(i <- 1 to nr_tests){
    val input = Array.fill(test_size)(scala.util.Random.nextInt)
    val output = Sorter.parallel_sort(input)
    assert(input.sorted sameElements output, "Test " + i + " failed")
    println("Test " + i + " succeeded")
  }
  val t1 = System.nanoTime()
  println("Average time: " + (((t1 - t0).toDouble / nr_tests.toDouble) * 1e-6) + " ms")
  exit()
}
