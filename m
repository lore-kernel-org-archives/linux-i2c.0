From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] MAINTAINERS: add DT binding docs for AT24
Date: Wed, 29 Nov 2017 16:30:16 +0100
Message-ID: <20171129153016.gkduedzytmxylvau@ninjato>
References: <20171129090442.2865-1-wsa@the-dreams.de>
 <20171129090442.2865-3-wsa@the-dreams.de>
 <CAMRc=Mduv+Ecu69Dkj5aB-+YHfu9q6A1=0k=1Va_i1CX=gPBng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gvctfxs4ipbtq2id"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55187 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753325AbdK2PaS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 10:30:18 -0500
Content-Disposition: inline
In-Reply-To: <CAMRc=Mduv+Ecu69Dkj5aB-+YHfu9q6A1=0k=1Va_i1CX=gPBng@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c <linux-i2c@vger.kernel.org>


--gvctfxs4ipbtq2id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 10:27:22AM +0100, Bartosz Golaszewski wrote:
> 2017-11-29 10:04 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> > The driver gaines DT support recently, so we should add the binding docs
> > in the MAINTAINERS file.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aa71ab52fd76d1..c870f329613d04 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2262,6 +2262,7 @@ AT24 EEPROM DRIVER
> >  M:     Bartosz Golaszewski <brgl@bgdev.pl>
> >  L:     linux-i2c@vger.kernel.org
> >  S:     Maintained
> > +F:     Documentation/devicetree/bindings/eeprom/at24.txt
> >  F:     drivers/misc/eeprom/at24.c
> >  F:     include/linux/platform_data/at24.h
> >
> > --
> > 2.11.0
> >
>=20
> Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>

I'd think both patches should go via your tree because they deal with
at24. If you'd prefer my tree, let me know and I'll apply them with your
ack. Thanks!


--gvctfxs4ipbtq2id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloe0oQACgkQFA3kzBSg
KbZYxBAAnNz0wGEbnnTQlOJXup3kAFoYJYhGc35x/3q6qmncYfmUHNhrwIEq8Ssa
6+TNXzv+f40f1Xnt1dwnCHHGDV2NUQn6jPKe+k66RQuSHLfFrbq2JI9eMIEsJFy/
SVhWf08Sx5z2g33BTP/lNgAcim5ZEyws9DEPl9zWO63Nx0LuMnQaSFmVeRGxj9Gs
0Xeuw3DewfJQ1X0GlpLa3fkpOU3gkMiz56VOxv0QXvIcl/MHQTIaiD66YFdlVa2j
uu+haIhq4sVp3OEraduM8C9thTBFbYItpMBFLwAkYbSJON12vh+vAeGVzvcCqePb
ZGAZMSvQmOLsUI5nedLxbLn1vBBqICyAe4ZFZ5pQpszJElpo3inrUTbsOS5OsFAk
CLLsWm2BNRCFLSAwf9hwWX5bmTR7su/MeDN28S10kfODKUYkCwRQdZ3cLpJv94N/
AKBN28DHNkrmoNWnMkBldSOYo2pUCL51INq+iznjQcnUD/3WzrS7UFT4LgSHN9S5
X/RbtQ7AQPhlKbJTANuwI9KEIVqijSQIS0/87fzn76pyhxKhqBE9JY8gUBG6dc53
Ge0P7aKjr3W0dmFUvbiCxZ71ATarNrciSbBK7tlUHfSzUYP+Rx4viDKEZjRFE1hE
FU8ui4yIgp/8JZEhCxDLHaAv8RXVLMsV+z/NE9ClfgVxeelAhb0=
=ggLa
-----END PGP SIGNATURE-----

--gvctfxs4ipbtq2id--
