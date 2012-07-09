From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: mxs_i2c_finish_read: mute flase positive
 uninitialized var
Date: Mon, 9 Jul 2012 13:14:40 +0200
Message-ID: <20120709111440.GF1296@pengutronix.de>
References: <1341178470-14904-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341178470-14904-1-git-send-email-mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2012 at 11:34:30PM +0200, Marc Kleine-Budde wrote:
> This patch mutes the false positive compiler warning:
>=20
> drivers/i2c/busses/i2c-mxs.c: In function 'mxs_i2c_xfer_msg':
> drivers/i2c/busses/i2c-mxs.c:206:8: warning: 'data' may be used uninitial=
ized in this function [-Wuninitialized]
> drivers/i2c/busses/i2c-mxs.c:196:6: note: 'data' was declared here
>=20
> Cc: "Wolfram Sang" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

FYI: Checkpatch complains about the position of the quotes above.

> Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied. I didn't know the exact intention of 'uninitialized_var'
before. Its commit message (9490991482a2091a828d997adbc088e24c310a4d)
convinces me to accept this compromise. It will silence the warning, but
it can be disabled if such warnings want to be seen. Also, there is no
extra code added like with '=3D 0'.

I still do think however, gcc should be able to find out what happens.
There is no pointer magic involved here...

> ---
>  drivers/i2c/busses/i2c-mxs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 04eb441..02ce1fa 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *=
i2c)
> =20
>  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
>  {
> -	u32 data;
> +	u32 uninitialized_var(data);
>  	int i;
> =20
>  	for (i =3D 0; i < len; i++) {
> --=20
> 1.7.10
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/6vSAACgkQD27XaX1/VRuGOwCaAmlkJIRyslF6cacjwt7l6DVJ
ctEAn1EnHsbrp7zDTxU4910ZIWqy491V
=m/Tg
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
