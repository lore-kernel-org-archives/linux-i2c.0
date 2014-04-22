From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Resend Patch 3/9] ACPI: Add acpi_bus_attach_private_data() to
 facilitate to attach data to ACPI handle
Date: Tue, 22 Apr 2014 14:23:31 +0300
Message-ID: <20140422112331.GG30677@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398147855-9868-4-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 22, 2014 at 02:24:09PM +0800, Lan Tianyu wrote:
> There is already acpi_bus_get_private_data() to get ACPI handle data
> which is associated with acpi_bus_private_data_handler(). This patch
> is to add acpi_bus_attach_private_data() to make a pair and facilitate
> to attach and get data to/from ACPI handle.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/bus.c      | 18 +++++++++++++++++-
>  include/acpi/acpi_bus.h |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index e7e5844..4ed8d48 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -132,6 +132,22 @@ void acpi_bus_private_data_handler(acpi_handle handle,
>  }
>  EXPORT_SYMBOL(acpi_bus_private_data_handler);
>  
> +int acpi_bus_attach_private_data(acpi_handle handle, void *data)
> +{
> +	acpi_status status;
> +
> +	status = acpi_attach_data(handle,
> +			acpi_bus_private_data_handler, data);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_ERROR((AE_INFO, "Error attaching device[%p] data\n",
> +				handle));
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_bus_attach_private_data);

When I added GPIO operation region support, Rafael mentioned that we might
want to add this private data to the struct acpi_device instead.

Either way, looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
