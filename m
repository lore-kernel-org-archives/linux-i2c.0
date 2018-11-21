From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 14/15] ACPI / scan: Create platform device for BOSC0200
 ACPI nodes
Date: Wed, 21 Nov 2018 13:29:38 +0100
Message-ID: <86b36781-a95f-f280-759a-c4865be603a2@redhat.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-15-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120155924.10773-15-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Steven Presser <steve@pressers.name>
List-Id: linux-i2c@vger.kernel.org

HI,

On 20-11-18 16:59, Andy Shevchenko wrote:
> On some laptops the ACPI device with BOSC0200 _HID is representing
> two accelerometers under one node.
> 
> We add an ID to the I2C multi instantiate list to enumerate
> all I2C slaves correctly.
> 
> For reference here is the relevant DSDT blurb from the Yoga 11e:
> 
> Device (ACC)
> {
> 	Name (_ADR, Zero)  // _ADR: Address
> 	Name (_HID, "BOSC0200")  // _HID: Hardware ID
> 	Name (_CID, "BOSC0200")  // _CID: Compatible ID
> 	Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> 	Name (_UID, One)  // _UID: Unique ID
> 	Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> 	{
> 		Name (RBUF, ResourceTemplate ()
> 		{
> 			I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
> 				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
> 				0x00, ResourceConsumer, , Exclusive,
> 			)
> 			I2cSerialBusV2 (0x0018, ControllerInitiated, 0x00061A80,
> 				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
> 				0x00, ResourceConsumer, , Exclusive,
> 			)
> 		})
> 		Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
> 	}
> 
> Reported-by: Jeremy Cline <jeremy@jcline.org>
> Cc: Steven Presser <steve@pressers.name>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

So as already discussed switching all devices which define a BOSC0200
device in their ACPI tables to using i2c-multi-instantiate.c will
break the orientation quirks in udev's hwdb since those go by
the modalias and this will change the modalias from acpi:BOSC0200:BOSC0200
to i2c:bmc150_accel

After our last discussion I've been thinking about this and I think the
best solution is something like this in drivers/acpi/scan.c:

#define I2C_MULTI_INST_FORCE      0x01

         static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
                 {"BOSC0200", },
                 {"BSG1160", },
                 {"INT33FE", I2C_MULTI_INST_FORCE},
                 {"INT3515", },
                 {}
         };
	const struct acpi_device_id *id = NULL;

         ...

	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to? */
	__acpi_match_device(device, i2c_multi_instantiate_ids, NULL, &id, NULL);
	if (id) {
		if (id->driver_data & I2C_MULTI_INST_FORCE)
			return false;

                 count = i2c_multi_inst_count_resources(device);
		if (count > 1)
			return false;
	}

This way we only move to a platform-device + i2c-multi-inst for BOSC0200
devices on devices which actually have multiple accelerometers defined
in the node, avoiding the problem of breaking hwdb for existing devices.

Note arguably the force flag should be set on all existing entries in
the i2c_multi_instantiate_ids, but at least the BSG1160 entry is expected
to always have multiple I2cSerialBus resources and I guess the same may
apply to the INT3515 case

The weird BYT/CHT INT33FE fake battery device is special and we always
need to not create an i2c-client for it, so that we ignore the
clkrate / speed from its bogus first and sometimes only I2cSerialBus resource.

Regards,

Hans







> ---
>   drivers/acpi/scan.c                          | 1 +
>   drivers/iio/accel/bmc150-accel-i2c.c         | 1 -
>   drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e9eda5558c1f..e46c877fa9f1 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1539,6 +1539,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>   	 * which i2c_device_id to use for each resource.
>   	 */
>   	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
> +		{"BOSC0200", },
>   		{"BSG1160", },
>   		{"INT33FE", },
>   		{"INT3515", },
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 8ffc308d5fd0..9d22a4d9d568 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -64,7 +64,6 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>   	{"BMA250E",	bma250e},
>   	{"BMA222E",	bma222e},
>   	{"BMA0280",	bma280},
> -	{"BOSC0200"},
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index efaf34cbbc7b..c90137d30a98 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -151,6 +151,12 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct i2c_inst_data bosc0200_data[]  = {
> +	{ "bmc150_accel" },
> +	{ "bmc150_accel" },
> +	{}
> +};
> +
>   static const struct i2c_inst_data bsg1160_data[]  = {
>   	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
>   	{ "bmc150_magn" },
> @@ -171,6 +177,7 @@ static const struct i2c_inst_data int3515_data[]  = {
>    * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>    */
>   static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
> +	{ "BOSC0200", (unsigned long)bosc0200_data },
>   	{ "BSG1160", (unsigned long)bsg1160_data },
>   	{ "INT3515", (unsigned long)int3515_data },
>   	{ }
> 
