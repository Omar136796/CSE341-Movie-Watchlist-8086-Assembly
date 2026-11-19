.MODEL SMALL
      

      
.STACK 100H  




.DATA

;;;;;;;;;;;;;;;;;;;;;; Feature 1 msg variables: login and registration ;;;;;;;;;;;;;;;;;;;;;;

; Main menu er messages
welcome_msg DB 0DH,0AH,'===== MOVIE WATCHLIST SYSTEM =====',0DH,0AH,'$'
menu_msg DB 0DH,0AH,'1. Register',0DH,0AH,'2. Login',0DH,0AH,'3. View All Users',0DH,0AH,'4. Exit',0DH,0AH,'Enter choice: $'
invalid_msg DB 0DH,0AH,'Invalid choice! Try again.',0DH,0AH,'$'

; Registration er messages
reg_header DB 0DH,0AH,'===== REGISTRATION =====',0DH,0AH,'$'
reg_user_prompt DB 'Enter username (max 15 chars): $'
reg_pass_prompt DB 0DH,0AH,'Enter password (max 15 chars): $'
reg_success DB 0DH,0AH,'Registration successful!',0DH,0AH,'$'
reg_exists DB 0DH,0AH,'Username already exists!',0DH,0AH,'$'
max_users_msg DB 0DH,0AH,'Maximum users reached (5)!',0DH,0AH,'$'

; Login er messages
login_header DB 0DH,0AH,'===== LOGIN =====',0DH,0AH,'$'
login_user_prompt DB 'Enter username: $'
login_pass_prompt DB 0DH,0AH,'Enter password: $'
login_success DB 0DH,0AH,'Login successful! Welcome!',0DH,0AH,'$'
login_fail DB 0DH,0AH,'Invalid credentials!',0DH,0AH,'$'
no_user_msg DB 0DH,0AH,'No user registered yet!',0DH,0AH,'$'

; Exit er message
exit_msg DB 0DH,0AH,'Thank you for using Movie Watchlist!',0DH,0AH,'$'


;;;;;;;;;;;;;;;;;;;;;; Feature 1 data variables: login and registration ;;;;;;;;;;;;;;;;;;;;;;

user_count DB 0                   ; max user 5 ta
usernames DB 80 DUP('$')          ; 5 ta user, 16 bytes each ; 5*16=80
passwords DB 80 DUP('$')          ; 5 ta user, 16 bytes each ; 5*16=80
roles DB 5 DUP(0)                 ; 5 ta user, 1 byte each (1=Admin, 2=User)
current_user_index DB 0           

; Temporary input buffers (input username and password hold korte)
input_username DB 16 DUP('$')
input_password DB 16 DUP('$')

; View users (3) er message
view_users_header DB 0DH,0AH,'===== REGISTERED USERS =====',0DH,0AH,'$'         ;users thakle ei msg
no_users_msg DB 0DH,0AH,'No users registered yet.',0DH,0AH,'$'                  ;users na thakle ei msg
user_label DB '. $'                                                             ; 1. Omar ; 1 er porer (. ) 
role_admin DB ' (Admin)$'                                                       ; 1. Omar (Admin); Omar er porer { (Admin)}
role_user DB ' (User)$'



;;;;;;;;;;;;;;;;;;;;;; Feature 2 msg variables: Admin and User view ;;;;;;;;;;;;;;;;;;;;;;

; Role selection er message
role_prompt DB 0DH,0AH,'Select role:',0DH,0AH,'1. Admin',0DH,0AH,'2. User',0DH,0AH,'Enter choice: $'
role_invalid DB 0DH,0AH,'Invalid role! Try again.',0DH,0AH,'$'


; Admin menu er message
admin_menu_header DB 0DH,0AH,'===== ADMIN MENU =====',0DH,0AH,'$'
admin_menu_msg DB '1. Add Movie to System',0DH,0AH,'2. Remove Movie from System',0DH,0AH,'3. View System Movies',0DH,0AH,'4. Logout',0DH,0AH,'Enter choice: $'

; User menu er message 
user_menu_header DB 0DH,0AH,'===== USER MENU =====',0DH,0AH,'$'
user_menu_msg DB '1. Add Movie to Watchlist',0DH,0AH,'2. Remove Movie from Watchlist',0DH,0AH,'3. Mark Movie Status',0DH,0AH,'4. View My Watchlist',0DH,0AH,'5. View System Movies',0DH,0AH,'6. Logout',0DH,0AH,'Enter choice: $'



;;;;;;;;;;;;;;;;;;;;;; Feature 2/3 msg variables: Movie Add ba Remove ;;;;;;;;;;;;;;;;;;;;;;

movie_prompt DB 0DH,0AH,'Enter movie name (max 20 chars): $'
genre_prompt DB 0DH,0AH,'Enter genre (max 20 chars): $'
date_prompt DB 0DH,0AH,'Enter release date (max 20 chars): $'
movie_added DB 0DH,0AH,'Movie added successfully!',0DH,0AH,'$'
movie_removed DB 0DH,0AH,'Movie removed successfully!',0DH,0AH,'$'
movie_not_found DB 0DH,0AH,'Movie not found!',0DH,0AH,'$'
movie_limit DB 0DH,0AH,'Movie list is full (max 10)!',0DH,0AH,'$'
movie_not_in_system DB 0DH,0AH,'Movie not in system! Only movies added by admin can be added to watchlist.',0DH,0AH,'$'
movie_already_exists DB 0DH,0AH,'Movie already exists in the list!',0DH,0AH,'$'
empty_list DB 0DH,0AH,'No movies in list.',0DH,0AH,'$'
system_movies_header DB 0DH,0AH,'===== SYSTEM MOVIES =====',0DH,0AH,'$'
watchlist_header DB 0DH,0AH,'===== MY WATCHLIST =====',0DH,0AH,'$'
movie_number DB '. $'
logout_msg DB 0DH,0AH,'Logged out successfully!',0DH,0AH,'$'


