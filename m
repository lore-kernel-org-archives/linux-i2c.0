From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on the same bus
Date: Fri, 31 Oct 2014 22:59:39 +0100
Message-ID: <20141031215938.GA5370@katana>
References: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A@mail.gmail.com>
 <20141031210301.GA4169@katana>
 <5453FC86.1080408@roeck-us.net>
 <CAB0SmAG1r-EUFrDAjuh14uYQYc_typV4+JbfkUvCGX+=_09QmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAB0SmAG1r-EUFrDAjuh14uYQYc_typV4+JbfkUvCGX+=_09QmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You are correct Guenter.  We need to address both i2c- and gpio-based
> multiplexers.  You and Jean suggested the following solution:
>=20
> I2C Mux:  i2c-N-mux-i2c-XX (chan_id M)
> GPIO Mux: i2c-N-mux-gpio-XX (chan_id M)
>=20
> Where XX is the i2c address or the first GPIO pin number.  This
> ensures unique IDs for both technologies.

I rediscovered this series:

http://www.spinics.net/lists/linux-i2c/msg11542.html
("i2c-mux: expose i2c bus topology under sysfs")

=46rom a glimpse, I like this approach better. I wonder if we can maintain
backward compatibility somehow. I need to play with it. But not today,
this has to wait till tomorrow.


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUVAZKAAoJEBQN5MwUoCm2dd8QAJE3fEh5VTBCEEn4PGN/OvmE
aITcSh12RwZoSN4tUbRkojdQ49BFRdxm3Nr/B7AeapBZKfwRnNE5FoGvcE/ck9gv
wQGp0j4MjioSkNcduUMnDDOCVqN9aPSiYug7BCCnYPalDRYSndkPv8goF3aRgbCH
Cmt6QAEml+BUYuKn84u1p+hFp+Mg7sLcrJ6Z+sOSAJwYkdDSC0pCaCeDY+tTb2YX
Ok0Urq7JvdJcFJwW9CKG7DBI2hk3c7dZUQKwP4KqfoO0puuqIlMRbFhAn/c62wCJ
4pkMPfTnQFCsThXAGZdJhy+Mz7HRi3x1xrQ1JQKB/OSUcBAlnhhy3HdAwj1Pnerm
pbuVOiNvGyVMNHj3pAd++jlI7DLkKdwkwm1OEqnurZdosxrjAg07qeYrMjbxXlvz
HsOu6TxHLuvKWcBsNdRirFqA4js0dWsz3jN7mlqg0F2UT2VOrVfA2BOtbRw1qjsj
6ZzkctVlhifzicnwL/xFhEqyn3Be9oAXehxHmix/1k0patvWXLcgmG8YJXt073NR
nV0Y3RYfFGXbjVmRbIeOdGlYGwTQu+ZM94Gk9rx1si01X8mLSP3eXe3bDxe/mwSE
YEdvEg14lArAqNMZiXbEB6Yjy4T6XNwSf096gIYzOddlqNS46Q3BCKFxiDz+6TlK
FykcNLx2WmKohsd0qSZi
=kBzM
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
