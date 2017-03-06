From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [i2c-tools PATCH v2] i2ctransfer: add new tool
Date: Mon, 6 Mar 2017 18:26:29 +0100
Message-ID: <20170306172628.GB2086@katana>
References: <20170306142931.10457-1-wsa@the-dreams.de>
 <CAMuHMdUO2-BCfdRUXghhZS7V=FoXNytesn8asCWH8nnpsnBxow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUO2-BCfdRUXghhZS7V=FoXNytesn8asCWH8nnpsnBxow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
List-Id: linux-i2c@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > This tool allows to construct and concat multiple I2C messages into one
> > single transfer. Its aim is to test I2C master controllers, and so there
> > is no SMBus fallback.
>=20
> Thanks for the tool!

Very welcome :)

>=20
> > I've been missing such a tool a number of times now, so I finally got
> > paround to writing it myself. As with all I2C tools, it can be dangerou=
s,
>=20
> around
>=20
> Very dangerous, it inserts spurious "p" characters ;-)

Yeah, but only if you write the tool. Everyone else is safe :D

> > +A transfer may consist of multiple messages and is started with a STAR=
T condition and ends with a STOP condition as described in the I2C specific=
ation.
>=20
> Funny, this is the other way around than on SPI (an SPI message consists
> of multiple transfers).

In deed, nice to know.

> > +It is parsed as an unsigned 16 bit integer, but note that the Linux mi=
ght apply an additional upper limit (8192 as of v4.10).
>=20
> s/the Linux/Linux/ (or the kernel, or i2c driver?)

Missing "Kernel". Will fix.

> > +Normally, addresses outside the range of 0x03-0x77 and addresses with =
a kernel driver attached to them will be blocked.
>=20
> So 10-bit adressing needs -f?

Not supported, will add this info to the man-page.

> > +static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned fla=
gs)
>=20
> unsigned int nmsgs?

No... 1)

>=20
> > +{
> > +       FILE *output =3D flags & PRINT_STDERR ? stderr : stdout;
> > +       unsigned i;
> > +       __u16 j;
>=20
> unsigned int, too?

No... 1)

> > +static int confirm(const char *filename, struct i2c_msg *msgs, __u32 n=
msgs)
>=20
> unsigned int nmsgs?

No... 1)

>=20
> > +{
> > +       fprintf(stderr, "WARNING! This program can confuse your I2C bus=
, cause data loss and worse!\n");
> > +       fprintf(stderr, "I will send the following messages to device f=
ile %s:\n", filename);
> > +       print_msgs(msgs, nmsgs, PRINT_STDERR | PRINT_HEADER | PRINT_WRI=
TE_BUF);
> > +
> > +       fprintf(stderr, "Continue? [y/N] ");
> > +       fflush(stderr);
> > +       if (!user_ack(0)) {
> > +               fprintf(stderr, "Aborting on user request.\n");
> > +               return 0;
> > +       }
> > +
> > +       return 1;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       char filename[20];
> > +       int i2cbus, address =3D -1, file, arg_idx =3D 1, nmsgs =3D 0, n=
msgs_sent, i;
>=20
> unsigned int i?

No... 2)

>=20
> > +       while (arg_idx < argc) {
> > +               char *arg_ptr =3D argv[arg_idx];
> > +               unsigned long len, raw_data;
> > +               __u16 flags;
>=20
> unsigned int flags?

No... 1)

1) I prefer to keep the type of the data source, i.e. where the value is
   copied from
2) i is always int for me

Thanks for the comments,

   Wolfram

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYvZvEAAoJEBQN5MwUoCm2E5gP/1ye+NoU1pVBZyJyXKzGvtm7
9Lmpj69bDfrYag/sqZiLSuutajiKda17w+iTVslj8e6zlw8XtefcUfC1Qw4/qzuq
JLtA4IUMkwsLS5YD+fsE2mxXF/XZfsg9J+BBQvKgipnMbZd3osbtf128rpuOCMFv
bLW/qx3wtYIoJJhk327/MlS7SVOH7CMVeO0OqNgTalSDHp77bJypDxSuYcXq2Zvs
UeRsfT8oudgMzGVDPQSxB5uA88q4CIkmhoCv4zmGJOI2cd0HoqKv2ydS6CmOCmXQ
rXqdxb3FLC3xZnYbmgfQKx1Qrj1ifhDqObagJxMYq+qJG5nnyXnNZFaFIzirAnzQ
PTi19AsI6dyF/UC/mGdPZHxje089zIWkv0kft8MGt62gHjnte4mpcpxqJL8jklOr
UMsRa2ZFZocSmHp2ZNRpkq7zozWZ2fcVX90bFTG2N9lA+Tg+NUX2gfhpKHHOLNNz
AbNb6GKkc9vOr5hfQKKsrXqpzoNXoEFcPX/jKVqC8W4bW1YMOOoZxMn8lJ44haFz
aqzXSMSbI23czbBNdfxnajDWYluACrqsIvrjfg1N3hg4pbTsSoCL/QC7ZUjTEwEK
UzxEHeARBAjdyM63AeFMIJgUpHl1g/H+U900HskcEEHnt/NWqWbrTbSkAQL3F5bU
0wn5BuZbgwYk47VmfOK3
=Si29
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
