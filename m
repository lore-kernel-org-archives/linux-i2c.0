From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Mon, 29 Sep 2014 23:24:50 +0200
Message-ID: <20140929212449.GC2758@katana>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140922091207.GJ1786-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 12:12:07PM +0300, Mika Westerberg wrote:
> On Sat, Sep 20, 2014 at 11:36:34AM +0200, Wolfram Sang wrote:
> > On Thu, Sep 18, 2014 at 12:26:07PM +0300, Mika Westerberg wrote:
> > > From: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >=20
> > > Add support for AMD version of the DW I2C host controller. The device=
 is
> > > enumerated from ACPI namespace with ACPI ID AMD0010. Because the core
> > > driver needs an input source clock, and this is not an Intel LPSS dev=
ice
> > > where clocks are provided through drivers/acpi/acpi_lpss.c, we regist=
er the
> > > clock ourselves if the clock rate is given in ->driver_data.
> > >=20
> > > Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > ---
> >=20
> > Applied to for-next, still wondering...
>=20
> Thanks!

I reconsidered and these two patches are not in i2c/for-next because of
two reasons:

1) They do not apply cleanly on top of other i2c-designware changes I
applied (check i2c/for-next I just pushed out). The conflicts might not
be hard, but they were not trivial enough for me to do them inbetween
other things. I'd be very happy about a repost on top of i2c/for-next.

>=20
> >=20
> > >  drivers/i2c/busses/Kconfig                  |  1 +
> > >  drivers/i2c/busses/i2c-designware-platdrv.c | 27 +++++++++++++++++++=
++++++++
> > >  2 files changed, 28 insertions(+)
> > >=20
> > > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > > index 2ac87fa3058d..9384498ef3c1 100644
> > > --- a/drivers/i2c/busses/Kconfig
> > > +++ b/drivers/i2c/busses/Kconfig
> > > @@ -422,6 +422,7 @@ config I2C_DESIGNWARE_CORE
> > > =20
> > >  config I2C_DESIGNWARE_PLATFORM
> > >  	tristate "Synopsys DesignWare Platform"
> > > +	depends on COMMON_CLK
> >=20
> > ... do all previous users have COMMON_CLK?
>=20
> The driver is being used on x86, ARM and ARC it seems. For x86 and ARM
> we pretty much have COMMON_CLK nowadays but I'm not sure about ARC.

2) "pretty much have" is not so convincing to me. That is such a generic
core, it probably has enough out-of-tree users as well. And with all
these ACPI regressions from this cycle, I am very cautious right now.
Brainstorming: What about "depends on (ACPI && COMMON_CLK) || !ACPI"?


--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKc4hAAoJEBQN5MwUoCm2C7QP/jEQ7d60VSfPkjOx3G+XqXH8
IRk0k3Qm+TRB3loQNE0M+G4FITTDMSHXTkJqIcitMnKRyNIWygGwuJRZzbZDitG6
XZrN00cXxsSCyp9NX13cvYD9toFUy1g8uEl65yhHVNwPrdvhv3BeeZyp2tQDBJN0
Kg7scuT7NexIV7ecdcZknRvmTBOR1myaHBzwWEL2nIzoDDXKv3DNsPJX21poo205
1ih1uliBi+RDsepVlYjH1t8M86Z3/dfddOi2mrmh7hnjQdjVG/1bwMN0NoVXVYDt
2K0T4iy7nhhV6215fQ5sVJuJMCahOhUL3WBG5fOKvlVIlIzOZSzTkpCXlMTHGeBn
FN+vVfrjLes16rpAlKvA9I1bLIhi4hJ0ao12pxeIPY4q51y4v+wJRhDVriQX3zV9
Fsr9cv4fenWi8eeoSuHkJK8q6aOFK8W58rBJXPJHkecMMqP7Y9jT4/8PdvHC24qK
VBsW799vKM97n64jiP44nf/47w8X4YnzlQHhgDQMtlAki++MRAvsX2jdfQ2MvZiL
wvh6ywoacvQZzzhfwisAQhxLxxfgyndRPSKi4jUKUTCYHCKF8yLv7BGCB52gfsRk
rl2BElmxM/OnDXPNUA0NfZcphezjO5QhJIvR2lN06h4fOjC+VFIIEimAxgDvbE0Q
Ny8i0xwu62BOZtYD2qyn
=8JCD
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
