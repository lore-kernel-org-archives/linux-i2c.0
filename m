From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Date: Tue, 11 Dec 2018 21:05:23 +0100
Message-ID: <20181211200522.ckfyo3uhv6f6kjdn@ninjato>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ttcironrq3vt57y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>
Cc: "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--7ttcironrq3vt57y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 03:00:52PM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> This patch moves configuration of hardware registers used for setting
> i2c client address to separate function. It is preparatory change for
> next commit.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Applied to for-next, thanks!


--7ttcironrq3vt57y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGIIACgkQFA3kzBSg
KbYq6A//Sr3+jIT+p/2/Ix/BN0y8eelGwSLZXrLUnCgPWkPwGLChH65KD8POy8y7
SS5DNLKH/MtooOW5XKLlZwkbrSD7WtCw1sS/5MWHEkQU8Op4rH97NgaFxn9xwGmz
fY2wZyu3rNTtMIezMScRzHTIAmPR31IHmNwCegzPtMrzhpFyW+kDU7eVDbp4Ux3A
BP9rJGeG0lvTHmzgDkWO2ESzlzKDWGNy24zTs9bgPcx9VOpEdAT7TF3WibT6VlKW
JyH1nlXfcQLfyd/t5zb/lzcCORxPVqu27NiX1SKcNllY5BvgeYfaLFvnwXQGpxYG
nC+xEduAgWXXlP6rRcA4L0yV6e8AbrrXzDaRly5uxPIq+y+yGZTZB4n5TRwCJsRf
uaKHV5HhYYAELv6uD/5EuSH/GGgnqhl0qj2x3xRXX2rb1PEh5VY622Yflw5PAQgY
UdZ/3ws9wjobDbTY9zqr3GVJAw7NlmQEN6MovduNphxxUh/gtj6yfDGbRI9z9wZV
vaBRPRIalXuApW2QXf89WmG98LmiKWDqy3usVNBVGLGDyiVuumO8+puRWPtiK9z8
FC79Wscei24+TuPRokmqexGnlVPVFwtF2tRpIUtOo8hKurUa3HDdxbuiaqfpugbL
Ma2R+vOze1ZQz4+apMAkd4MAxU4L+xmRB7tBZLq1kt7Z7zY1HyA=
=JZ0g
-----END PGP SIGNATURE-----

--7ttcironrq3vt57y--
