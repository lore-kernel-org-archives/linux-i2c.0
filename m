From: Libo Chen <chenlibo.3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC v3 3/3] i2c: pxa: use module_platform_driver() replace
 init/exit
Date: Thu, 23 May 2013 21:48:22 +0800
Message-ID: <519E1E26.3060106@gmail.com>
References: <1369310411-35652-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369310411-35652-1-git-send-email-libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org, sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

maybe I make a mistake, please drop it.

=D3=DA 2013-5-23 20:00, Libo Chen =D0=B4=B5=C0:
> use module_platform_driver() macro to replace the module init/exit
>=20
> Signed-off-by: Libo Chen<libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-pxa.c |   10 +---------
>   1 files changed, 1 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index 7b10102..e9c3524 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1242,15 +1242,7 @@ static struct platform_driver i2c_pxa_driver =3D=
 {
>   	.id_table	=3D i2c_pxa_id_table,
>   };
>  =20
> -static int __init i2c_adap_pxa_init(void)
> -{
> -	return platform_driver_register(&i2c_pxa_driver);
> -}
> -
> -static void __exit i2c_adap_pxa_exit(void)
> -{
> -	platform_driver_unregister(&i2c_pxa_driver);
> -}
> +module_platform_driver(i2c_pxa_driver);
>  =20
>   MODULE_LICENSE("GPL");
>   MODULE_ALIAS("platform:pxa2xx-i2c");
