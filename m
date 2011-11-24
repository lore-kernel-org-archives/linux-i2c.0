From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
Date: Thu, 24 Nov 2011 09:29:03 +0100
Message-ID: <20111124082903.GV19986@pengutronix.de>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1322121140-5216-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Shawn,

On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
>   CC      drivers/i2c/busses/i2c-mxs.o
> drivers/i2c/busses/i2c-mxs.c: In function =E2=80=98mxs_i2c_xfer=E2=80=
=99:
> drivers/i2c/busses/i2c-mxs.c:196:6: warning: =E2=80=98data=E2=80=99 m=
ay be used uninitialized in this function
>=20
> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mxs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mx=
s.c
> index 7e78f7c..00f098f 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_d=
ev *i2c)
> =20
>  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int=
 len)
>  {
> -	u32 data;
> +	u32 data =3D 0;
>  	int i;
> =20
>  	for (i =3D 0; i < len; i++) {
Looks like a stupid compiler. Then better use=20

	u32 uninitialized_var(data);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
