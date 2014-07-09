From: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] i2c: pxa: Make of_device_id array const
Date: Thu, 10 Jul 2014 07:52:41 +0800
Message-ID: <CAN1soZxb=tF+fetJTFrWy_oFq8fYYar=jaM89392s17DEnVHNg@mail.gmail.com>
References: <022101cf69d1$f1311200$d3933600$%han@samsung.com>
	<022201cf69d2$5fcc0ad0$1f642070$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <022201cf69d2$5fcc0ad0$1f642070$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 7, 2014 at 4:57 PM, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
>
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index bbe6dfb..be671f7 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1084,7 +1084,7 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
>         .functionality  = i2c_pxa_functionality,
>  };
>
> -static struct of_device_id i2c_pxa_dt_ids[] = {
> +static const struct of_device_id i2c_pxa_dt_ids[] = {
>         { .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
>         { .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
>         { .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA2XX },
> --
> 1.7.10.4
>
>

Acked-by: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
