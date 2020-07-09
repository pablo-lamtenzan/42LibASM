NAME = libasm.a
SRCDIR = srcs
OBJDIR = objs
ASM = nasm
CC = /usr/bin/clang
CFLAGS = -Wall -Wextra -Werror
AR = /usr/bin/ar
ARFLAGS = rcus
RM = /bin/rm
FORMAT = elf64
FLAGS = -g
UNITS = strlen strcpy strcmp write read strdup atoi_base_bonus list_size_bonus#list_push_front_bonus  
SRCS = $(addprefix $(SRCDIR)/ft_, $(addsuffix .s, $(UNITS)))
OBJS	=	$(patsubst $(SRCDIR)/%.s, $(OBJDIR)/%.o, $(SRCS))

all:			$(NAME)

$(NAME):		$(OBJS)
	@printf "%-3s $@ $(OBJS)\n" AR
	@$(AR) $(ARFLAGS) $@ $(OBJS)

$(OBJDIR):
	@printf "%-3s $@\n" MK
	@mkdir -p $(OBJDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.s $(OBJDIR) Makefile
	@printf "%-3s $<\n" ASM
	@$(ASM) $(FLAGS) $(AFLAGS) -f$(FORMAT) $< -o $@

clean:
	@printf "%-3s $(OBJDIR)\n" RM
	@$(RM) -rf $(OBJDIR)

fclean:			clean
	@printf "%-3s $(NAME) test\n" RM
	@$(RM) -rf $(NAME) test

re:				fclean all