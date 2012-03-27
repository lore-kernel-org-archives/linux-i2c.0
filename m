From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Convert i2c-octeon.c to use device tree.
Date: Mon, 26 Mar 2012 20:22:02 -0500
Message-ID: <4F71163A.5090309@gmail.com>
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com> <1332808075-8333-2-git-send-email-ddaney.cavm@gmail.com> <4F7115FA.6080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F7115FA.6080507-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/26/2012 08:20 PM, Rob Herring wrote:
> On 03/26/2012 07:27 PM, David Daney wrote:
>> From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> There are three parts to this:
>>
>> 1) Remove the definitions of OCTEON_IRQ_TWSI and OCTEON_IRQ_TWSI2.
>>    The interrupts are specified by the device tree and these hard
>>    coded irq numbers block the used of the irq lines by the irq_domain
>>    code.
>>
>> 2) Remove platform device setup code from octeon-platform.c, it is
>>    now unused.
>>
>> 3) Convert i2c-octeon.c to use device tree.  Part of this includes
>>    using the devm_* functions instead of the raw counterparts, thus
>>    simplifying error handling.  No functionality is changed.
> 
> Shouldn't this patch go after converting the platform to DT?

Nevermind this comment...

> 
>> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> ---
>>
>> Should probably go via Ralf's linux-mips.org tree.
>>
>>  arch/mips/cavium-octeon/octeon-irq.c      |    2 -
>>  arch/mips/cavium-octeon/octeon-platform.c |   84 -------------------------
>>  arch/mips/include/asm/octeon/octeon.h     |    5 --
>>  drivers/i2c/busses/i2c-octeon.c           |   94 ++++++++++++++++-------------
>>  4 files changed, 52 insertions(+), 133 deletions(-)
> 
> snip
> 
>>  
>> -	if (i2c_data == NULL) {
>> -		dev_err(i2c->dev, "no I2C frequency data\n");
>> +	/*
>> +	 * "clock-rate" is a legacy binding, the official binding is
>> +	 * "clock-frequency".  Try the official one first and then
>> +	 * fall back if it doesn't exist.
>> +	 */
>> +	data = of_get_property(pdev->dev.of_node, "clock-frequency", &len);
>> +	if (!data || len != sizeof(*data))
>> +		data = of_get_property(pdev->dev.of_node, "clock-rate", &len);
>> +	if (data && len == sizeof(*data)) {
>> +		i2c->twsi_freq = be32_to_cpup(data);
> 
> Can't you use of_property_read_u32?
> 
> Does the legacy binding really exist as DT support is new?
> 
> Otherwise,
> 
> Acked-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> 
>> +	} else {
>> +		dev_err(i2c->dev,
>> +			"no I2C 'clock-rate' or 'clock-frequency' property\n");
>>  		result = -ENXIO;
>> -		goto fail_region;
>> +		goto out;
>>  	}
>>  
>> -	i2c->twsi_phys = res_mem->start;
>> -	i2c->regsize = resource_size(res_mem);
>> -	i2c->twsi_freq = i2c_data->i2c_freq;
>> -	i2c->sys_freq = i2c_data->sys_freq;
>> +	i2c->sys_freq = octeon_get_io_clock_rate();
>>  
>> -	if (!request_mem_region(i2c->twsi_phys, i2c->regsize, res_mem->name)) {
>> +	if (!devm_request_mem_region(&pdev->dev, i2c->twsi_phys, i2c->regsize,
>> +				      res_mem->name)) {
>>  		dev_err(i2c->dev, "request_mem_region failed\n");
>> -		goto fail_region;
>> +		goto out;
>>  	}
>> -	i2c->twsi_base = ioremap(i2c->twsi_phys, i2c->regsize);
>> +	i2c->twsi_base = devm_ioremap(&pdev->dev, i2c->twsi_phys, i2c->regsize);
>>  
>>  	init_waitqueue_head(&i2c->queue);
>>  
>>  	i2c->irq = irq;
>>  
>> -	result = request_irq(i2c->irq, octeon_i2c_isr, 0, DRV_NAME, i2c);
>> +	result = devm_request_irq(&pdev->dev, i2c->irq,
>> +				  octeon_i2c_isr, 0, DRV_NAME, i2c);
>>  	if (result < 0) {
>>  		dev_err(i2c->dev, "failed to attach interrupt\n");
>> -		goto fail_irq;
>> +		goto out;
>>  	}
>>  
>>  	result = octeon_i2c_initlowlevel(i2c);
>>  	if (result) {
>>  		dev_err(i2c->dev, "init low level failed\n");
>> -		goto  fail_add;
>> +		goto  out;
>>  	}
>>  
>>  	result = octeon_i2c_setclock(i2c);
>>  	if (result) {
>>  		dev_err(i2c->dev, "clock init failed\n");
>> -		goto  fail_add;
>> +		goto  out;
>>  	}
>>  
>>  	i2c->adap = octeon_i2c_ops;
>>  	i2c->adap.dev.parent = &pdev->dev;
>> -	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
>> +	i2c->adap.dev.of_node = pdev->dev.of_node;
>>  	i2c_set_adapdata(&i2c->adap, i2c);
>>  	platform_set_drvdata(pdev, i2c);
>>  
>> -	result = i2c_add_numbered_adapter(&i2c->adap);
>> +	result = i2c_add_adapter(&i2c->adap);
>>  	if (result < 0) {
>>  		dev_err(i2c->dev, "failed to add adapter\n");
>>  		goto fail_add;
>>  	}
>> -
>>  	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
>>  
>> -	return result;
>> +	of_i2c_register_devices(&i2c->adap);
>> +
>> +	return 0;
>>  
>>  fail_add:
>>  	platform_set_drvdata(pdev, NULL);
>> -	free_irq(i2c->irq, i2c);
>> -fail_irq:
>> -	iounmap(i2c->twsi_base);
>> -	release_mem_region(i2c->twsi_phys, i2c->regsize);
>> -fail_region:
>> -	kfree(i2c);
>>  out:
>>  	return result;
>>  };
>> @@ -613,19 +619,24 @@ static int __devexit octeon_i2c_remove(struct platform_device *pdev)
>>  
>>  	i2c_del_adapter(&i2c->adap);
>>  	platform_set_drvdata(pdev, NULL);
>> -	free_irq(i2c->irq, i2c);
>> -	iounmap(i2c->twsi_base);
>> -	release_mem_region(i2c->twsi_phys, i2c->regsize);
>> -	kfree(i2c);
>>  	return 0;
>>  };
>>  
>> +static struct of_device_id octeon_i2c_match[] = {
>> +	{
>> +		.compatible = "cavium,octeon-3860-twsi",
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, octeon_i2c_match);
>> +
>>  static struct platform_driver octeon_i2c_driver = {
>>  	.probe		= octeon_i2c_probe,
>>  	.remove		= __devexit_p(octeon_i2c_remove),
>>  	.driver		= {
>>  		.owner	= THIS_MODULE,
>>  		.name	= DRV_NAME,
>> +		.of_match_table = octeon_i2c_match,
>>  	},
>>  };
>>  
>> @@ -635,4 +646,3 @@ MODULE_AUTHOR("Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>");
>>  MODULE_DESCRIPTION("I2C-Bus adapter for Cavium OCTEON processors");
>>  MODULE_LICENSE("GPL");
>>  MODULE_VERSION(DRV_VERSION);
>> -MODULE_ALIAS("platform:" DRV_NAME);
> 
