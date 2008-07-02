From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] New-style EEPROM driver using
	device_ids	(superseding the old eeprom driver)
Date: Wed, 2 Jul 2008 16:57:05 +0200
Message-ID: <20080702145705.GD4253@pengutronix.de>
References: <20080701172050.16801.66380.stgit@octopus.labnet.pengutronix.de>
	<20080702163004.722059ea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1973390553493609999=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080702163004.722059ea-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============1973390553493609999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2008 at 04:30:04PM +0200, Jean Delvare wrote:

> Great. The code looks very nice now, I think it's ready for merge.
Hooray! \o/

> > +/*
> > + * Specs often allow 5 msec for a page write, sometimes 20 msec;
> > + * it's important to recover from write timeouts.
> > + */
> > +static unsigned write_timeout =3D 25;
> > +module_param(write_timeout, uint, 0);
>=20
> No longer changeable at run-time? I don't mind, but I'm curious why you
> changed it.

Sorry, forgot to document it. When wearing my paranoia-hat, I wondered
what happened if you start writing to an EEPROM with a sufficent value
and change it to an insufficent one while still writing to it. You will
most probably end up with broken eeprom content. This is why I thought
one should better measuer a good value once, and then keep it. Measuring
can easily be done by reloading the module with a different parameter
(or hacking the source if you want to change it run-time).

> > +	{ "24c02", AT24_DEVICE_MAGIC(2048 / 8, 0) },
> > +	/* spd is a 24c02 in memory DIMMs */
> > +	{ "spd", AT24_DEVICE_MAGIC(2048 / 8,
> > +		AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
> > +	/* pcf8570 has SRAM only, write it all */
> > +	{ "pcf8570", AT24_DEVICE_MAGIC(2048 / 8, 0) },
>=20
> Now that you use page-size of 1 in all cases, this comment is a bit
> confusing. And I am curious if anyone will use this entry, given that
> its the same as "24c02", and anyone who is certain to have a PCF8570
> would provide platform data to take benefit of the lack of pages of
> this chip.
>=20
> I would at least remove the second part of the comment, and maybe even
> the entry, unless you add a new flag AT2C_FLAG_SRAM which automatically
> sets a large page size (if that makes sense) or restore the possibility
> to set the page size, just for this entry.

ACK. I'd say, delete this entry for now. I guess the 'page_size'-issue
will arise sooner or later anyhow, maybe then this entry can be
reactivated.

> > +	if (chip.flags & AT24_FLAG_TAKE8ADDR)
> > +		num_addresses =3D 8;
> > +	else
> > +		num_addresses =3D	DIV_ROUND_UP(chip.byte_len,
> > +			chip.flags & AT24_FLAG_ADDR16 ? 65536 : 256);
>=20
> Extra parentheses wouldn't hurt... I wouldn't know off the top of my
> head, which of & and ?: has greater precedence.
Okay. Seems I got used to it that ?: is really low.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIa5dBD27XaX1/VRsRApouAJ9/8FGkuS1pdxBS1I+vHtRsWK3r5QCfa10w
EG2XuN62/WmR6VvW1yue6SU=
=bMHs
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--


--===============1973390553493609999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1973390553493609999==--
