From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [PATCHv6 08/11] i2c: match vendorless strings on the internal
 string length
Date: Mon, 31 Oct 2016 15:01:52 +0000
Message-ID: <51902bcc-f5e6-ff9a-9aeb-bf7b8deeaf26@bingham.xyz>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
 <1477413715-22894-9-git-send-email-kieran@bingham.xyz>
 <20161026085316.GK8574@dell>
 <bc87437c-c53e-b6f6-e9b1-2d488639317b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc87437c-c53e-b6f6-e9b1-2d488639317b@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Thanks for your review

On 31/10/16 13:55, Peter Rosin wrote:
> On 2016-10-26 10:53, Lee Jones wrote:
>> On Tue, 25 Oct 2016, Kieran Bingham wrote:
>>
>>> If a user provides a shortened string to match a device to the sysfs i2c
>>> interface it will match on the first string that contains that string
>>> prefix.
>>>
>>> for example:
>>>   echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
>>>
>>> will match as3711, as3722, and ak8975 incorrectly.
>>>
>>> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
>>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>   
>>> ---
>>>  drivers/i2c/i2c-core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>> index 01bce56f733a..50c9cfdb87b7 100644
>>> --- a/drivers/i2c/i2c-core.c
>>> +++ b/drivers/i2c/i2c-core.c
>>> @@ -1708,7 +1708,7 @@ i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
>>>  		else
>>>  			name++;
>>>  
>>> -		if (!strncasecmp(client->name, name, strlen(client->name)))
>>> +		if (!strncasecmp(client->name, name, strlen(name)))
>>>  			return matches;
>>>  	}
>>>  
>>
> 
> Is that really so much better?

My original thought was that it verifies 'more' of the userspace input.
but...

> With this patch
> 	echo as3711CRAP 0x68 > /sys/...
> will match as3711.
>
> What if there is some as37112 driver that is the real target?

You're right - It looks like the only way to do this correctly is to
match the strncasecmp and the strlen of both strings.

So really we should be using sysfs_streq(). The only limitation there is
that this original code was performing a case-insensitive compare.

Lee - Where did the requirement for case insensitive matching come from
in your original code. Is it expected to be case-insensitive from the
I2C sysfs interface? or are dt-nodes expected to be case-sensitive?

Does anyone see reason that this shouldn't be using sysfs_streq()? or do
we need a sysfs_strcaseeq()...

> Cheers,
> Peter
> 

-- 
Regards

Kieran Bingham
