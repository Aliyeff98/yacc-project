                   CALCULATOR LANGUAGE

                    Member: RASHAD ALIYEV

 <prog>::= <function>

 <stmts>::=<sl>

 <sl>::=  <stmt>|<block_stmt>|<print_stmt>

 <stmt>::=  <types>|<expr>

 <types>::= <datatypes>|<String>

 <datatype>::= <int>|<boolean>

<expr>::= <assign_expr>

 <assign_expr>::= <lefthand_side> <relational_op> <assign_expr>|
 <lefthand_side> <op> <assign_expr>

 <block_stmt>:: = <conditional_stmt> | <loop_stmt> | <method_stmt>

 <conditional_stmt>::=<if_cond_exp> |<elif_cond_exp> |<else_cond_exp>

 <if_cond_exp>::= if (<cond_op> ) <body> 

 <elif_cond_exp>::=elif(<cond_op>) <body>

 <else_cond_exp>::= else( <body> )

 <loop_stmt>::= <while_stmt> 

 <while_stmt>::= while(<expr>)  <body>

 <method_stmt>::=  <method_mod>  <body>

 <method_mod>::= def <stmt> <body>

 <body>::= : <stmt> ? :

 <print_stmt>::= printer
 <comment>::= //

<int>::= <int> <op> <int> | <int> <relational_op> <int>? | <digit>
 <boolean>::= true | false 
<String>::=<letter> | <digit> | <symbol>


 <cond_op>::=<expr> && <expr> | <expr> || <expr> 
 <relational_op> ::= <  | > | ==

 <symbol>::=  ' | " | , |; | = | ( | ) | :| [ | ]

 <op>::= + | - | * | / | =

 <digit> ::=0 | 1 |....| 9

 <letter> ::= a | b ...| z | A | B ...| Z |



You can use various mathematical operations and basic  programming language features in this programming language.The name of the programming language is Calculator

