HDIR				=	inc
SDIR				=	src
ODIR				=	obj
NAME				=	pipex	
LIB_DIR				=	libft

MAKE_LIB			=	@make --no-print-directory -C

CC					?=	gcc
CFLAGS				?=	-g -Wall -Wextra -fsanitize=address -I$(HDIR)
MAKE_LIB			=	@make --no-print-directory -C

PRINTF_DIR			=	$(LIB_DIR)/printf
PRINTF_FILE			=	printf.a 	
PRINTF				=	$(PRINTF_DIR)/$(PRINTF_FILE)
CFLAGS				+=	-I$(PRINTF_DIR)/include
LIB					+=	$(PRINTF)

LIBFT_DIR			=	$(LIB_DIR)/libft
LIBFT_FILE			=	libft.a
LIBFT				=	$(LIBFT_DIR)/$(LIBFT_FILE)
CFLAGS				+=	-I$(LIBFT_DIR)/include
LIB					+=	$(LIBFT)

SRCS				:=	$(shell find $(SDIR) -name "*.c")
OBJS				:=	$(patsubst $(SDIR)/%.c,$(ODIR)/%.o, $(SRCS))
DIRS				=	$(sort $(dir $(OBJS)))

all: $(LIBFT) $(NAME)

$(OBJS): $(ODIR)/%.o: $(SDIR)/%.c | $(DIRS)
	$(Q)$(CC) $(CFLAGS) -c -o $@ $<

$(NAME): $(OBJS) $(LIBFT)
	$(Q)$(CC) $(CFLAGS) $^ -o $@ -lreadline

$(DIRS) $(TDIR)/bin:
	$(Q)mkdir -p $@

$(PRINTF):
	$(MAKE_LIB) $(PRINTF_DIR)

$(LIBFT):
	$(MAKE_LIB) $(LIBFT_DIR)

c clean:
	$(Q)rm -rf $(ODIR)
	$(Q)$(MAKE_LIB) $(LIBFT_DIR) clean
	$(Q)$(MAKE_LIB) $(PRINTF_DIR) clean
	$(ECHO) "Clean is done!"

f fclean: clean
	$(Q)rm -rf $(NAME)
	$(Q)$(MAKE_LIB) $(LIBFT_DIR) fclean
	$(Q)$(MAKE_LIB) $(PRINTF_DIR) fclean

n norm:
	@-norminette $(SDIR)
	@echo
	@-norminette $(HDIR)

r run: $(NAME)
	$(shell < $(NAME))

re: fclean all

.PHONY: all clean fclean re n norm 

ifeq ($(V),2)
    Q =
    ECHO = @echo
else ifeq ($(V),1)
    Q = @
    ECHO = @echo
else
    Q = @
    ECHO = @:
endif
