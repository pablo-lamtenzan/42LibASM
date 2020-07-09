/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_ft_atoi_base.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: plamtenz <plamtenz@student.42lyon.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/03 20:50:28 by chamada           #+#    #+#             */
/*   Updated: 2020/07/09 15:13:07 by plamtenz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


#include <tests.h>

int	unit_ft_atoi_base_rand_hex(void)
{
	static const int	len = 32;
	static const char	*base = "0123456789ABCDEF";
	char				src[len];
	int					dest;
	int					rand;

	rand = ft_rand(0, 0xffffffff);
	snprintf(src, len, "-+ -\t \t%X", rand);
	dest = ft_atoi_base_bonus(src, base);
	return (!diff_i(dest, rand));
}

int (*tests_ft_atoi_base[])(void) = {&unit_ft_atoi_base_rand_hex, NULL};
