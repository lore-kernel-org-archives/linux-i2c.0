From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] DT: i2c: Add Epson RX8010 to list of trivial devices
Date: Sun, 10 Jan 2016 09:32:58 +0100
Message-ID: <20160110083258.GD1526@katana>
References: <1450895938-21631-1-git-send-email-akshay.bhat@timesys.com>
 <CAHp75VfakA8SykeMSxAKJiDpge9xtMLk=dcemuw=9uU81pk2Lw@mail.gmail.com>
 <20160102211758.GF1589@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59543 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbcAJIdJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 10 Jan 2016 03:33:09 -0500
Content-Disposition: inline
In-Reply-To: <20160102211758.GF1589@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Akshay Bhat <akshay.bhat@timesys.com>, ktsai@capellamicro.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, justin.waters@timesys.com


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 02, 2016 at 10:17:58PM +0100, Wolfram Sang wrote:
> On Sun, Dec 27, 2015 at 05:02:48PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 23, 2015 at 8:38 PM, Akshay Bhat <akshay.bhat@timesys.com> =
wrote:
> > > This adds devicetree documentation for the bindings of rtc-rx8010
> > > driver.
> > >
> > > Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> > > ---
> > >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.tx=
t b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > index c50cf13..0f9c1de 100644
> > > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > @@ -49,6 +49,7 @@ dallas,ds4510         CPU Supervisor with Nonvolati=
le Memory and Programmable I/O
> > >  dallas,ds75            Digital Thermometer and Thermostat
> > >  dlg,da9053             DA9053: flexible system level PMIC with multi=
core support
> > >  dlg,da9063             DA9063: system PMIC for quad-core application=
 processors
> > > +epson,rx8010           I2C-BUS INTERFACE REAL TIME CLOCK MODULE
> >=20
> > Is it indeed required to have all those capital letters together?
>=20
> I agree. Fixing that in all Epson RTC entries would be nice.

Applied to for-next nonetheless, thanks! Squashed it with patch 2. Patch
3 got superseded by a cleanup series I posted recently.


--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkhc6AAoJEBQN5MwUoCm2sL0P/RqLkjPEChDDKojdrpXUPulR
GtwTSpSF4ikDVoIlt8bOwa5nnpfnLT9LfIh/yi+PO/ZGTouGpmANxxuc8eRpc1dr
jFe1FvSIEPkBH28snKLz/ouaJtSFkzaeFb0MsazgFtBPglbygi/HYfdyvAGBLcIG
6BcfEcPdNaSUbK6KqWPnKLdceqfjhKvxRthaQKYHrCbiGIgkjQWVbLTQF9UJAkBi
z1fbW2iSiJ/3L8VPJbfwzOKQXkWCNye/1oLZif5VYIMHVZMl8+SGoQAV3WokMeTP
krzm5CapdV0wHA9TW0AKKOKf7t8rMZhlmGXiIfotiZpLYKnsBTizF9H3SmqGzjmi
zgDwfc0LNA7/SfqWl61lhkGDyPNPlCFALWUc62Se6P3fdZ2BaBjR6K5nufloy0bM
4AjJpbYXURKR8HQJHMZ8FnG4xffBo69t3xekSjmvcC6oujXf5bKRhohkOiTFfkvp
jRgatv2KRjdJRVxdfEijbbDijnO7HTqBebs9hFCtqF1DpuIpUMEGZBU+JxMFcx4y
FyaNdyPza+hIbaD+0sd4JnZgHS+IyYVhumYcCOhf9u8IXPfgFJq1vQyHwUivE2uy
FjL5Zh4h1we+54xsgO3Sf9vKNOAB4xW10FwEUYC477oA0WRZz2ePnOXkdNrwWyu6
AUORwvgC+IbszPYAzyoI
=r3dx
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
