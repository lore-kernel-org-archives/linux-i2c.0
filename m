From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] i2c: uniphier{-f}: don't print error when adding adapter fails
Date: Wed, 10 Aug 2016 09:54:15 +0900
Message-ID: <CAK7LNATVHhyNXRFmk-_WRgLcuh-pZOZTBs_WL2-pvT0yJOM35Q@mail.gmail.com>
References: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

2016-08-10 5:11 GMT+09:00 Wolfram Sang <wsa-dev@sang-engineering.com>:
> The core will do this for us now.
>
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-uniphier-f.c | 5 -----
>  drivers/i2c/busses/i2c-uniphier.c   | 5 -----
>  2 files changed, 10 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
> index aeead0d27d1007..35608531fe070d 100644
> --- a/drivers/i2c/busses/i2c-uniphier-f.c
> +++ b/drivers/i2c/busses/i2c-uniphier-f.c
> @@ -550,11 +550,6 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
>         }
>
>         ret = i2c_add_adapter(&priv->adap);
> -       if (ret) {
> -               dev_err(dev, "failed to add I2C adapter\n");
> -               goto err;
> -       }
> -
>  err:
>         if (ret)
>                 clk_disable_unprepare(priv->clk);
> diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
> index 475a5eb514e215..d6e612a0e02a9d 100644
> --- a/drivers/i2c/busses/i2c-uniphier.c
> +++ b/drivers/i2c/busses/i2c-uniphier.c
> @@ -407,11 +407,6 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
>         }
>
>         ret = i2c_add_adapter(&priv->adap);
> -       if (ret) {
> -               dev_err(dev, "failed to add I2C adapter\n");
> -               goto err;
> -       }
> -
>  err:
>         if (ret)
>                 clk_disable_unprepare(priv->clk);


This version looks good to me.  :)


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


(Please make sure to squash this and the other big one into a single patch.)



-- 
Best Regards
Masahiro Yamada
