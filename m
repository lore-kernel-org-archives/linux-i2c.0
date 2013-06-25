From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix transfer error code
Date: Tue, 25 Jun 2013 18:42:58 +0200
Message-ID: <20130625164258.GB2973@katana>
References: <1371678832-26889-1-git-send-email-linux@roeck-us.net>
 <20130620192337.GB2961@katana>
 <20130621001627.GA25889@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130621001627.GA25889-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2013 at 05:16:27PM -0700, Guenter Roeck wrote:
> On Thu, Jun 20, 2013 at 09:23:37PM +0200, Wolfram Sang wrote:
> > On Wed, Jun 19, 2013 at 02:53:52PM -0700, Guenter Roeck wrote:
> > > The driver returns -ENODEV as error code if it did not get an ACK
> > > from the device. Per Documentation/i2c/fault-codes, it should
> > > return -ENXIO.
> > >=20
> > > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> >=20
> > Thanks, have you checked the other error codes as well while you were
> > there?
> >=20
> Other error codes are ok as far as I can see.

Applied to for-next, thanks for double checking!

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyciSAAoJEBQN5MwUoCm2+ZwP/2K07aMaVm1nWQJoXImQOJ28
+Je8ECVstU6CnlTjlKq1WmzdXNY3foEu1XNGEa73IGR+ijK1yz5N3ed//rAjQbH9
crvO+TtCiBBe+SuXRnq1fTPK/JiEf+ihS+KiBNLDCEMT4ESqLPoNPGjC70ZkPDmD
biXeq4gmP/TvCnFsij866daSs5sTWwMDeLtckTc78fQW0GehaBR5lC/k4dvK0tQv
IR3XBLYWhwIczypcdSfDeM/hslQ+IWoT3wPDWrwGdk/WH1EhJtnvcGW7njtvxvD0
V/Xsfoi4x9dkcdjeQOfs8Q7+4puYD3kqbPpRFhfckxX10dTMuZcUoOXuoQ2nmCSF
r5SJ+yLeIFYQ54yr7P0/FbF22PAIEoA2nN5KIkmB9aH5BSuzPG72xGbECzy2sTL3
8Zv6sp9olBASBPaL7v0Xq2XoVk6X6ju898utQiJ6Twadrpy2YPUeG4gtZuJTQfYZ
fxEU7kRjcMibLVY6oAWdL/E7BNewquROr1G/57tAu0Gux+T8EybQpnNy5Q4YOA7T
CkAD+w7sw2DMiiGzSxEUCgKMgWb766b6cpX9BQT98QUebGwOxeBemjbqLMSHV9p9
MaCeipLeZvOFiSj3HnpoVyoKpLQzCkMFhXO8TAlevGEQepLz2yTLXs7mrTY/7AsM
b5RxCsMPg2poFSaBUnFJ
=aVkS
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
