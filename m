From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: Include GPIO consumer header in main include
Date: Mon, 15 Jan 2018 19:03:03 +0100
Message-ID: <20180115180303.pdax5amdj2rtytih@ninjato>
References: <20171208133934.18038-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5tmfxckaoh432v5c"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40867 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeAOSDF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 13:03:05 -0500
Content-Disposition: inline
In-Reply-To: <20171208133934.18038-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--5tmfxckaoh432v5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 02:39:34PM +0100, Linus Walleij wrote:
> It seems most users of <linux/i2c.h> pick up their
> dependency of <linux/gpio/consumer.h> from other paths but
> that is not a universal law, so include the header
> explicitly so we have struct gpio_desc available.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I still think drivers needing GPIO should include it explicitly.
So, NAK until further arguments arrive...


--5tmfxckaoh432v5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc7NcACgkQFA3kzBSg
KbZMTQ//W6A3zPskYu8TCE2FGUXGjwCZ3JuWzFpYA2El2ldPa+/JdrgnsHPkSZrC
ApuEBQXFGdGGA3cASd7fW6V07CMzia/FDmqs7Sh5pLZ9donnUkMfP24YqvSiSmFr
me3dMZtngitVL2RK4Xj88vky3FaQC8RjOtds6jw/GaS9IY7b47eQBd8s7V4KwreF
TgIK/dlEnKXcU2BsXpHqEyenw4sgDH5HwLv7b0fMH4QahVURkwn+vVcOXBPjt8tV
65l2YH9L/iXkDR3r1F3XxFl/oYdw/pJJQUAU1sYNnsXYBQjFWcA7+4h2ZzBroyHu
05kgT6N0L+ECRJ0ybyjjCvC+dhShuAvSgTaBlLyrXwzc8AAdqttum+fkqYjK59ul
N+31mtP2FP7Z+8Qnsl2aP6OyLh9xPDBE7K2y5nKw8RjckMMsw2P8q0sOrhY4bVqd
9/oOmdBB9ajQ7ThdQb2K25njZJAn+7eatFhQl7gBgrs0B3zuRhoNLI9T83hvTbC1
X786YdmhKByqyg6MfgnX0gugwOInjT3AVAlfBVwWTT9AyWTJNQ2mON66CjSseE8L
YwUURAGBj7sd/ltsjsohHoPf/eZJiasauMugX5TXZopHZ9mshkR4xdPrlwMrPa+k
KeL6s618014o3Uw2J1ac7KJd9JcrJs4Vw2HzMeiFBsQNt8EJH98=
=/W5k
-----END PGP SIGNATURE-----

--5tmfxckaoh432v5c--
