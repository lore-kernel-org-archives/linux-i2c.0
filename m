From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c: add 'set_sda' to bus_recovery_info
Date: Tue, 9 Jan 2018 12:23:58 +0100
Message-ID: <20180109112358.3enbi2fxt6fniasm@ninjato>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-4-wsa+renesas@sang-engineering.com>
 <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5qntr2zkxlsjb4up"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZzwo9UhT08VDHXg6=eXdK80Pt1omZ4Xda_HFwguyNpaw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org


--5qntr2zkxlsjb4up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 09:39:48AM +0100, Linus Walleij wrote:
> On Mon, Dec 4, 2017 at 1:36 PM, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>=20
> > This will be needed when we want to create STOP conditions, too, later.
> > Create the needed fields and populate them for the GPIO case if the GPIO
> > is set to output.
> >
> > Cc: Phil Reid <preid@electromag.com.au>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> (...)
> >  #include <linux/errno.h>
> > +#include <linux/gpio.h>
>=20
> Please no.
>=20
> > +                       if (gpiod_get_direction(bri->sda_gpiod) =3D=3D =
GPIOF_DIR_OUT)
> > +                               bri->set_sda =3D set_sda_gpio_value;
>=20
> Just compare it to zero. if (!gpiod_get_direction())

Okay, for now, I'll do:

	/* FIXME: add proper flag once provided by GPIO core */
	if (gpiod_get_direction(bri->sda_gpiod) =3D=3D 0)

Thanks!

   Wolfram


--5qntr2zkxlsjb4up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpUpk4ACgkQFA3kzBSg
KbawlQ//SYS+r3JX007+ioa5xlwm47bOnD/+GJDN1T928JPbxKy2OkJEJVoyidiJ
MEvZ4OEyvjXjzvVTrJQwPLjFC15lgcGrFUWqHbhLMK/iMnOZTXb7Si2faEaUi4WM
3HDnnN60HqjtPOY6zn0wlHOkSNHT02Sf5V89CZmdiyNAMdoH/oMSfQU7FGb63cyw
WpiK+vbkbo3xNR9A482xb9W93O4XNgtRVm5YOyGXMusNXHzwkMIsLfVLewbbdGa+
D9Gn1YpEM6VcIepy0pJZDhh/jCPyAirKV2VvxmbczvKzAoDhyiYsVaQYwIYL1vjq
yc4YSQN4AEOYGAdn3TGwTh/0D5hdWzKfUX/8nrLl4d4CBAX9y5AL/CMVPe7zNjqE
aCxhPQ2/33dD4ZKm6PBAr5ihRkSCiWlIwoiWnRTRVKFv8mdYFN/AC0Qktn2TA1bE
oPDZAHVCnGoyWcSTrnIbQqEtXi/RkZUM2LcpzH/iOkAL9p3u/I4p/uWa1HURiB4A
hWG5MMHP5FKSa0GkqXfA/2DnHnH1F3vj/yTR6fn7Nej1JMdS49AW0aoxkvLu9vSa
qTq209ZM7B/5BQGhLHBCl1F7yo5h4f8KRF3+4+lufZmn7d8b8gwmKA8nRJOX97jp
le+Xcc/2FJNLto0gEoUk19NAh0fW3iSDu842FL4dtbpjbIe5PDY=
=nSqe
-----END PGP SIGNATURE-----

--5qntr2zkxlsjb4up--
