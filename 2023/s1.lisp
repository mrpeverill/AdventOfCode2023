;; to setup slime in emacs:
(load (expand-file-name "~/quicklisp/slime-helper.el"))
  (setq inferior-lisp-program "/usr/bin/sbcl")

;; external library setup.
(ql:quickload "CL-ppcre")


;; part 1
(defun extractfldigitsum (string) "Extract the first and last digit concatenated"
  (setq numerals (ppcre:all-matches-as-strings "[0-9]" string))
  (parse-integer (concatenate 'string
                              (car numerals)
                              (nth (-(length numerals) 1) numerals))))

;; file load.
(apply '+ (mapcar 'extractfldigitsum (uiop:read-file-lines "~/advent2023/s1in.txt")))

;; slightly different examples from https://stackoverflow.com/questions/1495475/parsing-numbers-from-strings-in-lisp looks for floating point numbers in a string.
;; (defun parse-string-to-floats (line)
;;   (loop
;;     :with n := (length line)
;;     :for pos := 0 :then chars
;;     :while (< pos n)
;;     :for (float chars) := (multiple-value-list
;;             (read-from-string line nil nil :start pos))
;;     :collect float))

;;OR

;; (defun parse-string-to-float (line)
;;   (with-input-from-string (s line)
;;     (loop
;;       :for num := (read s nil nil)
;;       :while num
;;       :collect num)))



;; part 2
;; good thing we used the regex!
;;
;; https://stackoverflow.com/questions/4439326/position-of-all-matching-elements-in-list
;; changed eq to qual per https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node74.html
(defun get-number-index (needle)
  (setq haystack '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"))
  (let ((result nil))
    (dotimes (i (length haystack))
      (if (equal (nth i haystack) needle)
          (push i result)))
    (mod (car (nreverse result)) 10)))


;; you can use a look behind to get overlapping matches https://stackoverflow.com/questions/35458195/pcre-regular-expression-overlapping-matches
;; crucial help on the clisp implementation https://www.reddit.com/r/lisp/comments/1duu4yx/help_with_clppcre_sbcl_and_a_gnarly_regex_please/
(defun extractfldigitsum2 (string) "Extract the first and last digit, or number, and sum them"
  (let ((nums1))
    (cl-ppcre:do-register-groups (num)
        ("(?=(one|two|three|four|five|six|seven|eight|nine|[1-9]))"
         string)
      (push num nums1))


    (let ((nums2 (mapcar 'get-number-index (nreverse nums1))))
      (parse-integer (concatenate 'string
                                  (write-to-string (car nums2))
                                  (write-to-string (nth (-(length nums2) 1) nums2)))))))

(apply '+ (mapcar 'extractfldigitsum2 (uiop:read-file-lines "~/advent2023/s1in.txt")))
