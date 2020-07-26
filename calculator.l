%{
#include <stdio.h>
#include "y.tab.h"
%}

%option yylineno
%x COMMENTS
%%
\"([^\\\"]|\\.)*\"  	                {return STRING;}
"true"					{return TRUE1 ;}
"false"				        {return FALSE1;}
"int"            		        {return INT;}  
"boolean"				{return BOOLEAN;}
"String"				{return STRING_TYPE;}
"if"            			{return IF;} 
"elif"				        {return ELSE;}
"while"            			{return WHILE;}
"loopEnd"				{return WHILE;}
"print"                			{return PRINT;}
"def"					{return MAIN;}
[ \t\n]		        ;
"//".*			;
"&&"               			{return AND;}
"||"            			{return OR;} 
"("		 			{return BO;}
")"		 			{return BC;}
"+"		 			{return ADD;}
"*" 		 			{return MUL;}
"/"	         			{return DIVIDE;}
"-"		 			{return SUB;}
"<"		 			{return LE;}
">" 		 			{return GR;}
","         	 			{return COMMA;}
"=="		 			{return DEQ;}
"="            				{return EQUAL;} 
";"            				{return SEMICOLON;}
":"            				{return TDO;}

[a-zA-Z_]([a-zA-Z_]|[0-9])*	{yylval.string=strdup(yytext); return (IDENTIFIER) ;}
[0-9]+		{yylval.number=atoi(yytext); return NUMBER; 
}
.            		;
%%

