From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: meson: add gxbb compatible string
Date: Sat, 24 Sep 2016 00:13:12 +0200
Message-ID: <20160923221312.GA5683@katana>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana>
 <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55695 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934194AbcIWWNW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 18:13:22 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 10:01:13AM -0500, Rob Herring wrote:
> On Thu, Sep 15, 2016 at 2:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Wed, Sep 14, 2016 at 11:49:15AM +0200, Jerome Brunet wrote:
> >> This patchset adds a specific compatible string in the Meson I2C driver
> >> for the Amlogic Meson gxbb SoC.
> >>
> >> Other patch series (pinctrl and device tree) are being sent to complete
> >> the i2c support on meson gxbb
> >>
> >> Neil Armstrong (2):
> >>   i2c: meson: add gxbb compatible string
> >>   dt-bindings: i2c-meson: add gxbb compatible string
> >
> > Squashed both patches and applied to for-next, thanks!
>=20
> Please don't squash. We ask people to split DT bindings for a reason
> being reviews and bindings may not go thru subsystem maintainers in
> the future. It also makes it harder to find things in the archives or
> patchwork (as does maintainer fixups of subject lines).

I intentionally don't ask people to send me the patches squashed. So,
you will have them seperate in patchwork et al. I only squash them just
before commiting to my tree. That's because I found that when digging
through git history, it is much more convenient to have all the
information in one commit.


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5aj3AAoJEBQN5MwUoCm2LusP/1TIp4VeWIbb/kECbVvSlUuk
7j9tIoVDjX7bmJmTkGdujfE+TsWFym2SLY0QMpQlwj4nG8Sl+06TrbUcxYKXafyk
KjdPCue4qSujO+m39oy2DX4CM/6n92D9NxEiPuwhTpVKtqR5JGtZpG3+E4Dacxhe
8pkEZa+pz0YhUdQhRHoyKXVDlzEQu6Th5evmgnISIvqab+pJhvvuM2+V/rxJTBxz
eYRPiN6dwKhLiTXDMXVxlr3YT3hqU/2jXY7GFD92VR2T3fbyTwOuzpAeTRIg8l2H
fer6wneOfoWgBKFop3sQ0+uvy1Car1R/1j3AYs5JBoRuP+CCl2+OdEF/9bx8SBTV
Db6GDYmzbCi3WVIBekE/MrjLVyBgsU6TIfPWX4Q9Y89jBxsKy2O4JigJ3znydITp
moqXthe6qxLRSvJjvEgxn8q/Ufj9ngAdVtLyyV7d5dBw8r4PGBIvMwPW5w2spcvk
Oj6S8WP9kRibl/vnMBuzwDB9knpMfreODeOnm8GeVSOh5AbwF5WQwd0zdiwHw0LQ
fBAbRQZzeDGsiNjFeC6C8CyXiA7ikzwAM2TEXJALqREKNNuIBj6c1iHLS9qPBRJx
ZxFmqjyAxRNpfY+RhCs+Wmq15LQzUqlVK0OZC0RAf7dsZVnFXk8+OHZ9UA+92VfQ
tirjXvkDNjWMWtjaX9X3
=WfuS
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
