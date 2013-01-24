From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] at24: extend driver to allow writing via
 i2c_smbus_write_byte_data
Date: Thu, 24 Jan 2013 15:07:46 +0100
Message-ID: <20130124140746.GI12933@pengutronix.de>
References: <1355933229-25865-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1355933229-25865-1-git-send-email-christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, c.gmeiner-qzos7lGCgFkk+I/owrrOrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2012 at 05:07:09PM +0100, Christian Gmeiner wrote:
> I have a at24 EEPROM connected via i2c bus provided by ISCH i2c
> bus driver. This bus driver does not support
> I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and so I was looking for a way
> to be able to write the eeprom. This patch adds support for
> I2C_SMBUS_BYTE_DATA writing via i2c_smbus_write_byte_data.
> It is quite slow, but it works.
>=20
> Signed-off-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2baeec5..723b411 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -56,6 +56,7 @@ struct at24_data {
>  	struct at24_platform_data chip;
>  	struct memory_accessor macc;
>  	int use_smbus;
> +	int use_smbuse_write;

Can't you use the same 'use_smbus' variable and do a similar switch-case
as in the read function?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEBQDIACgkQD27XaX1/VRubcgCfanKNVhiq/2/npM6usVXhsmod
AEoAoKqwJmZTki9wAb7xaZmikXPw0D6q
=wNkR
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
