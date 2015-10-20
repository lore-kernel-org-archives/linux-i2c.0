From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V5 1/6] i2c: Add i2c support to Freescale Layerscape
 platforms
Date: Tue, 20 Oct 2015 17:52:58 +0200
Message-ID: <20151020155258.GM5379@katana>
References: <1445255774-32887-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445255774-32887-1-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 07:56:09PM +0800, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> Modify the I2C_IMX config to support to Layerscape platforms.
>=20
> Signed-off-by: Mingkai Hu <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Three signed offs for a simple Kconfig change? And the person doing
the patch has no signed off?? That looks wrong. Maybe the above signed
offs should be acked by?

> ---
> V5: V4 V3 V2
>  - No change.
>=20
>  drivers/i2c/busses/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b8617..14147ec 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -582,10 +582,10 @@ config I2C_IMG
> =20
>  config I2C_IMX
>  	tristate "IMX I2C interface"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE
>  	help
>  	  Say Y here if you want to use the IIC bus controller on
> -	  the Freescale i.MX/MXC processors.
> +	  the Freescale i.MX/MXC or Layerscape processors.
> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-imx.
> --=20
> 2.1.0.27.g96db324
>=20

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmNaAAoJEBQN5MwUoCm2GmoP/jRzXnUGzGss8X/pKAnaTGX+
XkYOSlIabsGjbHVARbMorlYLkvkG0AVt8MpfrXKxHBx/xiCU8HRBwhWZzENCLIbz
CvVk0vuEQKDm/T6/TcjPlFbbzKwcwEebydcvsEU/VEej/KM7aWldqbYTYSX3lC2n
bJEOsyvn0tSr6gFFjSS9wyRQZUotbllNWSM9SAzvzMEN91SN+b4vkzTzDwU87q+R
3HUnpE8/eouHrKh2Q15Ak225l25l5IChso1MhWx5w7cfj80Bx0Ni4t+Nk27FfDND
uhMQ4UPqguBNxW1USEsEzHAIfG32VT+stURJoO7iw2ggnBOQweIUtCWOITxCLO2z
jgtDr06CnuqyFQjXsZWsvRo9AXRw+R27ZS0Yt/e7V5w6GHCTv8NIZVoLLphRphI3
DYNo66Cc9M5T4XUyf+a6jSCzxJ73j3L+9tKG+zOJm/8/ETKNBtVs6UEJN0caVTCL
CFUgql4ylmxJpIRGKAyS1BkpFd8Li7qtSWbzeJaULjXgl5Ci8GX8YdlqWQGbKSSc
IBpNFvcJXxlIiFfn3mGsg0y4qm8LS0ONE7mDO1E8X0Qzh9KqlPGsM/G30LfalYOD
qXyzjL9/DF1Jj/Ei1ThVBFqouRPltFrMlv5RzYJQ41b15um+UYxAvnMicZ4eUVkv
4ai9Ux1dRiVnvJcBCbQ2
=EpaM
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
