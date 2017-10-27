From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: Remove a useless test in
 'i2c_imx_init_recovery_info()'
Date: Fri, 27 Oct 2017 22:08:23 +0200
Message-ID: <20171027200823.eeltypcwwyuuuvgi@ninjato>
References: <20170806234953.30682-1-christophe.jaillet@wanadoo.fr>
 <20170807063617.5wr4i7b7k72uyrit@pengutronix.de>
 <9279b880-558a-17fb-404c-98012bb0f9f1@wanadoo.fr>
 <20170808081501.jxhid5rgfeqpshfw@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t5dogecywoc46qvw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170808081501.jxhid5rgfeqpshfw@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org


--t5dogecywoc46qvw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 10:15:01AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Aug 08, 2017 at 09:40:59AM +0200, Christophe JAILLET wrote:
> > Le 07/08/2017 =C3=A0 08:36, Uwe Kleine-K=C3=B6nig a =C3=A9crit :
> > > On Mon, Aug 07, 2017 at 01:49:53AM +0200, Christophe JAILLET wrote:
> > > > 'devm_pinctrl_get()' never returns NULL, so this test can be simpli=
fied.
> > > That's wrong. If CONFIG_PINCTRL is disabled devm_pinctrl_get returns
> > > NULL. But I think this shouldn't be considered an error, so your chan=
ge
> > > is right, just the commit log is not.
> > With that said, in fact, I think that the test is correct as is.
> > If CONFIG_PINCTRL is disabled, we will display an info about a missing
> > functionality, but would still continue normally without it (i.e. return
> > PTR_ERR(NULL) =3D 0 =3D success), as stated in the comment in front of
> > 'i2c_imx_init_recovery_info':
> >     "These alternative pinmux settings can be described in the device t=
ree
> > by
> >      a separate pinctrl state "gpio". If this is missing this is not a =
big
> >      problem, the only implication is that we can't do bus recovery."
> >=20
> > So, I won't propose any v2 patch with an updated commit log.
> > Feel free to update it yourself and apply it if you don't share my anal=
ysis
> > above.
>=20
> Then the only issue (maybe?) is that the driver makes use of
> PTR_ERR(NULL) =3D=3D 0 which I'm not sure is explicitly allowed.

I'll drop this patch for now. If somebody wants this applied, please
send a V2 with the issues here addressed.


--t5dogecywoc46qvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzkjcACgkQFA3kzBSg
KbYRJxAAnJHNGenCeS+tQEvHaYULeWVCI9eHNlde/6nD3d3haKZ2hMp0yJOwoX5e
xLLxJBThW1rigjEEvWdwNsq2M8RZlmZSxcNq2upKzlOe6WXDTU6dzw0shaeHDrJM
Gy08KfOe+M8EuBzkCZwOoZU4/XpXdBMytmc2Sa4wgIJ56jyTtFOxpgOH6YGxFdzd
7bhkMppK4SS3ndJxpMm9E80xN4iY+unxGB1ArRUhnKJdSyrcSglQ5o+jEMIYyN9b
58AYghHR/ViYNx93DnRlHvJc3bG1KayM5oxp4QakOZgCAGMQ6MA+tiLR2OS/d6EQ
q5YwetKMEaAQKPHQtJEXaRAbux4Flg4ZcoBEPFae2EsRDTBaa3cpYHs4+FBSyk8v
LXldG0fjwJT0PULf2jg3QoKj7GxZ1bcMqhaJKgnzxXkNSn5fG44MVGjhNJbQUDxp
qxh4zBBCKTVTUNYKDZJNMJ6WT8Bek2IwTieQqYxLha1UlFubcpWeYHtokvri8y9G
hknjQytgaWl1rKyKTdYEJmZS3nQwXuxd6BfuL3ZlME9EDU8i7HMzItDdjxq0Wu+U
n8sRNEmkgZikd4JU18b4w7cxi09hatBQKKoDhMc1S8G3bP6Ylrxr57+16iNmu2HE
MBqE+qGzQPXWYg1vGpfSe1asL4l0CDFyIC8erByuWUd3TQAXBIQ=
=d7tW
-----END PGP SIGNATURE-----

--t5dogecywoc46qvw--
