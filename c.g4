grammar c;

// ==========================
// Entrada
// ==========================
compilationUnit
    : (declaration | functionDefinition)* EOF
    ;

// ==========================
// Declarações
// ==========================
declaration
    : typeSpecifier initDeclarator ';'
    ;

initDeclarator
    : declarator ('=' expression)?
    ;

typeSpecifier
    : 'int' | 'float' | 'char' | 'void'
    ;

declarator
    : Identifier
    ;

// ==========================
// Funções
// ==========================
functionDefinition
    : typeSpecifier Identifier '(' parameterList? ')' compoundStatement
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : typeSpecifier declarator
    ;

// ==========================
// Statements
// ==========================
compoundStatement
    : '{' statement* '}'
    ;

statement
    : declaration
    | expressionStatement
    | compoundStatement
    | selectionStatement
    | iterationStatement
    | jumpStatement
    ;

expressionStatement
    : expression? ';'
    ;

selectionStatement
    : 'if' '(' expression ')' statement ('else' statement)?
    ;

iterationStatement
    : 'while' '(' expression ')' statement
    | 'for' '(' expression? ';' expression? ';' expression? ')' statement
    ;

jumpStatement
    : 'return' expression? ';'
    ;

// ==========================
// Expressões
// ==========================
expression
    : assignmentExpression
    ;

assignmentExpression
    : logicalOrExpression ('=' assignmentExpression)?
    ;

logicalOrExpression
    : logicalAndExpression ('||' logicalAndExpression)*
    ;

logicalAndExpression
    : equalityExpression ('&&' equalityExpression)*
    ;

equalityExpression
    : relationalExpression (('==' | '!=') relationalExpression)*
    ;

relationalExpression
    : additiveExpression (('<' | '>' | '<=' | '>=') additiveExpression)*
    ;

additiveExpression
    : multiplicativeExpression (('+' | '-') multiplicativeExpression)*
    ;

multiplicativeExpression
    : unaryExpression (('*' | '/') unaryExpression)*
    ;

unaryExpression
    : ('+' | '-' | '!')? primaryExpression
    ;

primaryExpression
    : functionCall
    | Identifier
    | Constant
    | '(' expression ')'
    ;

functionCall
    : Identifier '(' argumentList? ')'
    ;

argumentList
    : expression (',' expression)*
    ;

// ==========================
// Tokens
// ==========================
Identifier
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

Constant
    : IntegerConstant
    | FloatingConstant
    | CharacterConstant
    ;

IntegerConstant
    : [0-9]+
    ;

FloatingConstant
    : [0-9]+ '.' [0-9]* (('e' | 'E') ('+' | '-')? [0-9]+)?
    ;

CharacterConstant
    : '\'' . '\''
    ;

// ==========================
// Comentários e espaços
// ==========================
LineComment
    : '//' ~[\r\n]* -> skip
    ;

BlockComment
    : '/*' .*? '*/' -> skip
    ;

Whitespace
    : [ \t\r\n]+ -> skip
    ;