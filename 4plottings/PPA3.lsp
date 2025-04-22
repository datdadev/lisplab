(defun c:PPA3 ( / ss i ent entData pt1 pt2 pdfName userBase numStr saveDir total useXX )
  ;; Ask user for base filename (optionally containing 'XX')
  (setq userBase (getstring T "\nEnter base filename (optionally include 'XX', e.g., A3_01.01.03.XX.00): "))
  (setq useXX (vl-string-search "XX" userBase)) ;; will be NIL if "XX" not found

  ;; Set output directory relative to drawing location
  (setq saveDir (strcat (getvar "DWGPREFIX") "output\\"))
  (vl-mkdir saveDir)

  ;; Disable dialog boxes
  (setvar 'CMDDIA 0)
  (setvar 'FILEDIA 0)
  (setvar 'EXPERT 5)

  ;; Select all closed LWPOLYLINEs on layer "PRINT_A3"
  (setq ss (ssget '((0 . "LWPOLYLINE") (8 . "PRINT_A3") (-4 . "&=") (70 . 1))))

  (if ss
    (progn
      (setq total (sslength ss))
      (setq i (1- total))  ;; Start from last entity

      (while (>= i 0)
        (setq ent (ssname ss i))
        (setq entData (entget ent))

        ;; Extract all vertex points
        (setq pts '())
        (foreach d entData
          (if (= (car d) 10)
            (setq pts (cons (cdr d) pts))
          )
        )
        (setq pts (reverse pts))

        ;; Get bounding box
        (setq pt1 (list (apply 'min (mapcar 'car pts)) (apply 'min (mapcar 'cadr pts))))
        (setq pt2 (list (apply 'max (mapcar 'car pts)) (apply 'max (mapcar 'cadr pts))))

        ;; Prepare filename
        (if useXX
          (progn
            (setq numStr (if (< (- total i) 10)
                             (strcat "0" (itoa (- total i)))
                             (itoa (- total i))))
            (setq pdfName (strcat saveDir (vl-string-subst numStr "XX" userBase) ".pdf"))
          )
          (setq pdfName (strcat saveDir userBase ".pdf")) ;; use exact name if no XX
        )

        ;; Plot to PDF (Portrait A3)
        (command "._-plot"
                 "Yes"
                 "Model"
                 "AutoCAD PDF (High Quality Print).pc3"
                 "ISO full bleed A3 (420.00 x 297.00 MM)"
                 "Millimeters"
                 "Portrait"
                 "No"
                 "Window"
                 pt1 pt2
                 "Fit"
                 "Center"
                 "Yes"
                 "monochrome.ctb"
                 "Yes"
                 "Wireframe"
                 pdfName
                 "No"
                 "Yes"
        )

        (setq i (1- i))
      )
      (prompt "\n✅ Done plotting all rectangles in Portrait.")
    )
    (prompt "\n⚠️ No A3 rectangles found on PRINT_A3 layer.")
  )

  ;; Restore dialog settings
  (setvar 'CMDDIA 1)
  (setvar 'FILEDIA 1)
  (setvar 'EXPERT 0)
  (princ)
)
