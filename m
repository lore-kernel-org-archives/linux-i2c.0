From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 00/16] i2c: remove __dev* attributes for retirement of
Date: Wed, 28 Nov 2012 14:52:42 +0100
Message-ID: <20121128135242.GD14238@pengutronix.de>
References: <20121128104716.GC14238@pengutronix.de>
 <20121128135146.74D0580134@viridian.itc.virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121128135146.74D0580134-A/mCt7huS1Rvw44tLj6iNJvpjmsXDcsSh13vi7wywA4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-A/mCt7huS1Rvw44tLj6iNJvpjmsXDcsSh13vi7wywA4@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 08:51:46AM -0500, Bill Pemberton wrote:
> Wolfram Sang writes:
> >=20
> >=20
> > --iFRdW5/EC4oqxDHL
> > Content-Type: text/plain; charset=3Dus-ascii
> > Content-Disposition: inline
> > Content-Transfer-Encoding: quoted-printable
> >=20
> > On Tue, Nov 27, 2012 at 03:59:37PM -0500, Bill Pemberton wrote:
> > > This is a respin of the patches to remove the __dev* attributes in the
> > > i2c subsystem.
> > >=3D20
> > > The attributes __devinit, __devexit_p, __devinitdata, __devinitconst,
> > > and __devexit are no longer needed since CONFIG_HOTPLUG is being
> > > removed as an option.
> >=20
> > Thanks. Will wait one more day for acks, then probably squash them into
> > one and make this the last commit for 3.8. Is that okay with you?
> >=20
>=20
> There are two where a little manual checkpatch cleanup were requested.
> I'll clean those up and resend those two (unless you want the whole
> series resent).

Not necessary, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlC2FyoACgkQD27XaX1/VRtTXgCfaC5HSMPZq4FiXY+2a2OxxcWB
DyMAn0Hcd3Grfrm5MOsrNWaujsUxQkkT
=hvcR
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
