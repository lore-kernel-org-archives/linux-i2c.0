From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Wed, 5 Jun 2013 15:39:47 +0200
Message-ID: <20130605133945.GA2934@katana>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369648843-1640-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#define SUNXI_I2C_ADDR_REG		(0x00)
> +#define SUNXI_I2C_ADDR_ADDR(v)			((v & 0x7f) << 1)
> +#define SUNXI_I2C_XADDR_REG		(0x04)
> +#define SUNXI_I2C_DATA_REG		(0x08)
> +#define SUNXI_I2C_CNTR_REG		(0x0c)
> +#define SUNXI_I2C_CNTR_ASSERT_ACK		BIT(2)
> +#define SUNXI_I2C_CNTR_INT_FLAG			BIT(3)
> +#define SUNXI_I2C_CNTR_MASTER_STOP		BIT(4)
> +#define SUNXI_I2C_CNTR_MASTER_START		BIT(5)
> +#define SUNXI_I2C_CNTR_BUS_ENABLE		BIT(6)
> +#define SUNXI_I2C_CNTR_INT_ENABLE		BIT(7)
> +#define SUNXI_I2C_STA_REG		(0x10)
> +#define SUNXI_I2C_STA_BUS_ERROR			(0x00)
> +#define SUNXI_I2C_STA_START			(0x08)
> +#define SUNXI_I2C_STA_START_REPEAT		(0x10)
> +#define SUNXI_I2C_STA_MASTER_WADDR_ACK		(0x18)
> +#define SUNXI_I2C_STA_MASTER_WADDR_NAK		(0x20)
> +#define SUNXI_I2C_STA_MASTER_DATA_SENT_ACK	(0x28)
> +#define SUNXI_I2C_STA_MASTER_DATA_SENT_NAK	(0x30)
> +#define SUNXI_I2C_STA_MASTER_RADDR_ACK		(0x40)
> +#define SUNXI_I2C_STA_MASTER_RADDR_NAK		(0x48)
> +#define SUNXI_I2C_STA_MASTER_DATA_RECV_ACK	(0x50)
> +#define SUNXI_I2C_STA_MASTER_DATA_RECV_NAK	(0x58)
> +#define SUNXI_I2C_CCR_REG		(0x14)
> +#define SUNXI_I2C_CCR_DIV_N(val)		(val & 0x3)
> +#define SUNXI_I2C_CCR_DIV_M(val)		((val & 0xf) << 3)
> +#define SUNXI_I2C_SRST_REG		(0x18)
> +#define SUNXI_I2C_SRST_RESET			BIT(0)
> +#define SUNXI_I2C_EFR_REG		(0x1c)
> +#define SUNXI_I2C_LCR_REG		(0x20)
> +
> +#define SUNXI_I2C_DONE			BIT(0)
> +#define SUNXI_I2C_ERROR			BIT(1)
> +#define SUNXI_I2C_NAK			BIT(2)
> +#define SUNXI_I2C_BUS_ERROR		BIT(3)

The register set looks similar to i2c-mv64xxx.c. Has it been considered
to merge the two drivers?


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRrz+hAAoJEBQN5MwUoCm2svoP/iWj0dwlQD1jFvT8/jN6EpUr
FTaYYP/Qr8lvRA/RKycWINu75izM7JF4sM9sYgFRcWs3CIlJ5iY6arVfIOu4S7lJ
xIetX36FglYKehjAd5sE7Lvwp4mmIB4OtHsQHk5oEEqhVGQc5YCNaiWVhPWhBIFU
2bo07bTRmb0lB0qP2Udjp015CzPdbtBrgM3zUz9tdk0kNNZ5AyIVP3A2MZcFmVuW
1QUUAnK6/Q9W//bY3O0D+gRcFTmPgNmOpmWJWvnrqdVUVLD2s87LALsohCbiTgqO
CXr/z6xo/ylIVJWWAKihROVL3itV1yNTRjF9pDD45z1bTcRKNiLRFDglhRB0yGJu
Qvv+VyuhcY+9qJcOaWX669q1y6Z0R3XTeFPJjr4gUvEdarDHsZ43thBnLY9SAX2h
6qBTszwMbAuZADffbvN08ZOrVsIjP956foOdQhH2EM8d+JuUh8kOH5w9vgLl8PyB
ESc3t3PylpLjP+R288NM9gYZlmbdTO22ann2WLSPv9A1yp98UYLhfW0yhw9eo2ba
hjNdtHbxRzLmOsvRD/CJdzydrwKwgRgmUTKWGsU1g7CfHEskcM6AKrkbG0yBADFO
QPmyKKPGNU5QL5PnGowhxRn3LI722W5URGNKrUFkvSytDfTkqp8CXLFH5v0aJ6AE
DhhpisSRjUNmgUivH+Xt
=UTLl
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
