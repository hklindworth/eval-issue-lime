package;

import haxe.macro.Expr;
import lime.utils.Bytes;


class TestClass {
	macro public static function testMacro() : Expr {
		return macro false;
	}
}

class Main {
	public static function main () {

		trace("Hello World");
		
		TestClass.testMacro(); // Causes Compiler error: Field index for length not found on prototype haxe.io.Bytes
	}
}