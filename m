From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
Date: Fri, 10 Jul 2015 10:11:48 +0200
Message-ID: <20150710081148.GB1528@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436210695-19159-3-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
> Normally i2c controller works as master, so slave addr is not needed, or =
it
> will impact some slave device (eg. ST NFC chip) i2c accesses, because it =
has
> the same i2c address with controller.

Just to make sure: Does it? As I read the code, slave interrupts are
enabled later only when slave mode is selected? Is that a HW bug? And if
so, can't the code just be moved into this #ifdef block later?

>=20
> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index f4ac8c5..023e59f 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -459,7 +459,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	writel(I2C_ISR_INIT, _ISR(i2c));
>  	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
> =20
> -	if (i2c->reg_isar)
> +	if (i2c->reg_isar && IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
>  		writel(i2c->slave_addr, _ISAR(i2c));
> =20
>  	/* set control register values */
> --=20
> 1.9.1
>=20

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn35EAAoJEBQN5MwUoCm2+SIP/iTB4Kn8znsxmcO6kKoTAbJ5
anypB5FWWiDKqfXHH2WgmOHSqYq2BA+c5Pr9GXsssOlVIV7exxXpLDLvxwkoIKEq
UM3Z5PxrIhStCGwoHvdGiggQLL/eJQerLvTS/EV0U9RappQ3IDQD6Js7Bp9HEGSD
3EXgzMvVN5pn3UT0gvowBG3xhhXfOvvxuJ2Xdd4QvMMZaSYJI/obdZ39CAc29Uqk
os2JfTqYS2yZW6oUTXal2b3TA1ovjqXLKPaahA2yRvrB+RfihweIIKcK1FLXGlsY
h6VfXKmUlUzXWm+fwV5yUOsFzCkpS97YgjobgvfTUPzP+K87zYI8ymg0bBBxbrbL
pDTlaoRsf7bceXgV+bXXTvBm68VWIDDR1jcGAYLd6XJTeZWVJsTcPR5v7rAquYWk
JqJpYExZ0YlXRtAngWs84XBmZab6Cxv4TFLLj86W1gydXaJHMiYU7ygUKDMCp6Rm
NFgQTiuKqv776lZmwQ19KM7T8D5cDp5VCngSGHNnonOmITePQ3L5N04ujpPncZok
ONiHe9GohdJO7HtbpRqIVNudJaTrfdGMt6Rldc63FETohao0WUdlZlbnsjN3sGHn
r0YCn2/2yPyb4VLni7NoSlHqMsCpcP4rNM2xFNWtuXqfYVtLdKvXUTeqUVwRvXiB
msGo5Rsif5gmmx8ZeMQA
=rH6t
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
