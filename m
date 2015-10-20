From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 11/22] i2c: core: Probe i2c adapters and devices on
 demand
Date: Tue, 20 Oct 2015 12:42:26 +0200
Message-ID: <20151020104226.GA3654@katana>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-12-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441628627-5143-12-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2015 at 02:23:36PM +0200, Tomeu Vizoso wrote:
> When looking up an i2c adapter or device through its OF node, probe it
> if it hasn't already.
>=20
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

If the I2C part stays that simple and the core part of the series is
accepted, then:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks,

   Wolfram


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJhqSAAoJEBQN5MwUoCm24w4QAJ8ONPT/Hm1UJ6mBcD2gL8gN
YIrmKR0KrZKo+POtx1Ke64FBO29RZP/OlJKW2C1j6ZFu+Ab3DI0bERI5Vc6BzZLr
KC0zkEHP1i2Ya0AjGvUoYNFR7jsmLL48++UknY3TMPDKO/Z4/B+UEPHexF9dpkY7
94L8HIwQFj6+40VLmf7bvk+R6qTPMxb2CgV8cEiDUJX3u3EDAHX8Kegrcb5ndz6i
xCFEMiWHAT6FG9HJUUly1xV1aV69r0pX3DJeN0G+cnLTTMfrXzlCT+txtK7rgMPi
iT/43yeBvk4nrm1A2wkYIQfet2uAuwg/Jd179nN53mfHPtZcEa8mYr5wnlhIYzfj
NmpII7BnXz9SR15TU1ryTLvqueJNXpWk7TXqKDCBec2P6gJZIYD81rgxNQST7tqI
BxxSYjL7VRycQAlg33lgV/eSOnZLH8PppC8ALOpGm9mv4WkIIveaHjzLQO5xq8oq
tzlTdI4CKHPlndPbiVDCbjyv3/dHBLNCTusx5V1HxNheM8T7nuPGgT9wEsdTLVId
yTFvoKxJx8EmQbw1KWvmEXvo+c8cLNP8x41cwy2mYdoqgWoRZ23Ajtb/e7o/FSuG
izf6V5ztmhqX7f5hLKPbwj3hf5iWRkjO7f3c3aV09YZ5/VSTwaSd9d4mFZh9BzE3
Rh1W53P/SLYh3Jtbib31
=VtHt
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
