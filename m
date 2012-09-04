From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: pnx: Fix bit definitions
Date: Tue, 4 Sep 2012 11:20:20 +0200
Message-ID: <20120904092020.GA21271@pengutronix.de>
References: <1344411752-23469-1-git-send-email-stigge@antcom.de>
 <20120818095108.GB24812@pengutronix.de>
 <5030A81E.5090508@antcom.de>
 <083DF309106F364B939360100EC290F823A0354A3D@eu1rdcrdc1wx030.exi.nxp.com>
 <20120820175527.GA9169@pengutronix.de>
 <50451016.7010608@antcom.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50451016.7010608-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Bakki <srinivas.bakki-3arQi8VN3Tc@public.gmane.org>, "aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2012 at 10:16:22PM +0200, Roland Stigge wrote:
> Hi Wolfram,
>=20
> On 20/08/12 19:55, Wolfram Sang wrote:
> >> I've never had my hands on a PNX4008 chip at NXP, but I do
> >> believe they are the same IP. That specific I2C IP was used in a
> >> number of NXP/Phillips chips besides the PNX4008/LPC32xx. I don't
> >> think there are any PNX4008's in the wild, and even working in
> >> NXP, I can't find any non-marketing reference material for that
> >> part (including the user manual).
> >=20
> > Thanks for the heads up. I'll apply both patches, then.
>=20
> Should I consider the two patches as applied now (where?
> i2c-embedded?), or should I resend? ;-)

I will apply them these days and then let them stay in linux-next for a
few days. So, I'd think they should go in for rc6.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBFx9QACgkQD27XaX1/VRtkagCeJFTChjISeMcjcJcfwwThIKIF
nSQAmwSl2JaWlr0kFa3Kk5jVt6N5kQGQ
=h8Ur
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
