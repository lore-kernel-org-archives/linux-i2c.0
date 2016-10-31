From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCHv6 08/11] i2c: match vendorless strings on the internal
 string length
Date: Mon, 31 Oct 2016 14:55:43 +0100
Message-ID: <bc87437c-c53e-b6f6-e9b1-2d488639317b@axentia.se>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
 <1477413715-22894-9-git-send-email-kieran@bingham.xyz>
 <20161026085316.GK8574@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0107.outbound.protection.outlook.com ([104.47.2.107]:60523
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933235AbcJaOLH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Oct 2016 10:11:07 -0400
In-Reply-To: <20161026085316.GK8574@dell>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com

On 2016-10-26 10:53, Lee Jones wrote:
> On Tue, 25 Oct 2016, Kieran Bingham wrote:
> 
>> If a user provides a shortened string to match a device to the sysfs i2c
>> interface it will match on the first string that contains that string
>> prefix.
>>
>> for example:
>>   echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
>>
>> will match as3711, as3722, and ak8975 incorrectly.
>>
>> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
>   
>> ---
>>  drivers/i2c/i2c-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 01bce56f733a..50c9cfdb87b7 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -1708,7 +1708,7 @@ i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
>>  		else
>>  			name++;
>>  
>> -		if (!strncasecmp(client->name, name, strlen(client->name)))
>> +		if (!strncasecmp(client->name, name, strlen(name)))
>>  			return matches;
>>  	}
>>  
> 

Is that really so much better?

With this patch
	echo as3711CRAP 0x68 > /sys/...
will match as3711.

What if there is some as37112 driver that is the real target?

Cheers,
Peter
