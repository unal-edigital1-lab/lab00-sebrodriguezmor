# Lab 01 - sumador 
## Laboratorio 01 introducción a HDL
### Sebastian Rodriguez Morales
#### Diseño

De acuerdo con las especificaciones requeridad, se tuvo en cuenta la realizacion de dos sumadores, el primero de un solo bit y el segundo de 4 bits contando ambos con un carrier usualmente determinado por Cin cuya funcionalidad es determinar la carga adicional en la suma de A y B, de manera que si no se ha realizado una suma, este carrier no tendra valor y por lo tanto sera cero. La siguiente tabla muestra como se relacionan logicamente las entradas y salidas del sistema a diseñar.

![Sumador 1 bit](https://github.com/unal-edigital1-lab/lab00-sebrodriguezmor/blob/master/Imagenes/Sumador%201%20Bit.jpg)

Se pueden observar dos descripciones funcionales del modulo para el desarrollo del sumador de 1 bit, la primera hace uso de asignaciones para luego determinar literalmente la suma como operacion binaria en el codigo mediante la utilizacion de compuertas logicas AND, OR y XOR; la segunda opcion implementa un registro de 2 bits mediante el cual se almacena un valor en especifico hasta que se le indique cambiar su valor. Dichos codigos pueden observarse a continuacion.

* Descripcion 1:
```verilog
module sum1bcc_primitive (A, B, Ci,Cout,S);

// definicion de variables de entrada y salida

  input  A;
  input  B;
  input  Ci;
  output Cout;
  output S;

// se definen los cables para cada relacion de entradas y salidas

  wire a_ab;
  wire x_ab;
  wire cout_t;

// se establecen las compuertas logicas para cada operacion interna, en este caso solo usamos AND, OR y XOR.

  and(a_ab,A,B);
  xor(x_ab,A,B);

  xor(S,x_ab,Ci);
  and(cout_t,x_ab,Ci);

  or (Cout,cout_t,a_ab);

endmodule
```
* Descripcion 2:
```verilog
module sum1bcc (A, B, Ci,Cout,S);

  input  A;
  input  B;
  input  Ci;
  output Cout;
  output S;

  reg [1:0] st;

  assign S = st[0];
  assign Cout = st[1];

  always @ ( * ) begin // se hace enfasis en la entrada 
  	st  = 	A+B+Ci;
  end
  
endmodule
```
Siguiendo la logica anterior es posible desarrollar un sumador de 4 bits mediante la union de sumadores de 1 bit como se evidencia en la siguiente imagen:

![Sumador 4 bits](https://github.com/unal-edigital1-lab/lab00-sebrodriguezmor/blob/master/Imagenes/sum4b.jpg)

A partir de esto se concluye que el codigo para la implementacion puede ser el siguiente, en donde se puede observar como se han indicado las variables a utilizar mediante la creacion de "vectores" con el tamaño adecuado de la suma. Se han asignado 4 sumadores de 1 bit (sum1bcc) cuyo codigo se muestra anteriormente para la realizacion de las operaciones de manera que a sus variables internas se les asigna un valor en especifico en una matriz que realizara los procedimientos teniendo en cuenta el carrier que en este caso pasara a ser la salida de los sumadores.

```verilog
module sum4b(xi, yi,co,zi);


  input [3 :0] xi;
  input [3 :0] yi;
  output co;
  output [3 :0] zi;

  wire c1,c2,c3;
  sum1bcc s0 (.A(xi[0]), .B(yi[0]), .Ci(0),  .Cout(c1) ,.S(zi[0]));
  sum1bcc s1 (.A(xi[1]), .B(yi[1]), .Ci(c1), .Cout(c2) ,.S(zi[1]));
  sum1bcc s2 (.A(xi[2]), .B(yi[2]), .Ci(c2), .Cout(c3) ,.S(zi[2]));
  sum1bcc s3 (.A(xi[3]), .B(yi[3]), .Ci(c3), .Cout(co) ,.S(zi[3]));



endmodule
```
A partir de esto se realiza un test bench, explicado a continuacion, mediante el cual podremos establecer que tan funcionales son los procesos creados y adicionalmente, sera posible visualizar realmente como esta trabajando el codigo.

```verilog
`timescale 1ns / 1ps

module sum4b_TB;

  // Se crea un registro con capacidad de 4 bits para cada variable de entrada
  reg [3:0] A;
  reg [3:0] B;

  // Se crean cables de salida que se interconectan en cada sumador de 1 bit para dar un resultado final
  wire co;
  wire [3:0] S;

  // en esta parte se instancian las variables creadas en el codigo top, el cual fue explicado anteriormente
  sum4b uut (
    .xi(A), 
    .yi(B), 
    .co(co), 
    .zi(S)
  );

  
  initial begin
  

  // Se generan las condiciones que dada una situacion deban realizar un procedimiento efectivo
    A=0;
	 for (B = 0; B < 16; B = B + 1) begin
      if (B==0)
        A=A+1;
      #2 ;
		$display("El valor de %d + %d = %d",A, B,S) ;
    end
	
  end      

  initial begin: TEST_CASE
     $dumpfile("sum4b_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end


endmodule
```
El test bench en ejecucion se vera de la siguiente manera:

![Sumador 4 bits](https://github.com/unal-edigital1-lab/lab00-sebrodriguezmor/blob/master/Imagenes/Simulacion%204%20bits.jpg?raw=true)













