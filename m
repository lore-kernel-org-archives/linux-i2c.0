From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on the same bus
Date: Sun, 2 Nov 2014 21:38:07 +0100
Message-ID: <20141102203807.GA29452@katana>
References: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A@mail.gmail.com>
 <20141031210301.GA4169@katana>
 <5453FC86.1080408@roeck-us.net>
 <CAB0SmAG1r-EUFrDAjuh14uYQYc_typV4+JbfkUvCGX+=_09QmA@mail.gmail.com>
 <20141031215938.GA5370@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141031215938.GA5370@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I rediscovered this series:
>=20
> http://www.spinics.net/lists/linux-i2c/msg11542.html
> ("i2c-mux: expose i2c bus topology under sysfs")
>=20
> From a glimpse, I like this approach better. I wonder if we can maintain
> backward compatibility somehow. I need to play with it. But not today,
> this has to wait till tomorrow.

Sending a patch using this aproach in a minute...


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUVpYvAAoJEBQN5MwUoCm2fGEQAJBri0v3x1GE3wMB8UUK9sMT
DuMz71DH3RgEeRxckNl6RtYlJ43G8ylikonbnLnOVrl3IklxZDYxOJeOQpU9VNOp
Mzuamlw0XHPDfh34G6fMvQjOmfBJtRdBgLfK9nFs0Vf1y5UFnEoOCMd1RScqzetK
o1UXeabjgf1OA/BsI32lnNM0KmdSq+2qrmDN8EWK2VkLWugzpUSsTL1MSIR2n0fH
XvAhnPsScLmfSRs/KmEKgg104KkLuXq+8uWxHjlpAbRe4lgPK+R7C9iy8KnLjacD
N9UhkJZ2B7n7yDiJfiUidKCkEKRGlhjeEmECSdJPUTTfpoGBP3q9mBBMzrMbqpop
jV0ngOShK/iuHCrUHUTZ14tG+mQSCSJ5AjxZDCpfAihOD/51ffiE1n35BRrfIEh4
UGiZ+2KFB4r0QenwlpnhZOBQWSaBot0MnaC5OlAFcXmatEAhDviO0gGsXjS8X9gL
bM2VQ119EoRJkds112DjdV5TQeWBoZuY5G6I39tM/q1EuDbNRIPweP5EUTa3HmRV
C2c2onBi1vkGMAy3SUzCHYGCjgcay2VhDmrC2zkGd9RDtFNOeAsJ7+V+skjEMd7Q
jA1zCOUGoHpQT+Ydin7XyXwA+ldj3+dBDxr3tKBAhqe3gYSUXtV4AvTzj+B0PMQ9
8PYsmkdLGh0j7XonXW9D
=1z58
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
