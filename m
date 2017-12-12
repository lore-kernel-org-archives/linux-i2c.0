From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Tue, 12 Dec 2017 20:03:45 +0100
Message-ID: <7b8066a5-0a61-ca1b-e41f-6437e47ed7b2@axentia.se>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0097.outbound.protection.outlook.com ([104.47.2.97]:58881
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752255AbdLLTDu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 14:03:50 -0500
In-Reply-To: <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
Cc: giometti@enneenne.com, giometti@linux.it

On 2017-12-11 20:14, Peter Rosin wrote:
> On 2017-12-11 17:58, Adrian Fiergolski wrote:
>> +	/* Check manufacturer ID (12 bits) */
>> +	manufacturer_id = ((u16) device_id_raw.block[1] << 4) | (device_id_raw.block[2] >> 4);
> 
> This assignment is still broken...

Ooops, no, this one is fine. Sorry about that.

>> +	if (manufacturer_id != NXP_ID) {
>> +		dev_warn(&client->dev, "PCA9846 family: Manufacturer ID does not match NXP\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Check device ID (9 bits) */
>> +	device_id = ((u16) device_id_raw.block[2] << 5) | (device_id_raw.block[3] >> 3);
> 
> ...and this is also broken.

But this one is broken. You need to mask out the upper half of
...block[2] so that the lower bits of the manufacturer don't
end up above the device id bits.

Cheers,
Peter

>> +	if (device_id != chips[id->driver_data].deviceID) {
>> +		dev_warn(&client->dev, "PCA9846 family: Device ID does not match %s\n", id->name);
>> +		return -ENODEV;
>> +	}
