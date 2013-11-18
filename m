From: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] i2c: bcm-kona: fix error return code in bcm_kona_i2c_probe()
Date: Mon, 18 Nov 2013 09:05:08 -0800
Message-ID: <CAAYSxhrYmeJxmEndL-LaWP=ctLSasuOE0wHChTiWCHgf8pX1QA@mail.gmail.com>
References: <CAPgLHd8vdQL5Uyypjj_L9qg=abQEXoGc6ZBKwrF-5D9x2YNm-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPgLHd8vdQL5Uyypjj_L9qg=abQEXoGc6ZBKwrF-5D9x2YNm-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 18, 2013 at 5:03 AM, Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>
> Fix to return a negative error code from the bus speed parse
> error handling case instead of 0.
>
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bcm-kona.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
> index 865e5dd..036cf03 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -792,7 +792,8 @@ static int bcm_kona_i2c_probe(struct platform_device *pdev)
>         }
>
>         /* Parse bus speed */
> -       if (bcm_kona_i2c_assign_bus_speed(dev))
> +       rc = bcm_kona_i2c_assign_bus_speed(dev);
> +       if (rc)
>                 goto probe_disable_clk;
>
>         /* Enable internal clocks */
>

Looks good.  Thanks.

Reviewed-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
