grammar ourlang;

parse : block EOF;

statement
 : assign ';'
 | print ';'
 | ifSt
 | forSt
 | whileSt
 ;

block : (statement)*(RET expression ';')?;

print : PRINT '(' expression ')';
assign : NAME indexes? '=' expression;
ifSt : IF expression '{' block '}';
forSt : FOR NAME '=' expression ':' expression '{' block '}';
whileSt : WHILE expression '{' block '}';

expression
 : '-' expression                                       #minExpr
 | expression op=( '*' | '/' ) expression               #mulExpr
 | expression op=( '+' | '-' ) expression               #addExpr
 | expression op=( '>=' | '<=' | '>' | '<' ) expression #cmpExpr
 | expression op=( '==' | '!=' ) expression             #eqExpr
 | expression '&&' expression                           #andExpr
 | expression '||' expression                           #orExpr
 | print indexes?                                       #printExpr
 | '(' expression ')' indexes?                          #exprExpr
 | NUM                                                  #numExpr
 | BOL                                                  #bolExpr
 | NAME indexes?                                        #nameExpr
 | STR indexes?                                         #strExpr
 ;

indexes : ( '[' expression ']' )+;

AS       : '=';
EQ       : '==';
NEQ      : '!=';
GR       : '>';
LR       : '<';
GRE      : '>=';
LRE      : '<=';
ADD      : '+';
SUB      : '-';
MUL      : '*';
DIV      : '/';
LB       : '(';
RB       : ')';
LSB      : '[';
RSB      : ']';
OR       : '||';
AND      : '&&';

PRINT    : 'print';
IF       : 'if';
RET      : 'return';
FOR      : 'for';
WHILE    : 'while';

//LBB      : '{';
//RBB      : '}';
//DOT      : '.';
//COL      : ':';
//SC       : ';';
//TR       : 'true';
//FA       : 'false';

BOL      : 'true' | 'false';
NUM      : [0-9]+('.'[0-9]*)?;
NAME     : [a-z]+;
STR      : ["](~["\r\n\\])*["];
EOL      : [ \t\r\n] -> skip;

