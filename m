From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v4 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Mon, 28 Aug 2017 17:13:06 +0200
Message-ID: <20170828151306.GA10688@katana>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <acbfda522aa806284b86f8935278cc7f7133e876.1500021046.git.baolin.wang@spreadtrum.com>
 <20170827153054.ijqxbjk25zpskojl@ninjato>
 <CAMz4ku+MJ49-Orp4mGL=jW0bfnko5o9fZgAjpZKqAMVUiw-o4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+MJ49-Orp4mGL=jW0bfnko5o9fZgAjpZKqAMVUiw-o4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@spreadtrum.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> +     /*
> >> +      * If we did not get one ACK from slave when writing data, we sh=
ould
> >> +      * dump all registers to check I2C status.
> >
> > Why? I would say no. NACK from a slave can always happen, e.g. when an
> > EEPROM is busy erasing a page.
>=20
> For our I2C controller databook, if the master did not get one ACK
> from slave when writing data to salve, we should send one STOP signal
> to abort this data transfer or generate one repeated START signal to
> start one new data transfer cycle. Considering our I2C usage

Yes, so far so good.

> scenarios, we should dump registers to analyze I2C status and notify
> to user to re-start new data transfer.

I disagree here. You notify the users by returning -EIO. The upper layer
(e.g. the i2c client driver) will handle it, like the EEPROM driver
might retry after a while. This all is expected behaviour, so no need to
print the registers to the logfile.

If you really, really want to keep it, make it debug output. But I think
the sentence "we should dump all registers" needs to be rephrased.

> As I explained before, in our Spreadtrum platform, our regulator
> driver will depend on I2C driver and the regulator driver uses
> subsys_initcall() level to initialize. Moreover some other drivers
> like GPU, they will depend on regulator to set voltage and they also
> need initialization much earlier.
>=20
> Since it is arch_initcall() level, Andy suggested I should get rid of
> tristate (use bool) and drop module.h here and all leftovers like
> MODULE_*() calls including module_exit().

I see. So the driver is really so essential for proper bootup that it is
not even allowed to be unloaded. I might make an exception here and
allow arch_initcall() then. But I do wonder: did you try deferred
probing all over the place?


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmkMv4ACgkQFA3kzBSg
KbYoDxAAkDn/t1M/0oACkmTaiBL49b9FxkEsRGAT1KzO3FX/XMolsfhfaT9lfkCs
LvL0TGzUIc5zjTpkI1UGH4KG3vtUFsXPFU7vL37y4aWHnHdog6KKgI87JHN/mB+q
ezCowPxj9ODbgB4VzefvTx6742a2mdcQM/W6m59VXgCLPAiy7RLU+JeLTAWnmhE1
uhhKafY19IOfaKSTWOx08YeIJWKUse3Ce2YAWP1qQq9qf/UnwHAesJuB6SxVQkPT
Tual0b0btGgnotrb9nsZipbJH6A+oiH8TXNZwMq5ORm9Kx7XZwknkwsahvZ87Jmj
S7ynh/fqex8ArHIDLOyeXJsFGXrB5qUs0OxzlCDDv/Ev27xNQN1K8p+IwyH5Nx0S
qts7yTN49MxP5rMHKR3qZRuc/vE8r1O0NfeQ5r6LMvGfgVqtYKu2mbJZYcqTHFMi
XFseg7hGoukCf0juwuss8Kk4gbJVioDeMfEc6mD3Hh0GLisXfAkwO0Dv8Ag3lOuP
uqIx371hiR4XtkgdkN34Ws3kEbXMiFstZsIfDnTtSjBxlNbgkQ2rgl2CFW5K0sYC
0f0bSJW3qPYU7vl3wiWYypOevcDwqJZ0PV1zHCuJ2uhbSzrzKoJZ1Xe0POImKaG9
8/rWM3L+hMFglH5SMpo8cruBDsyWEeFmZweGZ5BNz+0dSPPPCi8=
=RICq
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
