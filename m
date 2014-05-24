From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: Sat, 24 May 2014 12:21:50 +0200
Message-ID: <20140524102150.GA3058@katana>
References: <20140521113029.GT2708@katana>
 <20140523131722.GA28143@curry>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140523131722.GA28143@curry>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I recently discovered that the I2C core of the S6000 is basically a
> > Designware IP core. For the latter we have a frequently used and updated
> > i2c driver while the S6000 driver seems to bitrot. My wish is to remove
> > the s6000 driver in favor of the DesignWare one. My question is if there
> > is someone who could test such a change on real hardware?
> > Grepping through sources, it looks to me like the only candidate in
> > mainline is the s6105, yet its defconfig doesn't even have I2C
> > activated? Can we remove this driver right away? Am I missing something?
>=20
> Removing drivers without a replacement tested and running
> doesn't make much sense, except one chooses to drop support
> for the whole S6 thing right away. Which I don't support.

Huh? I explicitly asked for help to test the replacement driver in the
first place. And was wondering why it is not in a defconfig. You know,
it could have been broken, too.


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTgHK+AAoJEBQN5MwUoCm2mNQP/2LcsPPl7zLxKsDXzxSRdpMT
4nT96pUug/+4fs84jlMugoGcbj7NysE6IeP7Ak6FqVyl8Rm4/msRuN8T0/h1L5te
qCdUvMZK9RXs1cZSmCY19u7QB6lTZTknh43Q8uJYKkzsqVe1LK7wyHZtl+sJRYwJ
W/P3mB/Zv5At53LyMk27bcbV04V/xum+RrZC/IqrFMQoy6V6TeNPY4JQG+vUU7UM
m3apwiQgYpGZck2Y7xu61K6OObG5jka60EU1ZZ+IusHY8MTg1PCLKZnD//Sg32Br
RnL9tQnIZnGpMmrnr2iWZyOhW/yVxilgRGWOY+21lOT9fxxlHNjTgLBuTxQKebeF
qf9Uzt9/xNM6dj4l1hyD/j2tI4YCuzC1x5qo9DRQLi37HwdlNpYUt2jmrW4ycMhr
5uT6Y6Y5dG2tcwJ825fduTo7Y9JN6NyNonqDFNuvpq7AAfHfjZfgWv3RN2VS94VG
4ALxAFJvlN+v+d8QubnqSiiPntTO9j57MtuVOmsLvMgT7Dcop6Ke+BnGd4eDA1mV
9qxb2EehACbcum6raF7AAcVgBFNeflbcdgxCDimUQdumrPJVUfTjTiyH/JHSnwdN
xTzBalmO1HYLJctlBeGxFVAfCnZaeLfw6t7sZjvysrZT5DkwjjF7Jd2hXMmXockZ
o5nqyCMXuDvPijq5qt6N
=Bq6M
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
