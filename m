From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] I2C: designware: fix IO timeout issue for AMD
 controller
Date: Tue, 1 Dec 2015 01:43:12 +0100
Message-ID: <20151201004312.GA2064@katana>
References: <1446726884-30558-1-git-send-email-Xiangliang.Yu@amd.com>
 <20151105135216.GN1509@lahna.fi.intel.com>
 <1C99EED8F51BBC41A8F1E645B51245F41AE8AA50@scybexdag03.amd.com>
 <20151106074608.GR1509@lahna.fi.intel.com>
 <1C99EED8F51BBC41A8F1E645B51245F41AE8AAB0@scybexdag03.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46098 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbbLAAnU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 19:43:20 -0500
Content-Disposition: inline
In-Reply-To: <1C99EED8F51BBC41A8F1E645B51245F41AE8AAB0@scybexdag03.amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xue, Ken" <Ken.Xue@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Wang, Annie" <Annie.Wang@amd.com>, "Li, Tony" <Tony.Li@amd.com>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > The driver disables TX interrupt when it is not needed anymore or
> > > > when TX gets aborted but the above will re-enable all interrupts
> > regardless.
> > > > Is that the intention?
> > > No, i2c controller can trigger next interrupt only after re-enable al=
l interrupt.
> >=20
> > If you get an error the function masks all interrupts and jumps to tx_a=
borted
> > label. With this patch you unmask all interrupts again before exiting t=
he
> > function.
> >=20
>=20
> I see, how about change if statement to else if?

That sounds to me that a V2 is needed, or? Marking as "Changes
requested"...


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXO0gAAoJEBQN5MwUoCm2i8sP/iIJcGSxbevFpcnpNeHorxNw
jrOpxOqp12WSd8DtcJs/7W1ivcitmhyYizVDy9fjJiW+ClSph5MZVXkeE/qF4K1/
Jrvd5rWOYpl84qKloLpxxyWxNNTdVqvg7CZ3bvuJeuM9DDFAc8auey5J87bDpPoc
Ubxc/OXDGUMotyKIg+sDCNGwybYLAL5yqZY5vqk90Yy1DHdYTOQFt+plPLwHlojh
9l4dBmebjsg+gDvVq08JpYG4lWqMZ6l0SzRmDgQgu0HK3aJaRdL1ejQrJYXhRRn/
O5bSnhDsaLoQFTkvo9Lxk8wuqVzCTP4oiYbwnaO1xA2ke0mJ1gHl/nRwrAwbAnOE
bHMOW0u7bmMS5IWLl9VCLM4a3UFLFhwOPGx4rkIgHMNM70hP+earkaP46hfqkX2j
QgZjbpfOyd2PiC4xWKlyRsIGrEXbER/zX6Is6WMte7BEKOwFNA3e/SlYtcohifi4
610FuSD65JYDUYqJhFCO4vBswHqFudChNnHb0RTajSp6BO51BcjvFog6ksiNyMzU
siYrmwM/lxYcy9p0zLFZp+vm2BEzTWdJ0pCU2tRTBXD3ir2fgK7wQ/yLT2eLmfdw
EVk4keTtsrVCmlyI1P3Y9nobHAvY8zWDQRcPYDXVNwdU2bbj21G/5ij9TO1zUPJU
k1w7wVRINOjd/TLUXw4Z
=S0H8
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
