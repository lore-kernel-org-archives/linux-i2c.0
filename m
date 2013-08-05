From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Mon, 5 Aug 2013 12:02:26 +0200
Message-ID: <20130805100225.GA9694@katana>
References: <20130711073600.GG4898@intel.com>
 <20130711101330.GP4898@intel.com>
 <51DFB6C1.4040001@pobox.com>
 <20130712085140.GY4898@intel.com>
 <51E0E76B.1040304@pobox.com>
 <20130716111616.GA25835@ab42.lan>
 <51E6ACBE.7000509@pobox.com>
 <20130722131706.GA24081@ab42.lan>
 <51EFE550.1000507@pobox.com>
 <20130805093126.GE20936@ab42.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130805093126.GE20936-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >Would it make sense to add generic I2C device tree properties for those
> > >parameters? These parameters are independent of the actual bus driver,
> > >rather a PCB property... And as such the correct place would be device
> > >tree or ACPI or similar.
> >=20
> > If there are other bus drivers that make use of tr/tf transition
> > times, I think it makes sense.
>=20
> Wolfram, what's your opinion on this?

If it is a PCB property, it makes sense to have generic bindings for
it. Can they have very-safe defaults and thus be optional?


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR/3gxAAoJEBQN5MwUoCm2kKgP/2DdjnYoBtaKUBiX1V9vl9ht
kxWfLqQ6/jcP9PAZZFh/sPt1wNzPdmzxVKI3Hsk/+CSvXpp30MYrmdfe2DmSiH0m
d9ObcAgQ/yGfLvw4NfYBlpWDOaGQ/cGhu0Oli/QEt5Etmi2qxWyVBMgkYntm3L9r
08DCpLXt1YizeFEUy29jgNYj9wvYVSLit0r8c7QvEDZ12DcqK0IItbbwu9Jv4iif
Q1byVnwm6hCoBPzehxXS0+crmr9/zsYpJCSk2q7E8lTA+JVmSx6Q4MMQA22EnxFT
SMTQYZ5TOHXV5LGEgKAO4Grk3HWy49gZ6n2iiZiq+Rn8LkJd2RJSYInHCxWotiHo
Ee9RNwWMEk+c4Rvg3f3wekaDZyag64K9i/sowy9hmLlL2Fmf06TroVdcG36zMpiU
OIrnrGFoJ6FNI6bNQKeQ8xJNZFroiGif8TnIyIFPklVTI7onNTur47dP3HVfEyJ9
Z7qNubR6T9jNjKz6UUqvt0uHkFhbLheKd1AWBPZjTfN17cgWYtGYOT310V3/tVk3
Dkm46E8g7qbuQ1ThHNNeWXhiYmxBu3KwDmGTBD86bNCUG3j1X/YF0DVrWV4RNw+I
VdOLHbrElQthcSQBPJkxLXyPldW6FV0JD7l+UO7Cc8gme9fBiOUjJFel5hGvhiWa
ihNywMA6U8WVcf/s6coE
=Nyxg
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
