From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 harder
Date: Sat, 12 Aug 2017 13:15:07 +0200
Message-ID: <20170812111507.rxc7lzc6f7uoqlt2@ninjato>
References: <20170626204009.32607-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7bsmkxfivdrxowoi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42648 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbdHLLPK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 07:15:10 -0400
Content-Disposition: inline
In-Reply-To: <20170626204009.32607-1-lyude@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lyude <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Benjamin Tissoires <btissoir@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--7bsmkxfivdrxowoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Jun 26, 2017 at 04:40:08PM -0400, Lyude wrote:
> There's quite a number of machines on the market, mainly Lenovo
> ThinkPads, that make the horrible mistake in their firmware of reusing
> the PCIBAR space reserved for the SMBus for things that are completely
> unrelated to the SMBus controller, such as the OpRegion used for i915.
> This is very bad and entirely evil, but with Lenovo's historically poor
> track record of fixing their firmware, it is extremely unlikely this is
> ever going to be properly fixed.
>=20
> So, while it would be nice if we could just cut off the SMBus controller
> and call it a day this unfortunately breaks RMI4 mode completely for
> most of the ThinkPads. Even though this behavior is extremely wrong, for
> whatever reason sharing the PCIBAR between the OpRegion and SMBus seems
> to be just fine. Regardless however, I think it's safe to assume that
> when the BIOS accesses the PCIBAR space of the SMBus controller like
> this that it's trying to get to something else that we mapped the SMBus
> controller over.
>=20
> On my X1 Carbon, this assumption appears to be correct. I've traced down
> the firmware accesses to being caused by the firmware mistakenly placing
> the SWSCI mailbox for i915 on top of the SMBus host controller region.
> And indeed, blacklisting i915 causes the firmware to never attempt to
> touch this region.
>=20
> So, in order to try to workaround this and not break either SMBus or
> i915, we temporarily unmap the PCI device for the SMBus controller,
> do the thing that the firmware wanted to do, then remap the device and
> report a firmware bug.
>=20
> Signed-off-by: Lyude <lyude@redhat.com>

No full name? Or is it your full name?

> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Benjamin Tissoires <btissoir@redhat.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: intel-gfx@lists.freedesktop.org

I don't know this matter at all. I'd need comments from these people on
CC to proceed with this one.

> ---
> So: unfortunately
>=20
> a7ae81952cda (i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PC=
I BAR)
>=20
> Seems to prevent the ThinkPad X1 Carbon 4th gen and the T460s from actual=
ly
> using their SMBus controllers at all. As mentioned above, I've traced the=
 issue
> down to the firmware responding to the SWSCI by sticking data in places it
> shouldn't, e.g. the SMBus registers.
>=20
> I'm entirely unsure if this patch is the correct fix for this, and wouldn=
't be
> at all surprised if it's just as bad of a patch as I think it is ;P. So I
> figured I'd send it to intel-gfx and the authors of the original version =
of this
> patch to get their take on it and see if there might be something less ha=
cky we
> can do to fix this.
>=20
>  drivers/i2c/busses/i2c-i801.c | 41 +++++++++++++++++++++++++------------=
----
>  1 file changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 6484fa6..bfbe0f9 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1406,33 +1406,42 @@ i801_acpi_io_handler(u32 function, acpi_physical_=
address address, u32 bits,
>  {
>  	struct i801_priv *priv =3D handler_context;
>  	struct pci_dev *pdev =3D priv->pci_dev;
> +	struct device *dev =3D &pdev->dev;
>  	acpi_status status;
> +	int err;
> =20
> -	/*
> -	 * Once BIOS AML code touches the OpRegion we warn and inhibit any
> -	 * further access from the driver itself. This device is now owned
> -	 * by the system firmware.
> -	 */
>  	mutex_lock(&priv->acpi_lock);
> =20
> -	if (!priv->acpi_reserved) {
> -		priv->acpi_reserved =3D true;
> +	/*
> +	 * BIOS AML code should never actually touch the SMBus registers,
> +	 * however crappy firmware (mainly Lenovo's) can make the mistake of
> +	 * mapping things over the SMBus region that should definitely not be
> +	 * there (such as the OpRegion for Intel GPUs).
> +	 * This is extremely bad firmware behavior, but it is unlikely this will
> +	 * ever get fixed by Lenovo.
> +	 */
> +	dev_warn_once(dev,
> +		      FW_BUG "OpRegion overlaps with SMBus registers, working around\n=
");
> =20
> -		dev_warn(&pdev->dev, "BIOS is accessing SMBus registers\n");
> -		dev_warn(&pdev->dev, "Driver SMBus register access inhibited\n");
> -
> -		/*
> -		 * BIOS is accessing the host controller so prevent it from
> -		 * suspending automatically from now on.
> -		 */
> -		pm_runtime_get_sync(&pdev->dev);
> -	}
> +	pm_runtime_get_sync(dev);
> +	pcim_iounmap_regions(pdev, 1 << SMBBAR);
> =20
>  	if ((function & ACPI_IO_MASK) =3D=3D ACPI_READ)
>  		status =3D acpi_os_read_port(address, (u32 *)value, bits);
>  	else
>  		status =3D acpi_os_write_port(address, (u32)*value, bits);
> =20
> +	err =3D pcim_iomap_regions(pdev, 1 << SMBBAR,
> +				 dev_driver_string(&pdev->dev));
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			FW_BUG "Failed to restore SMBus region 0x%lx-0x%Lx. SMBus is now brok=
en.\n",
> +			priv->smba,
> +			(unsigned long long)pci_resource_end(pdev, SMBBAR));
> +		priv->acpi_reserved =3D true;
> +	}
> +
> +	pm_runtime_put(dev);
>  	mutex_unlock(&priv->acpi_lock);
> =20
>  	return status;
> --=20
> 2.9.4
>=20

--7bsmkxfivdrxowoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmO4zcACgkQFA3kzBSg
KbZ3sxAAkVigTiZG2iqpTzUg7vXgSQkCLP5ERzSmPsuvccXA4XeAMV/INHM/phHj
puC0Nve0g7ATQvCGgd4H0KafUoQNeI5tv7ZZEnNsbjjtHfr9v6xHoiQWamhfyhm5
qVhmytDHvwx9ZfbHYDJc5kTwiXXtUJE16w5+irfLhESOI5jxqGSimZITVWeZsQKu
LG1UqA05xqT+YhFDWLjrS6C2UaZyEDCN8tRFt9xluNiPTgAuVjuxDQwGsyjIZA1h
ArFUcO4D4jISnFHY+pnhZK89FPiz/WI4pNODqip/kNwQQQ8Iqn6XBwqhQ4vGTkSE
foGzCZongOvz0c4FSJLvm8mtOux9SvSyCOETVO2i+9A33NiAevLW+oUD93jvOF94
FgLdl0gr7SMwpTPW61EHUEjB4NJUL3djWGQW+zYturF5nQ3AG3YCJLIwcv3Tb5WU
BTH75UcIlBqlN1nKjbvpi7RTZSgf9QVWy9B5GrmhuLN0PqdH0oCTJCvlLNNfuuJw
oAVZqP64JUCMHcIohzKrsHEv43hO3x8IY6DX3bSZqPWmBLN/0qBYuZxtgFh9EGqT
BC3BCR1MecTiFDfCtZtKVMLedeolJIqbVsm5+M4YKoOktYGOSnVBEOVCK7WlqXNk
qn4r3eVFmZU8l9dLbMdo4LtbDWDMeywjbHHcsTHvx0WQ7bwf360=
=ePpo
-----END PGP SIGNATURE-----

--7bsmkxfivdrxowoi--
