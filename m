From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] DT: i2c: Add Epson RX8010 to list of trivial devices
Date: Sat, 2 Jan 2016 22:17:58 +0100
Message-ID: <20160102211758.GF1589@katana>
References: <1450895938-21631-1-git-send-email-akshay.bhat@timesys.com>
 <CAHp75VfakA8SykeMSxAKJiDpge9xtMLk=dcemuw=9uU81pk2Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55550 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcABVSR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 2 Jan 2016 16:18:17 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75VfakA8SykeMSxAKJiDpge9xtMLk=dcemuw=9uU81pk2Lw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Akshay Bhat <akshay.bhat@timesys.com>, ktsai@capellamicro.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, justin.waters@timesys.com


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2015 at 05:02:48PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 23, 2015 at 8:38 PM, Akshay Bhat <akshay.bhat@timesys.com> wr=
ote:
> > This adds devicetree documentation for the bindings of rtc-rx8010
> > driver.
> >
> > Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt =
b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index c50cf13..0f9c1de 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -49,6 +49,7 @@ dallas,ds4510         CPU Supervisor with Nonvolatile=
 Memory and Programmable I/O
> >  dallas,ds75            Digital Thermometer and Thermostat
> >  dlg,da9053             DA9053: flexible system level PMIC with multico=
re support
> >  dlg,da9063             DA9063: system PMIC for quad-core application p=
rocessors
> > +epson,rx8010           I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>=20
> Is it indeed required to have all those capital letters together?

I agree. Fixing that in all Epson RTC entries would be nice.


--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiD6GAAoJEBQN5MwUoCm2RgAP/R+S0U+nsuCwjZ8iNIKiowku
70TvSLuDrKeeI94kaZvoonmsHuviNRw+N/qyXmv3RsEVYmEtAHIh211VKC2hHT8O
1WTlc5oSLC6oGtZXPvqfvYSXdEtwyiY7OBT6BD8OFz9UgK+t5fl9bJmTSQzlgBDT
QWWYY/+O6pubHAUOim2bL3U73mMBo49lFxq513jneMdHdRbcAlJ3LnilRIgq2fi0
JsE7C/B1YugFDfi09oeByi1cDwv05IyfkZV5QuIf+MCARTGtsXbekQNMHC8QzV9t
VpU7ld/1JxZZoZYHPtv9NY3+I4YUl8zRIew9tJz0mOJj9Nr0YV7+NaISFsuMneYO
+SKakm6pPEAwaH8H5id4AD7vb5l1E8leBYKwaAbmfG5jbaQz2oKY4o8WYMVNe2K0
LeSU1Q+7bmfuhT3ZpCmwlGYpO6SbeFi5Hx95j1vjY2fflq+L1H6IoxbAvVWdRbq4
yvVQR4kolsm4FYtxnvKOrxDgHMDpXR3f88OiOVsw63VrXaGDEpsFnikwRntasftH
Bs+IwCWX4YNfQsBnQOI/xJZ05fwKzzSB7w5xmsft06lHbs/pDy9/RZF+uEdpCfKp
qvLKq7l7qRLVIlxcZuYQTUNk0UNzVsYOgZAd6oUhVA+xvR2+5l1P+In9A+Eak4wF
3LDJBql9JSPSMdVOodgN
=Pca+
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
