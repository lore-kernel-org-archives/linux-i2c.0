From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Fri, 12 Feb 2016 20:09:56 +0100
Message-ID: <20160212190956.GL1520@katana>
References: <1454714564-8632-1-git-send-email-alexandra.yates@linux.intel.com>
 <20160210104231.3fa07523@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:59092 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcBLTKA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 14:10:00 -0500
Content-Disposition: inline
In-Reply-To: <20160210104231.3fa07523@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 10:42:31AM +0100, Jean Delvare wrote:
> Hi Alexandra,
>=20
> On Fri,  5 Feb 2016 15:22:44 -0800, Alexandra Yates wrote:
> > Changes log v2 to v3: Clarified commit message. No changes in code.

This line should be below the "---".

> >=20
> > Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
> > resources have been moved to reside under the i801 SMBus host
> > controller whereas previously they were under the LPC device.
> >=20
> > This patch adds Intel lewisburg SMBus support for iTCO device.
> > It allows to load watchdog dynamically when the hardware is
> > present.  This patch is an addition
> > to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
> > Intel Lewisburg device IDs".
> >=20
> > Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> > ---
> >  drivers/i2c/busses/i2c-i801.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i80=
1.c
> > index f62d697..27fa0cb 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -1271,6 +1271,8 @@ static int i801_probe(struct pci_dev *dev, const =
struct pci_device_id *id)
> >  	switch (dev->device) {
> >  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
> >  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
> > +	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
> > +	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
> >  	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
> >  		priv->features |=3D FEATURE_I2C_BLOCK_READ;
> >  		priv->features |=3D FEATURE_IRQ;
>=20
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>=20
> Note this checkpatch warning though:
>=20
> ERROR: Please use git commit description style 'commit <12+ chars of sha1=
> ("<title line>")' - ie: 'commit 0123456789ab ("commit description")'
> #40:=20
> to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
>=20
> It is also common to add a "Fixes:" line with that information so that
> patch backporting can be automated. And as I said before I would tag
> the patch for stable as well.

Can you do this and resend?


--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvi4EAAoJEBQN5MwUoCm2do4P/0U0SiZQcgQBp0Rtt4CJT6BI
Ti3z8NQl0uld8vOEU96GuNJArnY5JigL4f31Nj22Zm6dZ4OMwKwyhWz8FMXzgAUS
Sh/r796rWD0RGYDMNk7R1/9ZEc5FRDq0MpcdVf1sfcn2ZrIwcSzAEGVEn1wiGIP+
yobTbgPRYFMWJGnCwrk/mRj+SMio5MDnBZiX6y7jimxD0vf2y3j7gie8kOoL4Wd5
SdGd8s9IBmGNgOIq06r/70EUYKJhsdNhvwAxSk0tBJgYOOUPlOeGBwMhLzzhDFbl
35hAxI+rrxmLPr9xGPMlOI7n646ymcNz09zOpUOpzh5PUFejhruZAN0jyPri5ckk
EOleXqknRov4zXNvc2bPslmqboCadpJ9Z5osa7A/qaix5Qs4tMbsfqrGiIwadaVr
o9qxo2L5edB7yT3CXk617Ej6HemGwH9u0YWmhHHeUxmfI4OMU13i+OiWcy1tua9W
OeMpclyHeMkYeVV0LqKsvNI5UHRBTY9Pv78Qovdu0TLUDICIimiW10uR0UAh0s73
362C6ulUAb3ZtkOWbVjuBVWcCiyprQoIfnGnMPLa0IrWK1E+WcU1OWMmGey2mOER
I7ygDuVneS1/QGlV/5pdEGYp+uF8e9iiPU6pvPMGHI3krSbVGLVr711a7+d7JN/v
1Dx9eWCmoLuk9JViqlmI
=UpmR
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--
