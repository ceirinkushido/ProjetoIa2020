;;; Tabuleiros
(defun teste ()
  "Funcao que representa um tabuleiro de teste"
  '(
(
     (0 0 0 (b r a o) ) 
     (0 0 0 (p r a o) )  
     (0 0 0 (b r b o) ) 
     (0 0 0 (b r a c))
     )
    (
     (p r b o)
     (b q a o)
     (p q a o)
     (b q b o)
     (p q b o)
     (b r a c)
     (p r a c)
     (b r b c)
     (p r b c)
     (b q a c)
     (p q a c)
     (b q b c)
     (p q b c)
     )
    ) 
)

;;; Funcao que recebe uma lista que contem um tabuleiro com reservas de pecas e devolve o tabuleiro
(defun tabuleiro (table)
  (car table))

;;; Funcao que recebe uma lista que contem um tabuleiro com reservas de pecas e devolve a reserva de pecas.
(defun reserva (table)
  (cadr table))

;;; Funcao que recebe um indice e o tabuleiro e retorna uma lista que representa essa linha do tabuleiro.
(defun linha (index table)
  (cond
   ((= index 0) (car table))
   (t (linha (1- index) (cdr table)))))

;;; Funcao que recebe um indice e o tabuleiro e retorna uma lista que representa essa coluna do tabuleiro
(defun coluna (index table)
  (cond
   ((null table) nil)
   (t (cons (linha index (car table)) (coluna index (cdr table)))) ))

;;; Funcaoo que recebe dois indices (linha e coluna) e o tabuleiro e retorna o valor presente nessa celula do tabuleiro
(defun celula (x y table)
  (nth y (nth x table)))

;;; Funcao que recebe um tabuleiro e retorna uma lista que representa uma diagonal desse tabuleiro.
;;; (diagonal-1 (tabuleiro (teste))) -> ((branca redonda alta oca) (preta redonda alta oca) (branca redonda baixa oca) 0)
(defun diagonal-1(table)
  (if (null table) '()
  (cons (caar table) (diagonal-1 (mapcar #'cdr (cdr table))))))

;;; Funcao que recebe um tabuleiro e retorna uma lista que representa uma diagonal desse tabuleiro.
;;; (diagonal-2 (tabuleiro (teste))) -> (0 0 0 0)
(defun diagonal-2(table)
  (diagonal-1 (reverse table)))

;;; Funcao que recebe dois indices (linha e coluna) e o tabuleiro e devolve T se a casa estiver vazia e NIL caso contrario.
;;; O valor de uma casa vazia no Problema do Quatro tem o valor 0.
;;; (casa-vaziap 0 1 (tabuleiro (teste))) -> T
;;; (casa-vaziap 0 0 (tabuleiro (teste))) -> NIL
(defun casa-vaziap (line col table)
  (cond 
   ((atom (celula line col table)) T )
   (NIL)))

;;; Funcao que recebe uma peca e uma lista com as pecas de reserva e devolve uma nova lista sem essa peca
(defun remover-peca (piece reserved-pieces)
  (cond
   ((null reserved-pieces) NIL)
   ((equal piece (car reserved-pieces))
    (remover-peca piece (cdr reserved-pieces)))
   (T (cons (car reserved-pieces) (remover-peca piece (cdr reserved-pieces))))))

;;; Funcao que recebe um indice, uma peca e uma lista que representara uma linha do tabuleiro
;;;  e substitui pelo valor pretendido nessa posicao.
(defun substituir-posicao (index piece line)
  (cond
   ((null line) nil)
   ((= index -1) (append (cons (car line) nil) (substituir-posicao index piece (cdr line))))
   ((= index 0) (append (cons piece nil) (substituir-posicao (1- index) piece (cdr line))))
   (t (append (cons (car line) nil) (substituir-posicao (1- index) piece (cdr line)))) ))

;;; Funcao que recebe dois indices (linha e coluna), uma peca e o tabuleiro.
;;; A funcao devera retornar o tabuleiro com a celula substituida pelo valor pretendido. 
(defun substituir (line col piece table)
  (cond ((null table) nil)
        ((= line 0) (cons (substituir-posicao col piece (car table)) 
                          (substituir (1- line) col piece (cdr table))))
        (t (cons (car table) (substituir (1- line) col piece (cdr table))))))

;;Recebe um tabuleiro  e verifica se existe 4 propriedades iguais nas peças.
(defun verifica-propriedades (lista-pecas &optional (index 0))
  (cond 
   ((and (< index 3) (comparar-linha-coluna(linha index lista-pecas)) (comparar-linha-coluna(coluna index lista-pecas)))
    (verifica-propriedades lista-pecas (+ 1 index))) 
   ((or (not(comparar-linha-coluna (linha index lista-pecas) )) (not(comparar-linha-coluna (coluna index lista-pecas)))
        (not(comparar-linha-coluna (diagonal-1 lista-pecas)))  (not(comparar-linha-coluna (diagonal-2 lista-pecas))))  
    T)
   (nil)))

;; Todas as pecas diferentes de 0 e qualquer combinação das 4 propriedadades iguais 
(defun comparar-linha-coluna (linha)
  (cond (
         (and
          (not(equal 0 (car linha))) (not(equal 0 (cadr linha))) (not(equal 0 (caddr linha))) (not(equal 0 (cadddr linha))) 
          (or (and
               (equal (car (first linha)) (car (second linha))) (equal (car (second linha)) (car (third linha))) 
               (equal (car (third linha)) (car (fourth linha))) )  
              (AND
               (equal (cadr (first linha)) (cadr (second linha))) (equal (cadr (second linha)) (cadr (third linha))) 
               (equal (cadr (third linha)) (cadr (fourth linha))) ) 
              (AND
               (equal (caddr (first linha)) (caddr (second linha))) (equal (caddr (second linha)) (caddr (third linha))) 
               (equal (caddr (third linha)) (caddr (fourth linha))) ) 
              (AND
               (equal (cadddr (first linha)) (cadddr (second linha)))
               (equal (cadddr (second linha)) (cadddr (third linha)))
               (equal (cadddr (third linha)) (cadddr (fourth linha))) )) ) nil)
        (t)))