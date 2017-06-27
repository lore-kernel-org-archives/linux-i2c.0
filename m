From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] i2c: add helpers to ease DMA handling
Date: Tue, 27 Jun 2017 23:16:10 +0200
Message-ID: <20170627211610.53oeludkm3sooo64@ninjato>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
 <20170615183039.22925-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdVe1tBMZO9weMsf2Tj7pQ_AUeVu_X=uKbs+JbziLFQHvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ym4qsbbkg5hla56o"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVe1tBMZO9weMsf2Tj7pQ_AUeVu_X=uKbs+JbziLFQHvQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--ym4qsbbkg5hla56o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > +static inline int i2c_check_msg_for_dma(struct i2c_msg *msg, unsigned =
int threshold,
> > +                                       u8 **ptr_for_bounce_buf)
>=20
> __must_check?

Yes, why not.

> Isn't this function a bit large to be inlined?

That can be argued, yes. But I am unsure to bloat the core if the
function is so rarely needed...

> > +static inline void i2c_release_bounce_buf(struct i2c_msg *msg, u8 *bou=
nce_buf)
>=20
> This one is smaller.

Yup, but of course, they should be put in the same place, whereever that ma=
y be.

Thanks,

   Wolfram


--ym4qsbbkg5hla56o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSyxYACgkQFA3kzBSg
KbaI/RAAhYMryJ5CJlQe5g7lZOqiAqyQS7AE22HMQpW/J5g/rmIUy8GxwjWJa9lQ
BMm2R30/6fzQrNp7ic4jNKP5Ny2ELwpDau0INNJ0RBbcHEbgfBIL4SD3rjGL6dn4
BzX6CgvG1K7RW2XhX57RT0LFaXxHKIcjzzYut6HSSGnyUIM69jjFDxxJ5RliwKbv
gF28dcvHeeyGI5hV2xl5FmqXOAzu5Yc25/b/dA6j6baQcT+AsqCCg91Zw/73nv2y
EfEMcwwLqc2IdQVWdO717nO4mNtX4hU4I7dmRLUq8PhblyvV1R96b3HKcXE52iT+
0nnUZUzvP7n4q4Qc/yEIGkM2bCZcl07IDwn/bQ8kszjoaMnbGdEVxQzyoKIj+mdw
uEz9Vl7dn30vUL+IrNdwQ3lg1UWEFUYrM0GYMHjJ7qh+tG0VuPJvNriOtfIA0zGo
GTSuoQPSm/DvTkvwWUV2sva7hutkh6vTd6iwN2t7QW7dpxA91AlZq4hTzoesOk+b
uVVEnpgGoQX16qAHNwKAgb6S1+ls0u9kkPr53Opq4hXwYXjPlGrOPH+NurmYaujk
fW11Lx5sKTlardzCVf1zA3vwnux+f/cggHUae7QpVaTm7SFUkL14TKAQzwaqJB1/
A0nftuHPSNFdSCx3VSAR8s9Ag5J1FmbM53ZK+sbEPlzZtztxn9I=
=r09Y
-----END PGP SIGNATURE-----

--ym4qsbbkg5hla56o--
