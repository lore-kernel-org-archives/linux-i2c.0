From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/8] i2c: at91: cleanup and dt support
Date: Wed, 12 Sep 2012 12:16:07 +0200
Message-ID: <20120912101607.GA2624@pengutronix.de>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
 <505041EF.5060204@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <505041EF.5060204-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 10:03:59AM +0200, Nicolas Ferre wrote:
> On 09/12/2012 08:42 AM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> > From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >=20
> > Hi,
> >=20
> > This set of patches is based on Nikolaus at91_i2c driver.
> >=20
> > Changes:
> > v3:
> >   - only put multi-drive lines in the if...else statement (suggested
> >   by Warner Losh)
>=20
> Hi Wolfram,
>=20
> As said by Ludovic, this series goes on top of Nikolaus' one.
> My Acked-by is already set on this one, so I think that I have nothing
> more to do ;-)
>=20
> BTW, in case you need help to sort all this, do not hesitate to contact
> us... we can setup a git tree for this...

I think I am fine. Patches look good. I wondered a bit about first
removing the old driver, then adding the new one with regard to
bisectability. But as the old driver depends on BROKEN, I think this is
OK to do.

One thing I'd like to make, though. I'd like to squash the following
patches into one:

	drivers/i2c/busses/i2c-at91.c: add new driver
	i2c: at91: use managed resources
	i2c: at91: add warning about transmission issues for some devices
	i2c: at91: use an id table for SoC dependent parameters

It is especially the last patch I am mostly interested in. The id_table
approach is what I like, while the original id_entry mechanism looks
fishy. I'd was good for reviewing to have the patches split like this;
yet for hitting mainline, I'd prefer to have the driver proper on first
occasion. I already did the squashing in a test-branch and the result
looks good to me.

Nikolaus, Ludovic: Are you fine with this?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBQYOcACgkQD27XaX1/VRsdhACcCMZpbbT74RBMMnMo40o2jSLN
kloAoJx5nQusdKiVj5ymLpxnHAepyPhC
=9tRR
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
