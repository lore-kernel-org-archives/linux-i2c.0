From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: add a sanity check on i2c message length
Date: Fri, 2 Nov 2012 12:14:32 +0100
Message-ID: <20121102111432.GD21313@pengutronix.de>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de>
 <5093A8CD.60006@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5093A8CD.60006-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ludovic.desroches" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2012 at 12:04:45PM +0100, ludovic.desroches wrote:
> Hi Wolfram,
>=20
> Le 11/01/2012 11:29 PM, Wolfram Sang a =E9crit :
> >On Wed, Oct 10, 2012 at 04:25:58PM +0200, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wr=
ote:
> >>From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >>
> >>If the i2c message length is zero, i2c-at91 will directly return an err=
or
> >>instead of trying to send a zero-length message.
> >>
> >>Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >
> >What happens if you send a 0 byte message? Some hardware is able to do
> >this and it will be used in SMBUS QUICK which the driver states to
> >support according to at91_twi_func().
>=20
> Without this I had some data corruption when writing to / reading
> from a serial eeprom (depending on the IP version).
>=20
> Yes SMBUS quick command is supported but is not managed in the
> driver, we have to tell explicitly the IP that we want to send this
> command.

Ok, so unless you want to implement the support, please update this
patch with a comment that SMBUS_QUICK is a TODO and remove the
SMBUS_QUICK capability.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCTqxgACgkQD27XaX1/VRuRiQCgsW+TQQ4L69/Lr70gh9mds+Nw
3KsAnA/83SCg2cSmF4vY4bhL2LaD4nX5
=XXLe
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
