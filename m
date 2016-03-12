From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Add device HID for future AMD I2C
 controller
Date: Sat, 12 Mar 2016 17:03:09 +0100
Message-ID: <20160312160309.GL1661@katana>
References: <1457609692-25903-1-git-send-email-Xiangliang.Yu@amd.com>
 <56E13104.8050307@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E13104.8050307@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, rjw@rjwysocki.net, lenb@kernel.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, SPG_Linux_Kernel@amd.com
List-Id: linux-i2c@vger.kernel.org


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2016 at 10:32:04AM +0200, Jarkko Nikula wrote:
> On 03/10/2016 01:34 PM, Xiangliang Yu wrote:
> >Add device HID AMDI0010 to match the AMD ACPI Vendor ID (AMDI) that
> >was registered in http://www.uefi.org/acpi_id_list, and the I2C
> >controller on future AMD paltform will use the HID instead of AMD0010.
> >
> >Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> >---
> >  drivers/acpi/acpi_apd.c                     | 1 +
> >  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> >diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> >index d507cf6..d0aad06 100644
> >--- a/drivers/acpi/acpi_apd.c
> >+++ b/drivers/acpi/acpi_apd.c
> >@@ -143,6 +143,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
> >  	/* Generic apd devices */
> >  #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
> >  	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
> >+	{ "AMDI0010", APD_ADDR(cz_i2c_desc) },
> >  	{ "AMD0020", APD_ADDR(cz_uart_desc) },
> >  	{ "AMD0030", },
> >  #endif
> >diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> >index 438f1b4..d656657 100644
> >--- a/drivers/i2c/busses/i2c-designware-platdrv.c
> >+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> >@@ -123,6 +123,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
> >  	{ "80860F41", 0 },
> >  	{ "808622C1", 0 },
> >  	{ "AMD0010", ACCESS_INTR_MASK },
> >+	{ "AMDI0010", ACCESS_INTR_MASK },
> >  	{ "AMDI0510", 0 },
> >  	{ "APMC0D0F", 0 },
> >  	{ }
> >--
> I guess these changes don't necessarily need to go together? Although I
> think chances to get a conflict is pretty low.

I would have preferred seperate patches, too.

> For i2c-designware:
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

For the record:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5D29AAoJEBQN5MwUoCm2ZwcQAKD6TPmXmdUnXH3U/rijBcSe
BzKzYzAQo8L7JUJM5qoSqRVNkrsH12q7Qlnc2u8tTEmeiTCakEfuQFIg7RujrjCx
YR3GKQ8V3R9tB4ILv6V6tRamNLBpC1idjfGVx96+8347GnbxCUKtT8U3QUxb2kxy
kS5KaKrJn9cmEODY/2XsNmrQh0ucS3IKycNeeB90kwqQFm0wUBwkIyAhIpLMoagy
/DGGRA50egunOckfDtnC1fO4liJB8ciLdgqkqrfkVpTPuRrFLLH2wm9l+ZkL5NJv
bLRK0yj9KEzIZ2JhrSq4/JR4NA2g4ohMIXe8dusKmzfez8wPFYh0mUVmF4JTSsew
AOGTIqLnlpjBBhbTQx60okhMtOMIvWy1SZuaPNgXKKTg7qatTMfnBxo+LZNeLEmT
wJuqjU+AcL79aQnrMXMySJnQWaeEuggf3xZPAJB8Ry9RHBbnpNhccsZEW+jYpv7e
Sak5WxpJ2Maj1J+6LjlpMpw1xDhrWBR7c2r3t1YqbKQ04hLq/QEByeRWIAjAz47i
OJp/Ci2Lu5hmWki+Grwv1twWQ1DPzrVk1ZSpnX2g6saNybsrciNvNZglpynQOT2i
UaGqR42XH8Oc4mS69Qkp0Xx/i3511eRrylJPUr32Z2/vIiIMXMo7VwNBWG63iJmm
iEportPmJSe7Vhq16AKi
=5LVA
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--
