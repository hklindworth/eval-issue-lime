eval-issue-lime
===============

A project to reproduce a problem with Haxe4 compilation. No external dependencies.

To test call:

    haxe release.hxml


Build & runs successfully with Haxe3, with Haxe4 compilation shows error messages and fails with assertion:

	haxe release.hxml
	lime/lime/utils/Bytes.hx:21: characters 10-43 : haxe.io.Bytes does not have a constructor
	File "_build/src/macro/eval/evalJitContext.ml", line 81, characters 9-15: Assertion failed
