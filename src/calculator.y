%{
	#include <stdio.h>
	#include <math.h>
	#include <stdlib.h>
	#define lMaxBuffer 10000
	#define INTINFINITY 999999

	void yyerror (const char *msg);
	void yyrestart(FILE*);
	void printError(char *, int, int);
	int yylex(void);
	int outputFlag = 0;
	int isSuccess = 1;
	int isError = 0;
%}

%union {
	struct Value{
		int value;
		char type;
	} num;
}

%error-verbose
%expect 1

%token <num> NUM TRUE FALSE LBRACE QUIT
%type <num> exp
%left THREDF THREDS
%left OR
%left AND
%left BITOR
%left XOR
%left BITAND
%left EQ NEQ
%left BIG SMALL BIGE SMALLE
%left LEFTMOVE RIGHTMOVE
%left SUB ADD
%left MUL DEV MOD
%left NOT
%right POWER
%left LEFTBRACKET RIGHTBRACKET
%left NEG

%%
input: /* empty */
	| input line
	;

line: '\n' {
		if (outputFlag == 1)
			printf("> ");
	}
	| LBRACE { exit(1); }
	| exp LBRACE { 
		if (isSuccess) {  // not output the result is the input is error
			if ($1.type == 'i') {
				printf("%d\n", $1.value);
			} else {
				if ($1.value == 1)
					printf("True\n");
				else
					printf("False\n");
			}
			if (outputFlag == 1)
				printf("> ");
		}
		isSuccess = 1;
		exit(1);
	}
	| exp '\n' { 
		if (isSuccess) {
			if ($1.type == 'i') {
				printf("%d\n", $1.value);
			} else {
				if ($1.value == 1)
					printf("True\n");
				else
					printf("False\n");
			}
			if (outputFlag == 1)
				printf("> ");
		}
		isSuccess = 1;
	}

	// error recover
	| error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @1.first_line, @1.first_column);
	}
	| exp error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp THREDF error THREDS exp '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp THREDF exp THREDS error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp THREDF error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp THREDS error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp OR error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp AND error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp BITOR error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp XOR error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp BITAND error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp EQ error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp NEQ error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp BIG error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp SMALL error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp BIGE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp SMALLE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp LEFTMOVE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp RIGHTMOVE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp SUB error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp ADD error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp MUL error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp DEV error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp MOD error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp NOT error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| exp POWER error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  THREDF error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  THREDS error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  OR error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  AND error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  BITOR error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  XOR error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  BITAND error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  EQ error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  NEQ error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  BIG error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  SMALL error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  BIGE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  SMALLE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  LEFTMOVE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  RIGHTMOVE error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  SUB error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  ADD error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  MUL error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  DEV error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  MOD error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  NOT error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	|  POWER error '\n' {
		yyerrok;
		printError("LOSE BRACKET OR UNDEFINED SIMBOL", @2.first_line, @2.first_column);
	}
	| QUIT { exit(1); }
	;


