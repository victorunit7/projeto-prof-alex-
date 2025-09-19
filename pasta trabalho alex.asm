; Conversor Celsius -> Fahrenheit (NeanderWin)
; Fórmula: F = (C * 9 / 5) + 32
ORG 0

; --- copia Celsius para trabalho ---
LDA CELSIUS
STA TEMP_C

; --- PROD = 0 ---
LDI 0
STA PROD

; --- CONT_MUL = 9 (multiplicador) ---
LDI 9
STA CONT_MUL

MUL_LOOP:
    LDA PROD
    ADD TEMP_C
    STA PROD
    LDA CONT_MUL
    SUB UM
    STA CONT_MUL
    JZ DIVISAO
    JMP MUL_LOOP

DIVISAO:
    ; Inicializa quociente e resto
    LDI 0
    STA QUOCIENTE
    LDA PROD
    STA RESTO

DIV_LOOP:
    LDA RESTO
    SUB CINCO
    JN FIM_DIV    ; se negativo, não dá mais para subtrair -> fim da divisão
    STA RESTO
    LDA QUOCIENTE
    ADD UM
    STA QUOCIENTE
    JMP DIV_LOOP

FIM_DIV:
    ; soma 32 para converter
    LDA QUOCIENTE
    ADD TRINTA2
    STA FAHREN
    OUT 0         ; mostra no visor (dispositivo 0)
    HLT

; -----------------------
; Dados / constantes
; -----------------------
CELSIUS:   DB 10    ; <- altere aqui para testar outra temperatura em °C
CINCO:      DB 5
UM:         DB 1
TRINTA2:    DB 32

; variáveis de trabalho
TEMP_C:     DB 0
PROD:       DB 0
CONT_MUL:   DB 0
QUOCIENTE:  DB 0
RESTO:      DB 0
FAHREN:     DB 0
