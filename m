From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Thu, 9 Jun 2016 21:41:23 +0200
Message-ID: <20160609194122.GD23522@katana>
References: <1465480588-137449-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34738 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbcFITlq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 15:41:46 -0400
Content-Disposition: inline
In-Reply-To: <1465480588-137449-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 04:56:28PM +0300, Mika Westerberg wrote:
> Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
> PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
>=20
>   Device (SBUS)
>   {
>       OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
>       Field (SMBI, ByteAcc, NoLock, Preserve)
>       {
>           HSTS,   8,
>           Offset (0x02),
>           HCON,   8,
>           HCOM,   8,
>           TXSA,   8,
>           DAT0,   8,
>           DAT1,   8,
>           HBDR,   8,
>           PECR,   8,
>           RXSA,   8,
>           SDAT,   16
>       }
>=20
> There are also bunch of AML methods that that the BIOS can use to access
> these fields. Most of the systems in question AML methods accessing the
> SMBI OpRegion are never used.
>=20
> Now, because of this SMBI OpRegion many systems fail to load the SMBus
> driver with an error looking like one below:
>=20
>   ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
>        conflicts with OpRegion 0x0000000000003040-0x000000000000304F
>        (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
>   ACPI: If an ACPI driver is available for this device, you should use
>        it instead of the native driver
>=20
> The reason is that this SMBI OpRegion conflicts with the PCI BAR used by
> the SMBus driver.
>=20
> It turns out that we can install a custom SystemIO address space handler
> for the SMBus device to intercept all accesses through that OpRegion. This
> allows us to share the PCI BAR with the AML code if it for some reason is
> using it. We do not expect that this OpRegion handler will ever be called
> but if it is we print a warning and prevent all access from the SMBus
> driver itself.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Reported-and-tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: stable@vger.kernel.org

Applied to for-current, thanks! I am quite positive that all bugs are
gone now :)


--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWcZiAAoJEBQN5MwUoCm2nRgP/31cKP2cvqNdo9lOJLzsAxza
wH9sNkPMvYu/5OPxDxL6ZJPwMhltttWwBljMvNz4n270jfz9RhJthuufzde+Z/pY
oyv1ieJ/WvdFSdzslf4VELlj39PQJCYAzChwQLkFCz21WqcGQo4jJ5ulB0BHYOEI
a4PlkywPYAYj64cRfurwDIWY4dePhFoxoDttq98tTfuhSma+zpQWGO79CFAnQxRF
sqO7B6dLOH0oyzUtt+c3j3L2igpUC7vzISMX0djnbe/umzF1XwOTWPoIbJxT3EjU
7PxWaK/x86FCvLnl+c1P9F6S5uQTMoERbDggfQauSNrAAMn9iz8iN15u+mFxARY8
NsB+/0pgfy9TlNGxWF2imRVF9q5LPTUeYAInDA8tGK3bYE0q9JZG5+V+Wq+7uk+j
J2OOpwIuyAYqI9WGbliZ026adZDNLO7XEcP8kUzUGjXr0RTDCJ09PWL8ielrAz7u
MNplEEcaJn7lU5zyP4aKv12pul+FNxnVbaGet7iKHOHh0Qn9D42e4fTFMXorCj3e
aCa4AlE/UcRprpYnwlIhQvfQG5rn9H6gk36qD5SATb4aYEAfIlIjYe3o4RgoDnna
LoL+T0mkHK0gR891ymlyXPmrnWFMUXSRg+09EV198/ao2Sb4nkAB/FTpanoSgck4
zr8sd5/gr+36JhiRJ7Au
=F0HO
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
