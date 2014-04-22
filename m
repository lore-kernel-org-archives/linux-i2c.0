From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Resend Patch 8/9] I2C/ACPI: Move ACPI related code to i2c-acpi.c
Date: Tue, 22 Apr 2014 14:38:27 +0300
Message-ID: <20140422113827.GL30677@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-9-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398147855-9868-9-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 22, 2014 at 02:24:14PM +0800, Lan Tianyu wrote:
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 681e689..fc1ef42 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -586,7 +586,10 @@ static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node
>  #ifdef CONFIG_ACPI
>  int acpi_i2c_install_space_handler(struct i2c_adapter *adapter);
>  void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter);
> +void acpi_i2c_register_devices(struct i2c_adapter *adap);
>  #else
> +static inline void acpi_i2c_register_devices(struct i2c_adapter *adap) {};

Semicolon is not needed here.

Apart from that,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
