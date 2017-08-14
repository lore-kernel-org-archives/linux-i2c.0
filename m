From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
Date: Mon, 14 Aug 2017 21:47:13 +0200
Message-ID: <20170814194713.c6ojqcbi2iluayau@ninjato>
References: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
 <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
 <20170812144411.zqgbncsemzaolldv@ninjato>
 <1502674616.930.74.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pglexgzmdx5j52xk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502674616.930.74.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--pglexgzmdx5j52xk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 09:36:56AM +0800, Jun Gao wrote:
> On Sat, 2017-08-12 at 16:44 +0200, Wolfram Sang wrote:
> > > +static const struct i2c_adapter_quirks mt7622_i2c_quirks =3D {
> > > +	.max_num_msgs =3D 255,
> > > +	.max_write_len =3D 65535,
> > > +	.max_read_len =3D 65535,
> > > +	.max_comb_1st_msg_len =3D 65535,
> > > +	.max_comb_2nd_msg_len =3D 65535,
> > > +};
> >=20
> > That looks like no quirks? Then just leave the quirks pointer below
> > empty.
> >=20
> Compare to MT8173 i2c controller, MT7622 limits message numbers to 255.

I see. But you can safely drop all the length settings. The i2c core has
this comment in quirk handling:

/* Check if val is exceeding the quirk IFF quirk is non 0 */

IFF means "if and only if".


--pglexgzmdx5j52xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR/kEACgkQFA3kzBSg
Kbbj5Q//fQDCE7Au3G8Agh/MrXOjv7xt2g8VnVxGTBz6hRC3wkRjVFhEL1VdhRaa
jtAfNw5WImXlMAgCK48eWnP3kUi+KEEoFXF/eyevwLX6yhviZEvFHZNtPlH6EjZx
k+RfmC51eYiC4/T+ebynW7xZJH4oeMwx8kqXkWyTMzC87RNn8l0TnGcSErwoXzRh
ddAwKI/2yBn9WyxJW0Ab8nu7/NFZQi6MS00UgSUeN3+/jia5FwHOKHWTgcfiG6Sy
0FkKGG4/+/A09Y1lNIU0fIowflX4T6onTwxs4EgUoF6uMS1q94zKcZZpuMeN7m6L
WjAk1CpyloV0EuqBUt2NxVNhhaEzgDu29JNuTegTBmfJVPrmzlH54dEfRccurL2G
v3xQgxOmRWYPiPq3gHm31NHXp8svL7J6nHtz8aRJGL1MIHA47icRbVXFiTibE5Wg
I4nhYCR1+4Q/m4pYtPGz+7PPc722hguIogHrS05IFeb0tIvuZN+X+2eTjLbqjg4e
tzIMIkAO52y5TYUsIjI9LViQJrZ8ARA0ftzW+DbbhWf8q615YmIzZLGUBO8HIRjQ
JykHVgsthDGAOTrxXP1fl7M0qJqRiI98kylmxaeLJkbLLr9/brW9+RGrd6FmppIF
WkDuGHnQjexTP9ayRLyJpDhb1oziXwtyMZ3lCqob5n4UgDWTIuY=
=I9R4
-----END PGP SIGNATURE-----

--pglexgzmdx5j52xk--
