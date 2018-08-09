From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 3/4] ACPI / x86-utils: Remove status workaround from
 acpi_device_always_present()
Date: Thu, 09 Aug 2018 13:08:47 +0300
Message-ID: <cddf24980ccbb312f1e02eed632038fc0aa8b6fe.camel@linux.intel.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
         <20180809091558.4317-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809091558.4317-4-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2018-08-09 at 11:15 +0200, Hans de Goede wrote:
> Now that we init the status field to ACPI_STA_DEFAULT rather then to
> 0,
> the workaround for acpi_match_device_ids() always returning -ENOENT
> when
> status is 0 is no longer needed.
> 

Always good to have only "minus" statistics

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patch-set
> ---
>  drivers/acpi/x86/utils.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index ec5b0f190231..a4fb97d64b3b 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -103,13 +103,9 @@ static const struct always_present_id
> always_present_ids[] = {
>  
>  bool acpi_device_always_present(struct acpi_device *adev)
>  {
> -	u32 *status = (u32 *)&adev->status;
> -	u32 old_status = *status;
>  	bool ret = false;
>  	unsigned int i;
>  
> -	/* acpi_match_device_ids checks status, so set it to default */
> -	*status = ACPI_STA_DEFAULT;
>  	for (i = 0; i < ARRAY_SIZE(always_present_ids); i++) {
>  		if (acpi_match_device_ids(adev,
> always_present_ids[i].hid))
>  			continue;
> @@ -125,15 +121,9 @@ bool acpi_device_always_present(struct
> acpi_device *adev)
>  		    !dmi_check_system(always_present_ids[i].dmi_ids))
>  			continue;
>  
> -		if (old_status != ACPI_STA_DEFAULT) /* Log only once */
> -			dev_info(&adev->dev,
> -				 "Device [%s] is in always present
> list\n",
> -				 adev->pnp.bus_id);
> -
>  		ret = true;
>  		break;
>  	}
> -	*status = old_status;
>  
>  	return ret;
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
