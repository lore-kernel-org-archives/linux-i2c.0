From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Tue, 2 Jul 2013 20:11:15 +0200
Message-ID: <20130702181115.GR27010@pengutronix.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372780860-12972-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
> According to mx23 erratum 2727:
>=20
> "2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set=
=2E
>=20
> Description:
>=20
> When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generate=
d.=20
> However, the SDA line is read at the proper timing interval. If=20
> RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
> Also, the HW_I2C_VERSION register incorrectly states the version is 1=
=2E2.=20
> It should be 1.3.
>=20
> Workaround:
> HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to 1 =
to=20
> enable the fix for this issue."
>=20
> It has also been noticed that mx28 needs to implement this fix in ord=
er to have
> SMBus to work properly.
>=20
> Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Did you see this making the driver handle some situations that caused
failure before?=20

> ---
>  drivers/i2c/busses/i2c-mxs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mx=
s.c
> index 6d8094d..ce7ac86 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -56,6 +56,7 @@
>  #define MXS_I2C_CTRL1_CLR	(0x48)
> =20
>  #define MXS_I2C_CTRL1_CLR_GOT_A_NAK		0x10000000
> +#define MXS_I2C_CTRL1_ACK_MODE			0x08000000
>  #define MXS_I2C_CTRL1_BUS_FREE_IRQ		0x80
>  #define MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ	0x40
>  #define MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ		0x20
> @@ -140,6 +141,14 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2=
c)
>  	writel(0x00300030, i2c->regs + MXS_I2C_TIMING2);
> =20
>  	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> +
> +	/*
> +	 * According to mx23 erratum 2727:
> +	 * "I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set"
> +	 *
> +	 * HW_I2C_CTRL1[ACK_MODE] needs to be set when RETAIN_CLOCK is set.
> +	 */
> +	writel(MXS_I2C_CTRL1_ACK_MODE, i2c->regs + MXS_I2C_CTRL1_SET);
So you set this bis in the reset routine. The first thing in
mxs_i2c_pio_setup_xfer is however:

	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);

which unsets the ACK_MODE bit. Also when reading the docs I couldn't
find out the motivation to set RETAIN_CLOCK at all in the select
command.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
