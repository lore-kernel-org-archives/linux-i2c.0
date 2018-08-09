From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
Date: Thu, 9 Aug 2018 14:09:29 +0300
Message-ID: <20180809110929.GD1634@kuha.fi.intel.com>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809091558.4317-5-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 09, 2018 at 11:15:58AM +0200, Hans de Goede wrote:
> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
> i2c-device.
> 
> But in some rare cases the manufacturer has decided to describe multiple
> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
> 
> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> code to support this corner-case.
> 
> This commit introduces a new i2c-multi-instantiate driver which fixes this
> in a different way. This new driver can be built as a module which will
> only loaded on affected systems.
> 
> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> using the driver_data from the acpi_device_id it is binding to to tell it
> which chip-type (and optional irq-resource) to use when instantiating.
> 
> Note this driver depends on a platform device being instantiated for the
> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

<snip>

> +static int i2c_multi_inst_probe(struct platform_device *pdev)
> +{
> +	struct i2c_multi_inst_data *multi;
> +	const struct acpi_device_id *match;
> +	const struct i2c_inst_data *inst_data;
> +	struct i2c_board_info board_info = {};
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev;
> +	char name[32];
> +	int i, ret;
> +
> +	match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!match) {
> +		dev_err(dev, "Error ACPI match data is missing\n");
> +		return -ENODEV;
> +	}
> +	inst_data = (const struct i2c_inst_data *)match->driver_data;
> +
> +	adev = ACPI_COMPANION(dev);
> +
> +	/* Count number of clients to instantiate */
> +	for (i = 0; inst_data[i].type; i++) {}
> +
> +	multi = devm_kmalloc(dev,
> +			offsetof(struct i2c_multi_inst_data, clients[i]),
> +			GFP_KERNEL);
> +	if (!multi)
> +		return -ENOMEM;
> +
> +	multi->num_clients = i;
> +
> +	for (i = 0; i < multi->num_clients; i++) {
> +		memset(&board_info, 0, sizeof(board_info));
> +		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
> +		snprintf(name, sizeof(name), "%s-%s", match->id,
> +			 inst_data[i].type);
> +		board_info.dev_name = name;
> +		board_info.irq = 0;
> +		if (inst_data[i].irq_idx != -1) {
> +			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
> +			if (ret < 0) {
> +				dev_err(dev, "Error requesting irq at index %d: %d\n",
> +					inst_data[i].irq_idx, ret);
> +				goto error;

This seems to assume that we always have GpioInt with assigned for
these devices, but that's wrong. This needs to work with normal
Interrupt type resources as well.

The TI USB PD controller instances (HID 3515) for exmaple have normal
Interrupts assigned to them

Why not use the "irq_idx" with normal interrupts, and add a new member
for the GpioInts, something like gpio_irq_idx?

> +			}
> +			board_info.irq = ret;
> +		}
> +		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
> +		if (!multi->clients[i]) {
> +			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
> +			ret = -ENODEV;
> +			goto error;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, multi);
> +	return 0;
> +
> +error:
> +	while (--i >= 0)
> +		i2c_unregister_device(multi->clients[i]);
> +
> +	return ret;
> +}

Thanks,

-- 
heikki
