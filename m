From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/8] mfd: core: redo ACPI matching of the children
 devices
Date: Thu, 1 Oct 2015 15:54:36 +0100
Message-ID: <20151001145436.GD3214@x1>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1443698430-74415-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443698430-74415-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 01 Oct 2015, Andy Shevchenko wrote:

> There is at least one board on the market, i.e. Intel Galileo Gen2, t=
hat uses
> _ADR to distinguish the devices under one actual device. Due to this =
we have to
> improve the quirk in the MFD core to handle that board.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/acpi/enumeration.txt | 11 +++++---
>  drivers/mfd/mfd-core.c             | 52 ++++++++++++++++++++++++++--=
----------
>  include/linux/mfd/core.h           | 10 ++++++--
>  3 files changed, 52 insertions(+), 21 deletions(-)

This whole patch still needs an ACPI Ack.

> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/=
enumeration.txt
> index b731b29..a91ec5a 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -347,13 +347,18 @@ For the first case, the MFD drivers do not need=
 to do anything. The
>  resulting child platform device will have its ACPI_COMPANION() set t=
o point
>  to the parent device.
> =20
> -If the ACPI namespace has a device that we can match using an ACPI i=
d,
> -the id should be set like:
> +If the ACPI namespace has a device that we can match using an ACPI i=
d or ACPI
> +adr, the cell should be set like:
> +
> +	static struct mfd_cell_acpi_match my_subdevice_cell_acpi_match =3D =
{
> +		.pnpid =3D "XYZ0001",
> +		.adr =3D 0,
> +	};
> =20
>  	static struct mfd_cell my_subdevice_cell =3D {
>  		.name =3D "my_subdevice",
>  		/* set the resources relative to the parent */
> -		.acpi_pnpid =3D "XYZ0001",
> +		.acpi_match =3D &my_subdevice_cell_acpi_match,
>  	};
> =20
>  The ACPI id "XYZ0001" is then used to lookup an ACPI device directly=
 under
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index c17635d..60b60dc 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -82,29 +82,49 @@ static int mfd_platform_add_cell(struct platform_=
device *pdev,
>  static void mfd_acpi_add_device(const struct mfd_cell *cell,
>  				struct platform_device *pdev)
>  {
> -	struct acpi_device *parent_adev;
> +	const struct mfd_cell_acpi_match *match =3D cell->acpi_match;
> +	struct acpi_device *parent, *child;
>  	struct acpi_device *adev;
> =20
> -	parent_adev =3D ACPI_COMPANION(pdev->dev.parent);
> -	if (!parent_adev)
> +	parent =3D ACPI_COMPANION(pdev->dev.parent);
> +	if (!parent)
>  		return;
> =20
>  	/*
> -	 * MFD child device gets its ACPI handle either from the ACPI
> -	 * device directly under the parent that matches the acpi_pnpid or
> -	 * it will use the parent handle if is no acpi_pnpid is given.
> +	 * MFD child device gets its ACPI handle either from the ACPI devic=
e
> +	 * directly under the parent that matches the either _HID or _CID, =
or
> +	 * _ADR or it will use the parent handle if is no ID is given.
> +	 *
> +	 * Note that use of _ADR is a grey area in the ACPI specification,
> +	 * though Intel Galileo Gen2 is using it to distinguish the childre=
n
> +	 * devices.
>  	 */
> -	adev =3D parent_adev;
> -	if (cell->acpi_pnpid) {
> -		struct acpi_device_id ids[2] =3D {};
> -		struct acpi_device *child_adev;
> -
> -		strlcpy(ids[0].id, cell->acpi_pnpid, sizeof(ids[0].id));
> -		list_for_each_entry(child_adev, &parent_adev->children, node)
> -			if (acpi_match_device_ids(child_adev, ids)) {
> -				adev =3D child_adev;
> -				break;
> +	adev =3D parent;
> +	if (match) {
> +		if (match->pnpid) {
> +			struct acpi_device_id ids[2] =3D {};
> +
> +			strlcpy(ids[0].id, match->pnpid, sizeof(ids[0].id));
> +			list_for_each_entry(child, &parent->children, node) {
> +				if (acpi_match_device_ids(child, ids)) {
> +					adev =3D child;
> +					break;
> +				}
> +			}
> +		} else {
> +			unsigned long long adr;
> +			acpi_status status;
> +
> +			list_for_each_entry(child, &parent->children, node) {
> +				status =3D acpi_evaluate_integer(child->handle,
> +							       "_ADR", NULL,
> +							       &adr);
> +				if (ACPI_SUCCESS(status) && match->adr =3D=3D adr) {
> +					adev =3D child;
> +					break;
> +				}
>  			}
> +		}
>  	}
> =20
>  	ACPI_COMPANION_SET(&pdev->dev, adev);
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index a76bc10..27dac3f 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -18,6 +18,12 @@
> =20
>  struct irq_domain;
> =20
> +/* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
> +struct mfd_cell_acpi_match {
> +	const char			*pnpid;
> +	const unsigned long long	adr;
> +};
> +
>  /*
>   * This struct describes the MFD part ("cell").
>   * After registration the copy of this structure will become the pla=
tform data
> @@ -44,8 +50,8 @@ struct mfd_cell {
>  	 */
>  	const char		*of_compatible;
> =20
> -	/* Matches ACPI PNP id, either _HID or _CID */
> -	const char		*acpi_pnpid;
> +	/* Matches ACPI */
> +	const struct mfd_cell_acpi_match	*acpi_match;
> =20
>  	/*
>  	 * These resources can be specified relative to the parent device.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
