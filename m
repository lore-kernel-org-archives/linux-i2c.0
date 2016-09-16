From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/4] gpio: fix an incorrect lockdep warning
Date: Fri, 16 Sep 2016 19:58:42 +0200
Message-ID: <20160916175842.GD1426@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <20160916172621.GA1426@katana>
 <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <deaa654a-9afc-eae6-6bc8-75f2c3960970@axentia.se>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Looks good from my POV, but will wait for Peter to comment.
> >=20
> > If accepted, I'd think this should go via my I2C tree and I would like
> > to ask Linus to ack patch 4. D'accord, everyone?
>=20
> Since it is not clear if "Peter" is me or PeterZ (I suspect PeterZ...),

Nope, I meant you :) I really value your input, it especially helps me
on topics like locking, nesting, muxing... etc. Much appreciated, thanks
a lot for doing that!

> I'm just adding that it all looks fine by me as well, just to prevent
> this from being held up by a misunderstanding.

OK. I read this as Acked-by.

> It does unconditionally add a new function to i2c-core that is only
> ever used if lockdep is enabled, but it is tiny and I'm not bothered
> by that memory waste.

Same here. And if it prevents us from false positive lockdep reports, I
am all for fixing it.


--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3DLSAAoJEBQN5MwUoCm2HTIP/3YvphdjoQiK3aD6+lBosQ2L
TufcguEfhlJW3kJAws+b1qXb1bAdv5/kKphX1q2xKNBGH3KF0OuVRN3tCmw7/AXG
PTWPVgKyl9RExc8Y+SsNcctNE8nMwo6ngBkr8bEV7Qp7DlV90deRFL5f6A42myH/
Z/7cKHdE9UJD9rQg27sxm1H88lTpirjFFiwX+ovjksHghTB6EzPkIxuCEs5T7dTR
1lWf7tQeCFmLkvdaPY8nAT8yqXz5RUYsIfFmt3ngrdLcAuMYb+5PMWLX+a3cSZtv
mqhQPfxnCRBFB1JMbrAu5UDXS5FgSUHzGs7onp+D61mBfx990lEF1iEuNTU0PTbk
SWWtk/JB3IlHFdXFZEvwzBnkvyOdT/W31GAFzMrKb29IGAnxQTFs3VoXV+O9fvFJ
RcZ7DrjHfrVkvungJHFyjT7KKCE7dGlGJmS/qDqxYQ+2ZazZfn0Xw1vYUezsZ9sR
H1akWDJ6rOjg8KlE5ZiVfxLJIsq+p29oxcnISaL2A4T9X//KsqXgRv/R6xugT/f3
LTPLcGsfiVi/R/FF9pQ5PGPSM5FmFkX2uTX9v/RxVNn5NzcMgSRZZCM+9o3Uh92x
FDAEiFreHV4YL1EOV8kP2Vyo9k+WGTIVZBwT+cOPmjA5sRRZcf/mDKzo5y90VZ1Y
5Np2nWkqB6Ohzd8gQZu6
=O+Te
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
