From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 03/24] usb/otg/isp1301_omap: Fix dangling pointer
Date: Tue, 30 Mar 2010 14:30:30 +0200
Message-ID: <20100330123030.GE29472@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-4-git-send-email-w.sang@pengutronix.de> <20100320200907.GA3861@gandalf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100320200907.GA3861@gandalf>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2010 at 10:09:07PM +0200, Felipe Balbi wrote:
> On Sat, Mar 20, 2010 at 03:12:44PM +0100, Wolfram Sang wrote:
> > Fix this i2c-driver which missed setting clientdata to NULL before free=
ing the
> > structure it points to. Found by a semantic patch, but fixed by hand.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
>=20
> Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>=20
> Greg,
>=20
> if you wish, you can take queue it already unless Dave has any comments.

Thanks but:

please drop this this patch. We reached an agreement that a) setting the
clientdata-pointer to NULL should be done in the i2c-core [1] and b) how to=
 do
it. Based on that, I will do the modification of the i2c-core for 2.6.34 (a=
s it
fixes the dangling pointers) and then create one single patch removing the =
then
superflous calls to i2c_set_clientdata for 2.6.35 (as it is a cleanup). If =
you
already applied the above patch to your branch, you don't have to revert; we
will fix it for you in the next round.

Sorry for the detour!

Kind regards,

   Wolfram

[1] http://thread.gmane.org/gmane.linux.drivers.i2c/5674/focus=3D5729

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkux7uYACgkQD27XaX1/VRs8lgCfdSWmMqeV5ofY0y5my3O2weiK
XNUAnjk+HWCG3Djbomb6ueKiMunzc7RX
=885N
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