;;;;;;;;;;;;;;;;;;;;;; Feature 4 msg variables: Movie Status ;;;;;;;;;;;;;;;;;;;;;;

mark_status_prompt DB 0DH,0AH,'Enter movie number to mark: $'
status_menu DB 0DH,0AH,'Select status:',0DH,0AH,'1. Watched',0DH,0AH,'2. Planned to Watch',0DH,0AH,'3. Drop',0DH,0AH,'Enter choice: $'
status_updated DB 0DH,0AH,'Status updated successfully!',0DH,0AH,'$'
invalid_movie_num DB 0DH,0AH,'Invalid movie number!',0DH,0AH,'$'
status_watched DB ' [Watched]$'
status_planned DB ' [Planned]$'
status_drop DB ' [Drop]$'

;;;;;;;;;;;;;;;;;;;;;; Feature 2/3 data variables: Movie Add ;;;;;;;;;;;;;;;;;;;;;;

system_movies DB 630 DUP('$')             ; 10*63=630 bytes; max 10 ta movie, prottek ta 63 byte (21+21+21; character+$)
system_movie_count DB 0                   ; koyta movie system e ase currently


user_watchlists DB 3200 DUP('$')          ; (5*10*64) = 3200 byte ; 63+1 status byte 
user_watchlist_counts DB 5 DUP(0)         ; 5 ta users= 5*1 byte each

; Temporary input buffers (movie er jonno)

temp_movie DB 21 DUP('$')
temp_genre DB 21 DUP('$') 
temp_date DB 21 DUP('$')         
temp_full_movie DB 63 DUP('$')

; extra variables
newline DB 0DH,0AH,'$'
space DB ' $'

 
.CODE
MAIN PROC

; initialize DS

MOV AX,@DATA
MOV DS,AX
 
 
; enter your code here  

MOV AX, 0
MOV BX, 0
MOV CX, 0
MOV DX, 0

;;;;;;;;;;;;;;;;;;;;;; Feature 1 : login and registration (registration, login, view users, exit) ;;;;;;;;;;;;;;;;;;;;;;

MAIN_LOOP:
    ; Display welcome message
    LEA DX, welcome_msg
    MOV AH, 09H
    INT 21H
    
    ; Display menu
    LEA DX, menu_msg
    MOV AH, 09H
    INT 21H
    
    ; User er choice
    MOV AH, 01H
    INT 21H
    MOV BL, AL  ; Choice ta ke BL e store
    
    ; Check choice
    CMP BL, '1'
    JE REGISTER_USER
    
    CMP BL, '2'
    JE LOGIN_USER
    
    CMP BL, '3'
    JE VIEW_ALL_USERS
    
    CMP BL, '4'
    JE EXIT_PROGRAM
    
    ; Invalid choice
    LEA DX, invalid_msg
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP

;;;;;;;;;;;;;;;;;;;;;; Feature 1: user register (new user er username, password, role assign hoy) ;;;;;;;;;;;;;;;;;;;;;;

REGISTER_USER:
    ; maximum user hoise naki check
    CMP user_count, 5
    JGE MAX_USERS_REACHED
    
    ; Display registration header (==Registration== msg)
    LEA DX, reg_header
    MOV AH, 09H
    INT 21H
    
    ; username er prompt
    LEA DX, reg_user_prompt
    MOV AH, 09H
    INT 21H
    
    ; Read username into temp buffer
    LEA SI, input_username      ; SI, input_username array/buffer ke point kore
    CALL READ_STRING
    
    ; Check je username already ase naki
    CALL FIND_USER_BY_NAME
    CMP AL, 0FFH                           ; AL = 0FFH means not found
    JNE USERNAME_EXISTS
    
    ; Prompt for password
    LEA DX, reg_pass_prompt
    MOV AH, 09H
    INT 21H
    
    ; Read password into temp buffer
    LEA SI, input_password
    CALL READ_STRING
    
;;;;;;;;;;;;;;;;;;;;;; Feature 2: Role Selection ;;;;;;;;;;;;;;;;;;;;;;
    
SELECT_ROLE:
    ; Prompt for role selection
    LEA DX, role_prompt
    MOV AH, 09H
    INT 21H
    
    ; Get role choice
    MOV AH, 01H
    INT 21H
    
    ; Validate role
    CMP AL, '1'
    JE SET_ADMIN
    
    CMP AL, '2'
    JE SET_USER
    
    ; Invalid role
    LEA DX, role_invalid
    MOV AH, 09H
    INT 21H
    JMP SELECT_ROLE

SET_ADMIN:
    MOV BL, 1                       ; BL = role (Admin)
    JMP STORE_NEW_USER

SET_USER:
    MOV BL, 2                       ; BL = role (User)
    JMP STORE_NEW_USER

STORE_NEW_USER:
    MOV AL, user_count
    MOV AH, 0
    MOV CL, 16
    MUL CL                      ; AX = user_count * 16 (index*16)
    

    LEA SI, input_username
    LEA DI, usernames           
    ADD DI, AX                  ;user name buffer theke array te copy
    CALL COPY_STRING
    
    
    LEA SI, input_password
    LEA DI, passwords
    ADD DI, AX                  ;password buffer theke array te copy
    CALL COPY_STRING
    

    MOV AL, user_count
    MOV AH, 0
    LEA DI, roles
    ADD DI, AX
    MOV [DI], BL                    ;  role store kore roles array te
    
    INC user_count
    
    ; Display success message
    LEA DX, reg_success
    MOV AH, 09H
    INT 21H
    
    JMP MAIN_LOOP

MAX_USERS_REACHED:
    LEA DX, max_users_msg
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP

USERNAME_EXISTS:
    LEA DX, reg_exists
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP


;;;;;;;;;;;;;;;;;;;;;; Feature 1: User Login (Verifies credentials and routes to appropriate menu based on role) ;;;;;;;;;;;;;;;;;;;;;;

