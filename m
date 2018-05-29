From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Tue, 29 May 2018 19:19:58 +0200
Message-ID: <20180529171957.y2ctsptsnjw6ykag@ninjato>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ztvp5w4a5urifshj"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org


--ztvp5w4a5urifshj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> this series fixes an issue with the I2C driver of the Renesas R-Car and
> RZ/G1 family of chips. The issue is clearly visible with the CIP kernel
> (4.4) running on a iwg20d board from iWave due to the way the bq32000
> driver/device is interacting with the I2C driver/controller.
> In the stable kernel (4.4) there is no support for the iwg20d, I tried
> to replicate the same problem on a Koelsch board with no success, but
> the problem is there.

For the record, this patchset was developed on a Lager board (R-Car H2)
but the issue was known to be present on other Gen2 SoCs, too. This was
a nasty race condition. IIRC I was able to reproduce the issue only with
the first transfer after boot (for whatever reason). And fixing it,
together with another issue (double address byte), needed all this
refactoring.

I might try to recap how this double data byte problem was triggered.
This is somewhere on my todo-list anyhow. Just to check if the same
problem is still present with Gen3 SoCs. No promises, but I'll see what
I can do.


--ztvp5w4a5urifshj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsNi7kACgkQFA3kzBSg
KbbeGBAAmaTBWR61rcDvk2BAQ7tx8t7evxgHycHSKhRKw6nuvuiofe3Wt3HtFx+k
yC1V5C50K4sEmOIDNR+Sv5cMQSEa2XVDUtVL12zN8BKDbWgwNUGtE/uYNag5raij
i6Q4dJ/nScW5FPnrBLX9GGAkvyOUwZMqzlBBDK5BhVvRND4UfZeguSQx3wgc3ofS
iLr8sXVXk4GOqoCXyv+UPcsnPRO1sUVycly+K/OOE0cuYWNS9XsJrMvimew8qh96
t905aFkRilfUQMYWXFPKqRYOsCdGfRiwcqVQmLTe3QVjMpIHMBzqaGrlUq3EWBjy
qBzesFgIcduORmXkvfIaD0bk4lm+NHct6s8LekcJg4sOBGEEZn9P98cDUXf34lbW
HHl4UQZf/OzoouLNkOXE6UV7ZhHQaEJp8ZKCGksOb8rOyX1YyNLuDXEtdrtXOgbg
dZxUmjTCGl13k4uH4oDbp9++/GISGkUkbnxll/zwiFX9hRPzIU8uJG0pLJZ3iB0M
/52BE2ds96dJ8ouvyjtCdNjpSPlDcjw698jWWqpSwZ760krVS9XR5stVRqGjpoco
lBeCHdQFUOj6PWEY4jX9Q4RVto2hE/7ABtFkPN5D00vBlVOT7g0mkB7UFARMQMWY
93TsMWLBcXcHeRpdGJ4kYpgAfHBumwYqGZJvbPSvGxIMZc3Ob8c=
=xoeW
-----END PGP SIGNATURE-----

--ztvp5w4a5urifshj--
