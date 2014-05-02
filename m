From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c: add support for sc18im700 master i2c bus controller with
 uart interface
Date: Fri, 2 May 2014 16:02:27 +0200
Message-ID: <20140502140227.GA17943@katana>
References: <5363939A.2040706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5363939A.2040706-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: RAGHAVENDRA GANIGA <ravi23ganiga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> since i am writing algorithm support which is similar to=20
> pcf8584 adapters so i have selected the=20
> drivers/i2c/algos/ directory for the driver file

=46rom Documentation/i2c/summary

An Algorithm driver contains general code that can be used for a whole
class of I2C adapters. Each specific adapter driver either depends on
one algorithm driver, or includes its own implementation.

So any chance to simply reuse the pcf algorithm?

> also if you have any comment on driver. please=20
> provide the feedback.

Just post the driver and we will see.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTY6VzAAoJEBQN5MwUoCm2P10P/ii3iN6/UI2TbCmi581HKI6Y
EWyszWIb6RnaiMWUJiYov92z6/npkWq1txdO/TNdWiGVQDtjrTSGHIFotrxE3HXb
kNnhl1xH/fp4EWbQvAiBVQ0y5QueFQ8OhYXUrmTRxPR9QlxvHE4I2Z2/gZ653Rio
4Jq5W0p5hEF253l2uUfiZBqQUDDH6vLsSAY664VoeO6cpgZEA0p4mvzZJoap5LJm
XOV819jC7vpzqjZlf7tWLam4xP9Od3KbRPKGTrJY4WE2ktuTbH6kDXRV8yVT+nm3
Mb0u31RPWKgss6u8JXqsTx5SpS/Qt5072t3fmOmcmblnPU7gLU4Xhz6wIfpVD/VB
zO+bbnjY+gDy1MCs0lUjcTgzLiGDwhP9OyCtXJLFMEiSj64ibdZvzP0RwiLOtYb+
2gxagohoODMORUE+h4ftrDJonksl8f+EuU2L83kJ1Z9RjN4oF/CaW0cFTsbB5wLp
gHAA+JrCo7ZGY6Hn4ovO8C78jLhaa3hqUsCLyPp+Z1Op+ayw1qpeDjNZXgsl1YZC
vD2jqst1ltXRudboMaiLd7Y9uCXRmduDGoz09Fz7aDgdN6dJHB/6OtEf385jq3Wr
Nwih1g10i4l6b/F0rRYreFMlN+ZEgRskbYIbgLyb7YuTJKIi+uco7gwYfEjIt2pO
eJ7NGtdXDCRTLBDT/POv
=jNr3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
