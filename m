From: Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: choose the better clock divider
Date: Wed, 15 Jun 2011 16:34:31 +0800
Message-ID: <BANLkTi=1hMNNWeq_4bcCr_ynT8osY3efaA@mail.gmail.com>
References: <1308035825-22410-1-git-send-email-eric.miao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308035825-22410-1-git-send-email-eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Sorry forgot to include Ben.

Ben, any ideas?

On Tue, Jun 14, 2011 at 3:17 PM, Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote=
:
> The original algorithm doesn't perform very well in some cases, e.g.
>
> =C2=A0When the source clock of the I2C controller is 66MHz, and the
> =C2=A0requested rate is 100KHz, it gives a divider of 768 instead of
> =C2=A0the better 640.
>
> Choose a better clock divider so the final clock rate is closer to
> the requested one by comparing the rate distances calculated by
> two adjacent dividers.
>
> Cc: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Eric Miao <eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =C2=A0drivers/i2c/busses/i2c-imx.c | =C2=A0 46 ++++++++++++++++++++++=
++++++-------------
> =C2=A01 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 4c2a62b..cd640ff 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -112,6 +112,8 @@ static u16 __initdata i2c_clk_div[50][2] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 3072, 0x1E }, { 3840, 0x1F }
> =C2=A0};
>
> +#define I2C_CLK_DIV_NUM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ARRAY_SIZE(i2c_clk_div)
> +
> =C2=A0struct imx_i2c_struct {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_adapter =C2=A0 =C2=A0 =C2=A0ada=
pter;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 *res;
> @@ -240,22 +242,37 @@ static void i2c_imx_stop(struct imx_i2c_struct =
*i2c_imx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(i2c_imx->clk);
> =C2=A0}
>
> -static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int rate)
> +/* find the index into i2c_clk_div[] array, compare with the two
> + * dividers found, return the one with smaller error
> + */
> +static int find_div(unsigned long i2c_clk_rate, unsigned long rate)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 unsigned int i2c_clk_rate;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int div;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long div, delta_l, delta_h;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> - =C2=A0 =C2=A0 =C2=A0 /* Divider value calculation */
> - =C2=A0 =C2=A0 =C2=A0 i2c_clk_rate =3D clk_get_rate(i2c_imx->clk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0div =3D (i2c_clk_rate + rate - 1) / rate;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (div < i2c_clk_div[0][0])
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_=
div) - 1][0])
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D ARRAY_SIZE(i=
2c_clk_div) - 1;
> - =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i2c_=
clk_div[i][0] < div; i++);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (div > i2c_clk_div[I2C_CLK_DIV_NUM - 1][0])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return I2C_CLK_DIV=
_NUM;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < I2C_CLK_DIV_NUM; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_clk_div[i]=
[0] > div)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 delta_h =3D (i2c_clk_rate / i2c_clk_div[i - 1]=
[0]) - rate;
> + =C2=A0 =C2=A0 =C2=A0 delta_l =3D rate - (i2c_clk_rate / i2c_clk_div=
[i][0]);
> +
> + =C2=A0 =C2=A0 =C2=A0 return (delta_l < delta_h) ? i : i - 1;
> +}
> +
> +static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int rate)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long i2c_clk_rate =3D clk_get_rate(i2=
c_imx->clk);
> + =C2=A0 =C2=A0 =C2=A0 int i =3D find_div(i2c_clk_rate, rate);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Store divider value */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_imx->ifdr =3D i2c_clk_div[i][1];
> @@ -271,10 +288,9 @@ static void __init i2c_imx_set_clk(struct imx_i2=
c_struct *i2c_imx,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* dev_dbg() can't be used, because adapte=
r is not yet registered */
> =C2=A0#ifdef CONFIG_I2C_DEBUG_BUS
> - =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG "I2C: <%s> I2C_CLK=3D%d, REQ=
 DIV=3D%d\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, i2c_clk_=
rate, div);
> - =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG "I2C: <%s> IFDR[IC]=3D0x%x, =
REAL DIV=3D%d\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, i2c_clk_=
div[i][1], i2c_clk_div[i][0]);
> + =C2=A0 =C2=A0 =C2=A0 pr_debug("<%s> I2C_CLK=3D%ld, REQ RATE=3D%d, D=
IV=3D%d, IFDR[IC]=3D0x%x\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, i2c_clk_=
rate, rate,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_clk_div[i][0],=
 i2c_clk_div[i][1]);
> =C2=A0#endif
> =C2=A0}
>
> --
> 1.7.4.1
>
>
