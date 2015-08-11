From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v3] driver/i2c/mux: Add register-based mux i2c-mux-reg
Date: Tue, 11 Aug 2015 08:55:11 -0700
Message-ID: <55CA1ADF.200@freescale.com>
References: <1434657458-16553-1-git-send-email-yorksun@freescale.com> <20150811153916.GD1525@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811153916.GD1525@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 08/11/2015 08:39 AM, Wolfram Sang wrote:
> On Thu, Jun 18, 2015 at 12:57:38PM -0700, York Sun wrote:
>> Based on i2c-mux-gpio driver, similarly the register-based mux
>> switch from one bus to another by setting a single register.
>> The register can be on PCIe bus, local bus, or any memory-mapped
>> address. The endianness of such register can be specified in device
>> tree if used, or in platform data.
>>
>> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Thanks for this driver!
> 
> ...
> 
>> +- no-read: The existence indicates reading the register is not allowed.
> 
> Given that we have "read-only" properties already, I'd prefer this one
> to be "write-only".

Sure. That's easy to fix.

> 
>> +For each i2c child node, an I2C child bus will be created. They will
>> +be numbered based on their order in the device tree.
> 
> This is a Linux specific detail (which can be overridden by aliases), so
> it should not be in this document, I'd say.

OK. I can remove it.

> 
>> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
>> index f6d313e..77c1257 100644
>> --- a/drivers/i2c/muxes/Kconfig
>> +++ b/drivers/i2c/muxes/Kconfig
>> @@ -29,6 +29,17 @@ config I2C_MUX_GPIO
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called i2c-mux-gpio.
>>  
>> +config I2C_MUX_REG
>> +	tristate "Register-based I2C multiplexer"
>> +	help
>> +	  If you say yes to this option, support will be included for a
>> +	  register based I2C multiplexer. This driver provides access to
>> +	  I2C busses connected through a MUX, which is controlled
>> +	  by a sinple register.
> 
> Typo here. And keep the sorting, please.

Will fix.

> 
>>  obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
>> +obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
> 
> Keep the sorting, please.
> 
>>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
>>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
>>  obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
> 
>> +	adapter = of_find_i2c_adapter_by_node(adapter_np);
>> +	if (!adapter) {
>> +		dev_err(&pdev->dev, "Cannot find parent bus\n");
> 
> I don't think we should print something when deferring.

OK.

> 
>> +		return -EPROBE_DEFER;
>> +	}
>> +	mux->parent = adapter;
>> +	mux->data.parent = i2c_adapter_id(adapter);
>> +	put_device(&adapter->dev);
>> +
>> +	mux->data.n_values = of_get_child_count(np);
>> +	if (of_find_property(np, "little-endian", NULL)) {
> 
> You should check for a "big-endian" property as well, no?

I use the little-endian as an option to indicate the nature of litten-endian
register. It is default to big-endian if this property doesn't exist. I prefer
this way unless you strongly suggest to add both and throw out an error if
neither exists.

> 
>> +		parent = i2c_get_adapter(mux->data.parent);
>> +		if (!parent) {
>> +			dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
>> +				mux->data.parent);
>> +			return -EPROBE_DEFER;
> 
> Ditto about printing when deferred probing.

OK.

> 
>> +static int i2c_mux_reg_remove(struct platform_device *pdev)
>> +{
>> +	struct regmux *mux = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i = 0; i < mux->data.n_values; i++)
>> +		i2c_del_mux_adapter(mux->adap[i]);
>> +
>> +	i2c_put_adapter(mux->parent);
>> +
>> +	dev_dbg(&pdev->dev, "Removed\n");
> 
> No need for that debug. The driver core has debug output for that.

Will remove.

Thanks for reviewing. I will send a new version after testing.

York
