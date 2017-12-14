From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4] i2c: Add support for NXP PCA984x family.
Date: Thu, 14 Dec 2017 10:54:22 +0100
Message-ID: <990e4a1f-a9ac-c899-0075-ae3211ff9475@axentia.se>
References: <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
 <20171213161223.23832-1-adrian.fiergolski@cern.ch>
 <706ae942-a228-32d1-60d9-51c467d36188@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0096.outbound.protection.outlook.com ([104.47.1.96]:9678
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751341AbdLNJyc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 14 Dec 2017 04:54:32 -0500
In-Reply-To: <706ae942-a228-32d1-60d9-51c467d36188@axentia.se>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>

[Adding DT people]

On 2017-12-13 19:26, Peter Rosin wrote:
> On 2017-12-13 17:12, Adrian Fiergolski wrote:
>> This patch exetends the current i2c-mux-pca954x driver and adds support for
> 
> extends
> 
>> a newer PCA984x family of the I2C switches and multiplexers from NXP.
>>
>> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
>> ---
>> As suggested by Peter, for a moment the device_id checks have been removed
>> and need to wait for a support in the I2C core.
>>  .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  5 ++-
>>  drivers/i2c/muxes/Kconfig                          |  6 ++--
>>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 41 +++++++++++++++++++---
>>  3 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>> index aa097045a10e..b428bc0d81b1 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>> @@ -1,10 +1,13 @@
>>  * NXP PCA954x I2C bus switch
>>  
>> +The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
>> +
>>  Required Properties:
>>  
>>    - compatible: Must contain one of the following.
>>      "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
>> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
>> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
>> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"

Sorry for the incremental review, but I thought about a couple of
more issues with this patch...

First, I think that perhaps the new chips should have compatibles
like:

	compatible = "nxp,pca9846", "nxp,pca9546";
	compatible = "nxp,pca9847", "nxp,pca9547";
	compatible = "nxp,pca9848", "nxp,pca9548";

since they are extremely similar to the older chips (the only
difference is the device id support and other esoteric stuff that
you don't need to use). That way the device-tree will work even
with an older OS that only supports pca954x chips. And when you
add the device id check, you can differentiate.

(pca9849 isn't really compatible with any of the pca954x chips since
it lacks interrupt handling)

So, I'm adding the device-tree list to get input on how this is
normally handled. You're going to need their ack anyway on this hunk.
Hint, they also like it when the DT changes are in a separate patch.
You can run get_maintainer.pl on patches to find out where you should
send them.

Second, totally unrelated issues below, ...

>>  
>>    - reg: The I2C address of the device.
>>  
>> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
>> index 0f5c8fc36625..23cc41866a91 100644
>> --- a/drivers/i2c/muxes/Kconfig
>> +++ b/drivers/i2c/muxes/Kconfig
>> @@ -64,11 +64,11 @@ config I2C_MUX_PCA9541
>>  	  will be called i2c-mux-pca9541.
>>  
>>  config I2C_MUX_PCA954x
>> -	tristate "Philips PCA954x I2C Mux/switches"
>> +	tristate "NXP PCA954x I2C Mux/switches"
> 
> I think you should perhaps mention PCA984x here in the headline.
> 
>>  	depends on GPIOLIB || COMPILE_TEST
>>  	help
>> -	  If you say yes here you get support for the Philips PCA954x
>> -	  I2C mux/switch devices.
>> +	  If you say yes here you get support for the NXP PCA954x
>> +	  and PCA984x I2C mux/switch devices.
>>  
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called i2c-mux-pca954x.
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> index 2ca068d8b92d..b4a41d013538 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> @@ -1,14 +1,15 @@
>>  /*
>>   * I2C multiplexer
>>   *
>> + * Copyright (c) 2017 Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
> 
> This is a bit over the top when you only add data with questionable
> copyright value.
> 
>>   * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
>>   * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
>>   *
>> - * This module supports the PCA954x series of I2C multiplexer/switch chips
>> - * made by Philips Semiconductors.
>> + * This module supports the PCA954x and PCA954x series of I2C multiplexer/switch
>> + * chips made by NXP Semiconductors.
>>   * This includes the:
>> - *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
>> - *	 and PCA9548.
>> + *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547,
>> + *	 PCA9548, PCA9846, PCA9847, PCA9848 and PCA9849
> 
> The trailing . is missing.
> 
>>   *
>>   * These chips are all controlled via the I2C bus itself, and all have a
>>   * single 8-bit register. The upstream "parent" bus fans out to two,
>> @@ -63,6 +64,10 @@ enum pca_type {
>>  	pca_9546,
>>  	pca_9547,
>>  	pca_9548,
>> +	pca_9846,
>> +	pca_9847,
>> +	pca_9848,
>> +	pca_9849,
>>  };
>>  
>>  struct chip_desc {
>> @@ -129,6 +134,22 @@ static const struct chip_desc chips[] = {
>>  		.nchans = 8,
>>  		.muxtype = pca954x_isswi,
>>  	},
>> +	[pca_9846] = {
>> +		.nchans = 4,
>> +		.muxtype = pca954x_isswi,
>> +	},
>> +	[pca_9847] = {
>> +		.nchans = 8,

...you most likely need ".enable = 0x8," here.

>> +		.muxtype = pca954x_ismux,
>> +	},
>> +	[pca_9848] = {
>> +		.nchans = 8,
>> +		.muxtype = pca954x_isswi,
>> +	},
>> +	[pca_9849] = {
>> +		.nchans = 4,

Likewise, you need ".enable = 0x4," here.

Cheers,
Peter

>> +		.muxtype = pca954x_ismux,
>> +	},
>>  };
>>  
>>  static const struct i2c_device_id pca954x_id[] = {
>> @@ -140,6 +161,10 @@ static const struct i2c_device_id pca954x_id[] = {
>>  	{ "pca9546", pca_9546 },
>>  	{ "pca9547", pca_9547 },
>>  	{ "pca9548", pca_9548 },
>> +	{ "pca9846", pca_9846 },
>> +	{ "pca9847", pca_9847 },
>> +	{ "pca9848", pca_9848 },
>> +	{ "pca9849", pca_9849 },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, pca954x_id);
>> @@ -154,6 +179,10 @@ static const struct of_device_id pca954x_of_match[] = {
>>  	{ .compatible = "nxp,pca9546", .data = &chips[pca_9546] },
>>  	{ .compatible = "nxp,pca9547", .data = &chips[pca_9547] },
>>  	{ .compatible = "nxp,pca9548", .data = &chips[pca_9548] },
>> +	{ .compatible = "nxp,pca9846", .data = &chips[pca_9846] },
>> +	{ .compatible = "nxp,pca9847", .data = &chips[pca_9847] },
>> +	{ .compatible = "nxp,pca9848", .data = &chips[pca_9848] },
>> +	{ .compatible = "nxp,pca9849", .data = &chips[pca_9849] },
>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(of, pca954x_of_match);
>> @@ -339,7 +368,8 @@ static int pca954x_probe(struct i2c_client *client,
>>  	if (IS_ERR(gpio))
>>  		return PTR_ERR(gpio);
>>  
>> -	/* Write the mux register at addr to verify
>> +	/*
>> +	 * Write the mux register at addr to verify
> 
> This is now unrelated and belongs in a separate patch.
> 
>>  	 * that the mux is in fact present. This also
>>  	 * initializes the mux to disconnected state.
>>  	 */
>> @@ -443,6 +473,7 @@ static struct i2c_driver pca954x_driver = {
>>  
>>  module_i2c_driver(pca954x_driver);
>>  
>> +MODULE_AUTHOR("Adrian Fiergolski <Adrian.Fiergolski@cern.ch>");
> 
> And, just as Wolfram said, this is not appropriate anymore. Next
> time you should probably ask before adding authorship to an existing
> file, that makes you look better. Unless you do some major addition
> of course... But when you do add yourself, add yourself last so that
> it doesn't look like you are the principal author. Unless you did
> some really serious surgery of course...
> 
> Anyway, with those changes things are getting in shape.
> 
> Thanks for your patience!
> 
> Cheers,
> Peter
> 
>>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>>  MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
>>  MODULE_LICENSE("GPL v2");
>>
> 
