From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-i801: Check if interrupts are disabled
Date: Tue, 11 Nov 2014 15:41:07 +0100
Message-ID: <20141111144107.GA1330@katana>
References: <20141110222655.13660613@endymion.delvare>
 <20141110223139.02aafde4@endymion.delvare>
 <20141111105853.GB3794@katana>
 <20141111153214.39dfaeb8@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141111153214.39dfaeb8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +		if (pcists & SMBPCISTS_INTS)
> > > +			dev_warn(&dev->dev, "An interrupt is pending!\n");
> >=20
> > You think it is better to not clear it?
>=20
> I admit I did not think about it. As I am trying to better understand
> the few mysterious failure cases that have been reported to me, I just
> wanted to log everything out of the ordinary. I have no idea what's
> considered the right thing to do in such a situation. Do you believe
> that clearing the interrupt is the appropriate action in that case?

Depends on the driver, I'd say (which I haven't looked at in detail). If
this causes the irq handler to be called as soon as the irq is
registered, and if the state machine gets confused then, then it should
be cleared beforehand, of course.

If this is not the case, then it might be better to be less intrusive,
spit the warning, and wait for somebody to show up with this message in
the logs.


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYiACAAoJEBQN5MwUoCm2uIkQAJuvkoDhx4N7VSIvb3hX1PBb
vkOrwGL6H0phf2QDmfvhX9wHTdgA1yoPEbqTrw9lcCTOo7BXw5I7ZS4d419O8XIm
cIWx5phl3QU2jDjo1KOThEE0FqkP0GQQaO4r+G0KWJ0FXLZxvyjbFWbcP3U6KyTb
yGHcNtGaGpYDjk/1BTJwXbRqLpa6zPq014P50WSa7j9wQswC2OnZa8AE9sQKIJHo
avtWG61MAM8Qj9e0i6nacpqNbnut0Qr5BvHKdg4OX36uM42+q04CNV9lz5ll7LFZ
uMxm1w26P1IsPvQQ7ZArg+QWc/TSLvfCdaCp6VrqcG4BnPybwBM8xEr1vL4xcAa+
2eu4aW/qsjg/YuQltMb1OE9KV3RrSavCNL/tcTbvI1nEINu+HpeC8iPQ0FKi+li+
bhu3m7yhAeHjtK0RuvBoMy7zHNgIPEqLmuKbCcMBEjSIOEDdANhIz6G5YebC4n9T
BgKJLErlfAt6jbHkTQNBEnWq0s89hracki4BLkzTu2bbbJ/zG1fsgDcKo6Asrsbs
ReW0sgI7b9BOAtgy1oY6sMjH6Xx5sDrvKHmNGERy0FPrx7P7H47CEfT/Pdc/KwgF
DUz5L/WsxpvCW07XDsv8yocv2Ja2dtLUzmMH10woO4l+/VE38ba8E39Qom7/XQ1b
RVnCAGk6gEVs4JcsVELq
=sK82
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
