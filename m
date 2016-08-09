From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-tools: fix feature test macros for glibc >= 2.20
Date: Tue, 9 Aug 2016 22:40:11 +0200
Message-ID: <20160809204011.GA1644@katana>
References: <1470213836-2848-1-git-send-email-wsa@the-dreams.de>
 <20160803132311.59d53ad7@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60251 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbcHIVB6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 17:01:58 -0400
Content-Disposition: inline
In-Reply-To: <20160803132311.59d53ad7@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  /* For strdup and snprintf */
> > -#define _BSD_SOURCE 1
> > +#define _BSD_SOURCE 1 /* for glibc < 2.19 */
> > +#define _DEFAULT_SOURCE 1 /* for glibc >=3D 2.20 */
>=20
> Actually >=3D 2.19 if I read the web page you mentioned (which has the
> same "bug") correctly.

On the web page it is not a bug, because it says "If ... you must
support glibc < 2.19 and glibc >=3D 2.20 then define all three
unconditionally". This is correct since 2.19 works with both options.

However, I should probably use >=3D 2.19 and <=3D 2.19 here.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>=20
> Again the 3.1 branch would need the same fix.

Yes.


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXqj+rAAoJEBQN5MwUoCm2YbsQAI8rsitQp0mW23l5zOpwIH+s
rOoOrhWervwCFHOvloNoBv18AWsYCTpo9fM9FPHMo+xbyf0JalB9b5+4E3uEmYL3
jrz/LFlcOZdklpa6SWf6vN6X3xslEDwQyWXjHcEtJ1kU6mHmi3iyNY0TKV+Fes3H
gtk9lhRf+Wh3mHhAqOKx5eKLJWTMx79Uw8Y80BvBY2/TsY9suQ3ArxYTxO2Gs9wP
Z4/+EFrh/ub8RIlwEcb7SPvTFOu9Q835IJ2HdeEwkq1W5j5tto4MPP+YM6rpG0Jy
JJe/SWEbCpRbdi8r7J2t99GBXEIvZFPxDZUkwaSqQdbZ4gUFXv2JN33J5ag/KM2W
tQ0UJAubeQ+/ZWLcvax/qSedeP2QnVSI/4XFJEqyTk0hwRXW20z2xCJtS9hqpUeh
JBYTAScYGLiEOXe5EGI2+4fvi5uQvvayuh9/+KavZ/WgmMG1odjedFU4PA1kqO5F
BEN75Un4PZJ3NfqRWW8woFcL3qC3jSTYJGdtLhU8XEvArQGMn0C72NdUNYZNEY8f
2u3xX/PY8FuvjGQIh1kMlj4S6TWXdvAStrRqLPIBqN6XDxIpYeXM+EFDtgzyY2WZ
3CiiKaj69DsL+zhIT5eVBzO5K1VM3/mJtmv1AvaEpEu6KcagtEqhhoonc2koniIv
IYDEapo6mNzy0AFUd1kt
=1tiM
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
