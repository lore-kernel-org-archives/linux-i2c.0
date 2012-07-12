From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/4] i2c: i2c-ocores: support for 16bit and 32bit IO
Date: Thu, 12 Jul 2012 15:35:56 +0200
Message-ID: <20120712133556.GK2194@pengutronix.de>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1341900658-7698-5-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341900658-7698-5-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2012 at 11:40:58AM +0530, Jayachandran C wrote:
> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>=20
> Some architectures supports only 16-bit or 32-bit read/write access to
> their IO space. Add a 'reg-io-width' platform and OF parameter which
> specifies the IO width to support these platforms.
>=20
> reg-io-width can be specified as 1, 2 or 4, and has a default value
> of 1 if it is unspecified.
>=20
> Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-ocores.txt         |    2 ++
>  drivers/i2c/busses/i2c-ocores.c                    |   21 ++++++++++++++=
++++--
>  include/linux/i2c-ocores.h                         |    1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-ocores.txt
> index 1c9334b..c15781f 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> @@ -10,6 +10,7 @@ Required properties:
> =20
>  Optional properties:
>  - reg-shift       : device register offsets are shifted by this value
> +- reg-io-width    : io register width in bytes (1, 2 or 4)
>  - regstep         : deprecated, use reg-shift above
> =20
>  Example:
> @@ -23,6 +24,7 @@ Example:
>  		clock-frequency =3D <20000000>;
> =20
>  		reg-shift =3D <0>;	/* 8 bit registers */
> +		reg-io-width =3D <1>;	/* 8 bit read/write */
> =20
>  		dummy@60 {
>  			compatible =3D "dummy";
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-oco=
res.c
> index 9617ec1..034d1d5 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -30,6 +30,7 @@
>  struct ocores_i2c {
>  	void __iomem *base;
>  	int reg_shift;
> +	int reg_io_width;

u32 again.

>  	wait_queue_head_t wait;
>  	struct i2c_adapter adap;
>  	struct i2c_msg *msg;
> @@ -72,12 +73,22 @@ struct ocores_i2c {
> =20
>  static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
>  {
> -	iowrite8(value, i2c->base + (reg << i2c->reg_shift));
> +	if (i2c->reg_io_width =3D=3D 4)
> +		iowrite32(value, i2c->base + (reg << i2c->reg_shift));
> +	else if (i2c->reg_io_width =3D=3D 2)
> +		iowrite16(value, i2c->base + (reg << i2c->reg_shift));
> +	else
> +		iowrite8(value, i2c->base + (reg << i2c->reg_shift));

Hmm, this could be a helper function, probably. But nothing you'd need
to do right now...

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+0rwACgkQD27XaX1/VRt2RACeMPhsyu6NL1LxYzvJJNZsyNER
q7MAn2VP2YUqqxXx7n2VeOVy1dCGlg8q
=R3os
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
