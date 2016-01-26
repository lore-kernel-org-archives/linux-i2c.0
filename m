From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: drivers : i2c: Allow i2c devices share an interrupt
Date: Tue, 26 Jan 2016 07:08:03 +0100
Message-ID: <20160126060803.GA16383@katana>
References: <1452585707-20294-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51488 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbcAZGIJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 01:08:09 -0500
Content-Disposition: inline
In-Reply-To: <1452585707-20294-1-git-send-email-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ying.zhang22455@nxp.com
Cc: linux-i2c@vger.kernel.org, X.Xie@freescale.com, Ying Zhang <b40530@freescale.com>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2016 at 04:01:47PM +0800, ying.zhang22455@nxp.com wrote:
> From: Ying Zhang <b40530@freescale.com>
>=20
> The I2C devices on I2C1, I2C2, I2C3, I2C4 share interrupts,
> but the flag is not set when requesting IRQ.

For which SoC is that information? And with which devices is it shared?
Please update the commit message.

>=20
> This patch set the flag to IRQF_SHARED.
>=20
> Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d4d8536..611b269 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1094,7 +1094,7 @@ static int i2c_imx_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	/* Request IRQ */
> -	ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
> +	ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, IRQF_SHARED,
>  				pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpw1DAAoJEBQN5MwUoCm2KTwQAIjBoiUTjUAla1u2QkW5Vj8V
kacZexzGAWGmEIWfgepNJkFn8BmEBZCNc2PxYWTfCF5/oxSCmzTtLnPYn1375hr+
2jGT4ip6ZFPCX7FIrnq3koX8aAxifVP82wR9gHHiBEK0STwqJJB4/fYkFqDZg4ds
o962NQMua1GfDzX1toCx/PniFWL3buAnOPomL0SZO3YdmfeoAd2FLhHqWUg5MN1M
92+WsN3HLa9jo3oY5ex9x6AMU1mzyxzvUZwaL30OBp3kq6vyUVvdI11y8LSDpM8O
cSVWk8OfdxiXJVAMRuwAOui+VKaXxBIacbBM1T5OIiIN9MVLZln1zHwQtroNDnI9
azfaKmm8+WVpHUuJMauwOEJIKdl9cFDvxVVmRLy1jSId5FeSxRGp5hsO3BEIw1/f
vgC+ZObWB9NVHB68tklXc5boJhKYzxJuXzxI5tPybtQBEuMAZBe8RqUyHzzoZCR5
vl5YwvPBcPMYIqyMp6MR+oQqhMDO4/zJ8oQjclJv65/DmCSFsZtw3MihDoYmfpcN
xC3InAz0WoCMObIfodsUjCk9qZpLjW9Nb7dO8wtquNRLqERP6drxBcIObBxA48tE
vN5qwDZeN+M5ieU3cMFE5XNQ2WrjGoNCNuJ8IhYtFApxdqTJy5cB7Utvw/ey5olf
MeHo2RtEcKlbt7ji+BgG
=uuOO
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
