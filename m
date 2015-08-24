From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Mon, 24 Aug 2015 14:33:52 +0200
Message-ID: <20150824123352.GE3608@katana>
References: <20150730201431.GA5255@dtor-ws>
 <20150809152255.GA2367@katana>
 <20150810055936.GB26735@dtor-ws>
 <20150810061621.GA1573@katana>
 <20150819174347.GA2112@katana>
 <CAKdAkRRCLtRjDVysd9GQ-uJfbqDZ78hEMPkGuZbnXrQ0x+ACHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRRCLtRjDVysd9GQ-uJfbqDZ78hEMPkGuZbnXrQ0x+ACHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > When reviewing V2, I wasn't comfortable with just guessing what the old
> > code means. So, I did some digging and found:
> >
> > https://lkml.org/lkml/2008/8/10/204
> >
> > Quoting the interesting paragraph from David Brownell:
> >
> > =3D=3D=3D
> >
> > Better would be to preserve any existing settings:
> >
> >         if (!device_can_wakeup(&client->dev))
> >                 device_init_wakeup(...)
> > That way the userspace policy setting is preserved unless the
> > device itself gets removed ... instead of being clobbered by
> > the simple act of (re)probing a driver.
> >
> >> > +   device_init_wakeup(&client->dev, client->flags &
> >> > I2C_CLIENT_WAKE);
> >
> > =3D=3D=3D
> >
> > I have to admit that I am not familiar with device wakeup handling and
> > especially its userspace policies. Can you double check that your V2
> > meets the above intention?
>=20
> No it does not; it explicitly resets the wakeup flag. Note that the
> original code was not quite right in that regard either: it would
> preserve wakeup flag set by userspace upon driver rebinding; but it
> would re-arm the wakeup flag if it was disabled by userspace.
>=20
> I believe that resetting the flag upon re-binding the driver is proper
> behavior as the driver is responsible for setting up and handling
> wakeups.

Okay, that meets my idea of how this should work. I rephrased the above
paragraph slightly and added it to the commit message of V2.

Thanks,

   Wolfram


--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2w8wAAoJEBQN5MwUoCm25/AP/2Pb8gedVWT0rZg3ZXzKupvv
JeYg6pwIJx/4FCInF0D0FbHIF2jdRkGQWrIrxRzyrQ04U0vBY1wS4CBCqBU+9aUJ
syldEJe9w1yqomU9PeSpHfPWjAeLJUDcJmEcR3FacaG5kT8lKVE2b7XQh5SNBR/G
OxmkSAc3gvSoixPIc8fYmdntrGRG6HG23FrOi6Wo0fNLE28fjLP4wRb9akNoDoJA
NGK1/bUx+PVZtj+CAENzgwOcfujXO9GEGdjJlcoWeCyng4WzFYlZjGYfF9MlpBzx
nIdBJqwDClHvghZFFilThcA6IVb+35YY8VSsWm2UchgoadHhjqITrggA+3ISW056
amw+44m/8woSu5ODpDxCr12BzKfIowfKFAUEZKvLvqtVc/IhEYIJK7JjiH6+jOmf
xpUNvPLqnE70D4rurbG1s9ibQxaTqUoqCt6s3BX6t+46hCf4ghs89NS3yWyQC7GB
F9mZLxzurkcXGMPrF6nnoAyHDO+OJ4oStSWn1SqkMoAf5g5KrPkUihA8vmCP1NF/
/ZU3dwUfVeClcb8HG175selJFR9RZE99IQy3i2eK4ZRCSRpcsMwCxYSQvIYAfAQC
BYRkiEEgtMt9abZGihldchOCh/bamdq9u+5buJmJssY/flOA3PlRGLYhun9jNLu2
Vj6Ue6b860exwrBOoJN+
=eG9U
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
