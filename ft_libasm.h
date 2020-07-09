#ifndef FT_LIBASM_H
# define FT_LIBASM_H

# include <unistd.h>


/*
**---------------------------BONUS STRUCT--------------------------------------
*/
typedef struct			s_list
{
	void				*content;
	struct s_list		*next;
}						t_list;

/*
**----------------------------MANDATORY PART-----------------------------------
*/
int			ft_strlen(const char *str);
char		*ft_strcpy(char *src, const char *dest);
int			ft_strcmp(const char *s1, const char *s2);
char		*ft_strdup(const char *s1);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);

/*
**-----------------------------BONUS PART--------------------------------------
*/

int			ft_atoi_base(char *str, char *base);
void		*ft_list_push_front(t_list **begin_list, void *data);
int			ft_list_size(t_list *begin_list);
void		ft_list_sort(t_list **begin_list, int (*cmp)());


#endif
