NAME	= libasm.a

CC		= gcc

CFLAGS	=

AR		= ar rcs

OBJS	= ${SRCS:.s=.o}

${NAME} : ${OBJS}
	${AR} ${NAME} ${OBJS}

%.o				%.c ft_libasm.h
	${CC} ${FLAGS} -o $@ $<

all	:		${NAME}

clean	:	
	rm -f ${OBJS}

fclean	:
	rm -f ${NAME}

re :		fclean all

.PHONY:		all bonus clean fclean re
