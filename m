From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-mt65xx: fix NULL ptr dereference
Date: Sat, 28 Sep 2019 20:33:11 +0200
Message-ID: <20190928183305.GD12219@kunai>
References: <20190925203113.6972-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190925203113.6972-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, qii.wang@mediatek.com, drinkcat@chromium.org, hsinyi@chromium.org, tglx@linutronix.de
List-Id: linux-i2c@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
> +	if (adap->quirks && adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)

Right. Please use i2c_check_quirks(). Otherwise thanks for the catch!

@Mediatek-people: can we have a dedicated maintainer for this driver to
better prevent stuff like this from happening again?


--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2Pp2EACgkQFA3kzBSg
KbatPxAAr+Gltm2HCrzvvM07L4jnevtGwg05fL/W3Z71RjOwB1XMOX67NwKJn+gC
3JMaLtB/9VNojTumuxkfnHrtlCc3zQgBNDC/Wf/tQQVgssuAz3TIY40PaxyF3+dP
AWoh3UW9eM3p16wsqm6kH5SJCaZM3f8wuLYY2CtGOUIpzuTGar/X7DV34s+0BH/G
eFxrLdwlGeq31UYZlPI6LnfGqa+K9zH+hTlSGe6zHt0QCH0/i1qXkTMJa2MafBgv
Dl8VXDhBn6tN50JhfXgFbDYXKXV3FWoo8qGI5R4GHyeKOnGI3yszzx9AJq9zWiML
RVQ8uHFULHbt5IXldaE5VKPlAOBRnKNAjjWB16u3HgmKESieU4XNxAt2ByDX38bO
ZFVIbkuBzCIhdZxkipVlqYlF5fBLj4+fnqffCGYUYBUfMrSYLrd4FMhuVXaHABQy
PRyBu+QT6F2dhdW0wGEZE7EBV+XEkOJNzv0b5QQtfLBUYjDED0DEU5XQWaWfR3xm
KqcVj5XJoWNOpS+T5en8hUYIJNP43INdCoxG/M7oQgvYH28dIPlkIt9/iOo9EBzO
z9DiI5J+tE1faM6R2cMol4CEmlX49emrGfnuGwxbQi1gMv/YjfFlb5VcYjPF/5Jx
TTqCBC9wh8ruoyfuOPYnfQmLccm9IR4gnHjvPk0Zwncao5QRdc4=
=/LoV
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
