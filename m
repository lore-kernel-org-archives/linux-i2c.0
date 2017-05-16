From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix false warning from i2c_dw_clk_rate()
Date: Tue, 16 May 2017 23:29:14 +0200
Message-ID: <20170516212914.bjc77ogqbklm4udi@ninjato>
References: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
 <1494511249.6967.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bj54hdkskl6ik5in"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35978 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752266AbdEPV3Q (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 May 2017 17:29:16 -0400
Content-Disposition: inline
In-Reply-To: <1494511249.6967.11.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>


--bj54hdkskl6ik5in
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	switch (dev->master_cfg & DW_IC_CON_SPEED_MASK) {
> > +	case DW_IC_CON_SPEED_STD:
> > +		i2c_dw_set_timings_sm(dev);
> > +		break;
> > +	case DW_IC_CON_SPEED_FAST:
> > +		i2c_dw_set_timings_fm(dev);
> > +		break;
> > +	case DW_IC_CON_SPEED_HIGH:
> > +		i2c_dw_set_timings_hsm(dev);
> > +		break;
> > =C2=A0	}
>=20
> I would put same suffixes to the helper functions, i.e.
> _sm -> _std
> _fm -> _fast
> _hsm-> _high

BTW is this a bugfix? I tend to think, yes.


--bj54hdkskl6ik5in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkbbykACgkQFA3kzBSg
KbbWsQ//djAjfhK4JSQCZU8g1cUy4i2HnRkgKL707LZHSxOATbahvi0vyzFO2bFW
JHa43dPnXmi8YqbQRCfKCxoX3NntxXdasbRmo/xzc8edSAWYmlord1xYvGp/H38/
UUkJZcWiy6LiMwkuKlKYsI2v97h0z+aJIodvr9hmsuiW2fWAFrhQy5figNsvZr7o
Cy3c6ez+xivSN0iueDr5ObPNUjCs8wbmJQHvO4OdFRd7/oRi81sa6asU/N52vmbV
5D47nPdkar/91x3TalvmsAvAjWwUIFjYRYfvIw7qD0XYOQn3CowhnYXmVPPfwKPK
we9kfMie/3cnk7O/O4gNEap5lYsyJethf1F+dWxfoOTqChJojaW7WWa5NPDJRaxd
REnzn1JPMfQ1mFGcXt5sSnuWIlwd7MtYpbQMnQT3AzGdqNjNvUVnMtxRw4vyxVy7
N+Qper5PwHbjZ6LxZ/lvBXwhVXV06sx/p3rZWb54HidNtciik3v+o2WHkYScnRKO
YgpVlP2u9tk5ULKUuHExPtyjj2RXoO42kCrL7jTeYZhQXGPrJb/XIkSawEH+JH14
s4/8spjIgmo/KauSRLEbuQTa7p++dAG/hYP9C2MbsCJkqBQn6SmwbaLmQib1RbBD
b5Tf5wkLmURPB91KdUMmM5nRuPqA0CN8fT2GgLTq525iCkRHgEY=
=uEko
-----END PGP SIGNATURE-----

--bj54hdkskl6ik5in--
