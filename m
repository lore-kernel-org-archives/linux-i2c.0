From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C
	bindings
Date: Mon, 25 Jan 2010 12:56:54 +0100
Message-ID: <20100125115654.GB5257@pengutronix.de>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com> <1264408029-5290-2-git-send-email-wg@grandegger.com> <1264408029-5290-3-git-send-email-wg@grandegger.com> <1264408029-5290-4-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1264408029-5290-4-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2010 at 09:27:09AM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>=20
> This patch adds the MPC5121 to the list of supported devices,
> enhances the doc of the "clock-frequency" property and removes
> the obsolete "cell-index" property from the example nodes.

I think "fsl,mpc5121-i2c-ctrl" needs to be documented here, too?

>=20
> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
> ---
>  Documentation/powerpc/dts-bindings/fsl/i2c.txt |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documentati=
on/powerpc/dts-bindings/fsl/i2c.txt
> index b6d2e21..2af8a05 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> @@ -9,8 +9,8 @@ Recommended properties :
> =20
>   - compatible : compatibility list with 2 entries, the first should
>     be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
> -   e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second one
> -   should be "fsl-i2c".
> +   e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b. The
> +   second one should be "fsl-i2c".
>   - interrupts : <a b> where a is the interrupt number and b is a
>     field that represents an encoding of the sense and level
>     information for the interrupt.  This should be encoded based on
> @@ -20,7 +20,9 @@ Recommended properties :
>     services interrupts for this device.
>   - fsl,preserve-clocking : boolean; if defined, the clock settings
>     from the bootloader are preserved (not touched).
> - - clock-frequency : desired I2C bus clock frequency in Hz.
> + - clock-frequency : desired I2C bus clock frequency in Hz.  If this
> +   property and "fsl,preserve-clocking" is not defined, a safe fixed
> +   clock divider value is used (resulting in a small clock frequency).
> =20
>  Examples :
> =20
> @@ -28,7 +30,6 @@ Examples :
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
>  		compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> -		cell-index =3D <0>;
>  		reg =3D <0x3d00 0x40>;
>  		interrupts =3D <2 15 0>;
>  		interrupt-parent =3D <&mpc5200_pic>;
> @@ -38,7 +39,6 @@ Examples :
>  	i2c@3100 {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -		cell-index =3D <1>;
>  		compatible =3D "fsl,mpc8544-i2c", "fsl-i2c";
>  		reg =3D <0x3100 0x100>;
>  		interrupts =3D <43 2>;
> --=20
> 1.6.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktdhwYACgkQD27XaX1/VRujggCgrcarwmJRUBVv7W9Ru5mC5+Rz
dUgAn0bc1X9bB+8jQydmGIqqctNFYo+1
=wJpz
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
