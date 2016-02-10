From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 14/16] mfd: intel-lpss: Pass SDA hold time to I2C host
 controller driver
Date: Wed, 10 Feb 2016 16:53:12 +0000
Message-ID: <20160210165312.GO3782@x1>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448896304-87928-15-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448896304-87928-15-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, 30 Nov 2015, Andy Shevchenko wrote:

> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Intel Skylake the LPSS I2C pad circuit has internal delays that requi=
re
> programming non-zero SDA hold time for the I2C host controller. If th=
is is
> not done communication to slave devices may fail with arbitration los=
t
> errors like the one seen below taken from Lenovo Yoga 900:
>=20
>   i2c_hid i2c-SYNA2B29:00: Fetching the HID descriptor
>   i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=3D20 00
>   i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbit=
ration
>=20
> To fix this we follow what the Windows driver is doing and pass the d=
efault
> SDA hold time of 230 ns to all Intel Skylake host controllers. This s=
till
> allows the platform to override these values by passing special ACPI
> methods SSCN and FMCN.
>=20
> Reported-by: Kevin Fenzi <kevin@scrye.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 19 +++++++++++++++++--
>  drivers/mfd/intel-lpss-pci.c  | 31 +++++++++++++++++++++++--------
>  2 files changed, 40 insertions(+), 10 deletions(-)

Seems fine in principle.

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-a=
cpi.c
> index b6fd904..06f00d6 100644
> --- a/drivers/mfd/intel-lpss-acpi.c
> +++ b/drivers/mfd/intel-lpss-acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
> =20
>  #include "intel-lpss.h"
> =20
> @@ -25,6 +26,20 @@ static const struct intel_lpss_platform_info spt_i=
nfo =3D {
>  	.clk_rate =3D 120000000,
>  };
> =20
> +static struct property_entry spt_i2c_properties[] =3D {
> +	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
> +	{ },
> +};
> +
> +static struct property_set spt_i2c_pset =3D {
> +	.properties =3D spt_i2c_properties,
> +};
> +
> +static const struct intel_lpss_platform_info spt_i2c_info =3D {
> +	.clk_rate =3D 120000000,
> +	.pset =3D &spt_i2c_pset,
> +};
> +
>  static const struct intel_lpss_platform_info bxt_info =3D {
>  	.clk_rate =3D 100000000,
>  };
> @@ -35,8 +50,8 @@ static const struct intel_lpss_platform_info bxt_i2=
c_info =3D {
> =20
>  static const struct acpi_device_id intel_lpss_acpi_ids[] =3D {
>  	/* SPT */
> -	{ "INT3446", (kernel_ulong_t)&spt_info },
> -	{ "INT3447", (kernel_ulong_t)&spt_info },
> +	{ "INT3446", (kernel_ulong_t)&spt_i2c_info },
> +	{ "INT3447", (kernel_ulong_t)&spt_i2c_info },
>  	/* BXT */
>  	{ "80860AAC", (kernel_ulong_t)&bxt_i2c_info },
>  	{ "80860ABC", (kernel_ulong_t)&bxt_info },
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pc=
i.c
> index 5bfdfcc..a677480 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -17,6 +17,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
> =20
>  #include "intel-lpss.h"
> =20
> @@ -65,6 +66,20 @@ static const struct intel_lpss_platform_info spt_i=
nfo =3D {
>  	.clk_rate =3D 120000000,
>  };
> =20
> +static struct property_entry spt_i2c_properties[] =3D {
> +	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
> +	{ },
> +};
> +
> +static struct property_set spt_i2c_pset =3D {
> +	.properties =3D spt_i2c_properties,
> +};
> +
> +static const struct intel_lpss_platform_info spt_i2c_info =3D {
> +	.clk_rate =3D 120000000,
> +	.pset =3D &spt_i2c_pset,
> +};
> +
>  static const struct intel_lpss_platform_info spt_uart_info =3D {
>  	.clk_rate =3D 120000000,
>  	.clk_con_id =3D "baudclk",
> @@ -121,20 +136,20 @@ static const struct pci_device_id intel_lpss_pc=
i_ids[] =3D {
>  	{ PCI_VDEVICE(INTEL, 0x9d28), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x9d29), (kernel_ulong_t)&spt_info },
>  	{ PCI_VDEVICE(INTEL, 0x9d2a), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9d60), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9d61), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9d62), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9d63), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9d64), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0x9d65), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d60), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d61), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d62), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d63), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d64), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d65), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x9d66), (kernel_ulong_t)&spt_uart_info },
>  	/* SPT-H */
>  	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0xa129), (kernel_ulong_t)&spt_info },
>  	{ PCI_VDEVICE(INTEL, 0xa12a), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa160), (kernel_ulong_t)&spt_info },
> -	{ PCI_VDEVICE(INTEL, 0xa161), (kernel_ulong_t)&spt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa160), (kernel_ulong_t)&spt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0xa161), (kernel_ulong_t)&spt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0xa166), (kernel_ulong_t)&spt_uart_info },
>  	{ }
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
