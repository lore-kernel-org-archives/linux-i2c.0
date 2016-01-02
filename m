From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] DT: i2c: Update vendor prefix for 24c00
Date: Sat, 2 Jan 2016 22:21:43 +0100
Message-ID: <20160102212143.GG1589@katana>
References: <1450898335-22814-1-git-send-email-akshay.bhat@timesys.com>
 <CAHp75VfvLJu+aL233izR3jh7UQg7ewEmS2Z3EhAg2WPZ9s1gyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55653 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbcABVWC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 2 Jan 2016 16:22:02 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75VfvLJu+aL233izR3jh7UQg7ewEmS2Z3EhAg2WPZ9s1gyg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Akshay Bhat <akshay.bhat@timesys.com>, ktsai@capellamicro.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, justin.waters@timesys.com


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2015 at 04:57:48PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 23, 2015 at 9:18 PM, Akshay Bhat <akshay.bhat@timesys.com> wr=
ote:
> > "at" is not a valid vendor prefix, correcting the same to "atmel"
> >
>=20
> I'm afraid you can't just do this change alone as it's used in some
> DTS. Though you may deprecated it along with update of current users.

Well, in Linux, I2C core currently strips the vendor anyhow. This will
probably be changed somewhen (tm), but for now, the impact for Linux
should be extremly close to 0.


>=20
> > Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt =
b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index c50cf13..c4a01c0 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -20,11 +20,11 @@ adi,adt7476         +/-1C TDM Extended Temp Range I=
=2EC
> >  adi,adt7490            +/-1C TDM Extended Temp Range I.C
> >  adi,adxl345            Three-Axis Digital Accelerometer
> >  adi,adxl346            Three-Axis Digital Accelerometer (backward-comp=
atibility value "adi,adxl345" must be listed too)
> > -at,24c08               i2c serial eeprom  (24cxx)
> >  atmel,24c00            i2c serial eeprom  (24cxx)
> >  atmel,24c01            i2c serial eeprom  (24cxx)
> >  atmel,24c02            i2c serial eeprom  (24cxx)
> >  atmel,24c04            i2c serial eeprom  (24cxx)
> > +atmel,24c08            i2c serial eeprom  (24cxx)
> >  atmel,24c16            i2c serial eeprom  (24cxx)
> >  atmel,24c32            i2c serial eeprom  (24cxx)
> >  atmel,24c64            i2c serial eeprom  (24cxx)
> > --
> > 2.6.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiD9nAAoJEBQN5MwUoCm27aQQAKCecDnEUVnmYeJRhqRdW+mY
xXvSwq9sf1qFXLKT6b2Ef7beXJbS1vJugqINWvnWISCrFmWS0iZPNS1/AkVDll7l
cIDecBMgxu8LfBE6nZXu4q3w80vyq57M85f8qNsTR9Rr3Q7KmvNl2NLpG5koaWZE
zyNfmzsqb3m3HKMGoozK4NTQVOdt/YOkCdCNOazfO6wzF7rqtCObB/uORAHYfEry
eUgnBRfdqUXXqiWM7mTg0UuulzIx+TJLDclPUZiSzVrJVhhS7Vr0e/r6BpUHByD3
BBHA/6DwSP1ge3Zy5gCdkPC24Cv+c0yBpYZUbNjQ+L0bfWOQ6GU9fzaqic50k8sf
4h/FhFy5p0BbriXpulRbtemRRQ65Xhn8MsHafkpzYw/fEU8k2GUCzlS43vz9g2iO
/pWf6dXT3u8w/8zWpsnraW7NqPqT91xfGpOPaRaEZlLrY9Jmh19Zr/XaOsUmeLH5
1upTfrso+CrKD4zleU903WB6FauX27EWKIIMhqpgiAACKyPzmrhYmsJYs1jIh0sU
OHqMwLR8q3VuZuW/MJxbxM+JkQuQ4requseDeLCi4/nIPFoVuRG+A/Un0Q4rI9vA
EaEdxXGqxsTg9MHwwP+n63lDCXk9LrimDDO0bajb8ne7xaw2OBGLlnlWqXqmkIVv
SDse2w302FHAEfji69nb
=gtHk
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
