From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/1] i2c: aspeed: add proper support fo 24xx clock
 params
Date: Mon, 14 Aug 2017 22:09:24 +0200
Message-ID: <20170814200924.gfwogtgazgepd42u@ninjato>
References: <20170728204558.6455-1-brendanhiggins@google.com>
 <20170728204558.6455-2-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ryd4k455hnzkgzqd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728204558.6455-2-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: benh@kernel.crashing.org, joel@jms.id.au, rburanyi@google.com, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ryd4k455hnzkgzqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 01:45:58PM -0700, Brendan Higgins wrote:
> 24xx BMCs have larger clock divider granularity which can cause problems
> when trying to set them as 25xx clock dividers; this adds clock setting
> code specific to 24xx.
>=20
> This also fixes a potential issue where clock dividers were rounded down
> instead of up.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!


--ryd4k455hnzkgzqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmSA3QACgkQFA3kzBSg
KbZwwRAAsoQEYP1VWgUli8j3bbzadX2ErUWOYfan28SL+OrNh82agUqtew4FwgYG
rSUDaEzzZAx+5GuFduzFAVbTKECTkWiKlY4yBtAyx5BgPAV9U8zHMmvEqf63ygv1
S0um3aryfJ9a09Yc/PDAmX0lA8OmvaiUvMJUdgxmRVyf2GiiLkkdgkRcTU19NcsB
V5SrztVQaQCXX8a1ehYLjJQ3krHKlZkHvhoTMELPlxkxUEvKk+DrnvSfTHzflIRR
ViPm2/H2muiVdYBS3ljd0P5eGT/shdIbTFXDBys6OtHcQSCIYmLHi41VgLwiLn1w
ifYNb3kTsW6wYyPQkokZfH/62jtNvVvwQuh/66V7z79uTWYCZz02HGSznmgwvdHv
sIYCV4SSWDN0Nd3JBhe2ObRWxTc0HZxaBL2B7XhkWndPModbS2kDxQwOqEXsTeiK
p0i7k27271ZNsf0xVu5PMhfs3104UkFaITsKmiwnxXckKj6SNpfOhfVoLrGfYhdN
LodTCuy2Q/JXsHFxxlT/x45dI0caocBoHF54jJqXgDx/uqQEPn9Z1n6q6f0tToj8
e5PReO7QN4JlZwHCApNPXu4OjLCiYrkXXAbEX3Y/pmtho+q6vIFGOnici7o/gHiP
7KzxN5c3MDz0vnV9xZ+9EXnoHqbhT/t5sWjEhBgaCXSzoJMzpN4=
=O7c1
-----END PGP SIGNATURE-----

--ryd4k455hnzkgzqd--
