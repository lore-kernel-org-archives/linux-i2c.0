From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: i2c-bcm2835: match return type of
 wait_for_completion_timeout
Date: Wed, 25 Feb 2015 14:48:24 +0000
Message-ID: <20150225144824.GA5132@x1>
References: <1423393458-30334-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423393458-30334-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Felipe Balbi <balbi@ti.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Feb 2015, Nicholas Mc Guire wrote:

> return type of wait_for_completion_timeout is unsigned long not int. =
as
> time_left is used for wait_for_completion_timeout exclusively here it=
s=20
> type is simply changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>=20
> Patch was only compile tested with=20
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
>=20
>  drivers/i2c/busses/i2c-bcm2835.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2=
c-bcm2835.c
> index 5d6feb9..c9336a3 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -147,7 +147,7 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2=
c_dev *i2c_dev,
>  				struct i2c_msg *msg)
>  {
>  	u32 c;
> -	int time_left;
> +	unsigned long time_left;
> =20
>  	i2c_dev->msg_buf =3D msg->buf;
>  	i2c_dev->msg_buf_remaining =3D msg->len;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
