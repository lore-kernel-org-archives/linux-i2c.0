From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Wed, 21 Jun 2017 16:30:18 +0200
Message-ID: <20170621143018.GA1571@katana>
References: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
 <20170619103002.5d502c92@endymion>
 <20170620172810.h2anac45n5u3oova@ninjato>
 <20170621091843.657de813@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170621091843.657de813@endymion>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jean,

> There's no problem with the scope. The problem is with the
> initialization. The way you did, did_stop gets reset to false with
> every iteration, which isn't what you want.

Ouch, where is my brown paper bag...

> I looked at how 10-bit addressing works again and in fact it is simply
> impossible to not use repeated start when reading from a 10-bit address
> slave. Only the first 2 bits of the 10-bit address are repeated in the
> read part of the transaction. If there was a stop between the two parts
> then there would be no way to know which 10-bit slave should send the
> data.

Which reminds me: Have you ever seen a 10-bit client device in the wild?
I wanted to buy one for testing reasons but was not able to locate one.
I only know a Renesas IP core which has 10-bit slave capability (but no
driver support for that yet).

Regards,

   Wolfram


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllKgvUACgkQFA3kzBSg
KbYmzQ//VBvyEJ1TNiyT93XFwKcEPa19lN+I3CxTGSP7QIFjmK04wDKlUs/TaKxG
2382m/y8lnLx7rC6p58hB507bqD9leQFke72nY/bwu+soFPAlka0LWbzIdmgfD20
g0cQ4n3w3Keq0lOQ+GO7H94qbTkozcz+06csSDrXPL8PiVeB0siClt6n/A8qR8VN
thtZDP1nIwISEAbiwgxHFqmHTdbuWWmQ9DZUi6+zxMB/OHj5ckmV487EG0hKFRks
085I9fY/9KDN/gs0eMWoY6PXHjQoVoS8qNLb1MbB7E1O+njY7+Nx+pgJyBy7JnMA
Y/rAo1MrPJB2LrzJxCqpbjiT5cdxOswuJIOsbztgtAePZxJjMtEv+dsE9d2j53Vc
zgRrrUI9caiTajyLJ/AZt1QaDeBwm+oL51RDm4rHY6VPCgFpkVq1nXq+klVZiyBw
bvVCykmsp4CdtqZPzdbF2fc5M4/bTidbbmbeOYej3ieUO1XEQvjM0ydW29j6Ln86
vpuww/bnmaCiMYMDKGgiR1PN153YMv9inqk9ocABMi/Y/s6/yqcMsmwuPCfAXBbI
8heN2HSCIiO+nK5BpObBo7VNkacUTe+IdqK/lQGLWHy1CIbWgjANdT3yZs3maUpA
JeG9RvpqGTi2XDsm0vQ1tTWNEC82T98nukO3nWafWhb9noqz/VE=
=bKjt
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
