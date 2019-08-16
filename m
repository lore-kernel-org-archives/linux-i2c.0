From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v3 3/3] i2c/busses/i2c-icy: Add LTC2990 present on 2019
 board revision
Date: Fri, 16 Aug 2019 14:34:32 +0200
Message-ID: <513d49dd-70fc-a226-fdfd-598aadcfec05@enpas.org>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-3-max@enpas.org> <20190816115112.GA3507@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816115112.GA3507@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/16/2019 01:51 PM, Wolfram Sang wrote:
> 
>> +	if (IS_ERR(new_fwnode))
>> +		dev_info(&z->dev, "Failed to create fwnode for LTC2990, error: %ld\n",
>> +			 PTR_ERR(new_fwnode));
>> +	else {
> 
> Braces for both blocks. Did you run checkpatch?

I did, and it didn't say anything.

Turns out I misremembered the CodingStyle as having a corner case where it doesn't. I'll fix the style - I dislike the above, too ;)


>> +		/*
>> +		 * Store the fwnode so we can destroy it on .remove().
>> +		 * Only store it on success, as fwnode_remove_software_node()
>> +		 * is NULL safe, but not PTR_ERR safe.
>> +		 */
>> +		i2c->ltc2990_fwnode = new_fwnode;
>> +		ltc2990_info.fwnode = new_fwnode;
>> +
>> +		i2c->ltc2990_client =
>> +			i2c_new_probed_device(&i2c->adapter,
>> +					      &ltc2990_info,
>> +					      icy_ltc2990_addresses,
>> +					      NULL);
> 
> i2c_new_device (or better, the new i2c_new_client_device) should be
> sufficient, or? You only have one potential address.

Yes and no. Now that you mention it - the LTC2990 can be at four addresses (0x4c - 0x4f), and there are jumpers (solder pads) on the PCB to select its address. Shall I add all 4 addresses to the array?

It's also possible that there is no LTC2990 at all (because it's hard to solder at home), and that's why we need to probe for it first. I believe i2c_new[_client]_device doesn't do probing, but rather assumes the device to be there. Correct?


Max
