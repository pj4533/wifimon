import Foundation

class PiRunner {

	func shell(command: String) {
	  // Create a Task instance
	  let task = NSTask()

	  // Set the task parameters
	  task.launchPath = "/bin/bash"
	  task.arguments = ["-c", command]
	 
	  // Launch the task
	  task.launch()
	  task.waitUntilExit()
	}

}


 

