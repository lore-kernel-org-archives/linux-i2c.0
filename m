From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: acpi: Do not create i2c-clients for LNXVIDEO
 ACPI devices
Date: Tue, 4 Jul 2017 15:58:33 +0200
Message-ID: <20170704135832.ijcfpbckzpo3uxlw@ninjato>
References: <20170704130448.19064-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2hwablnlllmfcabu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49152 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdGDN6f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 09:58:35 -0400
Content-Disposition: inline
In-Reply-To: <20170704130448.19064-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org


--2hwablnlllmfcabu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 03:04:48PM +0200, Hans de Goede wrote:
> ACPI video devices get tagged by the kernel with the custom LNXVIDEO
> HID so that normal pnp-id matching can be used and are handled by the
> acpi-video driver.
>=20
> Sometimes the ACPI nodes describing these contain a SERIAL_TYPE_I2C ACPI
> resource. Before this commit the presence of this resource would cause the
> i2c-core to create a /sys/bus/i2c/devices/i2c-LNXVIDEO:00 device for this
> with a modalias of: "i2c:LNXVIDEO:00".
>=20
> There is no i2c driver for this custom HID, the acpi-video driver binds
> directly to the ACPI device /sys/bus/acpi/devices/LNXVIDEO\:00 which has
> a modalias of "acpi:LNXVIDEO:" .
>=20
> Not only is the creation of an i2c-client for this undesirable, it is
> actually causing problems. This weird pseudo-resource claims an i2c
> speed of 100KHz and typically points to the i2c bus which is used by the
> touchscreen controller. Some touchscreen controllers only work properly at
> 400KHz, at 100KHz they cause errors like these:
>=20
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> silead_ts i2c-MSSL1680:00: Registers clear error -11
>=20
> This commit makes the i2c-core ignore LNXVIDEO compatible ACPI devices
> which has 2 positive results:
>=20
> 1) The bogus i2c-client for these is no longer created.
> 2) i2c_acpi_lookup_speed now ignores the 100KHz speed from the pseudo
> i2c-resouce and properly returns 400KHz as speed for the touchscreen
> i2c bus, fixing the touchscreen not working on various devies.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks like a bugfix, so I'll include it in this merge window.

Applied to for-next, thanks!


--2hwablnlllmfcabu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllbnwQACgkQFA3kzBSg
KbZLDRAAqALu+mV6YS/8X+PchC/hcgWwNnD2KHdPhx64OrSbneIW2s3ty3zCCEQ/
ZCNdc9rS5T3rZcFuz9jzl623oNrrXbjb7ZCRntWVahO+BjAHPszidV8RmyLTecRf
74F/u4XAsUJl4dbYTecdJYx4dkG0cf/g7oCMoyzd0GN48sNrHDPPlM/cNrBbYiMk
jbJZZlenfAy5f06MYwxo57XAYcdj5ldPfQn75LfFzXvRCY17IpXwYjqieIyb7EdF
Kzy6+Ikbqvh1e+x4BFpIYLg4oDktJ2qJB8bbpyNoYDAwPuHi6c8gQc5srTaDXTsG
7fFYcKP/QqvTy2HBkRYbGr9SAAP+1GEbxcgLcRN+ZehNDhlUzgHP6US8rovWE3gM
xQUbvg5E6GqIDB4QYv5TsIqwKGthIk7NoTSAj+ZkP9cZAF1o62nbH2Mss4mKNfql
kVGSo5kE2lmotPA7o/6UWKV2CHv/Z3pRxpb1CMT94xU+7d6FXV+QG80zraDBtfFG
uGUHWHqBjk8KoVFPeW29hmJTFKLKUKD9pPBMN1JhNBJxoObg102ca5gnSDkOhCU2
SRYOHM7r5Rvm4hHiRj8ZZ1BIugrRc9Ly2gd37Mj243wsXOdbVI/ikoTCy3efUITM
ZXXJKOeRjFDJoIcKyiuXoxr2ubfA8ffq/Jl8h7pMsUvRkIt3ZOs=
=WsWv
-----END PGP SIGNATURE-----

--2hwablnlllmfcabu--
