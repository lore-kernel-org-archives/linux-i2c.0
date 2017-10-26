From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH resend v5 1/3] i2c: Allow overriding dev_name through
 board_info
Date: Thu, 26 Oct 2017 22:29:27 +0200
Message-ID: <20171026202927.unlrtd2n47qtqg6e@ninjato>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <20171011094121.6108-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqda4czghip45ns3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59680 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbdJZU3a (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 16:29:30 -0400
Content-Disposition: inline
In-Reply-To: <20171011094121.6108-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--cqda4czghip45ns3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 11:41:19AM +0200, Hans de Goede wrote:
> For devices not instantiated through ACPI the i2c-client's device-name
> gets set to <busnr>-<addr> by default, e.g. "0-0022" this means that
> the device-name is dependent on the order in which the i2c-busses are
> enumerated.
>=20
> In some cases having a predictable constant device-name is desirable,
> for example on non device-tree platforms the link between a regulator
> and its consumers is specified by the platform code by setting
> regulator_init_data.consumers. This array identifies the regulator's
> consumers by dev_name and supply(-name). Which requires a constant
> dev_name.
>=20
> This commit adds a dev_name field to i2c_board_info allowing
> platform code to set a contstant dev_name so that the device can
> be identified by its dev_name in other platform code.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

So, the live discussion at ELCE17 between broonie, Andy, and me came to
a good end for you ;)

Applied to for-next, thanks!


--cqda4czghip45ns3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnyRacACgkQFA3kzBSg
KbYQ6hAAoZz3nDMIoLm3gNCcB/4RBiFq8jYPV24BOQ3hTCn/LGkTQm3SXLaIRsy+
UWTwP8o+t3HLvNqj9S0M3G8nqOVvVRCxdFOWtX8ePJaGutXuFqyP8UwntpaiZDfb
0uZjvKcw5ihXbOCSAm//3aC7VEEnvXrXbi8LrnyPGMgwBWm2WB+rQoM6ONMtL8+g
EjjrKD8hE51GkHHwOM1q2OAcf0PZasW+77VYDY2siYdfmL7A2hM5A4PmKOY9QdvQ
ctM/cXlv3gv4Skm4I4IkyIFacjI4KyhLULEt0/WSG8GH5Lq7iHs9gB/SDpL1x/ui
tKD7IpWyVypwAH9gcYh61N8bS4TWHXOn/Z0HTmI964rpdNC4WmXaXmVYZKVKfhVX
JFxEEnkQV5RbZDwvz0jxiSNb7MNxe5NA8GfTKowhXFqWM/7t8qWffjKtq1vEwfGk
MrLW/AglI/8KLVneeRTQ5Txk/Aa1fTT+m6kC3JNnwaagLi7fGdPR1fH1r/A8Zdnl
iuu2uVcbawZw9oLw4rINE6sKKvw/7E2Fx+DsFENJFNYu7f9JNkr65rx+9MpeiZ7x
una7oAZqtshIegqI0xfPmpa0N5NRN6e531Ba0BxsZ45fpiV+feT8JsUqJpOP9gv2
h72amwa1ln9b6ZDoEJ3txlDOMQ7rmtnbLu00VKhQ9v7OMRhD3rw=
=JfU2
-----END PGP SIGNATURE-----

--cqda4czghip45ns3--
