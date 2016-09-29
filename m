From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] gpio: pca953x: add a comment explaining the need for a
 lockdep subclass
Date: Thu, 29 Sep 2016 08:06:38 +0200
Message-ID: <20160929060638.GB1524@katana>
References: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
 <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
 <20160926100030.GA5606@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160926100030.GA5606@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 12:00:30PM +0200, Wolfram Sang wrote:
> On Mon, Sep 26, 2016 at 11:54:15AM +0200, Bartosz Golaszewski wrote:
> > This is a follow-up to commit 559b46990e76 ("gpio: pca953x: fix an
> > incorrect lockdep warning"). The reason for calling
> > lockdep_set_subclass() in pca953x_probe() is not explained in
> > the code.
> >=20
> > Add a comment describing the problem, partial solution and required
> > future extensions.
> >=20
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
>=20
> Linus, because of dependencies, I should probably pick it up?

Linus, ping!


--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX7K9uAAoJEBQN5MwUoCm2dlMP/3g/JaQgkdYNTx6ZdZa+odkW
xcMex32LwA+SDGpXsWTULWcxcrPmTRl+21GbJys+DlPoM01HD1BDD8SgBqVAitIP
63pVi+Ux7iX/2aZgvWXjlKrPdt2xJDlo64pZaUeE0PiZX1Sjm/IsO0HX3ZLh2cg7
pICEQ8879RNDsSmga4hDE5rrsQAfX2Weq8m91X4wPSI42pz85RxOgsHX+tCw6EFn
YCXSLYtMjaTs4JI0d/dH7PD/Xnlw8p74aO9RUjqa03ooOwZcAis2lNsTutyVvxf9
SSjISVrZNQo1ZVNbf7A7Lzbg9+kQNIXxIR66zIpZELLVOH8gvqmi1Z1nq84SI7X8
NtfLrFH8HRcBvREQRh2VROUIfJNl+fZUO1oMBjqXKpRh+MYZmVze9GakcBuRKbja
Cwk4hF2G7fF3sen65E9bTcnm7GRzn25unySWMXO9nkJ2BelyQFJTWJEuVnmSOvv9
Hfj3qDy5e679iMT/2hj4E9mh8ioCHBAaG6JcQvVn7AxXQpuKD/UFlLS2x48TnRnx
0nO3WIfcsofOvVn9W8RYAiSPpMbIsqDYOYLARjc2oTNf8i5TXhpJXdGW2bfqycB/
hsUqkK/PuIwmIOTYulwLGi6e+gHObtDKGR6H+iV0//3uz02+5bulW0lrlv/mRenV
1eoheioHXUD1Ie66dAjJ
=Ds3x
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
