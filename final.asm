ld r7, 1 
         
         
ld r6, 25
movA r6
add r7
movR r6
add r6
add r6
add r6
add r6
add r6
add r6
add r6
sub r7
movR r6
         
 ld r1, 0
 movA r1 
 add r7  
 movR r1 
 sw r1   
         
cmp 2047
jn +2
jump 15
         
sub r6
cmp 2047
jn +2
jump 15
         
sub r6
cmp 2047
jn +2
jump 15
         
sub r6
cmp 1243
jz +2
jump 15
         
 ld r1, 2
         
movA r1  
cmp 85   
 jz +33
 jn +34
         
movA r1
movR r2
         
         
movA r2  
add r1   
movR r2  
movA r0  
sw r2    
movA r2  
         
cmp 2047
jn +2
jump 43
         
sub r6
cmp 2047
jn +2
jump 43
         
sub r6
cmp 2047
jn +2
jump 43
         
sub r6
cmp 1243
jz +3
jn +2
jump 43
         
         
movA r1
add r7
movR r1
lw r1
cmp 0
jz -5    
jump 37
         
         
ld r1, 2 
         
         
         
movA r1  
         
cmp 2047 
jn +2    
jump 101 
         
sub r6   
cmp 2047 
jn +2    
jump 101 
         
sub r6   
cmp 2047 
jn +2    
jump 101 
         
sub r6   
cmp 1243 
jz +32   
jump 101 
         
         
 lw r1   
 cmp 0   
 jz +2   
 movR r4 
         
         
 movA r1
 add r7
 movR r1
 jump 75 



; ld r7, 1
; ld r1, 0
; movA r1 
; add r7  
; movR r1 
; sw r1   
; cmp 7384
; jz -4   
; ld r1, 2
; movA r1
; cmp 85 
; jz 19
;        
; movA r1
; add r1 
; movR r2
; movA r0
; sw r2  
; movA r2
; cmp 7384
; jz 3
; jn 2
; jump 12
;        
; movA r1
; add r7
; movR r1
; lw r1
; cmp 0
; jz -5
; jump 9
;
; ld r1, 2
;         
; movA r1
; cmp 7384
; jz 32
;         
; lw r1
; cmp 0
; jz 2
; movR r4
;         
; movA r1
; add r7
; movR r1
; jump 31