LOGIN_USER:
    ; Check if any user is registered
    CMP user_count, 0
    JE NO_USER
    
    ; Display login header
    LEA DX, login_header
    MOV AH, 09H
    INT 21H
    
    ; Prompt for username
    LEA DX, login_user_prompt
    MOV AH, 09H
    INT 21H
    
    ; Read username
    LEA SI, input_username
    CALL READ_STRING
    
    ; Prompt for password
    LEA DX, login_pass_prompt
    MOV AH, 09H
    INT 21H
    
    ; Read password
    LEA SI, input_password
    CALL READ_STRING
    
    ; Find user by username
    CALL FIND_USER_BY_NAME
    CMP AL, 0FFH                         ; AL = 0FFH means not found
    JE LOGIN_FAIL_MSG
    
    ; AL = user index, verify password
    MOV BL, AL  ; Save user index in BL
    CALL VERIFY_USER_PASSWORD
    CMP AL, 1   ; AL = 1 means password matches
    JNE LOGIN_FAIL_MSG
    
    ; Login successful
    MOV current_user_index, BL  ; Store logged-in user index
    
    LEA DX, login_success
    MOV AH, 09H
    INT 21H
    

    ;;;;;;;;;;;;;;;;;;;;;; Feature 2: Role based menu selection ;;;;;;;;;;;;;;;;;;;;;;
    
    ; Get role of current user
    MOV AL, BL  ; BL = user index
    MOV AH, 0
    LEA SI, roles
    ADD SI, AX
    MOV AL, [SI]                ; AL = role (1=Admin, 2=User)
    
    
    CMP AL, 1
    JE ADMIN_MENU
    
    CMP AL, 2
    JE USER_MENU
    
    
    JMP MAIN_LOOP               ; Fallback to main loop if role is invalid

LOGIN_FAIL_MSG:
    LEA DX, login_fail
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP

NO_USER:
    LEA DX, no_users_msg
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP


;;;;;;;;;;;;;;;;;;;;;; Feature 2: View all users (Displays list of all registered users with their roles) ;;;;;;;;;;;;;;;;;;;;;;

VIEW_ALL_USERS:
    CMP user_count, 0                       ; Check if any users registered
    JE NO_USER
    
    LEA DX, view_users_header               ; Display header
    MOV AH, 09H
    INT 21H
    
    MOV BL, 0                               ; BL = current index
    
DISPLAY_USER_LOOP:
    CMP BL, user_count
    JGE DISPLAY_USERS_DONE
    
    
    LEA DX, newline             ; Print newline
    MOV AH, 09H
    INT 21H
    
   
    MOV AL, BL
    INC AL
    ADD AL, 30H   ; Print user number (index + 1), Convert to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    ; Print ". "
    LEA DX, user_label
    MOV AH, 09H
    INT 21H
    
    ; Print username
    MOV AL, BL
    MOV AH, 0
    MOV CL, 16
    MUL CL
    LEA DX, usernames
    ADD DX, AX
    MOV AH, 09H
    INT 21H
    
    ; Print role
    MOV AL, BL
    MOV AH, 0
    LEA SI, roles
    ADD SI, AX
    MOV AL, [SI]
    
    CMP AL, 1
    JE PRINT_ADMIN_ROLE
    
    CMP AL, 2
    JE PRINT_USER_ROLE
    
    JMP NEXT_USER

PRINT_ADMIN_ROLE:
    LEA DX, role_admin
    MOV AH, 09H
    INT 21H
    JMP NEXT_USER

PRINT_USER_ROLE:
    LEA DX, role_user
    MOV AH, 09H
    INT 21H
    JMP NEXT_USER

NEXT_USER:
    INC BL
    JMP DISPLAY_USER_LOOP

DISPLAY_USERS_DONE:
    ; Print final newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP


EXIT_PROGRAM:
    LEA DX, exit_msg
    MOV AH, 09H
    INT 21H
    
    JMP EXIT

;;;;;;;;;;;;;;;;;;;;;; Feature 2: Admin Menu (Admin can add/remove/view system movies) ;;;;;;;;;;;;;;;;;;;;;;

ADMIN_MENU:
    
    LEA DX, admin_menu_header           ; Display admin menu header
    MOV AH, 09H
    INT 21H
    
    LEA DX, admin_menu_msg              ; Display admin menu options
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H                 ; Get admin choice
    INT 21H
    MOV BL, AL
    
    ; Check choice
    CMP BL, '1'
    JE ADD_SYSTEM_MOVIE
    
    CMP BL, '2'
    JE REMOVE_SYSTEM_MOVIE
    
    CMP BL, '3'
    JE VIEW_SYSTEM_MOVIES
    
    CMP BL, '4'
    JE LOGOUT
    
    ; Invalid choice
    LEA DX, invalid_msg
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

ADD_SYSTEM_MOVIE:
    CMP system_movie_count, 10
    JGE SYSTEM_FULL
    
    LEA DX, movie_prompt
    MOV AH, 09H
    INT 21H
    
    LEA SI, temp_movie                  ; Read movie name
    CALL READ_STRING_MOVIE
    
    LEA SI, temp_movie                  ; Check if movie already exists in system (search by name only)
    LEA DI, system_movies
    MOV CL, system_movie_count
    CALL FIND_MOVIE_IN_LIST
    
    CMP AL, 1
    JE SYSTEM_MOVIE_EXISTS
    
    LEA DX, genre_prompt
    MOV AH, 09H
    INT 21H
    
    LEA SI, temp_genre
    CALL READ_STRING_MOVIE
    
    LEA DX, date_prompt
    MOV AH, 09H
    INT 21H
    
    LEA SI, temp_date
    CALL READ_STRING_MOVIE
    
    MOV AL, system_movie_count          ; Calculate position in system_movies array
    MOV BL, 63
    MUL BL                              ; AX = count * 63
    LEA DI, system_movies
    ADD DI, AX                          ; DI = position for new movie
    
    LEA SI, temp_movie                  ; Copy movie name (21 bytes)
    CALL COPY_STRING
    
    ADD DI, 21                          ; Move to genre position
    LEA SI, temp_genre
    CALL COPY_STRING
    
    ADD DI, 21                          ; Move to date position
    LEA SI, temp_date
    CALL COPY_STRING
    

    INC system_movie_count              ; Increment count
    
    LEA DX, movie_added                 ; Display success
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

