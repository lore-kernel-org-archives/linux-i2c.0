From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Add device HID for future AMD I2C
 controller
Date: Thu, 10 Mar 2016 10:32:04 +0200
Message-ID: <56E13104.8050307@linux.intel.com>
References: <1457609692-25903-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62409 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbcCJIcJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Mar 2016 03:32:09 -0500
In-Reply-To: <1457609692-25903-1-git-send-email-Xiangliang.Yu@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, rjw@rjwysocki.net, lenb@kernel.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, SPG_Linux_Kernel@amd.com

On 03/10/2016 01:34 PM, Xiangliang Yu wrote:
> Add device HID AMDI0010 to match the AMD ACPI Vendor ID (AMDI) that
> was registered in http://www.uefi.org/acpi_id_list, and the I2C
> controller on future AMD paltform will use the HID instead of AMD0010.
>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> ---
>   drivers/acpi/acpi_apd.c                     | 1 +
>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index d507cf6..d0aad06 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -143,6 +143,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>   	/* Generic apd devices */
>   #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
>   	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
> +	{ "AMDI0010", APD_ADDR(cz_i2c_desc) },
>   	{ "AMD0020", APD_ADDR(cz_uart_desc) },
>   	{ "AMD0030", },
>   #endif
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 438f1b4..d656657 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -123,6 +123,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
>   	{ "80860F41", 0 },
>   	{ "808622C1", 0 },
>   	{ "AMD0010", ACCESS_INTR_MASK },
> +	{ "AMDI0010", ACCESS_INTR_MASK },
>   	{ "AMDI0510", 0 },
>   	{ "APMC0D0F", 0 },
>   	{ }
> --
I guess these changes don't necessarily need to go together? Although I 
think chances to get a conflict is pretty low.

For i2c-designware:
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
