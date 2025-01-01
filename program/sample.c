/*
 * C言語のサンプルプログラム - Webkaru
 * - 入力した整数が正か負かを判定 -
 */
#include <stdio.h>
 
int main(void)
{
	/* 変数の宣言 */
	int number;
 
	/* 整数の入力 */
	printf("整数を入力 = ");
	scanf("%d", &number);
 
	/* 入力した整数が正か負かを判定 */
	if (number > 0)
		printf("%d は正です。\n", number);
	else if (number == 0)
		printf("%d は正・負のどちらでもありません。\n", number);
	else
		printf("%d は負です。\n", number);
 
	return 0;
}