SYSTEM_MOVIE_EXISTS:
    LEA DX, movie_already_exists
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

SYSTEM_FULL:
    LEA DX, movie_limit
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

REMOVE_SYSTEM_MOVIE:

    CMP system_movie_count, 0
    JE SYSTEM_EMPTY
    
    ; Prompt for movie name
    LEA DX, movie_prompt
    MOV AH, 09H
    INT 21H
    
    ; Read movie name
    LEA SI, temp_movie
    CALL READ_STRING_MOVIE
    
    ; Find and remove movie
    LEA SI, temp_movie
    LEA DI, system_movies
    MOV CL, system_movie_count
    CALL REMOVE_MOVIE
    
    CMP AL, 1
    JE MOVIE_REMOVED_OK
    
    ; Movie not found
    LEA DX, movie_not_found
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

MOVIE_REMOVED_OK:
    DEC system_movie_count
    LEA DX, movie_removed
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

SYSTEM_EMPTY:
    LEA DX, empty_list
    MOV AH, 09H
    INT 21H
    JMP ADMIN_MENU

VIEW_SYSTEM_MOVIES:
    ; FEATURE 2: Admin views all system movies
    ; Display header
    LEA DX, system_movies_header
    MOV AH, 09H
    INT 21H
    
    ; Check if empty
    CMP system_movie_count, 0
    JE SYSTEM_EMPTY
    
    ; Display all movies
    LEA SI, system_movies
    MOV CL, system_movie_count
    CALL DISPLAY_MOVIE_LIST
    
    JMP ADMIN_MENU


;;;;;;;;;;;;;;;;;;;;;; Feature 3: User Menu (User can manage watchlist and view system movies) ;;;;;;;;;;;;;;;;;;;;;;

USER_MENU:
    ; Display user menu header
    LEA DX, user_menu_header
    MOV AH, 09H
    INT 21H
    
    ; Display user menu options
    LEA DX, user_menu_msg
    MOV AH, 09H
    INT 21H
    
    ; Get user choice
    MOV AH, 01H
    INT 21H
    MOV BL, AL
    
    ; Check choice
    CMP BL, '1'
    JE ADD_TO_WATCHLIST
    
    CMP BL, '2'
    JE REMOVE_FROM_WATCHLIST
    
    CMP BL, '3'
    JE MARK_MOVIE_STATUS
    
    CMP BL, '4'
    JE VIEW_WATCHLIST
    
    CMP BL, '5'
    JE VIEW_SYSTEM_MOVIES_USER
    
    CMP BL, '6'
    JE LOGOUT
    
    ; Invalid choice
    LEA DX, invalid_msg
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

ADD_TO_WATCHLIST:

    MOV AL, current_user_index
    MOV AH, 0
    LEA SI, user_watchlist_counts
    ADD SI, AX
    MOV BL, [SI]  ; BL = current user's watchlist count
    
    ; Check if watchlist is full
    CMP BL, 10
    JGE WATCHLIST_FULL
    
    ; Check if system has any movies
    CMP system_movie_count, 0
    JE NO_SYSTEM_MOVIES
    
    ; Prompt for movie name
    LEA DX, movie_prompt
    MOV AH, 09H
    INT 21H
    
    ; Read movie name
    LEA SI, temp_movie
    CALL READ_STRING_MOVIE
    
    ; Check if movie exists in system_movies
    LEA SI, temp_movie
    LEA DI, system_movies
    MOV CL, system_movie_count
    CALL FIND_MOVIE_IN_LIST
    
    CMP AL, 0                                       ; If AL = 0, jodi movie system e na thake
    JE USER_MOVIE_NOT_IN_SYSTEM
    
    LEA SI, temp_movie
    LEA DI, system_movies
    MOV CH, 0
    MOV DH, 0                                       ; Index counter
    
FIND_SYSTEM_MOVIE_LOOP:
    CMP DH, system_movie_count
    JGE USER_MOVIE_NOT_IN_SYSTEM                    ; Should never happen
    
    PUSH DI
    PUSH SI
    CALL COMPARE_STRINGS
    POP SI
    POP DI
    
    CMP AL, 1
    JE FOUND_SYSTEM_MOVIE
    
    ADD DI, 63  ; Move to next movie
    INC DH
    JMP FIND_SYSTEM_MOVIE_LOOP
    
FOUND_SYSTEM_MOVIE:

    PUSH DI
    
    MOV AL, current_user_index
    MOV AH, 0
    MOV CX, 640                             ; Each user gets 640 bytes (10 movies * 64)
    MUL CX                                   ; AX = user_index * 640
    LEA DI, user_watchlists
    ADD DI, AX                              
    
    ; Check if movie already exists in current user's watchlist
    PUSH DI      
    LEA SI, temp_movie
    MOV CL, BL                                                  ; CL = current user's watchlist count
    CALL FIND_MOVIE_IN_WATCHLIST
    POP DI                                                      ; Restore base address
    
    ; If AL = 1, movie already in watchlist
    CMP AL, 1
    JE WATCHLIST_MOVIE_EXISTS_POP
    

    MOV AL, BL   ; AL = current user's count
    MOV BH, 64
    MUL BH       ; AX = count * 64
    ADD DI, AX   ; DI = position for new movie in watchlist
    
    ; Copy full 63-byte movie record from system to watchlist
    POP SI       ; SI = source (movie in system_movies)
    PUSH CX
    MOV CX, 63

