From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 13/24] mfd: fix dangling pointers
Date: Tue, 30 Mar 2010 14:41:58 +0200
Message-ID: <20100330124158.GJ29472@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-14-git-send-email-w.sang@pengutronix.de> <20100325104137.GA3720@sortiz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100325104137.GA3720-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2010 at 11:41:38AM +0100, Samuel Ortiz wrote:
> Hi Wolfram,
>=20
> On Sat, Mar 20, 2010 at 03:12:54PM +0100, Wolfram Sang wrote:
> > Fix I2C-drivers which missed setting clientdata to NULL before freeing =
the
> > structure it points to. Also fix drivers which do this _after_ the stru=
cture
> > was freed already.
> Patch applied, many thanks.

Thanks. Sadly some fixup will be needed:

We reached an agreement that a) setting the clientdata-pointer to NULL shou=
ld
be done in the i2c-core [1] and b) how to do it. Based on that, I will do t=
he
modification of the i2c-core for 2.6.34 (as it fixes the dangling pointers)=
 and
then create one single patch removing the then superflous calls to
i2c_set_clientdata for 2.6.35 (as it is a cleanup). As you already applied =
the
above patch to your branch: you don't have to revert, we will fix it for yo=
u in
the next round.

Sorry for the detour!

Kind regards,

   Wolfram

[1] http://thread.gmane.org/gmane.linux.drivers.i2c/5674/focus=3D5729

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkux8ZYACgkQD27XaX1/VRsWPQCeKipiGJ4vmu3Xb0myM+cG3Rx4
OYYAoL9SIRKKxnPXLO+9qOgDgedTzq54
=mQLF
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--
