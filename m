From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [Patch V3 1/5] ACPICA: Export acpi_buffer_to_resource symbol
Date: Tue, 20 May 2014 23:24:24 +0200
Message-ID: <1782070.yxHZNBOPJ3@vostro.rjw.lan>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com> <1400590764-11108-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400590764-11108-2-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday, May 20, 2014 08:59:20 PM Lan Tianyu wrote:
> The acpi_buffer_to_resource is needed in i2c module
> to convert aml buffer to struct acpi_resource
> 
> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

This isn't necessary on top of current linux-next I believe?  If so,
please do not resend it any more.

> ---
>  drivers/acpi/acpica/rscreate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
> index 75d3690..5828649 100644
> --- a/drivers/acpi/acpica/rscreate.c
> +++ b/drivers/acpi/acpica/rscreate.c
> @@ -112,6 +112,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
>  
>  	return (status);
>  }
> +ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>  
>  /*******************************************************************************
>   *
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