COPY_FULL_MOVIE_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_FULL_MOVIE_LOOP
    
    ; Set status byte to '$' (not set)
    MOV BYTE PTR [DI], '$'
    
    POP CX
    
    ; Increment current user's count
    MOV AL, current_user_index
    MOV AH, 0
    LEA SI, user_watchlist_counts
    ADD SI, AX
    INC BYTE PTR [SI]
    
    ; Display success
    LEA DX, movie_added
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

WATCHLIST_MOVIE_EXISTS_POP:
    POP DI  ; Clean up stack
    JMP WATCHLIST_MOVIE_EXISTS

NO_SYSTEM_MOVIES:
    LEA DX, empty_list
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

USER_MOVIE_NOT_IN_SYSTEM:
    LEA DX, movie_not_in_system
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

WATCHLIST_MOVIE_EXISTS:
    LEA DX, movie_already_exists
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

WATCHLIST_FULL:
    LEA DX, movie_limit
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

REMOVE_FROM_WATCHLIST:
    MOV AL, current_user_index
    MOV AH, 0
    LEA SI, user_watchlist_counts
    ADD SI, AX
    MOV BL, [SI]                                                    ; BL = current user's watchlist count
    
    
    CMP BL, 0                                                       ; Check if watchlist is empty
    JE WATCHLIST_EMPTY
    
    LEA DX, movie_prompt
    MOV AH, 09H
    INT 21H

    LEA SI, temp_movie
    CALL READ_STRING_MOVIE
    

    MOV AL, current_user_index
    MOV AH, 0
    MOV CX, 640  
    MUL CX      
    LEA DI, user_watchlists
    ADD DI, AX   
    
    LEA SI, temp_movie
    MOV CL, BL 
    CALL REMOVE_MOVIE_WATCHLIST
    
    CMP AL, 1
    JE WATCHLIST_REMOVED_OK
    
    LEA DX, movie_not_found
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

WATCHLIST_REMOVED_OK:

    MOV AL, current_user_index
    MOV AH, 0
    LEA SI, user_watchlist_counts
    ADD SI, AX
    DEC BYTE PTR [SI]
    
    LEA DX, movie_removed
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

WATCHLIST_EMPTY:
    LEA DX, empty_list
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

MARK_MOVIE_STATUS:

    MOV AL, current_user_index
    MOV AH, 0
    LEA SI, user_watchlist_counts
    ADD SI, AX
    MOV BL, [SI]  ; BL = current user's watchlist count
    
    CMP BL, 0
    JE WATCHLIST_EMPTY
    
    LEA DX, watchlist_header
    MOV AH, 09H
    INT 21H
    
    MOV AL, current_user_index
    MOV AH, 0
    MOV CX, 640
    MUL CX
    LEA SI, user_watchlists
    ADD SI, AX
    PUSH SI 
    
    MOV CL, BL
    CALL DISPLAY_MOVIE_LIST_WATCHLIST
    
    LEA DX, mark_status_prompt
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, 30H  
    
    CMP AL, 0
    JLE INVALID_MOVIE_NUMBER
    CMP AL, BL
    JG INVALID_MOVIE_NUMBER
    
    DEC AL  ; Convert to 0-based index
    MOV BL, 64
    MUL BL  ; AX = index * 64
    
    POP SI  ; Restore base address
    ADD SI, AX
    ADD SI, 63  ; Move to status byte position
    PUSH SI  ; Save status byte address
    
    ; Display status menu
    LEA DX, status_menu
    MOV AH, 09H
    INT 21H
    
    ; Read status choice
    MOV AH, 01H
    INT 21H
    
    POP SI  ; Restore status byte address
    
    ; Set status based on choice
    CMP AL, '1'
    JE SET_WATCHED
    
    CMP AL, '2'
    JE SET_PLANNED
    
    CMP AL, '3'
    JE SET_DROP
    
    ; Invalid status choice
    LEA DX, invalid_msg
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

SET_WATCHED:
    MOV BYTE PTR [SI], 'W'                  ; MOV AL, 'W' ; MOV [SI], AL
    JMP STATUS_SET_SUCCESS

SET_PLANNED:
    MOV BYTE PTR [SI], 'P'
    JMP STATUS_SET_SUCCESS

SET_DROP:
    MOV BYTE PTR [SI], 'D'
    JMP STATUS_SET_SUCCESS

STATUS_SET_SUCCESS:
    LEA DX, status_updated
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

INVALID_MOVIE_NUMBER:
    POP SI  ; Clean up stack
    LEA DX, invalid_movie_num
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

VIEW_WATCHLIST:

    LEA DX, watchlist_header
    MOV AH, 09H
    INT 21H
    
    MOV AL, current_user_index
    MOV AH, 0
    LEA SI, user_watchlist_counts
    ADD SI, AX
    MOV BL, [SI]                                        ; BL = current user's watchlist count
    
    CMP BL, 0
    JE WATCHLIST_EMPTY
    
    MOV AL, current_user_index
    MOV AH, 0
    MOV CX, 640  ; Each user gets 640 bytes (10 movies * 64)
    MUL CX       ; AX = user_index * 640
    LEA SI, user_watchlists
    ADD SI, AX   ; SI = base address of current user's watchlist
    
    MOV CL, BL   ; CL = current user's watchlist count
    CALL DISPLAY_MOVIE_LIST_WATCHLIST
    
    JMP USER_MENU

VIEW_SYSTEM_MOVIES_USER:

    LEA DX, system_movies_header
    MOV AH, 09H
    INT 21H
    
    ; Check if empty
    CMP system_movie_count, 0
    JE SYSTEM_EMPTY_USER
    
    ; Display all movies
    LEA SI, system_movies
    MOV CL, system_movie_count
    CALL DISPLAY_MOVIE_LIST
    
    JMP USER_MENU

SYSTEM_EMPTY_USER:
    LEA DX, empty_list
    MOV AH, 09H
    INT 21H
    JMP USER_MENU

