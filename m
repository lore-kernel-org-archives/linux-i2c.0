From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 3/4] i2c: core: Allow drivers to disable i2c-core irq
 mapping
Date: Sun, 16 Apr 2017 22:08:35 +0200
Message-ID: <20170416200835.og6flptm3p4joa57@ninjato>
References: <20170404220335.9815-1-hdegoede@redhat.com>
 <20170404220335.9815-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lvzbnk32uk6v4r3x"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57747 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756697AbdDPUIi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 16 Apr 2017 16:08:38 -0400
Content-Disposition: inline
In-Reply-To: <20170404220335.9815-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org


--lvzbnk32uk6v4r3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 12:03:34AM +0200, Hans de Goede wrote:
> By default the i2c-core will try to get an irq with index 0 on ACPI / of
> instantiated devices. This is troublesome on some ACPI systems where the
> irq info at index 0 in the CRS table may contain nonsense and/or point
> to an irqchip for which there is no Linux driver.
>=20
> If this happens then before this commit the driver's probe method would
> never get called because i2c_device_probe will try to get an irq by
> calling acpi_dev_gpio_irq_get which will always return -EPROBE in this
> case, as it waits for a matching irqchip driver to load. Thus causing
> the driver to not get a chance to bind.
>=20
> This commit adds a new disable_i2c_core_irq_mapping flag to struct
> i2c_driver which a driver can set to tell the core to skip irq mapping.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-next, thanks!


--lvzbnk32uk6v4r3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljzz0MACgkQFA3kzBSg
KbZdpw//f9lNkn1+SjN/kt4GYvxCEWqXFv93to72c3dXe2YhBu/ynSVL322t6BL3
ZPWA66F9PfkqhiOK3FJC01VmXgerJfZgP5/fCbKCS2hXCl20jMwXwM8DoDyALaCB
6F0jaYt1UCp+D9ilJr5A7w18Naks1PXaG/jg70v8gRJgNb3rrT1CMwbXfiZCVMNT
k/OkgT1EIqCF+GwcKi+3uxKG8hNxsmOtkG8wBZFbJ6KFmv3NYVWVwwaxNT58dPYk
qI+/cGDyslYsg/XvN5Q9qNaOUtXJagNg9fjwW7HINAx+7PDzZBUp16G3lg1q5Tbn
Mwitb4NRu1FPLGMc8WDYpUUUp40SPaZMaTnVrCWjRMslWwFNppMebjcSTmYgRsYF
PpnO4OlcvGLBvHKlEXz3i3w8/BJilwCea7LFborHpQ9TVjSv/cKhwGOjYBCZa5+k
5OuveX6Kk30UdcE5/N1Ozs+t6N5fJZZJm7aoXZjBa/9a977k4JCqxruCuSXx/Px9
Z2qCc3jEZSwJhMnHl4U8XbIZhCgadYbanG1CXfA/tioxhodJbD5hqDJTJnCi/3i9
LkC+pnnHVDgTwPqULBWW0ZkvSPRhHyubVegFUAdQybt1hPLW8HCgScDiIrIjT+35
5laHdOr9bmwOhcQ8jhXEpcYXwC+aWJQnUKmsuQyPY2SRD/2TYW8=
=5eoG
-----END PGP SIGNATURE-----

--lvzbnk32uk6v4r3x--
