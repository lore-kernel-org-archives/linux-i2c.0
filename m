From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/2] i2c: designware: Disable pm for PMIC i2c-bus even
 if there is no _SEM method
Date: Thu, 9 Mar 2017 17:00:37 +0200
Message-ID: <8c2c5e0e-8678-e572-3f7a-3d62853e9b21@linux.intel.com>
References: <20170308084713.4815-1-hdegoede@redhat.com>
 <20170308084713.4815-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15828 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754243AbdCIPBY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 10:01:24 -0500
In-Reply-To: <20170308084713.4815-3-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

+ Tianyu

On 03/08/17 10:47, Hans de Goede wrote:
> Cherrytrail devices use the dw i2c-bus with uid 7 to access their PMIC.
> Even if the i2c-bus to the PMIC is not shared with the SoC's P-Unit
> and i2c-designware-baytrail.c thus does not set the pm_disabled flag,
> we still need to disable pm so that ACPI PMIC opregions can access the
> PMIC during late-suspend and early-resume.
>
> This fixes errors like these blocking suspend:
>
>   i2c_designware 808622C1:06: timeout waiting for bus ready
>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>   acpi 80860F14:02: Failed to change power state to D3hot
>   PM: late suspend of devices failed
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 8ed96dd..08d609e 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -94,7 +94,10 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
>  static int dw_i2c_acpi_configure(struct platform_device *pdev)
>  {
>  	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> +	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
>  	const struct acpi_device_id *id;
> +	struct acpi_device *adev;
> +	const char *uid;
>
>  	dev->adapter.nr = -1;
>  	dev->tx_fifo_depth = 32;
> @@ -114,6 +117,18 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
>  	if (id && id->driver_data)
>  		dev->flags |= (u32)id->driver_data;
>
> +	if (acpi_bus_get_device(handle, &adev))
> +		return -ENODEV;
> +
> +	/*
> +	 * Cherrytrail I2C7 gets used for the PMIC which gets accessed
> +	 * through ACPI opregions during late suspend / early resume
> +	 * disable pm for it.
> +	 */
> +	uid = adev->pnp.unique_id;
> +	if ((dev->flags & MODEL_CHERRYTRAIL) && !strcmp(uid, "7"))
> +		dev->pm_disabled = true;
> +

I'm fine with this but wondering can this be detected any other way than 
hardcoded bus number.

Tianyu: You are the author of 5d98e61d337c ("I2C/ACPI: Add i2c ACPI 
operation region support"). Do you know is there way to see is there a 
PMIC connected to the bus?

Jarkko Nikula <jarkko.nikula@linux.intel.com>
