From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: balance clk enable/disable on removal
Date: Fri, 12 Feb 2016 19:54:00 +0100
Message-ID: <20160212185400.GH1520@katana>
References: <1454106696-5867-1-git-send-email-khoroshilov@ispras.ru>
 <56AF69D3.4070300@linux.intel.com>
 <1454337845.32507.20.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:58884 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbcBLSyJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 13:54:09 -0500
Content-Disposition: inline
In-Reply-To: <1454337845.32507.20.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 04:44:05PM +0200, Andy Shevchenko wrote:
> On Mon, 2016-02-01 at 16:21 +0200, Jarkko Nikula wrote:
> > On 01/30/2016 12:31 AM, Alexey Khoroshilov wrote:
> > > It seems clk_disable_unprepare() is missed in dw_i2c_plat_remove(),
> > > so the patch adds it.
> > >=20
> > > Found by Linux Driver Verification project (linuxtesting.org).
> > >=20
> > > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > > ---
> > > =C2=A0 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> > > =C2=A0 1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > index 438f1b4964c0..8f19b7b81fe0 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -267,6 +267,7 @@ static int dw_i2c_plat_remove(struct
> > > platform_device *pdev)
> > > =C2=A0=C2=A0	i2c_del_adapter(&dev->adapter);
> > >=20
> > > =C2=A0=C2=A0	i2c_dw_disable(dev);
> > > +	i2c_dw_plat_prepare_clk(dev, false);
> > >=20
> > I tried this quickly and it appears more work is needed. When=C2=A0
> > CONFIG_PM_SLEEP is set then autosuspending will do the unprepare and=C2=
=A0
> > this patch causes double unprepare at remove. But when
> > CONFIG_PM_SLEEP=C2=A0
> > is not set then indeed those clk calls are out of sync.
>=20
> Besides that I would suggest to check carefully error patch in the
> probe(), i.e. handling error from i2c_dw_probe(). There maybe similar
> issue is hidden.

So, waiting for V2 on this one.


--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvipHAAoJEBQN5MwUoCm2FIsQAJiezN4vJxzemg5ei447GqO0
Sz2DuXyxgZntQJdkl1MeEYX1xkC/0wjfJNoH1RYaZthXXMG95sYompIEvc4qW79w
7NMo8uv3P/90suGA8gvF3pTh1adypnDAwNlGJa7OlLupQNbJ+bruMHhtQS3ZXvC3
4QXzg1ZpOJW+y9YtDpF7GAN66snH5/T7Jis2/wMNoe4ZbrI06otxT6O0GnceOi8g
wC4wS7oReJf2UnP7yezhGFeg/MxtV3E1eoswFaMwU7PlwViX6uMFw9DzeyHOnbq3
mKcgAcWdjRYoHSwIOvYCQY8cmTIgno6U7JcAzd69DYZX9f2PgSd71s7t89ekgSqW
zQEy488Ry5hcvjQNV+1vWf7Lm9jnqubeVguVC4lSC9al22qt4DsedHRwuOKRv7C+
ofiegERwm4hAJdCwA9N46/MzSivo1Lem+8lNzkEcR0BWQhS8hX2Y5sMqrLzp3Lxu
pqWIR+PZ85D3lu7jUXWWDBcV7R7u9qCOq4+8DL6yXCtbpw8M5YN1HjmAwqtsmSgA
nBqG/IfGwGRp6TBFZOds6VSyQ9s8Y1r3UFPIXltErPBJzoV7p+hpe4KCX47pK9pS
7po2jCNjsXanjyI6BnvhuwnccZZNNs+mLPTuy/JsixuUpRfmbXjMAerQjWz5Ve3B
2RnJQIrkx/bGbgMK0F+Z
=SRBz
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
