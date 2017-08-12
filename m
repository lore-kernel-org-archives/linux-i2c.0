From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: uniphier-f: add suspend / resume support
Date: Sat, 12 Aug 2017 15:38:57 +0200
Message-ID: <20170812133857.36gzdcbjf6a7ybht@ninjato>
References: <1501480387-15692-1-git-send-email-yamada.masahiro@socionext.com>
 <1501480387-15692-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qvo4gdfkbnfe4bvc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501480387-15692-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--qvo4gdfkbnfe4bvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 02:53:07PM +0900, Masahiro Yamada wrote:
> When resuming, set up registers that have been lost in the sleep state.
> Also, add clock handling in the resume / suspend hooks.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--qvo4gdfkbnfe4bvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPBPEACgkQFA3kzBSg
KbbtJA/9FL65Ez+gJ00engk17/VGDwArtS3/B5nkgPOo28wcgpIsQE0HcnORSTb1
lXBzUIcTFYP3idW9/TJDdzSHojAiBsKsXa+wlWYfkSkbTDHxT5IX8Y47ylMwFMjS
f9TG7hmD+xIox1SEfgaJxTFb0I5Q3bGIcXCveRr8QdlK3AEEUsKi/cRjq+ixI4NQ
K8M0OGqHTJ0oHcvkBV/lEKVnS/vjv/U6k3JuDyChYK5CelqeAL/O6mJQ0/RvCnu3
7FIBJuSuDIBh60mNmcM/y/FIZVTxjFXk7rsG9umP0UaGDOgGH2ZFNn75n7S67Puu
TUcgdaiqTLWZF5MpKcK2UHpoVn9WMNhphDDbk9csjuXiv9KEXf92u+JOP6x22p0R
3q39AS5CPBvNubqbf24fRUqRXxxvBydNI5hr6AJLEEAnSKT+GOj0ccSyAwTkqw0s
B3SayoP7S2lfhloH6x5055Hj2azfnJUCxn4tXxA+Pc2OWFTyAV45054p5ETbAsu5
tFGGfXPl3mjRicPolwWK+ilF7758Z5HiwJdYrj9abjxPb6bgd8zCS3BaFBkC3lBz
tsz4YO6FrkmwheVLFbUdlmt+1Mkrl9Zfad6KO8T4n/df9Z/s5M9v3epRIX70gU9c
xTvjbtg6GoYZVfBOwcAxt0W0iNeq8WZd+WybNd2BUO/wKqV4G6g=
=UhJO
-----END PGP SIGNATURE-----

--qvo4gdfkbnfe4bvc--
