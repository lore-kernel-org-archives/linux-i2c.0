From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Date: Fri, 24 Aug 2018 16:07:06 +0200
Message-ID: <20180824140705.t3pkiqfpnqzaaksz@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <20180824130130.bialyhjarwkwodzw@ninjato>
 <1335058904.531.1535118581478@ox.credativ.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ac2cl3ttkkj4qfwg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1335058904.531.1535118581478@ox.credativ.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sedat Dilek <sedat.dilek@credativ.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-i2c@vger.kernel.org


--ac2cl3ttkkj4qfwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> will my patch go to [1]?

It won't be needed anymore, the __deprecated function will go away until
next week.


--ac2cl3ttkkj4qfwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluAEQUACgkQFA3kzBSg
Kba5Ow//dcKcXBiZ1sBJZgLzYdDjQPBb/xfPsxE8a4LzlShBun23hA9u2MiAh0q2
kJLeTsyAfiQR3nbb4ax1oUNLycqzInz/HrYW4zyiajbg4o8dQQugJNWwWbMJtiO3
UhasNZv3nwnbJ6DEOS3XVko9FQkjnn73fgfL0gq6qpSuC+YIYQOMjbdvhfFaR065
QJIGK/zz/xktwRRswSL2CV1rsF6edJMizgJR/IjXCZVFg5gYKQsk344MbK5w6pjZ
0lEiSkMML+fCk8rhkyYewrHKak99hM7IIRuwGGo2BJiukqgXpedLPzVVreYFlzu2
z2XfXZcJg15s6lgol54X4kk9bnBeqwsDz7TnveeVoqu4QaoMiva3ay2hkeS3zmpj
8XfaMy9o7PQMQdzx2OiX8w9uI9AEFRjd+5y4KknavVOqaoXmWEqwp1RMTZistIt/
BeJZE2vnazA8q3bG9n7ffzulY11ImxraEsgfY5uT88pfdaGeJrbLWEp7n/kFttGK
JFYGzSYL+HkcwoNra3odYDbef3t4j6TGZYh0HeDPHJpfyT2NWew237FGlR2cgUxb
hCq4oIG1+Q2TD7bZUstsJSg/tfycqYEUknr1KKiAYg3ZPAm9yuKocvVssIPg1loV
TXo5ORSiQy0TlqA6/qE1Ox8N0Ork76p1NNOlfswqn6rP9MLCRN0=
=oWai
-----END PGP SIGNATURE-----

--ac2cl3ttkkj4qfwg--
