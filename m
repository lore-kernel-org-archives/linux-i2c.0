From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c/busses: Convert timers to use timer_setup()
Date: Thu, 26 Oct 2017 23:10:23 +0200
Message-ID: <20171026211023.cu5yueotpj2qui5r@ninjato>
References: <20171016232729.GA101069@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5bgiksihli626hog"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171016232729.GA101069@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--5bgiksihli626hog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 04:27:29PM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer =
to
> all timer callbacks, switch to using the new timer_setup() and from_timer=
()
> to pass the timer pointer explicitly.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to for-next, thanks!


--5bgiksihli626hog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyTz8ACgkQFA3kzBSg
KbaXTw//TY3NRJoR3ZhVy8AnfUaFR7fGrfrmpDQwg1NUEmavY4yG7aLM0ZdaYqVU
jLKk03TKG0AygIg9g0YwwIlBZoYloN++nxvHvds33zQdRd13sgsAJCy9tfPrJBwx
3sEesqbvxBB5VRN51ZQT90jq0FqH/iKo/IOFAxLC4ZiePBKZKGnfutFf5fCoM18S
eHorksEkLYfsL45BmvdabLngjPgc2O4YfgRP3Y8bGdcJlwz5TgGnJupw1YUaranB
6t2sG7Q4Faeku42jzU6gAjZ3gNjyWEZQwWwcahlPbr8TkCOYB6iRf8L6vcbdpLN7
ukDoxiaxEJaBXa6eO5czgxUIySRdRuklUU9UcUmOTPHNEj0BJdH6+jKvrSzlIP94
ks63/FB7vYqfXZi/Bg0SwBbKLLu+iqBLIUKsPyeD2kFvbIrVMImV1ZH3SlQ8R5tu
naZKrQGIauswT7xf8dKGJvohgbo5DIb1tPIzO6qflNYlMdI3Ux8rl1hvrApmS7hU
n3jWtl7Td1S9IscS0oYAigX5Kl3ORP6HZduFpPmnt/kqe1WIQqgFotAis/5Alxyr
uEi+Oegz8m/ZDbePMIwNL2yphk/3JuvRU1LvWSeaSSnOw5zOqiM6bcg3dK9g6lDE
YCviVXaX46mTora55hYsQ/+ummL2lEkw4+QELv046nyCBg35VaY=
=Etlj
-----END PGP SIGNATURE-----

--5bgiksihli626hog--
