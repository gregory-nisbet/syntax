/**
 * Example:
 *
 *   ./bin/syntax -g examples/calc-eval.g -m slr1 -p '2 + 2 * 2'
 *
 *   > 6
 *
 *   ./bin/syntax -g examples/calc-eval.g -m slr1 -p '(2 + 2) * 2'
 *
 *   > 8
 */

{
  "lex": {
    "rules": [
      ["\\s+",                    "/*skip whitespace*/"],
      ["[0-9]+(?:\\.[0-9]+)?\\b", "return 'NUMBER'"],
      ["\\+",                     "return '+'"],
      ["\\*",                     "return '*'"],
      ["-",                       "return '-'"],
      ["\\/",                     "return '/'"],
      ["\\(",                     "return '('"],
      ["\\)",                     "return ')'"],
      ["\\^",                     "return '^'"],
      ["!",                       "return '!'"],
      ["%",                       "return '%'"],
      ["PI\\b",                   "return 'PI'"],
      ["E\\b",                    "return 'E'"],
    ]
  },

  "operators": [
    ["left", "+", "-"],
    ["left", "*", "/"],
    ["left", "^"],
    ["right", "!"],
    ["right", "%"],
    ["left", "UMINUS"],
  ],

  "bnf": {
    "e": [["e + e",  "$$ = $1 + $3"],
          ["e - e",  "$$ = $1 - $3"],
          ["e * e",  "$$ = $1 * $3"],
          ["e / e",  "$$ = $1 / $3"],
          ["e ^ e",  "$$ = Math.pow($1, $3)"],
          ["e !",    "$$ = (function _factorial(n) {if(n===0) return 1; return _factorial(n-1) * n})($1)"],
          ["e %",    "$$ = $1 / 100"],
          ["- e",    "$$ = -$2", {"prec": "UMINUS"}],
          ["( e )",  "$$ = $2"],
          ["NUMBER", "$$ = Number(yytext)"],
          ["E",      "$$ = Math.E"],
          ["PI",     "$$ = Math.PI"]],
  }
}