LOGOUT:
    ; Display logout message
    LEA DX, logout_msg
    MOV AH, 09H
    INT 21H
    JMP MAIN_LOOP

;exit to DOS

EXIT:           
MOV AX,4C00H
INT 21H

MAIN ENDP

;;;;;;;;;;;;;;;;;;;;;; Helper Functions ;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;; Helper 1 (keyboard theke username read) ;;;;;;;; 

READ_STRING PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI
    
    MOV DI, SI              ;address of input_username buffer
    MOV CX, 0               ; Character counter
    
READ_LOOP:
    MOV AH, 01H         ; Read character
    INT 21H
    
    CMP AL, 0DH             ; Enter key mane carriage return (13); Enter chaple pora sesh
    JE READ_DONE
    
    CMP CX, 15              ; Max 15 characters er username
    JGE READ_LOOP
    
    MOV [DI], AL
    INC DI
    INC CX
    JMP READ_LOOP
    
READ_DONE:
    MOV AL, '$'      
    MOV [DI], AL     ; Last e $ sign store kore
    
    POP DI
    POP CX
    POP BX
    POP AX
    RET
READ_STRING ENDP

;;;;;;;; Helper 2 (same name er 2 ta user ase naki) ;;;;;;;;

FIND_USER_BY_NAME PROC
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    
    MOV BL, 0                ; BL= current index
    
FIND_USER_LOOP:
    CMP BL, user_count
    JGE USER_NOT_FOUND
    
    MOV AL, BL
    MOV AH, 0
    MOV CL, 16
    MUL CL           ; AX=(Index*16)
    
    LEA SI, input_username     ;starting point of buffer ke point kore
    LEA DI, usernames          ;all user er memore er start ke point kore
    ADD DI, AX                 ; DI= usernames + (index*16) ; DI 16 step move korbe
    
    CALL COMPARE_STRINGS       ; function ta 1 return kore jodi strings equal 
    CMP AL, 1
    JE USER_FOUND
    
    INC BL
    JMP FIND_USER_LOOP
    
USER_NOT_FOUND:
    MOV AL, 0FFH                         ; Return 0FFH (not found) ; flag hishabe use; AL highest 255 ; error value
    JMP FIND_USER_DONE
    
USER_FOUND:
    MOV AL, BL  ; Return user index
    
FIND_USER_DONE:
    POP DI
    POP SI
    POP CX
    POP BX
    RET
FIND_USER_BY_NAME ENDP

;;;;;;;; Helper 3 (user jei password dise sheta stored pass er sathe match kore naki check) ;;;;;;;;

VERIFY_USER_PASSWORD PROC
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    
    MOV AL, BL      ;AL e user index
    MOV AH, 0
    MOV CL, 16
    MUL CL
    
    LEA SI, input_password
    LEA DI, passwords
    ADD DI, AX
    
    CALL COMPARE_STRINGS        ;(AL 1=match, 0=no match)
    
    POP DI
    POP SI
    POP CX
    POP BX
    RET
VERIFY_USER_PASSWORD ENDP

;;;;;;;; Helper 4 (keyboard theke movie name read) ;;;;;;;; 


READ_STRING_MOVIE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI
    
    MOV DI, SI          ;address of input_movie buffer
    MOV CX, 0           ; Character counter
    
READ_MOVIE_LOOP:
    MOV AH, 01H  ; Read character
    INT 21H
    
    CMP AL, 0DH                     ; Enter key mane carriage return (13); Enter chaple pora sesh
    JE READ_MOVIE_DONE
    
    CMP CX, 20   ; Max 20 characters
    JGE READ_MOVIE_LOOP
    
    MOV [DI], AL
    INC DI
    INC CX
    JMP READ_MOVIE_LOOP
    
READ_MOVIE_DONE:
    MOV AL, '$'
    MOV [DI], AL
    
    POP DI
    POP CX
    POP BX
    POP AX
    RET
READ_STRING_MOVIE ENDP


;;;;;;;; Helper 5 (Input ke permanent array te store kore buffer theke copy kore) ;;;;;;;; 

COPY_STRING PROC
    PUSH AX
    PUSH SI
    PUSH DI
    
COPY_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    
    CMP AL, '$'
    JE COPY_DONE
    
    INC SI
    INC DI
    JMP COPY_LOOP
    
COPY_DONE:
    POP DI
    POP SI
    POP AX
    RET
COPY_STRING ENDP

;;;;;;;; Helper 6 (System er shob movie display korte) ;;;;;;;; 

DISPLAY_MOVIE_LIST PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    MOV BL, 1               ; movie number (1,2,3,...) print korte
    MOV CH, 0               ; CX er upper 8 bit 0 ; CX= system_movie_count (movie add hoile increment hoy)
    
DISPLAY_LOOP:
    CMP CL, 0               ;CL --> shob movie display done
    JE DISPLAY_DONE
    
    ; Print newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    
    ; Print movie number (1. , 2. , etc)
    MOV AL, BL
    ADD AL, 30H                 ; ascii te convert
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    LEA DX, movie_number
    MOV AH, 09H
    INT 21H
    
    ;movie er name print (first er 21 bytes)
    MOV DX, SI
    MOV AH, 09H
    INT 21H
    
    ; First bracket er start print " ("
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '('
    MOV AH, 02H
    INT 21H
    
    ; movie er genre print (next er 21 bytes)
    PUSH SI
    ADD SI, 21   ; Move to genre position
    MOV DX, SI
    MOV AH, 09H
    INT 21H
    POP SI
    
    ; comma print ", "
    MOV DL, ','
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    ; movie er release date (next er 21 bytes after genre)
    PUSH SI
    ADD SI, 42   ; Move to date position (21 name + 21 genre)
    MOV DX, SI
    MOV AH, 09H
    INT 21H
    POP SI
    
    ; First bracket er end print ")"
    MOV DL, ')'
    MOV AH, 02H
    INT 21H
    
    ; next movie te move (63 --> 21+21+21)
    ADD SI, 63
    INC BL
    DEC CL
    JMP DISPLAY_LOOP
    
