From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Fri, 26 May 2017 01:22:55 +0200
Message-ID: <20170525232255.GA1526@katana>
References: <20170521204233.6745-1-wsa@the-dreams.de>
 <20170521204233.6745-2-wsa@the-dreams.de>
 <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com>
 <20170522155649.wuf2rcdtywa7e667@ninjato>
 <CAK8P3a2xU4R=hq5fjOyZN=+cS1KVfwP9sFuwEB+g2jnTwcE6gw@mail.gmail.com>
 <CACRpkdZ5CvmNuybrrOexYZ_9Cg1ojjNEybow+1pvUnhR0oX+UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ5CvmNuybrrOexYZ_9Cg1ojjNEybow+1pvUnhR0oX+UQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Samu Onkalo <samu.onkalo@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The one reason I can think of for removing them is that we don't
> > want ambient light sensor drivers in drivers/misc any more and
> > instead of adding DT probing code would also expect new users to
> > migrate to drivers/iio/light/, which already has drivers for
> > apds9300 and apds9960 but not apds990x, as well as bh1750 and
> > bh1780 but not bh1770.
>=20
> This (apds990x) and bh1770 were added by Samu Onkalo
> for Nokia's upstreaming efforts.
>=20
> Samu, what are the hardware targets using this? Something that
> has a userspace etc that we can test?
>=20
> Like Nokia 900 or so?

The bh1770 seems to be used on the N950:
http://elinux.org/N950

I couldn't find a user of the apds990x.


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlknZ0sACgkQFA3kzBSg
KbZNqA//frzYrV/8bxjg4Oai86Lykejn/Q3YU4jJpROPJR40ZHbq5IiRpEK9S7lx
y8AJ6FsYcC7wk55NGc1yRYbd0UNnQd/MHOOxhEmWaKdJCpJ+dj4vCQUlk6ytFX7n
CYACKaL1pSL8arDDJXEJNzvPJp94Sflic+fias8cB1PMnfzdcfToFGAufT13CacA
EdPmgbcZ5AYkJ/kcX7b4IOlYNuT7b4t+G/DqcCgaBflQMeE9hEnnM1I787gR1Yof
2gFKLHZEYIq273pGUhnn2aILwwWnv2S8mEcyFBryT1hX386t1fv5WnPv29HIZ9D5
RlsKw6do3TLbMF66WIXk/gopasK5Sd8UQDB6UN13H1KThZJxAJ/zD0z1eTf0xHWo
L/jDfqNgCMH+zTgky4Hgh+qebeZTahJK4nvtExOHuSnQI1rtnivtVRXxezqYDAXV
OPpfkSWuvG0Mdf4KmWxxLtvIxXK4wAG00JmJz+0GNI9A9FLIXdfzua5gaVcJnHoz
SgMpXzPkgU5Y//Jy0EES7FY/wCSgPhHVbZfAdw4srlpEmXZdAfCI/gOndqO9azMn
sAmchvYzWyJdJnfEov9RneeNFKpPV5ykBDIkrsgOgqzdpUmOrvdhm7UoMrV+WSIG
e7D/Nu/X8ApmFNKD3M3dkPeURCc5/NKZNU6RzyqdNZVXq2t76cs=
=qGQ+
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