exp  : NUM { 
		$$ = $1; 
	}
	| TRUE { $$.value = 1; $$.type = 'b'; }
	| FALSE { $$.value = 0; $$.type = 'b'; }
	| exp THREDF exp THREDS exp { 
		$$.value = $1.value ? $3.value : $5.value;
		$$.type = $1.value ? $3.type : $5.type;
	}
	| exp AND exp {
		$$.value = $1.value && $3.value;
		$$.type = 'b';
	}
	| exp OR exp {
		$$.value = $1.value || $3.value;
		$$.type = 'b';
	}
	| exp XOR exp {
		$$.value = $1.value ^ $3.value;
		$$.type = 'i';
	}
	| exp BITOR exp {
		$$.value = $1.value | $3.value;
		$$.type = 'i';
	}
	| exp BITAND exp {
		$$.value = $1.value & $3.value;
		$$.type = 'i';
	}
	| exp SMALL exp {  
		$$.value = ($1.value < $3.value) ? 1 : 0;
		$$.type = 'b';
	}
	| exp BIG exp {  
		$$.value = ($1.value > $3.value) ? 1 : 0;
		$$.type = 'b';
	}
	| exp SMALLE exp {
		$$.value = ($1.value <= $3.value) ? 1 : 0;
		$$.type = 'b';
	}
	| exp BIGE exp { 
		$$.value = ($1.value >= $3.value) ? 1 : 0; 
		$$.type = 'b';
	}
	| exp EQ exp {
		$$.value = ($1.value == $3.value) ? 1 : 0;
		$$.type = 'b';
	}
	| exp NEQ exp {  
		$$.value = ($1.value != $3.value) ? 1 : 0;
		$$.type = 'b';
	}
	| exp LEFTMOVE exp { $$.value = $1.value << $3.value; $$.type = 'i'; }
	| exp RIGHTMOVE exp { $$.value = $1.value >> $3.value; $$.type = 'i'; }
	| exp ADD exp { $$.value = $1.value + $3.value; $$.type = 'i'; }
	| exp SUB exp { $$.value = $1.value - $3.value; $$.type = 'i'; }
	| exp MUL exp { $$.value = $1.value * $3.value; $$.type = 'i'; }
	| exp MOD exp { 
		if ($3.value) {
			$$.value = $1.value % $3.value;
		} else {
			$$.value = $3.value;
			isSuccess = 0;
			printError("INTEGER MODULO BY ZERO", @3.first_line, @3.first_column);
		}
		$$.type = 'i';
	}
	| exp DEV exp {
		if ($3.value) {
			$$.value = $1.value / $3.value;
		} else {
			$$.value = INTINFINITY;
			isSuccess = 0;
			printError("INTEGER DIVERSION BY ZERO", @3.first_line, @3.first_column);
		}
		$$.type = 'i';
	}
	| exp POWER exp { $$.value = pow($1.value, $3.value); $$.type = 'i'; }
	| SUB exp { 
		if((@1.last_column + 1) == @2.first_column) {
			$$.value = -($2.value);
		}
		else {
			isSuccess = 0;
			printError("SYNATIC ERROR", @1.first_line, @1.first_column);
		}
		$$.type = 'i';
	}
	| ADD exp {
		if((@1.last_column + 1) == @2.first_column) {
			$$.value = $2.value;
		}
		else {
			isSuccess = 0;
			printError("SYNATIC ERROR", @1.first_line, @1.first_column);
		}
		$$.type = 'i';
	}
	| NOT exp { $$.value = !($2.value); $$.type = 'b'; }
	| LEFTBRACKET exp RIGHTBRACKET{ $$.value = $2.value; $$.type = $2.type; }
	| error RIGHTBRACKET {
		isSuccess = 0;
		printError("\'(\' LOSE ERROR", @1.first_line, @1.last_column);
		$$.value = 1; $$.type = 'i';
	}
	| LEFTBRACKET error{
		isSuccess = 0;
		printError("\')\' LOSE ERROR", @2.first_line, @2.first_column);
		$$.value = 1; $$.type = 'i';
	}
	;

%%

int main(int argc, char* argv[]) 
{ 
    if (argc <= 1) {
    	printf("> ");
    	outputFlag = 1;
    	yyparse(); 
    } else {
	    FILE* f = fopen(argv[1], "r"); 
	    if (!f) { 
	        perror(argv[1]); 
	        return 1; 
	    } 
	    yyrestart(f); 
	    yyparse(); 
    }
    return 0; 
}

void yyerror(const char* s) { 
	;
}

void printError(char *errorMess, int row, int col) {
	if (outputFlag == 1)
		row = 1;
	fprintf(stderr, "row: %d\tcol: %d\tError: %s\n", row, col, errorMess);
	if (outputFlag == 1)
		printf("> ");
}