DISPLAY_DONE:
    LEA DX, newline     ; sesh e ekta newline
    MOV AH, 09H
    INT 21H
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_MOVIE_LIST ENDP

;;;;;;;; Helper 7 (user er Watchlist er shob movie display korte status marker shoho) ;;;;;;;; 

DISPLAY_MOVIE_LIST_WATCHLIST PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    MOV BL, 1  ; Movie number counter
    MOV CH, 0  ; Clear upper byte of CX
    
DISPLAY_WATCHLIST_LOOP:
    CMP CL, 0
    JE DISPLAY_WATCHLIST_DONE
    
    ; Print newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    
    ; Print movie number
    MOV AL, BL
    ADD AL, 30H  ; Convert to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    ; Print ". "
    LEA DX, movie_number
    MOV AH, 09H
    INT 21H
    
    ; Print movie name (first 21 bytes)
    MOV DX, SI
    MOV AH, 09H
    INT 21H
    
    ; Print " ("
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '('
    MOV AH, 02H
    INT 21H
    
    ; Print genre (next 21 bytes)
    PUSH SI
    ADD SI, 21
    MOV DX, SI
    MOV AH, 09H
    INT 21H
    POP SI
    
    ; Print ", "
    MOV DL, ','
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    ; Print release date (next 21 bytes after genre)
    PUSH SI
    ADD SI, 42
    MOV DX, SI
    MOV AH, 09H
    INT 21H
    POP SI
    
    ; Print ")"
    MOV DL, ')'
    MOV AH, 02H
    INT 21H
    
    ; Check and print status (byte 63)
    PUSH SI
    ADD SI, 63  ; Move to status byte
    MOV AL, [SI]
    POP SI
    
    CMP AL, 'W'
    JE PRINT_WATCHED
    
    CMP AL, 'P'
    JE PRINT_PLANNED
    
    CMP AL, 'D'
    JE PRINT_DROP
    
    ; No status or unknown, skip
    JMP NEXT_WATCHLIST_MOVIE

PRINT_WATCHED:
    LEA DX, status_watched
    MOV AH, 09H
    INT 21H
    JMP NEXT_WATCHLIST_MOVIE

PRINT_PLANNED:
    LEA DX, status_planned
    MOV AH, 09H
    INT 21H
    JMP NEXT_WATCHLIST_MOVIE

PRINT_DROP:
    LEA DX, status_drop
    MOV AH, 09H
    INT 21H
    JMP NEXT_WATCHLIST_MOVIE

NEXT_WATCHLIST_MOVIE:
    ; Move to next movie (64 bytes: 21 name + 21 genre + 21 date + 1 status)
    ADD SI, 64
    INC BL
    DEC CL
    JMP DISPLAY_WATCHLIST_LOOP
    
DISPLAY_WATCHLIST_DONE:
    ; Print final newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_MOVIE_LIST_WATCHLIST ENDP


;;;;;;;; Helper 8 (System theke Movie remove korte) ;;;;;;;; 

REMOVE_MOVIE PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV CH, 0               ; CL/CX e total koyta movie list e ase store kora
    MOV BL, 0               ; Index counter (0 number movie theke 1 kore barbe)
    
FIND_LOOP:
    CMP BL, CL
    JGE NOT_FOUND
    
    PUSH DI                 ; current DI position ke save 
    PUSH SI                 ; searched name er position ke save

    CALL COMPARE_STRINGS    ;  current movie ke searched name er sathe compare

    POP SI
    POP DI
    
    CMP AL, 1
    JE FOUND_MOVIE
    
    ADD DI, 63          ;next movie te move
    INC BL
    JMP FIND_LOOP
    
FOUND_MOVIE:
    ; koyta movie shift kora lagbe
    MOV DH, CL      ; DH = Total koyta movie ase
    SUB DH, BL      ; BL = jei movie shorabo tar index
    DEC DH          ; jehetu 0 based indexing
    

    CMP DH, 0                   ; DH=0 mane last movie, just clear it
    JE CLEAR_LAST_MOVIE
    
    
SHIFT_LOOP:
    ; 1 ta movie copy kore left shift 63 byte, from [DI+63] to [DI]
    PUSH SI
    PUSH DI
    PUSH CX                             ; CX use kore loop run hobe
    
    LEA SI, [DI+63]                     ; jodi k index er movie shorate chai, movie[k]=movie[k+1]
    MOV CX, 63                          ; 63 bytes copy kore ; 63 bar COPY_MOVIE_BYTE loop run korbe

COPY_MOVIE_BYTE:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_MOVIE_BYTE
    
    POP CX
    POP DI
    POP SI
    
    ; Move to next position
    ADD DI, 63
    DEC DH
    CMP DH, 0
    JNE SHIFT_LOOP
    
    ; DI ekhn last movie slot e point korbe, clear it
    
CLEAR_LAST_MOVIE:
    ; Clear the movie slot by filling with '$'
    PUSH CX
    MOV CX, 63          ;CLEAR_LOOP 63 bar cholbe   
    MOV AL, '$'

CLEAR_LOOP:
    MOV [DI], AL
    INC DI
    LOOP CLEAR_LOOP
    POP CX
    
REMOVE_SUCCESS:
    MOV AL, 1
    JMP REMOVE_DONE
    
NOT_FOUND:
    MOV AL, 0
    
REMOVE_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET
REMOVE_MOVIE ENDP

;;;;;;;; Helper 9 (input string ar stored string same naki (username/movie)) ;;;;;;;;

COMPARE_STRINGS PROC
    PUSH SI
    PUSH DI
    PUSH BX                         ;BL er kaaj ase dekhe stack e pushed 
    
