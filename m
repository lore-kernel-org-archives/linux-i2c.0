From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [net-next,v3 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Date: Tue, 28 May 2019 13:42:08 +0300
Message-ID: <20190528104208.GE2781@lahna.fi.intel.com>
References: <20190528032213.19839-1-ruslan@babayev.com>
 <20190528032213.19839-3-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528032213.19839-3-ruslan@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>
Cc: wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 27, 2019 at 08:22:13PM -0700, Ruslan Babayev wrote:
> +	} else if (ACPI_COMPANION(&pdev->dev)) {

You can also use has_acpi_companion() here.

> +		struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +		struct fwnode_handle *fw = acpi_fwnode_handle(adev);
> +		struct fwnode_reference_args args;
> +		struct acpi_handle *acpi_handle;
> +		int ret;
> +
> +		ret = acpi_node_get_property_reference(fw, "i2c-bus", 0, &args);
> +		if (ACPI_FAILURE(ret) || !is_acpi_device_node(args.fwnode)) {
> +			dev_err(&pdev->dev, "missing 'i2c-bus' property\n");
> +			return -ENODEV;
>  		}
> +
> +		acpi_handle = ACPI_HANDLE_FWNODE(args.fwnode);
> +		i2c = i2c_acpi_find_adapter_by_handle(acpi_handle);
> +	}
> +
> +	if (!i2c)
> +		return -EPROBE_DEFER;
> +
> +	err = sfp_i2c_configure(sfp, i2c);
> +	if (err < 0) {
> +		i2c_put_adapter(i2c);
> +		return err;

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
