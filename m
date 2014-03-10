From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: s3c2410: Trivial cleanup in header file
Date: Mon, 10 Mar 2014 20:55:40 +0530
Message-ID: <CAK9yfHzuLE2tfPQXs9ypcsNBhMvjj7bOyhHvvCpbOj1W3+Cd6A@mail.gmail.com>
References: <1392359490-9834-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392359490-9834-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 14 February 2014 12:01, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> moved the files to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
>
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  include/linux/platform_data/i2c-s3c2410.h |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/platform_data/i2c-s3c2410.h b/include/linux/platform_data/i2c-s3c2410.h
> index 2a50048c1c44..05af66b840b9 100644
> --- a/include/linux/platform_data/i2c-s3c2410.h
> +++ b/include/linux/platform_data/i2c-s3c2410.h
> @@ -1,5 +1,4 @@
> -/* arch/arm/plat-s3c/include/plat/iic.h
> - *
> +/*
>   * Copyright 2004-2009 Simtec Electronics
>   *     Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
>   *
> @@ -10,8 +9,8 @@
>   * published by the Free Software Foundation.
>  */
>
> -#ifndef __ASM_ARCH_IIC_H
> -#define __ASM_ARCH_IIC_H __FILE__
> +#ifndef __I2C_S3C2410_H
> +#define __I2C_S3C2410_H __FILE__
>
>  #define S3C_IICFLG_FILTER      (1<<0)  /* enable s3c2440 filter */
>
> @@ -76,4 +75,4 @@ extern void s3c_i2c7_cfg_gpio(struct platform_device *dev);
>
>  extern struct s3c2410_platform_i2c default_i2c_data;
>
> -#endif /* __ASM_ARCH_IIC_H */
> +#endif /* __I2C_S3C2410_H */
> --
> 1.7.9.5
>

 Ping..

-- 
With warm regards,
Sachin
