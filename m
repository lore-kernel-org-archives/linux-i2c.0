From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v3] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Wed, 11 May 2016 11:19:28 +0200
Message-ID: <201605111119.28597@pali>
References: <1462781834-7890-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2638445.EoCzpQPFx2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34440 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbcEKJTd (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 05:19:33 -0400
In-Reply-To: <1462781834-7890-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart2638445.EoCzpQPFx2
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 09 May 2016 10:17:14 Mika Westerberg wrote:
> Many Intel systems the BIOS declares a SystemIO OpRegion below the
> SMBus PCI device as can be seen in ACPI DSDT table from Lenovo Yoga
> 900:
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
> There are also bunch of AML methods that that the BIOS can use to
> access these fields. Most of the systems in question AML methods
> accessing the SMBI OpRegion are never used.
>=20
> Now, because of this SMBI OpRegion many systems fail to load the
> SMBus driver with an error looking like one below:
>=20
>   ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
>        conflicts with OpRegion 0x0000000000003040-0x000000000000304F
>        (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
>   ACPI: If an ACPI driver is available for this device, you should
> use it instead of the native driver
>=20
> The reason is that this SMBI OpRegion conflicts with the PCI BAR used
> by the SMBus driver.
>=20
> It turns out that we can install a custom SystemIO address space
> handler for the SMBus device to intercept all accesses through that
> OpRegion. This allows us to share the PCI BAR with the AML code if
> it for some reason is using it. We do not expect that this OpRegion
> handler will ever be called but if it is we print a warning and
> prevent all access from the SMBus driver itself.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: stable@vger.kernel.org
> ---
> Changes to v2:
>=20
>  - Return -EIO instead of -EPERM
>  - Added ACK from Rafael
>  - Added Link and Reported-by tags
>  - Tagged for stable inclusion

Working fine on my Latitude E6440, add my:

Tested-By: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2638445.EoCzpQPFx2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlcy+SAACgkQi/DJPQPkQ1JxowCfTb19hMiqyyI+3RH9KHy10frL
ZLcAn1zxyeXIumqev063WNsr9m0tt7/J
=vXl/
-----END PGP SIGNATURE-----

--nextPart2638445.EoCzpQPFx2--
