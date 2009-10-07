From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 7 Oct 2009 14:47:48 +0200
Message-ID: <20091007124748.GH3177@pengutronix.de>
References: <20091007115017.6941faa7@hyperion.delvare> <20091007095610.GF3177@pengutronix.de> <20091007120734.31a41f33@hyperion.delvare> <20091007102557.GG3177@pengutronix.de> <4ACC85B7.2010300@cam.ac.uk> <20091007142746.4bc4f0f4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091007142746.4bc4f0f4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think we can simply move the driver and convert it directly, and
> document the interface changes. I've always said loudly that the
> tsl2550 driver was the first of its kind and as such its interface was
> subject to change when other similar drivers would be added. Which is
> what's happening right now.

ACK. So we move it when ALS is going mainline (probably next merge-window)?
That's foreseeable enough, I think. BTW Jonathan, is there an ALS-tree or s=
o? I
couldn't find any reference...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrMjfQACgkQD27XaX1/VRtMpwCgtKmQEicLCagOq9FybG+K73pa
t48An1wesEmHEFiL2112fk/9tae6NkLs
=DnMS
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--
