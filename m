From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c_imc: New driver for Intel's iMC, found on
 LGA2011 chips
Date: Wed, 17 Jun 2015 15:18:42 +0200
Message-ID: <20150617131841.GI13393@katana>
References: <cover.1425934386.git.luto@amacapital.net>
 <86c8b4d72f76cfdb7f76ad48825fb10e51634429.1425934386.git.luto@amacapital.net>
 <5503B59B.2020502@roeck-us.net>
 <CALCETrXvBxcZCyupHM6trb2Gv99MH9-HVG7ZuNGE2OPMZ7d7hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXvBxcZCyupHM6trb2Gv99MH9-HVG7ZuNGE2OPMZ7d7hA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Boaz Harrosh <boaz@plexistor.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rui Wang <ruiv.wang@gmail.com>, Jean Delvare <jdelvare@suse.de>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Paul Bolle <pebolle@tiscali.nl>, Tony Luck <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Having said that, I am still not convinced that the driver should be in=
 the kernel
> > to start with. Browsing through Intel's datasheets, the registers are s=
upported
> > in E5-2600 v1, v2, and v3. However, in v3 Intel added a note saying tha=
t the registers
> > should not be accessed by the OS directly, but only through the bios. G=
iven that,
> > and if that is possible, it might make more sense to rely on ACPI. It w=
ould then
> > be up to the board and/or BIOS vendor to decide if the information shou=
ld be available
> > to the OS or not.
>=20
> I think the plan is to add something to ACPI to tell us when we can
> use these registers.  Unfortunately I'm not privy to whatever the ACPI
> committee is doing.

Coming from the embedded world and not knowing much about this, I tend
to wait until the above issue is clear, meaning when and how this driver
is safe to be used. I hope you don't mind. Keeping your code up to date
and sharing it is much appreciated, though! As well as Guenter's comments.

Thanks!


--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgXOxAAoJEBQN5MwUoCm2hSUP/1328ERR7MU+AtUVTE0T/gzu
kAyqo9WO7E7aGAvwlGmCkQAEkIZ93zoWf7c6CmpxuprPrjcG8bZsjeXzSzTCx0QW
dtZujYU8dEncWXjhXWqebyPdfIdu9O2ADEFaOa3djS6XU00lsxyadapPRDC6v0/s
YDoeACgjE8S3j5Lye77r53aoSvUmzbcq9l+tT0uVUVOPB5gLuQspTV96vTXQzXak
hc7ePcatiDGLf2L2FhYQIinx0DAhro23le9QVi7skD87acF6Be3R2lKIvwqvXf6c
exAhLAgRV5lJvLd/4bLSpUs6v2fa+CSxa+l5IYHiB+3yw7UL2GPRNAbd2EfgEGhG
3tp+Br94oJx2u0ytjALxZNyflTph9/upcbvMNuWeYEEs+zOD4jMLa/yPeWZ/keiE
Zlfo5goM0NI8c/Aq8vk2Em9gdbH/xmJiBm/cAEVH2dX3pN+vY4I8/NnfQthyCaO/
5XsmsbY/nuCiMV0iS2yeswUbzuPyeu+F/oUN/W4dngEqEIk5Q75L0GM9vr6E8+nL
pMqzTB3ZPhLKWnhDhnq4BVlRhfPTNA+naRyZAqZIaq1ot4tXvI/1KyNoYr4lod/2
O3TkCgOAscNkabTdh8yWf+84ufPpcdcKfI/6OimvicbyfXaAw/MWJDQ5ylvZ0V2v
OVf1GCjW3BH/UA6AlhQ2
=qQt4
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--
