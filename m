From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Wed, 12 Sep 2012 00:13:44 +0200
Message-ID: <20120911221344.GF27031@pengutronix.de>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>
 <503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
 <503B7D6E.7090906@atmel.com>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D747@wm021.weinmann.com>
 <504EF5BF.2090404@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <504EF5BF.2090404-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, "'ludovic.desroches'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, 'Yanes Martinez Adrian' <adrian.yanes-uOixanVlb7U@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "'balbi-l0cyMroinI0@public.gmane.org'" <balbi-l0cyMroinI0@public.gmane.org>, "'h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "'rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "'carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org'" <carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2012 at 10:26:39AM +0200, Nicolas Ferre wrote:
> On 08/27/2012 04:29 PM, Voss, Nikolaus :
> > ludovic.desroches wrote on Monday, August 27, 2012 4:00 PM :
> >> For the moment, I don't have the necessary knowledge about the TWI
> >> controller to take a decision. I would say it can be done in an other
> >> patch in order to have your driver included in the mainline quickly
> >> since it doesn't introduce a breakage.
> >=20
> > That would be the most pragmatic approach.
> > Wolfram, is the anything left to do from my side?
>=20
> Wolfram, ping?
>=20
> Can we imagine to have this support and the device tree patches from
> Ludovic in 3.7-final?

Yes. I'd need your ack since it touches mach-specific stuff. Reviewed-by
would be even better since you know the HW better than me :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBPt5gACgkQD27XaX1/VRuwcACgj3btCafqBDiUtLacOdNljF3Y
KaAAmwYMqWuNbweu3cLgu74CXze6xTJC
=J9Qi
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
