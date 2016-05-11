From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xlr: rename ARCH_TANGOX to ARCH_TANGO
Date: Wed, 11 May 2016 16:55:36 +0200
Message-ID: <20160511145536.GE1716@katana>
References: <5733416D.70409@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37739 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbcEKOzk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 10:55:40 -0400
Content-Disposition: inline
In-Reply-To: <5733416D.70409@free.fr>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-i2c@vger.kernel.org, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 04:27:57PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>=20
> The ARCH name was changed during the review process.
> http://article.gmane.org/gmane.linux.ports.arm.kernel/456331
>=20
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---

Where is your Signed-off? Where is your real name? Shouldn't there be a
flag day changing that all at once?

>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2dd40ddf04de..d8d18ed65440 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -965,7 +965,7 @@ config I2C_XILINX
> =20
>  config I2C_XLR
>  	tristate "Netlogic XLR and Sigma Designs I2C support"
> -	depends on CPU_XLR || ARCH_TANGOX
> +	depends on CPU_XLR || ARCH_TANGO
>  	help
>  	  This driver enables support for the on-chip I2C interface of
>  	  the Netlogic XLR/XLS MIPS processors and Sigma Designs SOCs.
> --=20
> 2.8.1

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXM0foAAoJEBQN5MwUoCm2MaYP/26b6yi2Lfkiha7bWabGcQaw
ExKZspQDzd5UEVPijQ70kyfdM4jTVoYf71peIZTWEgfSezOMO7vvYCbjReSRJj/j
e+kbIOJap7kc9Xu5T1DkWD+/UyjfkhEMkARPkTx4M4Mkjlm5mmcEA26/rabPFw2J
AATUvpLpigy/+yZpECKSvH3OcXaPa9B/EzPQV8Tk9FSx9Jiw6PPDN1cJtWQs+3+/
/rn9H8X4bWt17MN0XBiwI2FHdyP18Uh6FCN25gjoNUDtBZbfm6UsnFxKVBjH40NS
xy80EjA1n9yJg4XrFWJ35cJ0QvY09Auh6rjnXHD9I8u29oCntfyYQAq1sQJ8V5Ou
I2oOANcwKSA29XTJzimlAjyRLTdJBSOv7qybGsBJp2bfSuvDrfAVvYMa7pdcDReL
5bl1c8QfI3Xd/6WXxyM0j5epUsmcXD5us+Pk1Exbg1f6uwkqz9zXDIAsku74cvbl
eNaOOTlSF9NCXM0rhVCFpf4jg5iQyb2ArrjtWhWSyhrjiG/mxXMF6hx/W+C+v3AM
8uWzN81DqQFryVRs9X+xUjz/dsU1ytt/8mpTVoKRAACCkHUx/G+9Z/xTZ1kxNwJS
2JtW1PZGlu+Y+RtevPHJJ8YevTOpab+AToAtjdea/jV825ta3gDe1uGuNOO+T2P6
Lg/3muvW0wsGgfIHw4EH
=mDt1
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
