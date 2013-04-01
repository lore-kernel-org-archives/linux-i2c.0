From: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI / I2C: Use parent's ACPI_HANDLE() in acpi_i2c_register_devices()
Date: Mon, 01 Apr 2013 09:27:41 +0800
Message-ID: <5158E28D.6040403@intel.com>
References: <2966020.zlpeyGGUDW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2966020.zlpeyGGUDW-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/01/2013 08:25 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The ACPI handle of struct i2c_adapter's dev member should not be
> set, because this causes that struct i2c_adapter to be associated
> with the ACPI device node corresponding to its parent as the
> second "physical_device", which is incorrect (this happens during
> the registration of struct i2c_adapter).  Consequently,
> acpi_i2c_register_devices() should use the ACPI handle of the
> parent of the struct i2c_adapter it is called for rather than the
> struct i2c_adapter's ACPI handle (which should be NULL).
> 
> Make that happen and modify the i2c-designware-platdrv driver,
> which currently is the only driver for ACPI-enumerated I2C
> controller chips, not to set the ACPI handle for the
> struct i2c_adapter it creates.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Thanks,
Aaron

> ---
>  drivers/acpi/acpi_i2c.c                     |    2 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpi_i2c.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_i2c.c
> +++ linux-pm/drivers/acpi/acpi_i2c.c
> @@ -90,7 +90,7 @@ void acpi_i2c_register_devices(struct i2
>  	acpi_handle handle;
>  	acpi_status status;
>  
> -	handle = ACPI_HANDLE(&adapter->dev);
> +	handle = ACPI_HANDLE(adapter->dev.parent);
>  	if (!handle)
>  		return;
>  
> Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> ===================================================================
> --- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -182,7 +182,6 @@ static int dw_i2c_probe(struct platform_
>  	adap->algo = &i2c_dw_algo;
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
> -	ACPI_HANDLE_SET(&adap->dev, ACPI_HANDLE(&pdev->dev));
>  
>  	r = i2c_add_numbered_adapter(adap);
>  	if (r) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
