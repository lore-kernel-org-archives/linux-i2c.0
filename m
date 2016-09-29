From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] gpio: pca953x: add a comment explaining the need for a
 lockdep subclass
Date: Thu, 29 Sep 2016 10:04:50 +0200
Message-ID: <20160929080449.GA4032@katana>
References: <1474883655-15824-1-git-send-email-bgolaszewski@baylibre.com>
 <1474883655-15824-2-git-send-email-bgolaszewski@baylibre.com>
 <20160926100030.GA5606@katana>
 <20160929060638.GB1524@katana>
 <CAMpxmJWmzju-gJ54irsqGb86i6THx4BXzqMAa=okqGAi=5bbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJWmzju-gJ54irsqGb86i6THx4BXzqMAa=okqGAi=5bbrA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2016 at 09:56:58AM +0200, Bartosz Golaszewski wrote:
> 2016-09-29 8:06 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> > On Mon, Sep 26, 2016 at 12:00:30PM +0200, Wolfram Sang wrote:
> >> On Mon, Sep 26, 2016 at 11:54:15AM +0200, Bartosz Golaszewski wrote:
> >> > This is a follow-up to commit 559b46990e76 ("gpio: pca953x: fix an
> >> > incorrect lockdep warning"). The reason for calling
> >> > lockdep_set_subclass() in pca953x_probe() is not explained in
> >> > the code.
> >> >
> >> > Add a comment describing the problem, partial solution and required
> >> > future extensions.
> >> >
> >> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> >>
> >> Linus, because of dependencies, I should probably pick it up?
> >
> > Linus, ping!
> >
>=20
> Hi Wolfram,
>=20
> this patch will not apply to the gpio tree. If Linus is too busy to
> comment, maybe you could pick it up anyway - it doesn't change
> anything in terms of functionality and it's better to have the code
> commented when it's not obvious what it does.

I want to pick it up and am likely to do so anyway, but to be formally
perfect, I need an ack from Linus.


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX7MshAAoJEBQN5MwUoCm2chsQAKzQPjgn+zgQt0All046Zwwj
MwPtYxndHkr7D+ClGovfjcKgzsqPap46x0moAEwYeFqui8RfAToKLNN+247ogdzP
3TmCOinWlParAuwJTath6DVGBTVicVyvhebRk25DoEUkGS9DztagN+8/VNxTXnUT
E67XETPWQU6tJIKWdc6azyOkh0nAzhWcqAtZqLqzDVBfljzxLWmbDFb3OuNp89sj
nUtHZtMmrPWIV/MIzMycrIwQyc4X6X6i4tLpqba2vJ0ll4SGj8T/uWrY0M43MC36
DI2dms4kY8x4w4lF2FJPU07Z8iEnfzXyR7xn8pqIrZvJUT5++pYoPEJZT3lUnQgs
fk1YmT+xH8LUDoodvnaq9vk3Nk0M1KB5DS2TZan0eruV8wb9MDkkLln3Sk9FHM7R
ugNlwOhx3cCtQ0CwAAmpWBlljvhA5rkeXKwcrO4RgAF1wyPkKscwbYAlhedUtemQ
/94wau3WbMFylY2eb8I6YlOnLqDEARvAv0UB5r4q9J3/DnoKcRbpkEeHSehfhXMu
q3w59/IW86PXiADoNb30yAC+wJiMnxUDIBwKf6lhtSt4nE2aXD/LGwZmC0Ml2hv4
DJ0e4SA0hSrTMbYIrvKqbTddPvmudz8EQvV+NwGZCuXz0bhBE8yLnwOQiuLj7s3y
iA+DpZR+RfMD+2UWQZMo
=JNFn
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
