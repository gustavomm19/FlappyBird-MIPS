# Gustavo Márquez - Edward Pizzurro. Los Cracks
# Flappy Bird
# Unidad 4x4 pixels
# Display 512x512 pixels
# Base Addr Display: 0x10000000 (global data)
# Filas: 128 (0-127)

.data
	#Colores
	.space 999999
	blanco: .word 0xFFFFFF
	grisClaro: .word 0xFAFAFA
	darkGrey: .word 0x1E1E1E
	verdePipes: .word 0x6BE724
	pico: .word 0xDB3636
	colorBird1: .word 0xFF0000 #rojo
	colorBird2: .word 0x40FF00 #verde
	colorBird3: .word 0x0040FF #azul
	azul: .word 0x14E1FE
	verdeClaro: .word 0x80cd2c
	verdeOscuro: .word 0x17a41a
	jumpLine: .asciiz "\n"
	prueba: .asciiz "works"
	color: .word 0xfae33e
	puntaje: .word 0
	msgFin: .asciiz "Ha terminado el juego. Tu puntaje es: "
	msgAgain: .asciiz "Quieres jugar de nuevo?"
	
	
	
.text

.eqv base, 0x10000000

# <<<<<<<<<<<<<<<<<<<<<< MACROS >>>>>>>>>>>>>>>>>>>>>>>>>>
.macro pintarMapa()
	li $t0, 0
	lw $t1, azul
loop:
	sw $t1, base($t0)
	addi $t0, $t0, 4
	blt $t0, 65538, loop
.end_macro





.macro pintarColumna($posi, $color)
	li $t6, 512
	loopc:
	sw $color, 0($posi)
	addi $posi, $posi, 512
	subi $t6, $t6, 1
	bgtz $t6, loopc
.end_macro



.macro pintarPipe($pos1)
	
	move $s3, $pos1
	addi $pos1, $pos1, base
	
	#primera columna
	lw $t1, darkGrey
	pintarColumna($pos1, $t1)
	
	#segunda columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4
	lw $t1, verdeClaro 
	pintarColumna($pos1, $t1)
	
	#tercera columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 8
	lw $t1, verdeClaro 
	pintarColumna($pos1, $t1)
	
	#cuarta columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 12
	lw $t1, verdeClaro 
	pintarColumna($pos1, $t1)
	
	#quinta columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 16
	lw $t1, verdeOscuro 
	pintarColumna($pos1, $t1)
	
	#sexta columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 20
	lw $t1, verdeOscuro 
	pintarColumna($pos1, $t1)
	
	#septima columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 24
	lw $t1, verdeOscuro 
	pintarColumna($pos1, $t1)
	
	#octava columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 28
	lw $t1, verdeOscuro 
	pintarColumna($pos1, $t1)
	
	#novena columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 32
	lw $t1, verdeOscuro 
	pintarColumna($pos1, $t1)
	
	#decima columna
	move $pos1, $s3
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 36
	lw $t1, darkGrey
	pintarColumna($pos1, $t1)
.end_macro 


.macro pintarFila($posi, $color, $pixels)
	loopf:
	sw $color, 0($posi)
	addi $posi, $posi, 4
	subi $pixels, $pixels, 1
	
	bgtz $pixels, loopf
.end_macro


.macro chocar()
	beq $s4, $zero, salir
	beq $s4, 0x80cd2c, salir
	beq $s4, 0x17a41a, salir
	beq $s4, 0x1E1E1E, salir
.end_macro 


