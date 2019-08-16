From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v3 2/3] hwmon/ltc2990: Generalise DT to fwnode support
Date: Fri, 16 Aug 2019 10:37:30 +0200
Message-ID: <5b9b4383-c1e9-91a6-8ab6-8f831b362dca@enpas.org>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-2-max@enpas.org>
 <6920f2da-3139-6fc8-b02c-3678cc17912e@enpas.org>
 <20190815224341.GA12420@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815224341.GA12420@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/16/2019 12:43 AM, Guenter Roeck wrote:
> On Fri, Aug 16, 2019 at 12:19:42AM +0200, Max Staudt wrote:
>> On 08/15/2019 02:58 PM, Max Staudt wrote:
>>> -	if (of_node) {
>>> -		ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
>>> -						 data->mode, 2);
>>> +	if (i2c->dev.of_node || i2c->dev.fwnode) {
>>
>> One more idea, would it be better here to do the following?
>>
>> 	if (device_property_present(i2c->dev, "lltc,meas-mode")) {
>> 		ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
>> 						 data->mode, 2);
>> 	}
>>
>> I'm happy to prepare a patch if you wish to have this in - just let me know whether it should be on top of the last one, or instead of it.
> 
> That would be semantically different. The property is currently mandatory.
> The above code would make it optional. This might work:
> 
> 	if (dev_fwnode(&i2c->dev)) {
> 		ret = device_property_read_u32_array(...);
> 		...
> 	}

Fair point. The semantic change was part of my question, but the more I think about it, the less I want to open this can of worms. We can still make the property optional later on, while it's not as easy to make it mandatory.

I'll send a patch with your suggestion.

Thanks!
Max
