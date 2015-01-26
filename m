From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C slave support
Date: Mon, 26 Jan 2015 12:33:29 +0100
Message-ID: <20150126113329.GB1052@katana>
References: <20150124210825.521bf923@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150124210825.521bf923-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I find it confusing that I2C slave support is included even when
> CONFIG_I2C_SLAVE is not set. I don't know if this was discussed before?

I was thinking about it but was undecided between "size of code added
unconditionally" and "ugly #ifdeffing the code".

> I am considering adding ifdefs around the code to only include it when
> CONFIG_I2C_SLAVE is set. Alternatively the code could be moved to a
> separate module altogether. What do you think?

Own module: Again, undecided. On the one hand it makes for a nice
encapsulation, on the other hand there is overhead for having another
module. I am very happy that the core code for slave support is so slim.

Mabye #ifdef is a good start. I could do it as well, I don't mind.


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxiYJAAoJEBQN5MwUoCm2O3oP/3aH6/Se+vwPjB/nPw4EGNcy
OELy0Gx/4ZAWYqa+iGKuw11DwsOBV9OGiej7s+WwnQddS8yAjBh8AuXCMs6v/Wnu
8Dzc5sBQfXRjdQPUfvZxQxebXGLhrOl0h2oKgV+uHscvtXgqONOMQCmggAWOy8py
zZQp/TE2RQSWBJ+AoYfGiR2wHnta7QFHfjTLf58nTTh2eaCSZEGbwnx9oXwRk63y
ge+34W6YoA4GoFLHToYheyR0F83G/saA+nAq0lT6hnTnFGl4FgqRxA9Sio+f8jyf
hujY81t86Ym8RhhTTegUuHAXDtI5CAUm04J9AcAXAqOfvA6LXK2DUGzbvq/0z2S0
LBpATf6tze//ZVeHuQ1Az5qild2MeEx+daWKLwlf3gBeoOXoOZWyLa97B91Ct9u5
Epm6EwLhITvDv88NIPOOruWOa32G8jcUvfhC/ukN2JvHZkZQYg3boOWxJKSQtUHe
ZeXS3sPsCJU9zuruXjPqHsiG6zTb7h3bCj2wzUWYssmJXc4qaPDJKCOvNBaiLhxN
a5FShnuDJCZO0pceWv86RlvXHg7l/3QVeD1D5C9ao0yImOBsJZSbEZ78ZK3U9YER
+zzO/oJTgaDaLocuNzjnbpJr5DQudIqqvXGCF5M2BmBxEASCaNBchNbqytXHywb/
1HvQnP48Cim4VVnYUxnn
=Lzcy
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
