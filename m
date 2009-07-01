From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] TSL2550 driver bugfix
Date: Wed, 01 Jul 2009 10:00:56 +0000
Message-ID: <4A4B33D8.1070903@cam.ac.uk>
References: <4A4A2FBC.1060804@valueteam.com> <4A4A4036.3000408@cam.ac.uk> <4A4B1A71.20101@valueteam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4B1A71.20101-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Looks good to me. (perhaps a bit more detail in the commit
message of the patch?)

Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> Jonathan Cameron wrote:
>> Michele De Candia (VT) wrote:
>>  
>>> Hi all,
>>>
>>> I've tested TSL2550 driver and I've found a bug: when light is off,
>>> returned value from tsl2550_calculate_lux function is -1 when it should
>>> be 0 (sensor correctly read that light was off).
>>>
>>> I think the bug is that a zero c0 value (approximated value of ch0) is
>>> misinterpreted as an error.
>>> I'm attaching you a patch that fixes the bug.
>>>
>>> Regards,
>>> Michele Jr De Candia
>>>     
>> Sounds reasonable, but I think a stray line got away in your patch
>> (see below)
>> Not to mention, if the c1 <= c0 check is still valid, should you not also
>> confirm that c1 == 0 as well? Perhaps reverse the ordering?
>>   
> That's right. A new patch can be found in attachment.
>> if (c1 <= c0)
>>     if(c0) {
>>         r = c1* 128 / c0;
>>         lux = ((c0 - c1) * ratio_lut[r]) / 256;
>>     } else
>>         lux = 0;
>> else
>>     return -1;
>>     
>>
>> Signed-off-by: Michele Jr De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
>>
>> diff --git a/drivers/i2c/chips/tsl2550.c b/drivers/i2c/chips/tsl2550.c
>> index 1a9cc13..6bad072 100644
>> --- a/drivers/i2c/chips/tsl2550.c
>> +++ b/drivers/i2c/chips/tsl2550.c
>> @@ -189,10 +189,16 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
>>      u8 r = 128;
>>  
>>      /* Avoid division by 0 and count 1 cannot be greater than count 0 */
>> -    if (c0 && (c1 <= c0))
>> -        r = c1 * 128 / c0;
>> -    else
>> -        return -1;
>> +    if (c0)    {
>> +        if (c1 <= c0)
>> +            r = c1 * 128 / c0;
>> +        else
>> +            return -1;
>> +           
>> +        /* Calculate LUX */
>> +        lux = ((c0 - c1) * ratio_lut[r]) / 256;
>> +    }
>> +    else lux = 0;
>>  
>>
>> This last line should have been removed I think?
>>      /* Calculate LUX */
>>     lux = ((c0 - c1) * ratio_lut[r]) / 256;
>>
>> ---
>> Jonathan Cameron
>>
>>   
> Than
