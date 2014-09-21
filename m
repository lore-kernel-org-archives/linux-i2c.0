From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices
 addresses
Date: Sun, 21 Sep 2014 19:49:04 +0200
Message-ID: <20140921174902.GA1479@katana>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <20140920164858.GA2260@katana>
 <541DDA9B.40904@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <541DDA9B.40904-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >This raises the first question for me: Are the additional addresses
> >configurable? Sadly, I can't find good documentation for the adv7604.
> >Otherwise, if I know I have a adv7604 and know its addresses, this
> >information should go into the driver and not the DT.
> >
>=20
> They are. The current driver hard codes the other addresses, but that's n=
ot
> working when you have multiple adv7604s on the same I2C bus.

How is this configured? I can't imagine every address has its own
setting, but rather some 1-3 pins which select a certain block of
addresses?


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHw+OAAoJEBQN5MwUoCm2t80P/R6TgQftd/uBDonUOAWOWU9D
1dFdChiDFsy5qRyXfsgZIsgxCzMp7MvUyddRGbiA4DgiO3nnA7T/DoVo+3jT4dPC
BWa5PAsFhUl4ZdsKpyWF9kSVH3IlIGdqhKSSVA9wCJnuBHNbl6sd7pE+TfOBI2lg
s+LY8lche9BDDdfuATnBCr+3F/QWj23t1bqR5ML9FWCzn6lLrHPOASEjPYvfriLS
HoTdXzU8pTyVL2yi7pRYbgSxi7a/2iTx5auEyLrFs0bKz3MpUY7XI1gxJbOmdpa8
+aPp1aWmv/cesESKtiPA1bFVIGRWxdClbuXp29xPov6wVDYJ1ly4rZfhHIL8W+cH
MehXy8TelfdefTdtuPxbaTCTWcQfLpznbl9qlPskB9fCfFMfuPG+WWGAFBYPohIj
tnNGQzV2x9HO9S6TNOWC6sfo84smz9l3nRPOmrP6PuC+gBXSiu5nk+Ms0NDPrp3d
XLCA0Y+qApIdswRaBkZSmjzR8sHA8DrLHDD32AvCYzSh+eXneypjqghQ+MugO1LB
aQgbWfrfVvLbCBqnSS4tFHYKBIhOQ9UY/9Npv+qEJ4RSMsyhMvX5nG3wfAl0fuVq
YdbbRwu1XlP6bejfh1gKSzHyx8gf+QdvUUyskykrXVFi2jpEA4GmPyWgv/yDDFRF
FNbN8/3RdJ7tafj0X4aG
=UCC5
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
