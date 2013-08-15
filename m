From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Improve logging on failure to probe for ->class
 devices
Date: Thu, 15 Aug 2013 14:51:08 +0200
Message-ID: <20130815125108.GG17155@katana>
References: <7416fe787fbbe867a2a980b3a2e2de6cec7bf5f6.1374092773.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7416fe787fbbe867a2a980b3a2e2de6cec7bf5f6.1374092773.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2013 at 01:27:59PM -0700, Andy Lutomirski wrote:
> While writing the i2c-imc driver, I noticed that the warning message
> when the i2c core can't figure out how to probe is mostly useless.
> This trivial patch improves it.
>=20
> Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>

Applied to for-next, thanks!


--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDM68AAoJEBQN5MwUoCm22mAQAKDQCQBrT//caV/YCHZSCsXv
c58Y9WUeOfpnCGZ79C60Xxif/mVCq/oMQCP6IgoGNlUyBrc+11Cj63u7zAq4qHCH
L7SNMXVy7i7AlGLnofwdDMV133aNcllSTF1CK08jhzFXLLGy4mF+NB4zYlQJxwo4
EUzfNe7otrScGujw4/jvN0XwMlHiXvSYnrnEHLL8QSnh27z16tdv83NLqoD+vHF+
FXLRZ9hWSu8Me/54yX99sCsI7d+E/lZGdfSP7qUml/Yo8wxgs2tFwC3iZXR/Qy/d
kgIbITm7fCZSW/ASUkZbxItTySLPefS2e+RUaMlZmoxr0SAtnURx1IHn57EMfPZn
XaPy45lO99R2XnC6CU6E1JPlwcB36HrKEvZKYe1CgcH7NPhZnn40T/+RzSuBdutu
vRzx75oQzjAQjZ2NmnroXg4yMzR6zixxNROEV6t4G0SkzNMiBcGoKoCO4enekU3d
A8FjG5xifa4NdZuhimNuzLzZ5Xu4v8J1RhFrVQqbFQBRZvaJ3rNld0aEmHsG7m/Q
NlV4myls9faVKzkqSQ1spN7DlCVxwErWKkh2U3cAXjQnEaYPecErVU4CZFl9Mar9
efurosOvlhL1RT4Mb94Jl3QjOVhr2d7f2a2UqeKogxw8PCf35fwh6OmoWzfRcA6o
rMKd9b4TifOXYa7VmOoB
=8r6q
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
