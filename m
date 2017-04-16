From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 4/4] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Sun, 16 Apr 2017 22:08:10 +0200
Message-ID: <20170416200810.sck2btf7xcznb5xt@ninjato>
References: <20170404220335.9815-1-hdegoede@redhat.com>
 <20170404220335.9815-5-hdegoede@redhat.com>
 <1491400346.24567.5.camel@linux.intel.com>
 <20170405154146.GD27833@fury>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fzmkpnhwtqewrqn"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170405154146.GD27833@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--7fzmkpnhwtqewrqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 08:41:46AM -0700, Darren Hart wrote:
> On Wed, Apr 05, 2017 at 04:52:26PM +0300, Andy Shevchenko wrote:
> > On Wed, 2017-04-05 at 00:03 +0200, Hans de Goede wrote:
> > > The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources
> > > for
> > > 3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB300C USB Type-C
> > > Controller and PI3USB30532 USB switch.
> > >=20
> > > This commit adds a driver for this ACPI device which instantiates
> > > i2c-clients for these, so that the standard i2c drivers for these
> > > chips
> > > can bind to the them.
> > >=20
> >=20
> > Looks like we need something such as MFD for I2C bus clients...
> >=20
> > FWIW:
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Wolfram, will you be making an immutable i2c branch available for us to m=
erge
> into our platform driver x86 for-next branch in order to apply this patch?
>=20
> Alternatively you could send this in on our behalf, but that complicates =
any
> fixes between now and rc1 for this new driver. We'd prefer the immutable =
branch
> and pull this in ourselves.

Fine with me, here it is:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-INT33FE


--7fzmkpnhwtqewrqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljzzykACgkQFA3kzBSg
Kbb+pQ/+JbNw4Uu5h9jW6q2bVZyCYB1hc1/PkAQ6lghnmg8qMsmulrltf8gJLvhz
bqUwxONPVD/OJJ8kAwAC+wv+ugnyE6VrACwsJR7lGlfcAL2sTAM6a1Hw8pllyXEV
Y8gMDClbW/uQCxzKGzdTKA023XczGnwdbRtQ7IX3YghHWgSxX+gXSWBhTDz58wVh
wbngHe+Tdku+lwDSYFwt8LZS7/apaZmAlFcUpClE1v0AeR4816CQUEzHszFF/fAG
ht2X0tLHSK+si9kLBpNnGr9h4s7jrSaHNDLk346vignnFNtj+0EdvAvJLvW452Sw
8GpjBk7X01uSdRCYGUFmxUxXM9v/oKtwe0UqU3LVV24xMFpLawX2Up0hdnEG3Wjz
aTERsY/lppDccguvYC4UXsvt7y3McQBqPvBDijbDE5/HKFSfk39hiKrz+nStB7Qz
VC5TlgE5MeUwnUThvkOI+HUaAEQvtBbBRIEmhtrztrg+cg3t9wHuqTOhfbh4l6Gv
5Dak4PlW1mX5cosY+jQykZUb4pOVUZy+Cj4Oknc6zrOcioniG8UNrUpjIyofPcvX
ASKEZbgl8gvlsvV0s9D+iqokJIqeYnegrsSFiVExNTDb7vqYidgjd06hBStQa9Eu
7aqD9Nc/iAGvPLoMOTrUvzTV5gV7k0TRhqZPLCE+6a6g/Zv9+jA=
=9FVR
-----END PGP SIGNATURE-----

--7fzmkpnhwtqewrqn--
