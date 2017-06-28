From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/5] i2c: pca-platform: add devicetree awareness
Date: Wed, 28 Jun 2017 11:42:51 +0200
Message-ID: <20170628094251.vm3c36pto7p777i2@ninjato>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
 <CAHp75VeFUZzj00i9oSSanudPVzd61XFRkQ9Uz72r05EqdHNdxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsazays6jxegmgln"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55897 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdF1Jmx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Jun 2017 05:42:53 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VeFUZzj00i9oSSanudPVzd61XFRkQ9Uz72r05EqdHNdxg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--zsazays6jxegmgln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >         /* If irq is 0, we do polling. */
> > +       if (irq < 0)
> > +               irq =3D 0;
>=20
> This does not belong to what is written in commit message. Looks like
> a separate fix.

True, this needs explanation.

> > +               of_property_read_u32_index(np, "clock-frequency", 0,
> > +                                          &i2c->algo_data.i2c_clock);
>=20
> And what prevents you to use device_property_read_*() here and get rid
> of OFstuff?

device_* functions are not super much known yet. Even I tend to forget
them occasionally like here. We can fix it incrementally, too. But I
agree, it would be nice to have it right from the beginning.


--zsazays6jxegmgln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTehsACgkQFA3kzBSg
KbZUBg//VghO67PrS6khSDya6IvKsMWkERcv+QD2xk3i94rGhi0dnUNa+vqDMWBe
RQZ+C/qBGXWSFoQrLRNlcxlHir5XJbQezWq/V71P3c/EylhwBMxNfNQtdZjlLcAo
BX7oJSNoNm0KJobvrlVTLGHgE0kfyhy7AwhetZE7BJTLtE5NMQeg2h5RCWCTkkwp
YtW8eLMuOY3GQ2q04dBg+DS7bw2zYUViq+wj+ft1j8N9tEgifB7wRSYXx9OIfc10
r3Y3q2WkPzgJ9TqbySoSyYuyDh8tM0VFMZgIGeI6dUwUjeSoa5ypQnFFUaxEi55z
hyzeLKc5bdYJg4KgBVQMBgXMshMYL6VHKkKDMMU95JS5QdjzIOMvSfNG98CTBlVk
XQYAOgy4VUoEy3HE2JpJW7u+Ppg56aaSAvSEU6BPAkHv9pCZVgyW9hygX1UTUGiJ
QbpQVrhKJcdoSDxzNZDJafPPYHZcqnu2gf4N0iuiE0DjiwjljwNEcH48uG3CIUW6
/hann+HG7eS4LVRWuuZ91hfZgHuXaBjTJMJxGpWcajIXVHm69DJXGEgzL3B1JxrS
8hr8s7PUxXA1mWjrNzq55EBbGrQB2nt8cMTcEKrK2RezOqD0jknFLW5rhru1cAsI
hStpTKj94BHv8oEEEDDj0WVL2sQKVBWMTtEE4Av9xC7QmRWFPJY=
=9WW5
-----END PGP SIGNATURE-----

--zsazays6jxegmgln--
