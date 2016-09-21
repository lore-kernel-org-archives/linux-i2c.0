From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs
 to another adapter
Date: Wed, 21 Sep 2016 18:14:38 +0200
Message-ID: <20160921161435.GA1432@katana>
References: <874m5ax3o4.fsf@gmail.com>
 <20160920135925.45450-1-mika.westerberg@linux.intel.com>
 <20160921054834.GC1484@katana>
 <20160921084502.GV1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45837 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756613AbcIUQOx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 12:14:53 -0400
Content-Disposition: inline
In-Reply-To: <20160921084502.GV1811@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 11:45:02AM +0300, Mika Westerberg wrote:
> On Wed, Sep 21, 2016 at 07:48:35AM +0200, Wolfram Sang wrote:
> > On Tue, Sep 20, 2016 at 04:59:25PM +0300, Mika Westerberg wrote:
> > > When enumerating I2C devices connected to an I2C adapter we scan the =
whole
> > > namespace (as it is possible to have devices anywhere in that namespa=
ce,
> > > not just below the I2C adapter device) and add each found device to t=
he I2C
> > > bus in question.
> > >=20
> > > Now after commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI
> > > reconfigure notifications") checking of the adapter handle to the one=
 found
> > > in the I2cSerialBus() resource was moved to happen after resources of=
 the
> > > I2C device has been parsed. This means that if the I2cSerialBus() res=
ource
> > > points to an adapter that does not exists in the system we still parse
> > > those resources. This is problematic in particular because
> > > acpi_dev_resource_interrupt() tries to configure GSI if the device al=
so has
> > > an Interrupt() resource. Failing to do that results errrors like this=
 to be
> > > printed on the console:
> > >=20
> > >   [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
> > >=20
> > > To fix this we pass the I2C adapter to i2c_acpi_get_info() and make s=
ure
> > > the handle matches the one in the I2cSerialBus() resource before doing
> > > anything else to the device.
> > >=20
> > > Reported-and-tested-by: Nicolai Stange <nicstange@gmail.com>
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >=20
> > Considering this for for-current. So shall we add:
> >=20
> > Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure noti=
fications")
> >=20
> > ?
>=20
> Yes please :)

Huh? It doesn't apply on top of rc7 here? What did you base it on?


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4rHrAAoJEBQN5MwUoCm2hiMP/1f5a4Ysbgb0Nkh99QWjTKxv
TJffNgVusnA9Rzj3CTyHb+REYCLR+jj7QiMz5qNmEDQk1D1OgJXTweqRSmcakuRF
h7ie15tXdwhn9MUBNMu62SvsoHgEVjv4IHbPhYOOXjPTeleaUePQhseWFolqO82B
YZg7gYQOQAAolO5cOne6fr+dauZnvtEq9FQWoAPTwxZybq0sZKKE4YoBpQ0tMqYg
AsD0ZFLed2H12KiH8OHXBzUaDl1OosFbs/15cUeZ6hO8VdZgeeZvz5vpL/eJOZe5
tsokmTbyCUJxeasc/gBPPkqGLqDJfzV/pipyTOD/h0+FjhIHRos8w4uo0Iw3bOvt
TI/AVjT/BQLJLAJkFmfey8sd6ArbS8ayANEW3bFZ56d178kKbuDNF/XxSIYSGn5U
XBvP3M/q+0cCToezft/y6Kl4MAZKP8T4k+Ge4G8VAUBvZjKN5tGkIYsHa77ST9sb
GmLeJF7tNDYms3+Zta0KiZ0VP+ZZLptuqUOYAZ3IuAHZZkML9UAPZ6n0KfkzTo5n
bUj+90BP4xRhykzlk7HDRGZfXVo3HKXQ/qrWePxbAoUBTSjf3ZSF+R94w85RUSmU
7suWJv5c5omoY7nzWILMZydPNQwFxk0H2I1LToLbvD5tTS680PjmAskelyUPKQr2
sn4cKNDd7Thq/kLBk/u/
=ny5b
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
