From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Sat, 24 Jan 2015 05:19:14 +0100
Message-ID: <20150124041914.GA1190@katana>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1422014045-20584-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150123124155.GA1906@katana>
 <20150123124805.GP1850@lahna.fi.intel.com>
 <1422018246.31903.162.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422018246.31903.162.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 03:04:06PM +0200, Andy Shevchenko wrote:
> On Fri, 2015-01-23 at 14:48 +0200, Mika Westerberg wrote:
> > On Fri, Jan 23, 2015 at 01:41:55PM +0100, Wolfram Sang wrote:
> > > On Fri, Jan 23, 2015 at 01:54:03PM +0200, Andy Shevchenko wrote:
> > > > There is no need to duplicate same data for each controller. If we =
need
> > > > specific stuff for a certain controller in the future we may add it=
 later. The
> > > > patch leaves one controller per platform.
> > > >=20
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > > ---
> > > >  drivers/i2c/busses/i2c-designware-pcidrv.c | 63 ++++++------------=
------------
> > > >  1 file changed, 11 insertions(+), 52 deletions(-)
> > > >=20
> > > > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i=
2c/busses/i2c-designware-pcidrv.c
> > > > index 5c6fca7..435a8ec 100644
> > > > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > > > @@ -40,13 +40,7 @@
> > > >  #define DRIVER_NAME "i2c-designware-pci"
> > > > =20
> > > >  enum dw_pci_ctl_id_t {
> > > > -	medfield_0,
> > > > -	medfield_1,
> > > > -	medfield_2,
> > > > -	medfield_3,
> > > > -	medfield_4,
> > > > -	medfield_5,
> > > > -
> > > > +	medfield,
> > > >  	baytrail,
> > > >  	haswell,
> > > >  };
> > > > @@ -98,47 +92,12 @@ static struct dw_scl_sda_cfg hsw_config =3D {
> > > >  };
> > > > =20
> > > >  static struct  dw_pci_controller  dw_pci_controllers[] =3D {
> > > > -	[medfield_0] =3D {
> > > > -		.bus_num     =3D 0,
> > >=20
> > > Wasn't that bus_num used to ensure stable bus numbers? Adding Mika.
> >=20
> > That's right.
> >=20
> > However, I don't think anybody really uses Medfield outside Intel so in
> > that sense this patch should not break anything.
>=20
> I think better to ask David who is closer to that Intel MID area.

OK, waiting for a reply from him here.


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwx1CAAoJEBQN5MwUoCm2F4oQAI5JpkQxST7jHw1LYRXKOBdp
/+Gti3QoFKuXbAYYfkbSjS+OMVaS+uN3gtmVcZIWVo/cdnudtbQL9uFPD88vtzcN
gXMX/mvC6PfVUVTCEAOrASJUqQG5ZPKcNQ22ECYw9NN66TvgFWuLxqM5mN6bFZJu
7IvUPTQLm9z5s0ybI/NceP8XFoeUe8tyaISBgtbLBe/swcVEJcAm/eX3t59bFTBY
MaUBxg1eURA1p7sI/vLNSkDqH2LfaxGTULn8zGGqPNuDd6MYRfDal/yT5mfOxYq/
9nQP8TFOjMZA6tMoE4iLAxAxgw2s+ODG72qqEZGsF+YCLHhd6QTp7s8eNfjzxfOa
erB2/0mSI2Z7ws90177PtIhQZKOD6Onv24VkXzIuA4xTy48x94ISKjlQBqgf9XWr
aTJAiOI4/IXnAnpB10h33083nvP3lsOgFc+xBPECAOgxfWkGOBdEh4TwZgXRcKse
j5EzTw7r+GW3mxhVhuVP9jV0FljkBMJyKowxUB82/RzvVKe2AuOS+TInihv9We3U
Idl6Wu0eCEEB/cRs+AxYrC8je96gSFG+JhPosxxK3UB+SjhItFAVwZifYd2yzhci
NwxJrqdyxvXj0aQgftl42nU5chAjXRwYfsRSqC/sPn7sXmBOVTob0hI4gP7pEazD
cf8gpOjtC0fUx7biluCa
=8YVK
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
