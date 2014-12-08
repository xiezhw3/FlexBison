%{
	#include "calculator.tab.h"
	int yywrap();
%}

%%
[\n] { yylloc.first_column = 1; yylloc.last_column = 0; yylloc.first_line++; return *yytext; }
[0-9]+ { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; yylval.num.value = atoi(yytext);yylval.num.type = 'i'; return NUM; }
<<EOF>> { return LBRACE; }

"(" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return LEFTBRACKET; }
")" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return RIGHTBRACKET; }
"+" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return ADD; }
"-" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return SUB; }
"*" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return MUL; }
"/" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return DEV; }
"%" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return MOD; }
"^" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return POWER; }

">" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return BIG; }
"<" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return SMALL; }
">=" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return BIGE; }
"<=" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return SMALLE; }
"==" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return EQ; }
"!=" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return NEQ; }

"<<" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return LEFTMOVE; }
">>" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return RIGHTMOVE; }
	
"True" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; yylval.num.value = 1; yylval.num.type = 'b'; return TRUE; }
"False" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; yylval.num.value = 0;yylval.num.type = 'b'; return FALSE; }
"or" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return OR; }
"and" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return AND; }
"xor" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return XOR; }
"not" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return NOT; }
"quit" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return QUIT; }

"&" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return BITAND; }
"|" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return BITOR; }

"?" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return THREDF; }
":" { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return THREDS; }
[ \t] { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += (*yytext == '\t' ? 3 : 1); }
. { yylloc.first_column = yylloc.last_column + 1; yylloc.last_column += yyleng; return *yytext;}

%%

int yywrap() { return 1; }