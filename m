From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: at91: add dma support
Date: Wed, 14 Nov 2012 10:22:48 +0100
Message-ID: <20121114092248.GB5954@pengutronix.de>
References: <1352470068-7678-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352470068-7678-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2012 at 03:07:48PM +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>=20
> Add dma support for Atmel TWI which is available on sam9x5 and later.
>=20
> When using dma for reception, you have to read only n-2 bytes. The last
> two bytes are read manually. Don't doing this should cause to send the
> STOP command too late and then to get extra data in the receive
> register.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Some minor comments. But please let sparse run over your build. It has
some hints for you.

> ---
>=20
> Changes:
> - v2 (based on Russell feedback):
>     - replace DMA_TO_DEVICE/DMA_FROM_DEVICE by DMA_MEM_TO_DEV/DMA_DEV_TO_=
MEM
>     - don't check for tx_submit errors
>     - atmel dma header location has changed
>=20
>  drivers/i2c/busses/i2c-at91.c | 316 ++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 305 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index aa59a25..f6fba9c 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -19,6 +19,8 @@
> =20
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -30,6 +32,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20

Unneeded empty line.

> +#include <linux/platform_data/dma-atmel.h>
> +
>  #define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
>  #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
> =20
> @@ -65,9 +69,21 @@
>  #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
> =20
>  struct at91_twi_pdata {
> -	unsigned	clk_max_div;
> -	unsigned	clk_offset;
> -	bool		has_unre_flag;
> +	unsigned		clk_max_div;
> +	unsigned		clk_offset;
> +	bool			has_unre_flag;
> +	bool			has_dma_support;
> +	struct at_dma_slave	dma_slave;
> +};

This is a good example why indenting struct members to tabs is causing
trouble later. My recommendation is to use a single space even if this
means no alignment.

=2E..

> @@ -224,12 +389,36 @@ static int at91_do_twi_transfer(struct at91_twi_dev=
 *dev)
>  		if (dev->buf_len <=3D 1 && !(dev->msg->flags & I2C_M_RECV_LEN))
>  			start_flags |=3D AT91_TWI_STOP;
>  		at91_twi_write(dev, AT91_TWI_CR, start_flags);
> -		at91_twi_write(dev, AT91_TWI_IER,
> +		/*
> +		 * When using dma, the last byte has to be read manually in
> +		 * order to not send the stop command too late and then
> +		 * to receive extra data. In practice, there are some issues
> +		 * if you use the dma to read n-1 bytes because of latency.
> +		 * Reading n-2 bytes with dma and the two last ones manually
> +		 * seems to be the best solution.
> +		 */
> +		if (dev->use_dma && (dev->buf_len > 2)) {

Setting up DMA can cause quite some overhead, so it might be more
efficient to to start using DMA only for transfers bigger than x byte
instead of 2.

=2E..

BTW on a glimpse, are you really using the cookies you set up?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjYugACgkQD27XaX1/VRtiSgCgoy27QoUy9lAwbhSoBnFcF3LM
rd4An2+W+kvAGAWjsEk92QwLP6vostXb
=VejB
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
