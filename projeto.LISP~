;;; This File Loads required files and handles user interaction
(load "~/desktop/ProjetoIa2020/puzzle.lisp" ::if-does-not-exist nil)
(load "~/desktop/ProjetoIa2020/procura.lisp" ::if-does-not-exist nil)

(defun load-problem (number algorithm)
  (let 
      ( (problem (with-open-file (stream "~/desktop/ProjetoIa2020/problemas.dat") (skip-line stream number)) ) ) 
    (cond
     ((equal problem :eof) "Eof: please check problem number")
     (t (run-algorithm problem algorithm)))))

(defun skip-line (file number)
  (cond 
   ( (> number 1) (read file nil :eof) (skip-line file (- number 1)))
   (t(read file nil :eof))))

(defun run-algorithm(table algorithm)
  (cond
   ((equal algorithm 'bfs) "bfs")
   ((equal algorithm 'dfs) (table))
   ((equal algorithm 'a*) "a*")
   (t "Not the right algorithm")))