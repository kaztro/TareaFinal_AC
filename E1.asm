org	100h

section	.text

	call modG
	xor	di, di
	xor	si, si

lupi_1:	
    mov	cx, 20d		
	add	cx, si
	mov	dx, 30d
	add	dx, di
	call pixel
	inc	di
	cmp	di, 201d
	jne	lupi_1
	xor	di, di
	inc	si
	cmp	si, 151d
	jne	lupi_1
	mov	ah, 3d
	call cursor_1

	xor	di, di

lupi_2:	
    mov	ah, 0Eh 	
	mov	al, [welcome + di]
	mov	bl, 1111b
	int	10h
	inc	di
	cmp	di, len_1
	jl lupi_2

	xor	di, di

lupi_3:	
    call kb 		
	cmp	al, 0Dh
	je write
	cmp	al, 40h
	je esp_1

cont:	
    mov	[400h + di], al
	inc	di
	jmp	lupi_3	

write:	
    mov	[360h], di
	cmp	di, 70d
	jg error
	cmp	di, 50d
	jl error

	xor	ah, ah
	mov	ah, 3d
	call cursor_2
	xor	si, si

lupi_4:	
    mov	ah, 0Eh 	
	mov	al, [400h + si]
	mov	bl, 1110b
	int	10h
	cmp	si, 17d
	je line_1
	cmp	si, 35d
	je line_2
	cmp	si, 53d
	je line_3

cont1:	
    inc	si
	cmp	si, di
	jle	lupi_4

	mov	ah, 5d
	call cursor_1
	xor	di, di

lupi_5:	
    mov	ah, 0Eh 	
	mov	al, [continue + di]
	mov	bl, 0010b
	int	10h
	inc	di
	cmp	di, len_3
	jl lupi_5

	call kb
	cmp	al, 0Dh
	je	new
	int	20h

new:	
    mov	ax, 0000h
	int	10h
	call modG
	xor	di, di
	xor	si, si

lupi_6:	
    mov	cx, 20d		
	add	cx, si
	mov	dx, 30d
	add	dx, di
	call pixel
	inc	di
	cmp	di, 201d
	jne	lupi_6
	xor	di, di
	inc	si
	cmp	si, 151d
	jne	lupi_6

	xor	ah, ah
	mov	ah, 3d
	call cursor_2
	xor	si, si

lupi_7:	
    mov	ah, 0Eh 	
	mov	al, [400h+si]
	add	al, 20h
	cmp	al, 40h
	je esp_2

cont3:	
    mov	bl, 1110b
	int	10h
	cmp	si, 17d
	je line_4
	cmp	si, 35d
	je line_5
	cmp	si, 53d
	je line_6

cont2:	
    inc	si
	cmp	si, [360h]
	jle	lupi_7
	call kb
	int	20h

line_1:	
    mov	ah, 4d		
	call cursor_2
	jmp	cont1

line_2:	
    mov	ah, 5d
	call cursor_2
	jmp	cont1

line_3:	
    mov	ah, 6d
	call cursor_2
	jmp	cont1

line_4:	
    mov	ah, 4d
	call cursor_2
	jmp	cont2

line_5:	
    mov	ah, 5d
	call cursor_2
	jmp	cont2

line_6:	
    mov	ah, 6d
	call cursor_2
	jmp	cont2

modG:
    mov	ah, 00h
	mov	al, 12h
	int	10h
	ret

clean:
    mov	ah, 00h
	mov	al, 03h
	int	10h
	ret

pixel:	
    mov	ah, 0Ch			
	mov	al, 1110b
	int 10h
	ret

cursor_1:	
    mov	dh, ah			
	mov	dl, 25d
	mov	bh, 0d
	mov	ah, 02h
	int	10h
	ret

cursor_2:	
    mov	dh, ah
	mov	dl, 3d
	mov	bh, 0d
	mov	ah, 02h
	int	10h
	ret

esp_1: 
    mov	al, 20h		
	jmp	cont

esp_2:
    mov	al, 20h
	jmp	cont3

error:	
    mov	ah,3d
	call cursor_1
	xor	di, di

errr:	
    mov	ah, 0Eh 	
	mov	al, [err+di]
	mov	bl, 0100b
	int	10h
	inc	di
	cmp	di, len_2
	jl	errr
	call kb
	int	20h

kb: 	
    mov	ah, 00h
	int 16h
	ret

section	.data
welcome	db "Parrafo en MAYUSCULAS. [Enter] Para enviar"
len_1 equ $-welcome
err	db "Debe ser en MAYUSCULAS con 50 o 70 caracteres"
len_2 equ $-err
continue db	"Continuar con el proceso? (enter <YES> | esc <NO>)"
len_3 equ $-continue