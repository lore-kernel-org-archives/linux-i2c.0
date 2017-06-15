From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] i2c: rcar: check for DMA-capable buffers
Date: Thu, 15 Jun 2017 21:17:43 +0200
Message-ID: <20170615191743.xdrvigy4h2gqk2kk@ninjato>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
 <20170615183039.22925-5-wsa+renesas@sang-engineering.com>
 <CAKocOONjafedew70jMnV9HfNru6mhQV6FXAkoHTL3wzght7+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4l7glm5z5wyky46"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKocOONjafedew70jMnV9HfNru6mhQV6FXAkoHTL3wzght7+Ww@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Shuah Khan <shuahkhan@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuah@kernel.org
List-Id: linux-i2c@vger.kernel.org


--p4l7glm5z5wyky46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > -       /* Do not use DMA if it's not available or for messages < 8 byt=
es */
> > -       if (IS_ERR(chan) || msg->len < 8)
> > +       if (IS_ERR(chan) || msg->len < RCAR_DMA_THRESHOLD || priv->flag=
s & ID_P_NODMA)
>=20
> Might be more efficient to check for ID_P_NODMA first instead of msg->len.

I think most of the I2C transfers are smaller (like reading/writing one
register) than the threshold, so this "should" be more efficient. Plus,
honestly, I also think this is a micro-optimization which is largely
depending on the use-case. Can we agree on that?

> > -       read =3D msg->flags & I2C_M_RD;
> > +       /* we need to check here because we need the 'current' context =
*/
> > +       if (i2c_check_msg_for_dma(msg, RCAR_DMA_THRESHOLD, NULL) =3D=3D=
 -EFAULT) {
> > +               dev_dbg(dev, "skipping DMA for this whole transfer\n");
>=20
> Adding reason for skipping will be helpful.

The I2C core helper will immediately print before that the buffer is not
DMA capable. Do you think this together will do?

Thanks for your input,

   Wolfram


--p4l7glm5z5wyky46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllC3VMACgkQFA3kzBSg
KbafYhAAmyoo5P2skceqIrlpA8m+aTMIdtM2WpN3UXqE0RSAeIWyfz15gD9rUFCR
Zv+coqU5Qmuj3sP1XbYcdOjog1npbvrlpvG3qMKKB//T5MJXQCXw0sLBCOCuSOxb
vKtNQznS+dDcd20RkFmwxAHOcBrsZMNo/osWG9+mF7BC8yxbaYA8CHWm1aRmqaaX
nhqWl88FAHuN7wqeSULqxMPJyH2sUrd1XmY1Y1NCM2r/uhLXdlnLST3bWs/B1O/U
ZvqYAgSczZYsX+b9U9gApmxUoHaKf0HT6SHBUwBubZ0TI2oxMVWsdCkQz4rlgii+
oKwwjnwsw/9s6kdf1uLhbqgkWKJgwnMmPbD7fOnB+Sx4uIRqcQ89XWtKWipfanwQ
+pDCNWmbEPD/FXQLIgcTHI2JQ3+wOBO1wlTaLkhme6pqR8aQcI5AnK/aLMp3zWlC
ZxESuwO/GNYrtMUXxd3CwYm9s7V8ch6jw8h5YKcKVRxdjsqQ4EOYeMIIpY/qjl9S
GlmJQkfANEcgIe5ffkaDama+/VplM/lCCbh4eT3sVkRW2EvY7k3fC+xZwl4yCtPS
r8rT8GdCqU+//4fRwKrPFAwbMN5BEF9sLngIJL0BFk7/qzTSg85tvmWRo6Bhg0Ig
OW3RE96P9l6lZaFqwPH8st7k3ymKy6WsnaPxmNF4HENxNeLjn1A=
=NLO4
-----END PGP SIGNATURE-----

--p4l7glm5z5wyky46--
