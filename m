From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Fwd: Py-smbus for Python 3
Date: Mon, 19 Jan 2015 10:24:20 +0100
Message-ID: <20150119092420.GA998@katana>
References: <1421658501.2937.2@smtp.inria.fr>
 <1879153388.1899869.1421658735412.JavaMail.zimbra@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1879153388.1899869.1421658735412.JavaMail.zimbra-MZpvjPyXg2s@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 10:12:15AM +0100, Michael Mercier wrote:
> Hi,
>=20
> I am working on a project that use the py-smbus module. The problem is=20
> I am using python 3.x and the py-smbus library is not compatible with=20
> this version.
>=20
> I found a lot of hack to do so, like:
> http://www.raspberrypi.org/forums/viewtopic.php?f=3D32&t=3D22348
> http://procrastinative.ninja/2014/07/21/smbus-for-python34-on-raspberry/
> http://comments.gmane.org/gmane.linux.drivers.i2c/11290
> http://www.spinics.net/lists/linux-i2c/msg08427.html
>=20
> I eventually manage to make it work but this code only working with=20
> python 3.
>=20
> I like distribute it but I do not know where. Is there someone that can=
=20
> merge this upstream properly (with python2 compatibility)?
>=20
> I can also put it on github to make it available so any interested people=
 could improve it?
>=20
> What do you think?

Adding Jean to the list, he is the current maintainer of i2c-tools.


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvM1EAAoJEBQN5MwUoCm2dpsQAJ45jgcdSykdUSkFrWEkkQ2k
Y7t/hcjb0lo8RX7ao5hKexR6nwbNvwdBplKG6KUBVMWiy/B4u+/496qxb8AI+qdJ
NWGA1eDRSS2a9t4Tt6AR4B8uf5LS590TwPy+vyvgCt8+k7IRp5gfT3spzxtpf955
UZkGcxquBNdiECfhpODkd9nmXk1S/19jUk5uDTRE8FvPKLaYpL//VgyPIIyWs/Ln
aKCAzrt5Z43Xtv8PKw87yvkteMxFV8AigIEtu3uoyQAMl/cm/sbR6C9oine9/Blh
zgxexZRt7ZAY7XxhcSrvzPItQekZaCk3Zp2utCxs87pJ6bO3w5cESHzd9kk8SeEm
JRqD1vcoHYxqsWZXU+V9zxCPj0FWBMFSyMN0vr7nc2+O2ueaIk0FF+AUx1TyKJyh
RNqPT6514l5EmMP3VqaIxc4Z8VT0ddSFQHNLyHBlYt/5nXuIqc95a92JvO1m5Z/p
RCinXfJj1zPCMbmr1LQ9MbX3jb0c/zKW16+vNbR1Yu+jObetRjBvp+Ff6t0/FthD
g7dFdFagU23UdPPa61YXowHWYLAtGFcDLGNFc03Cv8gsSdHNOczUNn8qXkLE1oPm
3TjTYpzQBk4zqrUpYa6KxCRGur+xrC1ur34j1smFduh//cxWL0QPAbs2MlIpuXhI
mMSAcmt2t8skuGlNCjMW
=rFR5
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
