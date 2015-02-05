From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Thu, 5 Feb 2015 20:21:36 +0100
Message-ID: <20150205192136.GE15307@katana>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1422014045-20584-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150123124155.GA1906@katana>
 <20150123124805.GP1850@lahna.fi.intel.com>
 <1422018246.31903.162.camel@linux.intel.com>
 <20150124041914.GA1190@katana>
 <20150126121508.GE1052@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150126121508.GE1052@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 01:15:08PM +0100, Wolfram Sang wrote:
> On Sat, Jan 24, 2015 at 05:19:14AM +0100, Wolfram Sang wrote:
> > On Fri, Jan 23, 2015 at 03:04:06PM +0200, Andy Shevchenko wrote:
> > > On Fri, 2015-01-23 at 14:48 +0200, Mika Westerberg wrote:
> > > > On Fri, Jan 23, 2015 at 01:41:55PM +0100, Wolfram Sang wrote:
> > > > > On Fri, Jan 23, 2015 at 01:54:03PM +0200, Andy Shevchenko wrote:
> > > > > > There is no need to duplicate same data for each controller. If=
 we need
> > > > > > specific stuff for a certain controller in the future we may ad=
d it later. The
> > > > > > patch leaves one controller per platform.
> > > > > >=20
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563A2t4k+OOtxA@public.gmane.org=
om>
> > > > > > ---
> > > > > >  drivers/i2c/busses/i2c-designware-pcidrv.c | 63 ++++++--------=
----------------
> > > > > >  1 file changed, 11 insertions(+), 52 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drive=
rs/i2c/busses/i2c-designware-pcidrv.c
> > > > > > index 5c6fca7..435a8ec 100644
> > > > > > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > > > > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > > > > @@ -40,13 +40,7 @@
> > > > > >  #define DRIVER_NAME "i2c-designware-pci"
> > > > > > =20
> > > > > >  enum dw_pci_ctl_id_t {
> > > > > > -	medfield_0,
> > > > > > -	medfield_1,
> > > > > > -	medfield_2,
> > > > > > -	medfield_3,
> > > > > > -	medfield_4,
> > > > > > -	medfield_5,
> > > > > > -
> > > > > > +	medfield,
> > > > > >  	baytrail,
> > > > > >  	haswell,
> > > > > >  };
> > > > > > @@ -98,47 +92,12 @@ static struct dw_scl_sda_cfg hsw_config =3D=
 {
> > > > > >  };
> > > > > > =20
> > > > > >  static struct  dw_pci_controller  dw_pci_controllers[] =3D {
> > > > > > -	[medfield_0] =3D {
> > > > > > -		.bus_num     =3D 0,
> > > > >=20
> > > > > Wasn't that bus_num used to ensure stable bus numbers? Adding Mik=
a.
> > > >=20
> > > > That's right.
> > > >=20
> > > > However, I don't think anybody really uses Medfield outside Intel s=
o in
> > > > that sense this patch should not break anything.
> > >=20
> > > I think better to ask David who is closer to that Intel MID area.
> >=20
> > OK, waiting for a reply from him here.
>=20
> @David: ping

David: ping again


--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08LAAAoJEBQN5MwUoCm29OwQAIW1M63rbGQWgbS2W0IkgB57
cWllACy5GYZPaKc0hNHJ2NxVHoUQO4Nf3uYS5yOFb9Oob4YF0esRUjfOGImZ+snR
A2qpj7Rklpa/vMTfIsLYUlZHd7ecCzNygi7QHlmZHByoeUOWIl2+pu1hquEv3Wcq
ZCQaLRrUPdn0XeB5eC1WTFQ7c9Hliiy3WgT4xrSvsbn+iP4zk2Bd+fLa43pPm2+F
lth9hVZb6VOuhP5OqNDPMLMarnzXnkEgvCpyOhKLA3iz9xWHh1XPWgRqsu4RqaoU
Nk7WxPzaHbdRq2uzUdkUgLewfH9bDMgyTpwF9A5o/tzQ7BXSCRABnJYBPGFbc+zP
O37JeEw0TzPCmVLPU7wEQPvwqfzcjH9kRzReJ4PtjEnGkScyQYcG0u6XVth9d3i+
H/Svm12inlmyK/5ogArsw/8MnmkjwzczU7Dqe/qATrpOMv8NqaD4+5D9KTRx2CAs
zB8kxpgn5TYilXoANUWBykFc74vhalb/FhA7418H09jvcEH41HGUe+4wjynjnY2R
BxA1m5b4evEd+I3TjXT3TblXFmiCCO9zFJ4H85eOMZcXB9Jyu4oXr1RnEqPp3hmf
vVDSPAamzTohIlM99GZ0GOj9jv33MGywmhpuLPlD3DcnebJ8GIeHeDIy5/t69XJj
R6Qc2/3XH3rs1wFoEpl9
=HjzI
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
