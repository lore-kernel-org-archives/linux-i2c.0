From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mediatek: fix transfer error handling
Date: Fri, 31 Jul 2015 13:00:46 +0200
Message-ID: <20150731110045.GJ1522@katana>
References: <1438054685-25214-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438054685-25214-1-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2015 at 11:38:05AM +0800, Eddie Huang wrote:
> From: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>=20
> Reset i2c dma engine in hw init function.
> When occur i2c ack error, mtk_i2c_irq may is twice,
> first is the ack error interrupt, then the complete interrupt,
> so i2c->irq_stat need keep the two interrupt value, and only
> call complete() for the complete interrupt.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Looks to me this patch needs to be split up into one patch per issue?
And doesn't it kill the auto_restart functionality? Sascha?

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt6=
5xx.c
> index 9920eef..57d11b7 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -59,6 +59,7 @@
>  #define I2C_DMA_START_EN		0x0001
>  #define I2C_DMA_INT_FLAG_NONE		0x0000
>  #define I2C_DMA_CLR_FLAG		0x0000
> +#define I2C_DMA_HARD_RST		0x0002
> =20
>  #define I2C_DEFAULT_SPEED		100000	/* hz */
>  #define MAX_FS_MODE_SPEED		400000
> @@ -81,6 +82,7 @@ enum DMA_REGS_OFFSET {
>  	OFFSET_INT_FLAG =3D 0x0,
>  	OFFSET_INT_EN =3D 0x04,
>  	OFFSET_EN =3D 0x08,
> +	OFFSET_RST =3D 0x0c,
>  	OFFSET_CON =3D 0x18,
>  	OFFSET_TX_MEM_ADDR =3D 0x1c,
>  	OFFSET_RX_MEM_ADDR =3D 0x20,
> @@ -262,6 +264,10 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
>  	writew(control_reg, i2c->base + OFFSET_CONTROL);
>  	writew(I2C_DELAY_LEN, i2c->base + OFFSET_DELAY_LEN);
> +
> +	writel(I2C_DMA_HARD_RST, i2c->pdmabase + OFFSET_RST);
> +	udelay(50);
> +	writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_RST);
>  }
> =20
>  /*
> @@ -550,16 +556,20 @@ err_exit:
>  static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
>  {
>  	struct mtk_i2c *i2c =3D dev_id;
> -	u16 restart_flag =3D 0;
> +	u16 intr_stat =3D 0;
> =20
> -	if (i2c->dev_comp->auto_restart)
> -		restart_flag =3D I2C_RS_TRANSFER;
> +	intr_stat =3D readw(i2c->base + OFFSET_INTR_STAT);
> +	writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
> =20
> -	i2c->irq_stat =3D readw(i2c->base + OFFSET_INTR_STAT);
> -	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR
> -		| I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
> +	/*
> +	 * when occurs i2c ack error, mtk_i2c_irq is called twice,
> +	 * first is the ack error interrupt, then the complete interrupt,
> +	 * i2c->irq_stat need keep the two interrupt value.
> +	 */
> +	i2c->irq_stat |=3D intr_stat;
> =20
> -	complete(&i2c->msg_complete);
> +	if (i2c->irq_stat & I2C_TRANSAC_COMP)
> +		complete(&i2c->msg_complete);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -729,3 +739,4 @@ module_platform_driver(mtk_i2c_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MediaTek I2C Bus Driver");
>  MODULE_AUTHOR("Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
> +MODULE_AUTHOR("Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
> --=20
> 1.7.9.5
>=20

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1VdAAoJEBQN5MwUoCm2d54P/jU97UHKytBCjNuyUyMQvVsR
wr1OOTSCebNlD0WMmLdgyzsXjEk4JjTFuJWOr5/qh+ePA5/tYxPWoUzpf6jjGet4
Bsk3Vb8gcd0LSoDj3lo/rv0JSmmkvg581kmP0ljK8JOdaTLbxlGihWY4gH3gPuMI
+5cjOmyN96p7qzWDLyV5f71mS4O/cP4N0Knyn5rqhAefT8lrMfKtZKSBUv/zz1gQ
uiOXZTcGMDNseusMlUPjR+h2Vyaw4NfTNe7gFmDS+yZ1SBpiwy2JbAnjOXIRdrKi
4KfqptViqNGRqOhAvJmBwE1GFxdnY3x2+DIB+hdO6tWFTKWKAAd2QFwfhLUuyuf/
Z/qCCMWbrf7LcjDldbKbai5t3dTk+hlEgHbbRxBst7TVhsWIT1HGCvae/YEWL4F0
g+LYREa1H9p/eUDtbc2TMn1YVqgkqUmoEPytmSFix1yYg5FL4InGCRpnmCAVPJZ/
095u/cdtVk2tZyqeskk7uS+WVrGY/Hi3IdhsSxdSYsmeelNk4iMnLnMzTPKzJMz3
LQ75wCjN0XDWhB3GtDjyhZn0/p/4dZqMkTzA8AkPsiU0Db0xLxbHNFkBT0f8K9YK
6Va1PNUfCyL6vCNwvbikCGW0Ozu8XoHwMPqE5JyYszHN6YdQ29r9eZGpOnl/V73g
E8muu2cheP36GBjudK9/
=Ex/T
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
