From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware-pci: add 10-bit addressing mode
 functionality for BYT I2C
Date: Sun, 9 Mar 2014 09:53:58 +0100
Message-ID: <20140309085357.GA4695@katana>
References: <1394201571-11681-1-git-send-email-chiau.ee.chew@intel.com>
 <1394201571-11681-2-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394201571-11681-2-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2014 at 10:12:50PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> All the I2C controllers on Intel BayTrail LPSS subsystem able
> to support 10-bit addressing mode functionality.
>=20
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Ong, Boon Leong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/bus=
ses/i2c-designware-pcidrv.c
> index f1dabee..87f2fc4 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -64,12 +64,19 @@ struct dw_pci_controller {
>  	u32 tx_fifo_depth;
>  	u32 rx_fifo_depth;
>  	u32 clk_khz;
> +	u32 functionality;
>  };
> =20
>  #define INTEL_MID_STD_CFG  (DW_IC_CON_MASTER |			\
>  				DW_IC_CON_SLAVE_DISABLE |	\
>  				DW_IC_CON_RESTART_EN)
> =20
> +#define DW_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |			\
> +					I2C_FUNC_SMBUS_BYTE |		\
> +					I2C_FUNC_SMBUS_BYTE_DATA |	\
> +					I2C_FUNC_SMBUS_WORD_DATA |	\
> +					I2C_FUNC_SMBUS_I2C_BLOCK)

Can't we have I2C_FUNC_SMBUS_EMUL here? (Need checking with
I2C_SMBUS_QUICK)


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHCwlAAoJEBQN5MwUoCm2B6sP/32n+bq57zW4khi/abZKdUyW
g+cK31cudfHOdUzzNAcixOqTq2DgkfDZViIP9D2Cum/suFCqjebjpIEtnkbjdfav
xsXtAM+8XrS2biv2Wd7wXg6iW0n1UoHyl+bz57yYr8ZiXlI6lcwSuL4hKlgZA4Lm
fw4jvn5GNz5lXZua8Fh3XE2uT43ViVO8Gx6EPZZsD+0wgXn8zBj37NAXtA5ENRRW
vdwsRChNT00d9XNi3yhDfujhNbvK8Xfit91vWxTejsakpwkNt68NBDB5Gl4aDfq4
oe/iv6Qzs3z8syyNnoSca3z/DbFSVQCnFGiVUiILpLHWzTSMVD7J7anxcFgRcy8R
eNqtpEeEHPGysKNWBtdkzRvAIJDzPF4qcFRPz0Nx7AiKQcNH+wHHvHOMWOnCqq8l
282z3WGHaOJnC7qQ0mWOwbLi/R0QhigCbuK0VHB9h1RDzqOfr26tpjOStr9V2f9v
rvpkRF55g4YXeJ4HEAdpDP7t0YiPX1AwE/A3Po9I0s7jIb1EZXcDbmw6NyC2DjT6
J1dQ+IazPcRybpDHxyXVvZUXm3Fqh7ArjQ6r0R9ONjJ2vTJ6W635N7JJJHzfRpYy
QG9h/CcqU23G2fjlA+F/vH0kckZdHXDFBj0+mtZLfrUrPmkfO+LHB9vYKQbNRb2I
PF8FqBSIzq18NRe7V3Bq
=v7HB
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
