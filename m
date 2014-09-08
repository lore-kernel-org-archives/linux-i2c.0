From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mxs: debug error message: second SELECT -> READ
Date: Mon, 8 Sep 2014 20:14:07 +0200
Message-ID: <201409082014.07749.marex@denx.de>
References: <540DEFA6.9030600@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540DEFA6.9030600-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, September 08, 2014 at 08:04:22 PM, Janusz U=C5=BCycki wrote:

Thanks, but the Subject of the email doesn't make much sense. Also, a s=
hort=20
commit message exlaining what you did and why you did it would be nice.

While the patch is obvious and obviously correct, can you please fix th=
ose two=20
minor things ?

> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> ---
>   linux-3.14.17/drivers/i2c/busses/i2c-mxs.c | 2 +-

btw. how did this 'linux-3.14.17' get in the path ?

>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> b/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> index 0cde4e6..87ee72d 100644
> --- a/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> +++ b/linux-3.14.17/drivers/i2c/busses/i2c-mxs.c
> @@ -429,7 +429,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adap=
ter
> *adap,
>                  ret =3D mxs_i2c_pio_wait_xfer_end(i2c);
>                  if (ret) {
>                          dev_err(i2c->dev,
> -                               "PIO: Failed to send SELECT command!\=
n");
> +                               "PIO: Failed to send READ command!\n"=
);
>                          goto cleanup;
>                  }
>=20
> --
> 1.7.11.3

Best regards,
Marek Vasut
