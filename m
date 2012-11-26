From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: Add support for device-tree based chip initialization
Date: Mon, 26 Nov 2012 10:43:38 -0600
Message-ID: <50B39C3A.5080600@gmail.com>
References: <1353905636-6697-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353905636-6697-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/25/2012 10:53 PM, Guenter Roeck wrote:
> Some I2C devices are not or not correctly initialized by the firmware.
> Configuration would be possible via platform data, but that would require
> per-driver platform data and a lot of code, and changing it would not be
> possible without re-compiling the kernel. It is more elegant to do it
> generically via devicetree properties.
> 
> Add a generic I2C devicetree property named "reg-init". This property provides
> a sequence of device initialization commands to be executed prior to calling
> the probe function for a given device.
> 
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
> Any comments / feedback ?

This has been discussed before in terms of memory mapped registers. I
think this is of questionable use of DT and could easily be abused. Not
all systems use DT, so this needs to be solved without DT anyway.

Do you have examples of drivers that would use this?

Can this be handled in userspace using the i2c device interface before
loading the device's module?

Rob

> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   24 +++++++
>  drivers/i2c/i2c-core.c                             |   68 ++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 2f5322b..33b694e 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -2,6 +2,30 @@ This is a list of trivial i2c devices that have simple device tree
>  bindings, consisting only of a compatible field, an address and
>  possibly an interrupt line.
>  
> +Device initialization is supported with an optional reg-init property.
> +This property contains a sequence of commands to be written into the chip.
> +Each command consists of four values: Register, command type, mask, and data.
> +	Register:
> +		Register or command address
> +	Command type:
> +		0: SMBus write byte
> +		1: SMBus write byte data
> +		2: SMBus write word data
> +	Mask:
> +		If set, the register is read and masked with this value.
> +	Data:
> +		Data to be written (or with original data and mask if set)
> +
> +Example:
> +	max6696@1a {
> +		compatible = "maxim,max6696";
> +		reg = <0x1a>;
> +		reg-init = <
> +			0x09 1 0x00 0x24
> +			0x21 1 0x00 0x05
> +		>;
> +	};
> +
>  If a device needs more specific bindings, such as properties to
>  describe some aspect of it, there needs to be a specific binding
>  document for it just like any other devices.
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a7edf98..49f8b74 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -104,6 +104,69 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
>  
> +static int i2c_dev_of_init(struct i2c_client *client, struct device *dev)
> +{
> +	const u32 *reg_init;
> +	int rlen;
> +	int val;
> +	u32 reg, access, mask, data;
> +
> +	reg_init = of_get_property(dev->of_node, "reg-init", &rlen);
> +	if (!reg_init)
> +		return 0;
> +
> +	if (!rlen || rlen % 4)
> +		return -EINVAL;
> +
> +	while (rlen >= 4) {
> +		reg = reg_init[0];
> +		access = reg_init[1];
> +		mask = reg_init[2];
> +		data = reg_init[3];
> +
> +		if (reg > 0xff)
> +			return -EINVAL;
> +
> +		switch (access) {
> +		default:
> +			return -EINVAL;
> +		case 0:
> +			val = 0;
> +			break;
> +		case 1:
> +			val = mask ? i2c_smbus_read_byte_data(client, reg) : 0;
> +			break;
> +		case 2:
> +			val = mask ? i2c_smbus_read_word_data(client, reg) : 0;
> +			break;
> +		}
> +		if (val < 0)
> +			return val;
> +
> +		val &= mask;
> +		val |= data;
> +
> +		switch (access) {
> +		default:
> +		case 0:
> +			val = i2c_smbus_write_byte(client, reg);
> +			break;
> +		case 1:
> +			val = i2c_smbus_write_byte_data(client, reg, val);
> +			break;
> +		case 2:
> +			val = i2c_smbus_write_word_data(client, reg, val);
> +			break;
> +		}
> +		if (val < 0)
> +			return val;
> +
> +		reg_init += 4;
> +		rlen -= 4 * sizeof(u32);
> +	}
> +	return 0;
> +}
> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client = i2c_verify_client(dev);
> @@ -122,7 +185,12 @@ static int i2c_device_probe(struct device *dev)
>  					client->flags & I2C_CLIENT_WAKE);
>  	dev_dbg(dev, "probe\n");
>  
> +	status = i2c_dev_of_init(client, dev);
> +	if (status)
> +		goto error;
> +
>  	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> +error:
>  	if (status) {
>  		client->driver = NULL;
>  		i2c_set_clientdata(client, NULL);
> 
