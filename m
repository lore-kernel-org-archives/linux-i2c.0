From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Tue, 27 Nov 2018 13:50:50 +0100
Message-ID: <20181127125050.GO1107@kunai>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123125138.22489-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The "at," prefix was never correct for Atmel, so fix the few occurrences
> that got it wrong. Use "atmel," instead.
>=20
> While at it, remove the at,24c08 compatible string from the list of
> trivial devices because it is already documented in eeprom/at24.txt.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Peter, I'd assume you are okay with me applying the patch directly?


--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9PaUACgkQFA3kzBSg
Kbbeag/9GryblAnTfh83KYcmS1+cmhQj1hm3HPFPUwU/SFzuk6CjnqdIY3UXY8uk
OIlLEsOaS37IkBXz/JquTdd9vKY8gFygX2xCk9mnLmxCBrKHwH059Kj46jika2/r
/QHmib+Jqu3ZYP5SJxR7CwF7YNljNyXv2oAXODpWgwHQOFcyJpGwNuethXYKxaHy
tHsVcIOLrTeG/CIS0McGXina6t0GUjFJZKqy6AFmf9Y2jlf6AfvgKcctzPqyXefB
jzXIPCs45LXU37ok9Mr14ciYMLy8/8crd982UwVdftz6cNbn5XK43jEVeFoqXk6a
M4Zr8gLl5sIwbsl4vH8Ubz1p7+KD5rXOh1YakuHpF68j/4b/ya7TJfmo3PNAzUdJ
FBNYf6ax7MiykBIxTV8nmnbMMsCBCnYUyqkMkKks0M4bt6jsZhR3Cix3EAvp7HRQ
OZ+526waEcTlVaatE0VC/bEQHhGYJ3CraWSJoM3EOF2zzVViWbSyI5YHLrVg3Sui
rjtLrQXhHrZErCYQkNsjS7XgfJhLlxpRsKjebZQC+SGZi5L8nTQOpowjWmatjo6d
Q3ANmQV/bHWQw2VUaWP+hfQa5haXMpjthgghNMrZp1xvjcrHvzJdGh8XZ15T+tb2
MmTz7ANBLQTQuXFRLnApu9Q0hVkHFfldErrjYirT9M934lrjmMY=
=zSyz
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
