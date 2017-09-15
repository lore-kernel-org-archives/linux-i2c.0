From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Fri, 15 Sep 2017 19:54:39 +0200
Message-ID: <20170915175439.izhfpx2ztep4evet@ninjato>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oazmpjhsdhtbnxtk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50095 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbdIORyl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 15 Sep 2017 13:54:41 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-MIPS <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net, "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>


--oazmpjhsdhtbnxtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 10:51:28AM -0700, Olof Johansson wrote:
> On Sun, Sep 10, 2017 at 2:44 PM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> [...]
> > Cc: arm@kernel.org
> > Cc: Steven Miao <realmz6@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ARM SoC folks: requesting ACK for Wolfram to take this patch.
> > Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> > Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> > Lee: requesting ACK for Wolfram to take this patch.
>=20
> Acked-by: Olof Johansson <olof@lixom.net>
>=20
> Wolfram: Same thing here, maybe this and the other patch can go on one
> branch for merge in case of conflicts.

Yes, I am fine with picking all these up. However, we already found out
there needs to be a V2 because Geert had another series cleaning up the
i2c-gpio driver and it was decided to merge those two series.


--oazmpjhsdhtbnxtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm8E9sACgkQFA3kzBSg
KbZXtQ/+JZGwzbZ0lFycSE6nwh94j8fXX+V+QjA/97m3WDLFuRm2hF/mg0Wa5e/P
569CnZApavhIE2Gqxw1vT8npm0KNXb5qQfJ1xyKVNnXUSWrlxb0R/6IdNHNRkFVU
T6wjtGlJHUAKG4j+3HOHeZLscACQ0KXIjvqEHzGB0pfbX3mcJRsfR87RNeZgst0P
elE5OFVGPWlKrnIdhwaz7iN6WXB8yldbeqW0HPL+L/vbo127RiS8hWhPfP4l7RpA
CQ027zMTIsXCxzRld0Md4+lsOa+CoNloGn64H4w39cQrBSFQNkNjFKkELxl6w/rw
VqNwbAseQ7bh3PDct/rv25UmRfLg9VA2vb2r9cKyqc4LrKfxdNxaYruCKcs+341u
+RhoBpVtqciv1HkvUsnJRBpmdC7JYgklY3Kt6Tp8YpH/Lhxn3wDIX3v/ZniBI6a4
IUidLo0+dgm8Xm6Hh6ON6w4+hFXFsE2jSdQUq7dqWymYsPDzdwW3WvxA01zlwucQ
z2lwcOFqJzwyJWdhfYMwBecum6snlEAQQaJAwtPwjyDqNPdjtU+wn17/p3vCYk+R
02D8TPY9I5wZpi4PRU03Gyi+JRfUeGn938lDU+upf3bRi6YchGgRa8NCYHAg/5qc
T7KAjvw7nRC6fBZHYPWnzrbFeokcEsLdiJ4Vgbz8xBT7wAua1FI=
=ZYSM
-----END PGP SIGNATURE-----

--oazmpjhsdhtbnxtk--