.macro pintarPajaro($pos1)
	move $s1, $pos1
	addi $pos1, $pos1, base
	
	#primera fila
	#li $s2, 8
	#pintarFila($pos1, $zero, $s2
	sw $zero, 0($pos1)
	sw $zero, 4($pos1)
	sw $zero, 8($pos1)
	sw $zero, 12($pos1)
	sw $zero, 16($pos1)
	sw $zero, 20($pos1)
	sw $zero, 24($pos1)
	sw $zero, 28($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	subi $pos1, $pos1, 512
	
	lw $s4, 0($pos1)
	chocar()
	
	lw $s4, 4($pos1)
	chocar()
	
	lw $s4, 8($pos1)
	chocar()
	
	lw $s4, 12($pos1)
	chocar()
	
	lw $s4, 16($pos1)
	chocar()
	
	lw $s4, 20($pos1)
	chocar()
	
	lw $s4, 24($pos1)
	chocar()
	
	lw $s4, 28($pos1)
	chocar()
	
	
	
	#segunda fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 504
	sw $zero, 0($pos1)
	sw $zero, 4($pos1)
	lw $t1, colorBird1
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $zero, 28($pos1)
	lw $t1, grisClaro
	sw $t1, 32($pos1)
	sw $t1, 36($pos1)
	sw $zero, 40($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	
	lw $s4, -8($pos1)
	chocar()
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 32($pos1)
	chocar()
	
	
	#tercera fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 1012
	sw $zero, 0($pos1)
	lw $t1, colorBird1
	sw $t1, 4($pos1)
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $zero, 28($pos1)
	lw $t1, grisClaro
	sw $t1, 32($pos1)
	sw $t1, 36($pos1)
	sw $t1, 40($pos1)
	sw $t1, 44($pos1)
	sw $zero, 48($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 504
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 44($pos1)
	chocar()
	
	
	#cuarta fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 1520
	sw $zero, 0($pos1)
	lw $t1, colorBird1
	sw $t1, 4($pos1)
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $t1, 28($pos1)
	sw $zero, 32($pos1)
	lw $t1, grisClaro
	sw $t1, 36($pos1)
	sw $t1, 40($pos1)
	sw $t1, 44($pos1)
	sw $zero, 44($pos1)
	sw $t1, 48($pos1)
	sw $zero, 52($pos1)
	
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 1012
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 52($pos1)
	chocar()
	
	
	#quinta fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 2028
	sw $zero, 0($pos1)
	lw $t1, colorBird1
	sw $t1, 4($pos1)
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $zero, 36($pos1)
	lw $t1, grisClaro
	sw $t1, 40($pos1)
	sw $t1, 44($pos1)
	sw $zero, 48($pos1)
	sw $t1, 52($pos1)
	sw $zero, 56($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 1520
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 56($pos1)
	chocar()
	
	
	#sexta fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 2540
	sw $zero, 0($pos1)
	sw $zero, 4($pos1)
	sw $zero, 8($pos1)
	sw $zero, 12($pos1)
	sw $zero, 16($pos1)
	lw $t1, colorBird1
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $t1, 36($pos1)
	sw $zero, 40($pos1)
	lw $t1, grisClaro
	sw $t1, 44($pos1)
	sw $t1, 48($pos1)
	sw $t1, 52($pos1)
	sw $zero, 56($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 2028
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 60($pos1)
	chocar()
	
	
	#septima fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3048
	
	sw $zero, 0($pos1)
	lw $t1, colorBird3
	sw $t1, 4($pos1)
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $zero, 24($pos1)
	lw $t1, colorBird1
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $t1, 36($pos1)
	sw $t1, 40($pos1)
	sw $t1, 44($pos1)
	sw $zero, 48($pos1)
	sw $zero, 52($pos1)
	sw $zero, 56($pos1)
	sw $zero, 60($pos1)
	sw $zero, 64($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 2540
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 60($pos1)
	chocar()
	
	
	#octava fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3560
	sw $zero, 0($pos1)
	lw $t1, colorBird1
	sw $t1, 4($pos1)
	lw $t1, colorBird3
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	lw $t1, colorBird1
	sw $t1, 20($pos1)
	sw $zero, 24($pos1)
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $t1, 36($pos1)
	sw $t1, 40($pos1)
	sw $zero, 44($pos1)
	lw $t1, pico
	sw $t1, 48($pos1)
	sw $t1, 52($pos1)
	sw $t1, 56($pos1)
	sw $t1, 60($pos1)
	sw $t1, 64($pos1)
	sw $zero, 68($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3048
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 68($pos1)
	chocar()
	
	
	#novena fila (I WANT TO DIE)
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4076
	sw $zero, 0($pos1)
	sw $zero, 4($pos1)
	sw $zero, 8($pos1)
	sw $zero, 12($pos1)
	sw $zero, 16($pos1)
	lw $t1, colorBird2
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $zero, 36($pos1)
	lw $t1, pico
	sw $t1, 40($pos1)
	sw $zero, 44($pos1)
	sw $zero, 48($pos1)
	sw $zero, 52($pos1)
	sw $zero, 56($pos1)
	sw $zero, 60($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3560
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 72($pos1)
	chocar()
	
	
	#decima fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4592
	sw $zero, 0($pos1)
	lw $t1, colorBird2
	sw $t1, 4($pos1)
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $zero, 36($pos1)
	lw $t1, pico
	sw $t1, 40($pos1)
	sw $t1, 44($pos1)
	sw $t1, 48($pos1)
	sw $t1, 52($pos1)
	sw $zero, 56($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4076
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 64($pos1)
	chocar()
	
	
	#ONCEAVA FILA
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 5108
	sw $zero, 0($pos1)
	sw $zero, 4($pos1)
	lw $t1, colorBird2
	sw $t1, 8($pos1)
	sw $t1, 12($pos1)
	sw $t1, 16($pos1)
	sw $t1, 20($pos1)
	sw $t1, 24($pos1)
	sw $t1, 28($pos1)
	sw $t1, 32($pos1)
	sw $zero, 36($pos1)
	sw $zero, 40($pos1)
	sw $zero, 44($pos1)
	sw $zero, 48($pos1)
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4592
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 60($pos1)
	chocar()
	
	
	
	#DOCEAVA FILAAA
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 5628
	sw $zero, 0($pos1)
	sw $zero, 4($pos1)
	sw $zero, 8($pos1)
	sw $zero, 12($pos1)
	sw $zero, 16($pos1)
	sw $zero, 20($pos1)
	sw $zero, 24($pos1)
	
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 5108
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 52($pos1)
	chocar()
	
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 5628
	
	lw $s4, -8($pos1)
	chocar()
	
	lw $s4, -4($pos1)
	chocar()
	
	lw $s4, 28($pos1)
	chocar()
	
	lw $s4, 32($pos1)
	chocar()
	
	lw $s4, 36($pos1)
	chocar()
	
	lw $s4, 40($pos1)
	chocar()
	
	
	#choque
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 6140
	
	lw $s4, 0($pos1)
	chocar()
	
	lw $s4, 4($pos1)
	chocar()
	
	lw $s4, 8($pos1)
	chocar()
	
	lw $s4, 12($pos1)
	chocar()
	
	lw $s4, 16($pos1)
	chocar()
	
	lw $s4, 20($pos1)
	chocar()
	
	lw $s4, 24($pos1)
	chocar()
	
	
.end_macro


.macro borrarBordeInf($pos1)
	move $s1, $pos1
	lw $t1, azul
	
	#doceava fila
	li $s2, 7
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 5628
	pintarFila($pos1, $t1, $s2)
	
	#onceava fila
	li $s2, 5
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 5108
	sw $t1, 0($pos1)
	sw $t1, 4($pos1)
	addi $pos1, $pos1, 32
	pintarFila($pos1, $t1, $s2)
	
	#decima fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4592
	sw $t1, 0($pos1)
	sw $t1, 56($pos1)
	
	#novena fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 4076
	sw $t1, 0($pos1)
	sw $t1, 60($pos1)
	
	#octava fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3560
	sw $t1, 0($pos1)
	sw $t1, 68($pos1)
.end_macro

.macro borrarBordeSup($pos1)
	move $s1, $pos1
	addi $pos1, $pos1, base
	lw $t1, azul
	
	#primera fila
	li $s2, 8
	pintarFila($pos1, $t1, $s2)
	
	#segunda fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 504
	sw $t1, 0($pos1)
	sw $t1, 4($pos1)
	sw $t1, 40($pos1)
	
	#tercera fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 1012
	sw $t1, 0($pos1)
	sw $t1, 48($pos1)
	
	#cuarta fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 1520
	sw $t1, 0($pos1)
	sw $t1, 52($pos1)
	
	#quinta fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 2028
	sw $t1, 0($pos1)
	sw $t1, 56($pos1)
	
	#sexta fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 2540
	sw $t1, 0($pos1)
	sw $t1, 56($pos1)
	
	#septima fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3048
	sw $t1, 0($pos1)
	sw $t1, 64($pos1)
	
	#octava fila
	move $pos1, $s1
	addi $pos1, $pos1, base
	addi $pos1, $pos1, 3560
	sw $t1, 68($pos1)
.end_macro

.macro abrirHueco()
	addi $t8, $t8, base
	addi $t8, $t8, 468
	li $a1, 41
	li $v0, 42
	syscall
	
	addi $t1, $a0, 30
	mul  $t1, $t1, 512
	
	#addi $t8, $t8, 11732
	add $t8, $t8, $t1
	lw $t1, darkGrey
	addi $s3, $t8, -512
	li $s2, 10
	pintarFila($s3, $t1, $s2)
	addi $s3, $t8, -3584
	li $s2, 10
	pintarFila($s3, $t1, $s2)
	lw $t1, azul
	li $t7, 12800
loopA:
	li $s2, 10
	pintarFila($t8, $t1, $s2)
	addi $t8, $t8, 472
	addi $t7, $t7, -512
	bgtz $t7, loopA
	li $s2, 10
	lw $t1, darkGrey
	pintarFila($t8, $t1, $s2)
	addi $t8, $t8, 3544
	li $s2, 10
	pintarFila($t8, $t1, $s2)
	
.end_macro


.macro movePipe()
moverPipes:
	li $s1, 0
	beq $t9, 268435456, specialCase		#Si la pipe está al borde del mapa hay que moverla diferente
	lw $t7, 0($t9)				#buscamos en la primera fila del bitmap
	move $t8, $t9
	bne $t7, 0x14E1FE, encontrada		#si el color en esa posicion es diferente de azul, encontramos una tuberia
	bge $t9, 268435964, loopFall
	addi $t9, $t9, 4
	b moverPipes
encontrada:
	#lw $t7, -4($t8)
	#beq $t7, $zero, salir
	lw $t7, 0($t8)
	sw $t7, -4($t8)				#pintamos ese color, un pixel a la izquierda
	addi $t8, $t8, 4
	addi $s1, $s1, 4
	bne $t7, 0x14E1FE, encontrada		#si el ultimo color que pintamos es azul, ya terminamos de mover una fila
	sub $t8, $t8, $s1			#movemos el apuntador hacia la izquierda la cantidad de veces que movimos un pixel
	addi $t8, $t8, 512			#movemos el apuntador una fila hacia abajo
	bgt $t8, 268500984, exit
	
nextLine:
	li $s1, 0
	lw $t7, 0($t8)
	#bne $t7, 0x14E1FE, encontrada
	beq $t7, 0x1E1E1E, encontrada
	beq $t7, 0x80cd2c, encontrada
	beq $t7, 0x17a41a, encontrada
	addi $t8, $t8, 512
	b nextLine
	
exit:
	addi $t9, $t9, 36
	b moverPipes
	
specialCase:
	lw $t7 0($t9)
	move $t8, $t9
	bne $t7, 0x14E1FE, borrar
	addi $t9, $t9, 4
	b moverPipes
borrar:
	lw $t7, azul
	pintarColumna($t8, $t7)
	addi $t9, $t9, 4
	
	#puntaje sumar
	lw $s6,puntaje
	addi $s6,$s6,1
	sw $s6,puntaje
	
	b moverPipes
.end_macro

.macro generarNewPipe()
generarPipe:
	li $v0, 30
	syscall
	blt $a0, $s5, sal
	li $t7, 468
	pintarPipe($t7)
	li $t8, 0
	abrirHueco()
	li $v0, 30
	syscall
	addi $s5, $a0, 5000
sal:
.end_macro
	
		
# <<<<<<<<<<<<<<<<<<<<<<FIN DE LAS MACROS>>>>>>>>>>>>>>>>>>>>>>>>>>	

#~~~~~~~~~~~~~ REGISTROS USADOS ~~~~~~~~~~~~~~~~~~~~
# $t0 posicion base para pintar
# $t1 contenedor de colores
# $t2 entrada de texto
# $t3 posicion en y del pajaro
# $t4 controlador de interrupcion
# $t5 controlador del salto
# $t6 auxiliar pintar columna
# $t7 posicion base de columnas
# $t8 generador de numero random
# $t9 buscador de pipes
# $s0 tiempo de retardo
# $s1 auxiliar de posicion base
# $s2 contador de pixeles para pintar
# $s3 auxiliar de pipe
# $s4 auxiliar choque
# $s5 tiempo de generar pipes
# $s6 puntaje auxiliar

Start:	
	
	li $t3, 29252
	li $t7, 468
	sw $zero,puntaje # Reiniciar puntaje
	pintarMapa()
	move $t0, $t3
	pintarPajaro($t0)
	pintarPipe($t7)
	li $t8, 0
	abrirHueco()
	li $v0, 30
	syscall
	addi $s5, $a0, 5000
	lw $t1, azul
	li $t9, 0
	add $t9, $t9, base
	
	
loopFall:
	li $v0, 30
	syscall
	addi $s0, $a0, 30
retardo:
	li $t5, 1
	lw $t4, 0xffff0000
	li $v0, 30
	syscall
	blt $a0, $s0, noFall
	move $t0, $t3
	borrarBordeSup($t0)
	addi $t3, $t3, 512
	move $t0, $t3
	pintarPajaro($t0)
	li $v0, 30
	addi $s0, $a0, 30
	li $t9, 0
	add $t9, $t9, base
	generarNewPipe()
	movePipe()
noFall:
	bne $t4, 1, retardo
	
	lw $t2, 0xffff0004
	beq $t2, 32, salto
	beq $t2, 80, pausa
	beq $t2, 112, pausa
	b retardo
	
salto:
	move $t0, $t3
	borrarBordeInf($t0)
	addi $t3, $t3, -512
	move $t0, $t3
	pintarPajaro($t0)
	beq $t3, 580, salir
	addi $t5, $t5, 1
	ble $t5, 8, salto
	li $t9, 0
	add $t9, $t9, base
	movePipe()
	b retardo

pausa:
	li $v0, 30
	syscall
	move $t8, $a0		#Tomamos el tiempo en que entramos a la pausa para no alterar el tiempo de generar pipes
thePausa:	
	lw $t4, 0xffff0000
	bne $t4, 1, thePausa
	li $v0, 30
	syscall
	sub $t7, $a0, $t8
	add $s5, $s5, $t7	#sumamos al tiempo para generar pipes, el tiemo transcurrido en la pausa
	lw $t2, 0xffff0004
	beq $t2, 80, retardo
	beq $t2, 112, retardo
	b pausa
	
	
salir:	# Mostrar Puntaje
	li $v0,56
	la $a0,msgFin
	lw $s6,puntaje
	div $s6,$s6,10
	sw $s6,puntaje
	lw $a1,puntaje
	syscall  

	li $v0,50
	la $a0,msgAgain
	syscall
	beq $a0,0, Start
	
	li $v0,10
	syscall

	
