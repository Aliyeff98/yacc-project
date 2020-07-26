%{
#include <stdio.h>
#include<stdbool.h>
#include"lex.yy.c"
#include<string.h>
void sys();
int look(char *);
void yyerror (char const *);
int check(int, int, int);
char error[55] = "Error";
extern int yylineno;
int loc =-1;
int lid =-1;
 
struct types
{
    char UID[50];
    int val;
    int type; 
    int line_no;
    int scope;
};

struct types st[50];
%}
%union
{    	int number;
    	char *string;
}
%token <number> NUMBER INTEGER
%token <number> NUM 
%token <string> IDENTIFIER

%type<number> arithm_e

%type<string> ids1
//%type<string> ids2
%type<string> ids3
%type<number> relational_exp

%token  STRING   EQUAL DEQ AND OR INT  IF ELSE TRUE1 
%token FALSE1 BOOLEAN TRY CATCH EXCEPTION FUNC MAIN STRING_TYPE  PRINT 
%token BO BC WHILE ADD SUB MUL DIVIDE LE GR COMMA SEMICOLON TDO
%nonassoc EQUAL
%left ADD SUB MUL DIVIDE
%right LE GR DEQ

%%
prog: function
             	;
method_name:IDENTIFIER
	;
function:MAIN body
       	;
body: TDO sl  TDO
	;
sl: sl s1
  |
  ;
s1:  stmt 
	| SEMICOLON
	| method_name BO BC
	|if_stmt         
	|while_stmt 
	;
stmt: variable_declaration SEMICOLON
		|expr SEMICOLON
		|print_stmt
		;
variable_declaration: datatypes
			|STRING_TYPE
                	;
datatypes: INT ids1
        | BOOLEAN  ids2
	|STRING_TYPE ids3
    	;

ids1: IDENTIFIER EQUAL arithm_e    {if(look($1)==-1){lid++; strcpy(st[lid].UID,$1); st[lid].type =0; st[lid].val = $3;} }
   | ids1 COMMA IDENTIFIER    {if(look($3)==-1) {lid++; strcpy(st[lid].UID,$3);  st[lid].type =0; } else {yyerror(error);} }
   | IDENTIFIER    	 {if(look($1)==-1) {lid++; strcpy(st[lid].UID,$1); st[lid].type =0; } }
   | IDENTIFIER EQUAL relational_exp    {loc = look($1);  if(loc==-1) {lid++; strcpy(st[lid].UID,$1); st[lid].type =3; st[lid].val = $3;} else { st[loc].val = $3; } }
   ;

ids2: IDENTIFIER EQUAL relational_exp    {if(look($1)==-1) {lid++; strcpy(st[lid].UID,$1); st[lid].type =3; st[lid].val = $3;} else { st[loc].val = $3; } }
  
   | IDENTIFIER    	 {if(look($1)==-1) {lid++; strcpy(st[lid].UID,$1); st[lid].type =3; } }
   ;

ids3: IDENTIFIER EQUAL   STRING  {printf("%s",yytext);}
	;

expr: arithm_e
         | relational_exp
      	;
relational_exp: arithm_e LE arithm_e   	 {$$ = check($1,$3,1);}
      	| arithm_e GR arithm_e 	 {$$ = check($1,$3,2);}
      	| arithm_e DEQ arithm_e     {$$ = check($1,$3,5);}
	| arithm_e AND arithm_e		{$$ = check($1,$3,7);}
	| arithm_e OR arithm_e		{$$ = check($1,$3,8);}
      	;
arithm_e: arithm_e MUL arithm_e   	 {$$ = $1 * $3;}
     | arithm_e DIVIDE arithm_e    {$$ = $1 / $3;}
     | arithm_e ADD arithm_e    { $$ = $1 + $3;}
     | arithm_e SUB arithm_e    {$$ = $1 - $3;}
     | IDENTIFIER   		{loc = look($1); if(loc!=-1) { $$ = st[loc].val; } else {yyerror(error);} }
     | NUMBER   			 {$$ =  $1; }
     | INTEGER   		 {$$ =  $1; }
    
     | IDENTIFIER EQUAL arithm_e    {loc = look($1); if(loc!=-1) { st[loc].val = $3; } else {yyerror(error);}}
	  
	;
if_stmt: IF BO relational_exp BC body   		 
   	| IF BO relational_exp BC body else_if_blocks   
   	;
else_if_blocks :  ELSE else_if_block
           	| else_if_blocks  ELSE else_if_block
           	;
else_if_block : IF BO relational_exp BC body
      	| body
         ;
while_stmt: WHILE BO for_args BC bod
    	;
bod: TDO state_loop  TDO
	;
state_loop: sl loop_stmt	|
	;
loop_stmt: WHILE BO BC SEMICOLON {
    int j=-1;
    printf("\nTime\tval\t\n");
    for(j=0;j<=lid;j++)
    {    
	for(lid=0;lid<=st[j].val;lid++){

		printf("%s\t%d\t\n",st[j].UID,st[j].val);
		}
    }
printf("%s","LOOP");
}
	;
for_args: arg1 SEMICOLON arg2 SEMICOLON
   	;
arg1: variable_declaration
   	|expr
   	|
   	;
arg2: relational_exp
 	|
 	;



print_stmt: PRINT BO BC SEMICOLON { int j=-1;
    
    for(j=0;j<=lid;j++)
    {    
		printf("\t%d\t\n",st[j].val);		
    }}
	;

%%

int main()
{
yyparse();
return 1;

}


int look(char *name)
{
    int j=-1;
    for(j=0;j<lid+1;j++)
    {
   	 
   	 if(strcmp(name, st[j].UID)==0)
   	 {    
   			 
   		 return j;
   	 }
    }
return -1;
}
int check(int a, int b, int k )
{

switch(k)
{
case 1: if (a<b)
    	return 1;
    	else
    	return 0;
    	break;
case 2: return (a>b);
     	break;   	 
case 3: return (a==b);
     	break;
case 4: return (a&&b);
     	break;
case 5: return (a||b);
     	break;

}
}      	 
 
void yyerror (char const *s)
{
fprintf (stderr, "%s\n", s);
  printf("Line No.  %d\n" , yylineno);
 
   printf("Error after : %s\n" , yytext);
 

}   
	 