COMP_LOOP:
    MOV AL, [SI]                    ; input er current character
    MOV BL, [DI]                    ; stored value er current character
    
    ; Jodi searched term age sesh hoy
    CMP AL, '$'
    JE CHECK_MOVIE_END
    
    ; Jodi stored term age sesh hoy
    CMP BL, '$'
    JE COMP_NOT_EQUAL
    
    ; character er sathe character er comparison (case-sensitive)
    CMP AL, BL
    JNE COMP_NOT_EQUAL
    
    ; Move to next character
    INC SI
    INC DI
    JMP COMP_LOOP
    
CHECK_MOVIE_END:
    ; 2 ta string ek sathe sesh
    CMP BL, '$'
    JNE COMP_NOT_EQUAL
    
    MOV AL, 1                           ; Equal
    JMP COMP_DONE
    
COMP_NOT_EQUAL:
    MOV AL, 0                           ; Not equal
    
COMP_DONE:
    POP BX
    POP DI
    POP SI
    RET
COMPARE_STRINGS ENDP


;;;;;;;; Helper 10 (movie system e ase naki check) ;;;;;;;;

FIND_MOVIE_IN_LIST PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV CH, 0                       ; CL/CX e total koyta movie list e ase store kora
    MOV BL, 0                       ; Index counter (0 number movie theke 1 kore barbe)
    
FIND_MOVIE_LOOP:
    CMP BL, CL
    JGE MOVIE_NOT_FOUND_IN_LIST
    
    PUSH DI                          ; current DI position ke save 
    PUSH SI                          ; searched name er position ke save

    CALL COMPARE_STRINGS             ;  current movie ke searched name er sathe compare 

    POP SI          
    POP DI
    
    CMP AL, 1
    JE MOVIE_FOUND_IN_LIST
    
    ADD DI, 63                      ; next movie te jump
    INC BL
    JMP FIND_MOVIE_LOOP
    
MOVIE_FOUND_IN_LIST:
    MOV AL, 1                       ; Found
    JMP FIND_MOVIE_DONE
    
MOVIE_NOT_FOUND_IN_LIST:
    MOV AL, 0                       ; Not found
    
FIND_MOVIE_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET
FIND_MOVIE_IN_LIST ENDP


;;;;;;;; Helper 11 (Movie watchlist e ase naki) ;;;;;;;;


FIND_MOVIE_IN_WATCHLIST PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV CH, 0                           ; CL/CX e total koyta movie list e ase store kora
    MOV BL, 0                           ; Index counter (0 number movie theke 1 kore barbe)
    
FIND_WATCHLIST_LOOP:
    CMP BL, CL
    JGE MOVIE_NOT_FOUND_IN_WATCHLIST
    
    PUSH DI                             ; current DI position ke save
    PUSH SI                             ; searched name er position ke save

    CALL COMPARE_STRINGS                 ;  current movie ke searched name er sathe compare 

    POP SI
    POP DI
    
    CMP AL, 1
    JE MOVIE_FOUND_IN_WATCHLIST
    
    ADD DI, 64                          ; next movie te jump ; watchlist 64 B karon 63+1 status byte ('W', 'P', 'D', or '$' for not set)
    INC BL
    JMP FIND_WATCHLIST_LOOP
    
MOVIE_FOUND_IN_WATCHLIST:
    MOV AL, 1                                           ; Found
    JMP FIND_WATCHLIST_DONE
    
MOVIE_NOT_FOUND_IN_WATCHLIST:
    MOV AL, 0                                           ; Not found
    
FIND_WATCHLIST_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET
FIND_MOVIE_IN_WATCHLIST ENDP


;;;;;;;; Helper 12 (watchlist theke movie remove) ;;;;;;;;

REMOVE_MOVIE_WATCHLIST PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV CH, 0                                   ; CL/CX e total koyta movie list e ase store kora
    MOV BL, 0                                   ; Index counter (0 number movie theke 1 kore barbe)
    
FIND_WATCHLIST_REMOVE_LOOP:
    CMP BL, CL
    JGE WATCHLIST_NOT_FOUND
    

    PUSH DI
    PUSH SI

    CALL COMPARE_STRINGS

    POP SI
    POP DI
    
    CMP AL, 1
    JE FOUND_WATCHLIST_MOVIE
    
    ; Move to next movie (64 bytes)
    ADD DI, 64
    INC BL
    JMP FIND_WATCHLIST_REMOVE_LOOP
    
FOUND_WATCHLIST_MOVIE:
    ; koyta movie shift kora lagbe

    MOV DH, CL                          ; DH = Total count
    SUB DH, BL                          ; DH = movies from current to end
    DEC DH                              ; DH = movies after this one (to shift)

    CMP DH, 0                           ; DH = 0 mane last movie chilo ; $ diye fill hobe
    JE CLEAR_LAST_WATCHLIST_MOVIE
    
SHIFT_WATCHLIST_LOOP:
    PUSH SI
    PUSH DI
    PUSH CX
    
    LEA SI, [DI+64] ; Source = next movie
    
    MOV CX, 64      ; loop 64 bar run hobe

COPY_WATCHLIST_BYTE:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_WATCHLIST_BYTE
    
    POP CX
    POP DI
    POP SI
    
    ; Move to next position
    ADD DI, 64
    DEC DH
    CMP DH, 0
    JNE SHIFT_WATCHLIST_LOOP
    
CLEAR_LAST_WATCHLIST_MOVIE:
    ; Clear the movie slot by filling with '$'
    PUSH CX
    MOV CX, 64
    MOV AL, '$'

CLEAR_WATCHLIST_LOOP:
    MOV [DI], AL
    INC DI
    LOOP CLEAR_WATCHLIST_LOOP
    POP CX
    
WATCHLIST_REMOVE_SUCCESS:
    MOV AL, 1                               ; Success
    JMP WATCHLIST_REMOVE_DONE
    
WATCHLIST_NOT_FOUND:
    MOV AL, 0                               ; Not found
    
WATCHLIST_REMOVE_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET
REMOVE_MOVIE_WATCHLIST ENDP

    END MAIN   