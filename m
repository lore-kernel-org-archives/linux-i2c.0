From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH net-next v2 1/2] i2c: acpi: export
 i2c_acpi_find_adapter_by_handle
Date: Mon, 27 May 2019 11:39:43 +0300
Message-ID: <20190527083943.GX2781@lahna.fi.intel.com>
References: <20190505193435.3248-1-ruslan@babayev.com>
 <20190525005302.27164-1-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190525005302.27164-1-ruslan@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, xe-linux-external@cisco.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 24, 2019 at 05:53:01PM -0700, Ruslan Babayev wrote:
> +struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
>  #else
>  static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
>  					     struct acpi_resource_i2c_serialbus **i2c)
> @@ -996,6 +998,10 @@ static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
>  {
>  	return NULL;
>  }
> +struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)

This should be static inline, I think.

> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_ACPI */
>  
>  #endif /* _LINUX_I2C_H */
> -- 
> 2.17.1
