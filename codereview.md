David's Code Review Checklist
=============================

These are common points I'll raise in a code review.

## Design

* Prefer customization with aggregation over inheritance.
	* If we want a different method for Targetter.CalculateWeight, we should have a WeightStrategy instead of subclassing Targetter and overriding CalculateWeight. That different Targetters can mix and match strategies.
	* See [Game Programming Patterns - Component](http://gameprogrammingpatterns.com/component.html) for an in-depth example.
* Prefer compile-time errors to runtime errors.
	* Runtime errors aren't always caught and may not be trivial to reproduce.
	* Make good use of `static_assert` and compile warnings.
	* Emit editor warnings instead only checking at runtime.


## Implementation

* Call super in overridden functions or comment why you're not calling super.
	* Distinguishes whether not calling super is an oversight.
	* If super is called in a called function, then comment.
* Avoid using `default` in switch statements.
	* Compiler can output a warning for unhandled enums only if default is omitted. I prefer to return from all cases and assert after the switch (to be extra safe).
	* Using default to assert converts a compile-time error into a runtime error.


## Style

* Name booleans (variables and query functions) like a question: IsFollowing, ShouldFollow, WasSuccessful, HasCompleted.
	* Disambiguates reality vs. desire (Following could describe behavior we want or behavior we observe).
* API functions that accept an object should use references unless the object is optional.
	* Communicates nonoptional information.
	* Delegates error checking to caller who is better equipped to handle error.
* API functions that accept a boolean should use a two-value enum.
	* Intent is clearer at callsites: SetFlying(true) vs SetFlying(EFlightMode::Hover).
* API functions to set a value should have a separate function to clear the value.
	* Makes it easier for maintainers to see and track clears.
	* Prevents accidental clears from invalid value.
* Be explicit about units.
	* Especially when varying from standard units. If your codebase always measures time in seconds, variables holding minutes should contain the word "Minutes".
	* Often you can massage the name to make the units more natural. SecondsBeforeExplosion vs. PreExplosionDuration.
* Prefer `static_cast` over c-style casts.
	* c-style casts don't have typesafety (`reinterpret_cast` vs `static_cast`), get lost in the code, and are hard to find.
* Put a newline after break or return in a switch statement.
	* This blank line clearly separates each case and makes fallthroughs self-apparent.
* Include your module name in your include directory.
	* Put your header files in folders inside the include root.
	* See next item for why.
* Use relative paths from the include directory in #includes
	* Even if including a file in the same directory.
	* This makes your includes a list of what modules you're using.
	* Unreal: The words "Public" and "Classes" should not include in an include statement. Delete everything up to them and keep everything after them.
* Put a new line between adjacent ifs to clearly distinguish them from else ifs
	* if-elseif-elseif is a common form and if-if-if looks very similar.

## Style nitpicks

* Open scope on the same line as the thing describing scope.
	* A function call isn't clearly a function without its open parens. A list isn't clearly a list without its opening brace. Put these logical pieces together.
	* This style is enforced in Python (you have to use an escape to thwart it).
	* Don't start holy wars: if curly brace on newline is the standard, follow it.

* C++: Use full include paths and not relative ones.
	* If two files are in the same directory (include/hello/{greet,meet}.h), still use the folder (hello) for the `#include` path.
	* Communicates higher-level information about modules used and sorts better (all camera module includes sort together).

* Avoid comparing a boolean to true.
	* The extra line noise is not helpful if your booleans are already obviously named.

* Prefer [Apps Hungarian over Systems Hungarian](https://en.wikipedia.org/wiki/Hungarian_notation#Systems_vs._Apps_Hungarian)
	* Or use neither.
	* [Making Wrong Code Look Wrong by Joel Spolsky](http://www.joelonsoftware.com/articles/Wrong.html)

* The minimum/maximum value for something should always be a valid value.
	* Minimum and maximum are implicitly inclusive.
	* When defining an enum where the last entry is the size of the array, name the last entry `COUNT` and not `MAX_PLAYERS`. `MAX_PLAYERS` should be the same as `LAST_PLAYER` and `remainingLives[EPlayerId::MAX_PLAYERS] = 4` should be valid. `remainingLives[EPlayerId::COUNT] = 4` is clearly wrong to anyone familiar with 0-indexed arrays.
	* When defining a minimum speed, use speed >= minSpeed for validation.


## Error handling
* Give enough information in an error to fix it.
	* If we get a smoke fail because an error fires, the fail text should be sufficient to solve the problem.
	* Include details of how to fix, the object instance name, etc.

## Unreal Engine
* DECLARE_LOG_CATEGORY_EXTERN should uses Warning level by default.
	* DECLARE_LOG_CATEGORY_EXTERN(LogCombat, Warning, All);
	* You shouldn't expose your Log-level messages to the whole team.
* Prefer enums over TEnumAsByte except for storage
	* UPROPERTY enums must be stored as TEnumAsByte, but pass them around as enums.
	* TEnumAsByte is extra noise that's not relevant to the reader.
