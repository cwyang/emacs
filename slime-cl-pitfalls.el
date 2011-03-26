;;; slime-cl-pitfalls.el --- warnings instead of encouragement

;; Copyright (C) 2008 Yoni Rabkin <yonirabkin@member.fsf.org>
;; Copyright (C) 1995 Jeff Dalton
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:
;;
;; When SLIME starts, it can display a MOTD-style encouragement
;; randomly picked from several which come with SLIME. This package
;; replaces those messages of encouragement with an explanation of a
;; Common-Lisp pitfall, chosen at random from this file.
;;
;; The texts themeselves are provided here with the kind permission of
;; Jeff Dalton, their author.
;;
;; If you have a good pitfall you think would fit amongst these,
;; please mail it in and I'll add it.

;;; Installation:
;;
;; Add to your .emacs: 
;;
;; (add-to-list 'load-path "~/elisp/slime-cl-pitfalls")
;; (require 'slime-cl-pitfalls)

;;; Code:

(eval-after-load "slime"
  '(setq slime-words-of-encouragement
	'(
"
The result of many non-destructive functions such as REMOVE and
UNION can share structure with an argument; so you can't rely on
them to make a completely new list."

"
APPEND copies all of its arguments _except the last_.
CONCATENATE copies all of its (sequence) arguments."

"
SORT is (usually) destructive.

So, for instance, (SORT (REMOVE ...) ...) may not be safe."

"
Destructive functions that you think would modify CDRs might
modify CARs instead.  (Eg, NREVERSE.)"

"
The value of a &REST parameter might not be a newly constructed
list.  (Remember that the function might be called using APPLY,
and so an existing list might be available.)  Therefore it is not
safe to modify the list, and the following is _not_ equivalent to
the LIST function: (lambda (&rest x) x).  [See CLtL p 78, which
is not as clear as it might be.]"

"
Many of the functions that treat lists as sets don't guarantee
the order of items in the result: UNION, INTERSECTION,
SET-DIFFERENCE, SET-EXCLUSIVE-OR, and their destructive \"N\"
versions."

"
REMOVE- and DELETE-DUPLICATES keep the _later_ (in the sequence)
of two matching items.  To keep the earlier items, use :FROM-END
T.  Remembering that :FROM-END exists may make it easier to
remember the default behavior."

"
Array elements might not be initialized to NIL.  Eg,

 (make-array 10) => #(0 0 0 0 0 0 0 0 0 0)

Use (make-array 10 :initial-element nil)."

"
READ-FROM-STRING has some optional arguments before the keyword
parameters.  If you want to supply some keyword arguments, you
have to give all of the optional ones too.

Other functions with this property: WRITE-STRING, WRITE-LINE,
PARSE-NAMESTRING."

"
EQUAL compares both vectors and structs with EQ.  EQUALP
descends vectors and structs but has other properties (such as
ignoring character case) that may make it inappropriate.  EQUALP
does not descend instances of STANDARD-CLASSes."

"
EQ may return false for numbers and characters even when they
seem to be provably the same.  The aim is to allow a greater
range of optimizations, especially in compiled code, by not
requiring that numbers and characters behave like proper
objects-with-identity.  CLtL p 104 gives an extreme
example: (let ((x 5)) (eq x x)) might return false."

"
Some Common lisp operators use EQ, rather than the usual EQL,
in a way that cannot be overridden: CATCH, GET, GET-PROPERTIES,
GETF, REMF, REMPROP, and THROW.  See table 5-11 on p 5-57 of the
standard."

"
The function LIST-LENGTH is not a faster, list-specific version
of the sequence function LENGTH.  It is list-specific, but it's
slower than LENGTH because it can handle circular lists."

"
 (FORMAT T ...) interprets T as *STANDARD-OUTPUT* All other I/O
functions interpret T as *TERMINAL-IO*."

"
COERCE will not perform all of the conversions that are
available in the language.  There are good reasons for that, but
some cases may be surprising.  For instance, COERCE will convert
a single-character string to a character, but it will not convert
a character to a single-character string.  For that you need
STRING."

"
The DIRECTORY function returns the TRUENAME of each item in the
result, which can be slow.  If you don't need the truenames, on
some systems it's faster to run \"/bin/ls\" and read its standard
output (if your Lisp supports this)."

"
Remember that there are \"potential numbers\" and that they are
reserved tokens [CLtL pages 516-520].  Normally, only odd things
such as 1.2.3 or 3^4/5 are \"potnums\", but when *READ-BASE* is
greater than 10, many more tokens are effected.  (For real fun,
set your read base to 36.)"

"
As mentioned above, SORT is (usually) destructive and so such
combinations as (SORT (REMOVE ...) ...) may not do as you expect
 (if what you expect is that REMOVE will produce a new list)."

"
SORT may not return equal elements in the same order in
different CL implementations, because different sorting
algorithms are used.  To ensure that you get the same result in
all implementations, when that's what you want, use
STABLE-SORT (or write your own)."

"
The comparison predicate given to SORT is treated as a strict
\"less than\" and so should return NIL when its 1st argument is
considered greater than _or equal to_ its 2nd."

"
CLtL suggests that using the :KEY argument to SORT may be more
efficient than calling the key function inside the comparison
predicate (p 408).  However, it may well be less efficient.
Implementations may not take advantage of the separate :KEY to
extract the keys only once; and the key function might be
compiled in-line when it appears inside the predicate."

"
The array-total-size-limit may be as small as 1024."

"
 (DEFVAR var init) assigns to the variable only if it does not
already have a value.  So if you edit a DEFVAR in a file and
reload the file only to find that the value has not changed, this
is the reason.  (Cf DEFPARAMETER.)"

"
Internal DEFUNs define global functions, not local ones.
Scheme programmers, in particular, may expect otherwise.  When
the outermost form is not a DEFUN (or, presumably, a DEFMETHOD or
DEFGENERIC), some implementations won't compile it (or the
function definitions it contains)."

"
When calling a function on more than two arguments, remember
that there can be intermediate results.  For instance, when
adding three fixnums, it's not enough to say only that the
_final_ result is a fixnum.  You'll have to break the computation
down into 2-argument calls."

"
Remember that implementations often use type declarations for
optimization rather than for checking.  Adding type declarations
can _reduce_ the number of checks.  Different implementations do
different things, and their behavior may be affected by OPTIMIZE
declarations."

"
 (EXPORT NIL) does not export NIL.  You have to use (EXPORT
'(NIL))."

"
If you have a package named P that exports a symbol named P, you
won't (in another package) be able to say (USE-PACKAGE 'P).
Instead of 'P you'll have to write \"P\" or maybe #:P.  [\"Why?\"
is left as an exercise for the reader.]"

"
The best order for package operations is _not_ that of the \"Put
in seven extremely random user interface commands\" mnemonic
 [CLtL p 280].  Instead, it's the order used by DEFPACKAGE [p
271].  The change is to put EXPORT last.  Of course, it's often
better to just use DEFPACKAGE."

"
Shared (i.e., class-allocated) slots of standard classes are not
per-(sub)class.  That is, if a class C has a slot S
with :ALLOCATION :CLASS, that one slot is used by all instances of C or of
subclasses of C, except for subclasses where the slot has been
\"shadowed\" [See CLtL p 779].  To get a per-class slot, you have
to explicitly define it for each class."

"
Don't forget, with :AROUND methods, that other :AROUND methods
might execute around them.  (E.g., an :AROUND method that
recorded run time might not be the outermost one.)  A similar
point applies to :BEFORE and :AFTER methods."

"
Don't forget that a method specialized to class C can be called
on instances of subclasses of C, or that such a subclass may have
ancestors that have no other relation to C.")))

(provide 'slime-cl-pitfalls)

;;; slime-cl-pitfalls.el ends here.
