From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C slave support
Date: Mon, 26 Jan 2015 17:30:13 +0100
Message-ID: <20150126163013.GE13494@katana>
References: <20150124210825.521bf923@endymion.delvare>
 <20150126113329.GB1052@katana>
 <20150126171745.3d6d0fec@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150126171745.3d6d0fec-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Own module: Again, undecided. On the one hand it makes for a nice
> > encapsulation, on the other hand there is overhead for having another
> > module. I am very happy that the core code for slave support is so slim.
>=20
> I gave a try to the separate module approach and I have to agree that
> it seems overkill given the small amount of code.

OK, thanks for trying!

> Something like this?

Yes, pretty much what I had in mind. One issue, though:

> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
>  enum i2c_slave_event {
>  	I2C_SLAVE_REQ_READ_START,
>  	I2C_SLAVE_REQ_READ_END,
> @@ -263,6 +266,7 @@ static inline int i2c_slave_event(struct
>  {
>  	return client->slave_cb(client, event, val);
>  }
> +#endif

This should fail because bus drivers need those enums for their slave
backend. Try building i2c-sh_mobile which builds with an x86 toolchain
as well.

* Either we leave this included, so bus drivers don't need any ifdeffery

or

* we mandate that bus drivers also use the ifedeffery. Then, we could
  also mask out the (un)reg_slave callbacks in struct i2c_adapter

What do you think?


--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxmuVAAoJEBQN5MwUoCm2kzsP/0B40uJmnvbvnHqELP3WC9e1
xYMqoE3i/DtdZcVDVWh0LNeZbdPa7MvG5i3UxStg2ICDv9sFpBmQj6Ju3xaN8pOn
161k3bxjDTQ3wicpIia4knnH44WhdWtOZujRZWu8rikahvXrvl5ZX6rVLgpXwGCW
rPqAx9kqEqGOmwJzZyWTxx+YN6v6qD4V8NrZt+Tc0oXXRwchrxskxJzcoFGREGXF
o9dPwJ7o8M+IObetIroyP+FMxWiobvnVdLILU/qQ+4i5dLWrm5n7ol8sfxb0XZmZ
BgQh5pvMTT7hY5ND99UeY8fUd4ayKhq64y7V5EtEGFj3AdsQ2AutSo4l8S4YzSOd
QzL7DvcHWGpt04vYEfGP+nmlpxjh27Qm8Kp82rgFQB0noUlfa+8uPKwzFT1QaBkR
o9dPDCjva+ULYlmeuYBtdM0HA3E8FhwDBex+559m29ePBGxYnic7hKfg8FMvjSUU
Mm69IvloBMBJ/AT0uyKBG9MMs5QJW3xrOgIqM0EVe5N6d0a6c/YuAw8k+Ta9Wz2i
655pomtZ2iKtPTrtnnauIPJARhmGKIIDo7Tou5VJ7HedUC43DtLeQp1dvwVthmXt
PoktIbJ/qzOdcQI3Rwa3ub1TlvAZhv/zTM4JVibVAwsreY3Iq9pvg9NworjoV95M
G2pr0PT5luNAMlZSPo/p
=fR9h
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
