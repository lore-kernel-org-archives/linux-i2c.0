From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2 1/2] acpi: support IBM SMBus CMI devices
Date: Tue, 27 Oct 2009 18:03:32 +0100
Message-ID: <20091027180332.62f2c758@hyperion.delvare>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com>
	<20091021023016.GC32413@crane-desktop>
	<200910210857.13978.bjorn.helgaas@hp.com>
	<20091021173733.GN26149@tux1.beaverton.ibm.com>
	<20091022071748.GA17917@crane-desktop>
	<20091022174304.GO26149@tux1.beaverton.ibm.com>
	<20091023044451.GB1367@crane-desktop>
	<20091023170311.GC21723@tux1.beaverton.ibm.com>
	<20091025125353.55d3bfad@hyperion.delvare>
	<20091026205819.GR26149@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091026205819.GR26149@tux1.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: djwong@us.ibm.com
Cc: Crane Cai <crane.cai@amd.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Oct 2009 13:58:19 -0700, Darrick J. Wong wrote:
> On some old IBM workstations and desktop computers, the BIOS presents in the
> DSDT an SMBus object that is missing the HID identifier that the i2c-scmi
> driver looks for.  Modify the ACPI device scan code to insert the missing HID
> if it finds an IBM system with such an object.  This patch needs Crane Cai's
> update to i2c-scmi to work around incorrectly named methods within the SMBus
> control object.
> 
> Affected machines: IntelliStation Z20/Z30.  Note that the i2c-i801 driver no
> longer works on these machines because of ACPI resource conflicts.
> 
> v2 contains minor tweaks suggested by Jean Delvare.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/acpi/scan.c         |   38 ++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_drivers.h |    2 ++
>  2 files changed, 40 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 14a7481..5a24429 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -8,6 +8,7 @@
>  #include <linux/acpi.h>
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
> +#include <linux/dmi.h>
>  
>  #include <acpi/acpi_drivers.h>
>  
> @@ -1014,6 +1015,41 @@ static void acpi_add_id(struct acpi_device *device, const char *dev_id)
>  	list_add_tail(&id->list, &device->pnp.ids);
>  }
>  
> +/*
> + * Old IBM workstations have a DSDT bug wherein the SMBus object
> + * lacks the SMBUS01 HID and the methods do not have the necessary "_"
> + * prefix.  Work around this.
> + */
> +static int acpi_ibm_smbus_match(struct acpi_device *device)
> +{
> +	acpi_handle h_dummy;
> +	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int result;
> +
> +	if (!dmi_name_in_vendors("IBM"))
> +		return -ENODEV;
> +
> +	/* Look for SMBS object */
> +	result = acpi_get_name(device->handle, ACPI_SINGLE_NAME, &path);
> +	if (result)
> +		return result;
> +
> +	if (strcmp("SMBS", path.pointer)) {
> +		result = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* Does it have the necessary (but misnamed) methods? */
> +	result = -ENODEV;
> +	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "SBI", &h_dummy)) &&
> +	    ACPI_SUCCESS(acpi_get_handle(device->handle, "SBR", &h_dummy)) &&
> +	    ACPI_SUCCESS(acpi_get_handle(device->handle, "SBW", &h_dummy)))
> +		result = 0;
> +out:
> +	kfree(path.pointer);
> +	return result;
> +}

I'm only half please with this. You change the function named, but it
doesn't follow the calling convention of acpi_dock_match(), which is a
little confusing.

Anyway, I will need an ack from the ACPI people before I can pick this
patch. Or maybe they should even push it upstream themselves.

> +
>  static void acpi_device_set_id(struct acpi_device *device)
>  {
>  	acpi_status status;
> @@ -1064,6 +1100,8 @@ static void acpi_device_set_id(struct acpi_device *device)
>  			acpi_add_id(device, ACPI_BAY_HID);
>  		else if (ACPI_SUCCESS(acpi_dock_match(device)))
>  			acpi_add_id(device, ACPI_DOCK_HID);
> +		else if (!acpi_ibm_smbus_match(device))
> +			acpi_add_id(device, ACPI_SMBUS_IBM_HID);
>  
>  		break;
>  	case ACPI_BUS_TYPE_POWER:
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index f4906f6..83a2960 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -65,6 +65,8 @@
>  #define ACPI_VIDEO_HID			"LNXVIDEO"
>  #define ACPI_BAY_HID			"LNXIOBAY"
>  #define ACPI_DOCK_HID			"LNXDOCK"
> +/* Quirk for broken IBM BIOSes */
> +#define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
>  
>  /*
>   * For fixed hardware buttons, we fabricate acpi_devices with HID


-- 
Jean Delvare
