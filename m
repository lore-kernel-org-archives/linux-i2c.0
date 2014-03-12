From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: exynos5: remove unnecessary cast of void pointer
Date: Thu, 13 Mar 2014 02:09:51 +0900
Message-ID: <CAHfPSqC3eGrpRtVLD1Qwqp2bL0sLAN7xE4+aZAZ0op=Gj0_q=Q@mail.gmail.com>
References: <000501cf3cc8$4b7f8d90$e27ea8b0$%han@samsung.com> <000601cf3cc8$70627460$51275d20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000601cf3cc8$70627460$51275d20$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Naveen Krishna Ch <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Taekgyun Ko <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Mr. Han,

On 11 March 2014 10:22, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Remove unnecessary cast of void pointer, because 'algo_data' of
> 'struct i2c_adapter' is a void pointer. Casting the void pointer
> is redundant. The conversion from void pointer to any other
> pointer type is guaranteed by the C programming language.
>
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-exynos5.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index 60601ef..00af0a0 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -566,7 +566,7 @@ static int exynos5_i2c_xfer_msg(struct exynos5_i2c *i2c,
>  static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>                         struct i2c_msg *msgs, int num)
>  {
> -       struct exynos5_i2c *i2c = (struct exynos5_i2c *)adap->algo_data;
> +       struct exynos5_i2c *i2c = adap->algo_data;
>         int i = 0, ret = 0, stop = 0;
>
>         if (i2c->suspended) {
> --
> 1.7.10.4
Thanks for the patch.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
