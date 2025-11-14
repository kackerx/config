;; extends
;; 高亮 return 关键字
"return" @return

;; 高亮 err 关键字
((identifier) @return
 (#eq? @return "err"))
