From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] gpio: pca953x: fix an incorrect lockdep warning
Date: Sat, 24 Sep 2016 10:55:24 +0200
Message-ID: <20160924085524.GB1434@katana>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
 <1474041765-17818-5-git-send-email-bgolaszewski@baylibre.com>
 <20160921054521.GB1484@katana>
 <CACRpkdbYgetpYntO6KsVLh1n_7DU+1AD3AwVVkmV5ud5A6Q31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbYgetpYntO6KsVLh1n_7DU+1AD3AwVVkmV5ud5A6Q31g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 10:10:57AM +0200, Linus Walleij wrote:
> On Wed, Sep 21, 2016 at 7:45 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>=20
> >> In order to get rid of the warning, retrieve the adapter nesting depth
> >> and use it as lockdep subclass for chip->i2c_lock.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Linus, we'd like that in 4.9. Can I get your ack for the gpio part?
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Sorry for not attending quick enough, I was down in the
> block layer.

Well, it was close but still quick enough. Glad to see that one can come
back from the depths of the block layer ;)


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5j97AAoJEBQN5MwUoCm2V9UP/0nagaVZ6g0S/vVOHt7qB9RT
c1rvYUdboDkAWm2iaIhewcOyY9HlyOhPIqtkZYL6KOPe1x9JbBnMSBOasrLQhTrY
xyAUpEklc+ADVAkfI0tutYV2SuFR6Bcx6kY7E7lwbpB9ZkRIFHFi7ER5fPxJEpyb
F/zQzMP4jTwpzMkHCcjxJrE8J8BcUpgkBvU5byVIHXRhN0whzAdhmb7B9pcbJmuH
NpY7G3SkKxZHuO5Hj81seoXtNFEUXntL+72itmIJa2EunHhcN06uXR2++r97FHAq
Fz/ULdAfFShHLZAbBWoKYLH16k3LvsjMJYI9bfguflkrqnXEMHRnVkbKKf9gbdif
3HbbNmGTqVYMDYnOC+IwhwwW2wDpQbUaF2P2ypu4Y4OPX/HpjfAATWZ5srxzUxnC
OYZK9na9bOqrBND6TmwK46hMqIbBvEnwcQ3lHzDmQl/5wZFXOGHyNwRCYoe+NuK1
qPQvzQzNiexrLkOnogfKn2FaJ0RGtOYyDDmSey39TLt3D0BfaLE+x+pRD34XQOW4
C6t3f7VZLAzui8TNgPAC74pa3r8EP0EfAIzrcmg268oBUOAzIoWKlPH5a0Pfp4mO
6xg77xWsQqmFwjGQhMUXxramc0EnXXJpat46dAIKLus8FdSmxsnCZ/cYdGKq7117
cD0wFlzrO41eao+tNYfE
=AQ/c
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
