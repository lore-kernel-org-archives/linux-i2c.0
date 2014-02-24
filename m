From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: factor platform data into state
 container
Date: Mon, 24 Feb 2014 10:13:42 +0100
Message-ID: <20140224091311.GB2617@katana>
References: <1391423246-32410-1-git-send-email-linus.walleij@linaro.org>
 <20140218183539.GE18768@katana>
 <CACRpkdZULnOmRL7Qv-3Y_R4Cxo1A3CtgUBLmUKjsaehEZHur2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZULnOmRL7Qv-3Y_R4Cxo1A3CtgUBLmUKjsaehEZHur2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 09:57:05AM +0100, Linus Walleij wrote:
> On Tue, Feb 18, 2014 at 7:35 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>=20
> >> -     of_property_read_u32(np, "clock-frequency", &pdata->clk_freq);
> >> +     /* Default to 400 kHz if no frequency is given in the node */
> >> +     if (of_property_read_u32(np, "clock-frequency", &nmk->clk_freq))
> >> +             nmk->clk_freq =3D 400000;
> >
> > I can't really recommend this. 100kHz is something all devices support,
> > but, although common, 400 kHz is already an extension of the standard.
> >
> > Let me know if I should fix this up for you.
>=20
> I think this is done like this because all devices on all Nomadik variants
> out there (Nomadik, Ux500) support 400kHz.
>=20
> Buit change it if you prefer, nothing will break, it will just get slower=
 :-)

OK, then I'll change it. There is this idea of parsing "clock-frequency" in
the core somewhen and if so, 100kHz would be the default, for sure.

> I can easily fix that up ipso facto by modifying the device trees to
> state 400kHz for them.

Then lets do it this way.

Thanks!


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTCw0mAAoJEBQN5MwUoCm2Gs0QAKlNATO37KtgF5VxDEZwGY9e
59ZFn2nTu7BK1TvRNpzCmyKYtt32N/RMHzpUBKb8OAN0lGkrWX7D8F6tLRh7QVX8
JokoaBFIDwP+PAN+oiqRZuLcRZicKRBLshLnGgGEM1LzXIpWVK8gr4ja99SD4/rN
DH3hUolBuajZz8+gPAFGENr6LRmpjB6A7Y835QNquAjyiD7ZZgPlh63CPVzdz0G4
0ITOtRSsO2V+N6ChcSnvqzPg1RRr5e1Fd4IbUEaoOyqqrCmeikD6k8CJUycxjhFw
uqDDgN8OwkNqzumuYwmHQNuAFXZ/v1AlKuvnSe3egMKPTMLWWnnfc0jX1+AmhkZU
qKL3e0n4CIFzrIdjm2hvXcDem26J56ZGPUPE9ZvUcyPSkxwTK2vH8HhYIzGZk6y+
z2pqv832quEBLkJtOdOrZURo627+G+dpCbE5XHnu9GGeL7ak7SUApu3w4rugnibs
1lsqEYqRkCYQpnxQQrYwkCYftmTP1ZJ0tChYpjhujLEfSZW/oDt6kXo67q69B4RT
+jRX3gk2t5ppZm+uCOl65Wab0V+Od+d3BpWYm2qiXNX+s/Gy8sdGTw/TVb7oV2ie
bluksKemb+YUCl/f+lRMRSvXEnATDZL2t97Utc/Yiu/HKkpjBoLJfSe8IX/x08JM
ZyTEm3cQkBfG8opAQISU
=JcXk
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
