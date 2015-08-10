From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Mon, 10 Aug 2015 08:16:21 +0200
Message-ID: <20150810061621.GA1573@katana>
References: <20150730201431.GA5255@dtor-ws>
 <20150809152255.GA2367@katana>
 <20150810055936.GB26735@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150810055936.GB26735@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I think it is a useful addition. Can someone add a paragraph describing
> > this handling on top of the new generic i2c binding docs?
> >=20
> > http://patchwork.ozlabs.org/patch/505368/
>=20
> Yes, I will.

Great, thanks!

>=20
> >=20
> > > @@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
> > >  	if (!device_can_wakeup(&client->dev))
> > >  		device_init_wakeup(&client->dev,
> > >  					client->flags & I2C_CLIENT_WAKE);
> >=20
> > I was about to ask if we couldn't combine this and the later if-blocks
> > with an if-else combination. But now I stumble over the above block in
> > general: If the device cannot cause wake ups, then we might initialize
> > it as a wakeup-device depending on client->flags??
>=20
> I believe it is done so that we do not try to re-add wakeup source after
> unbinding/rebinding the device. With my patch we clearing wakeup flag on
> unbind, so it is OK, but there is still error path where we might want
> to reset the wakeup flag as well.

I was wondering if it wants to achieve that, why does it not
unconditionally use 0 instead of the WAKE flag.


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyEG1AAoJEBQN5MwUoCm2vdYQAKiS9KQ3zRS2tK6KOHiFZ/Qv
gs8rE4gmm5qqZA4h62k6iBGiPvBOU3vVlgQCcOENTzcAwPohGQ1XccXZhYLDRFli
dvnmkyKOjwJiAFuBveXE3vRuilYRD95Ip66UY1szmxtlw5WkvvUvM3A3fWwS52NT
yZBe5elWcxPAlYM1cN2Xx0PT1PuYmK4VLLFs9iTbSOITyvjFjEgCrm9hrox9NHBB
m19jea1F3mLDT4XRN8Qr8tH06v1LvClBnbFX04Jg4ceTiiO9+MinHQ2QxvvLl8au
ckOCW8fn8i224eIU1nCx9tLEfvMOBks5wcbnVZSENpt2BYHiXFaoiy5sBlOqbhR4
uKTnmK7eHS0YyyIFuSTv8XJnGf7ies8K3uPQz52x1Rkm8DcJ0k3bD9OQWEppzOHz
rGRz4tAkCYSiqk7m2+d42Rzd8RRZvs+9NbHyLMUDj2jpxKbQ+ArOLJSYH33EddE9
2yKDRBEaAIPQSczQHqhwho1+BtdEs1RWKnzGdPN3/X9OkOaRNjRfb+2F+p2Cj5yQ
zF3Lq5I+KLX8AeedDifpcs2mft3tCPAlkjeThEwz1IBedcClexd5e0RGoeFmBpWB
6BLbcuY2NJhABafQWzdKGhh4L4eFDi7QTJZ+cFcRUnpOA1/yAzFy/lN5vuae/qhD
0nl52kFddo2/NXWxD3UJ
=axF3
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
