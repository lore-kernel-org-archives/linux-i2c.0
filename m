From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/2] i2c: add ACPI support for I2C mux ports
Date: Fri, 23 Oct 2015 12:16:11 +0200
Message-ID: <20151023101611.GH13380@katana>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-3-git-send-email-dustin@cumulusnetworks.com>
 <20151023084013.GS1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151023084013.GS1526@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 11:40:13AM +0300, Mika Westerberg wrote:
> On Thu, Oct 22, 2015 at 02:17:42AM -0700, Dustin Byford wrote:
> > Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
> > device property compatible string match), enumerating I2C client devices
> > connected through an I2C mux needs a little extra work.
> >=20
> > This change implements a method for describing an I2C device hierarchy =
that
> > includes mux devices by using an ACPI Device() for each mux channel alo=
ng
> > with an _ADR to set the channel number for the device.  See
> > Documentation/acpi/i2c-muxes.txt for a simple example.
> >=20
> > To make this work the ismt, i801, and designware pci/platform devs now
> > share an ACPI companion with their I2C adapter dev similar to how it's =
done
> > in OF.  This is done on the assumption that power management functions =
will
> > not be called directly on the I2C dev that is sharing the ACPI node.
> >=20
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
>=20
> This looks good to me.
>=20
> You did also some stylistic changes to the drivers in question which I
> think should be placed to a separate patches.

I am fine with those.

> Regardless of that,
>=20
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I would love to get a Tested-by for the designware part. Then, I could
queue it for 4.4 already.

> I'll leave this up to Rafael and Wolfram to decide how to go forward
> with this patch.

I'd think I pick both when Rafael acks patch 1 (with the unneded 'return'
removed).


--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKgjrAAoJEBQN5MwUoCm2lPsQAJoDz+5sU/F4Kszvx06sTq6f
MHkS1QigX9fqsfMJ+EgaFOrq0fRVX1xpsYeHUPdHidVInf6it2iy8q//JFoBBiN9
iuCbEWt42OunLrA4oBDZgHB9S/fBbomNdNjKGTo4DJ+6E5OIiryKUc6AtX8mTORy
miLMhQngrSNpbo7ximlQ6LR48xypwOHZ4NZlO0I9Sfa842b3rYcWKkGLwzXs1Gbz
HcIegyvp4B3uHG+QlB5Bp7ljmfNf9Wt1ziDNyA7HzvrQjMd4HMGWMPHMgP6n1+wG
jX4U2izqpUOl+WMgezkeM2Jvuz3VqeLeXfGCv4sirXq7T/5sj2KBKs4XLOrS4pxu
BanPTkBn80boojCfec7u+6OVkyt+hHsPMkL1TcA/Ha8+Gu8yOMzDQF/vf1S/K9Q7
SyAms6QKVfoW8gq01wNU9cEoxu3JOeUh2TC/ZxTiAgsdM/TgOw757Q5tVDmKqlmI
qYCRje3HybebVmDi85C3YEWk64zMr6ez3VHo2ttUWbWk3JZVCykE5+NitY+2TaJB
Zv93JsulqbWP+0OBVi8XIZYtI9Qj//ECTU27hMS1ERiNckNDBZPlU9QRXelK+hNY
mdzpnGVTNxfRhForcY3SXkIF38iR+VydHX96lcXzwTnoh2F6k5hJdMmh478KG799
wbtx6Lm0nAFd3HTKChrx
=B/b3
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
