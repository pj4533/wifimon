import Glibc
import Foundation

func initLCD() -> HD44780LCD {
	let gpios = SwiftyGPIO.getGPIOsForBoard(.RaspberryPiRev2)
	let lcd = HD44780LCD(rs:gpios[.P25]!,e:gpios[.P24]!,d7:gpios[.P22]!,d6:gpios[.P27]!,d5:gpios[.P17]!,d4:gpios[.P23]!,width:20,height:4)
	return lcd	
}


while (true) {
	print("updating...")
	// weird i can't read this file directly
	PiRunner().shell("cat /proc/net/wireless | tail -n1 > outfile")

	do {
		let text = try NSString(contentsOfFile: "outfile", encoding: NSUTF8StringEncoding)

		let link = text.substringWithRange(NSRange(location: 14, length: 5))
		let level = text.substringWithRange(NSRange(location: 21, length: 5))

		let lcd = initLCD()
		lcd.cursorHome()
		lcd.clearScreen()

		lcd.printString(0,y:0,what:"Link: \(link)",usCharSet:true)	
		lcd.printString(0,y:1,what:"Level: \(level)",usCharSet:true)	
	} catch (_) {
		print("caught errrer")	
	}

	sleep(1)

}
