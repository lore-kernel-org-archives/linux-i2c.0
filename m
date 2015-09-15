From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: core: fix a code to suppress a warning
Date: Tue, 15 Sep 2015 15:00:49 +0200
Message-ID: <20150915130049.GB1525@katana>
References: <1442311867-60185-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <55F80047.4000805@mentor.com>
 <1442318818.8361.29.camel@linux.intel.com>
 <55F8134F.5080401@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F8134F.5080401-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> I2C_M_RD is defined as 1, probably (msg->flags & I2C_M_RD) is good
> >> enough here.
> >=20
> > Today is 1, tomorrow is 0x80, so, I would stay as I put in the initial
> > fix.
>=20
> I believe I2C_M_RD will never get any other value than 1, since this
> value is deliberately set to 1 and it is in active use by userspace
> applications for years, nobody intends to break ABI tomorrow.

I agree. That is one thing that permanently slips through the cracks,
but I wanted to add a comment saying the I2C_M_RD is guaranteed to be 1
and then simplify the drivers.

Maybe I should start with the comment right now...


--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV+BaBAAoJEBQN5MwUoCm2c5EP/3uQR/d2BZ4d2ZA7p4LgN/vD
n84rwAYwW8M4mQWwyWriPFuox21CqiZsXaWiLk+Su2VaLeU5B4GyBsD98u/4H85H
Szq125nx3HOsSres2pPETu0mZQz/1QP9+ApPBsHHamaZjvaQub0pOTRWr4CRiJAi
dy7K/YYG5NHh1ay0zmU8KI+oJynOXpM+jt29Sdppr9ut4e2rtWEBXpzy8bCNT7Ck
vhRsShfeRDRefg9JEfGyDfElIv4sjUmyw/IUQ3/DRkhFbMIJecBr7gwJDAXbcFpy
+EUwBnWI6ukdiy1eQBZZWLgsDO9oHBvZ2vacd/csUAzMMa93LGGkstydlL8Pw4gD
Y9H7sew4uBCrVGnkqZ7CFPSDNMNxCYPxzk5+nk8cwJVqiFz7zXJi+Zl++ZQnnXvE
T+8+RhkiBzCWj+DBULQYbIi3x9+L6lGWTzpQaA+aT3YifyrjXE8+tAGVMyzD2xVi
AW7WT0wGZL6XbXkz0CB2R3wgyB3FUA71Z0PdS+rydZ7pXz44qfJSth38jzWkDiWf
kMN7mV7Zdw2NbyPVYg3opBDkKGImIUtNxOQo6AUH5s5Ecp6Am4n+wZpV2tFc2VTZ
WWpYn14JKPPWb3vTNguHBYpPw0rChM1y6fEBKVoFEo2gov7SIf9bU1DjY4UwQMOZ
GtXuD6gScfDVFa7NWB/s
=E7p7
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
