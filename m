From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 21/22] i2c-designware: Tx abort cleanups
Date: Mon, 16 Nov 2009 20:27:47 +0900
Message-ID: <4B013733.9010900@necel.com>
References: <4AF419B6.1000802@necel.com> <4AF41BED.1050406@necel.com> <4AFB8F3A.6060208@necel.com> <20091114222249.GM13398@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091114222249.GM13398-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
>>> +	for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
>>> +		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
>> Dev_err() might be annoying when we use sort of misc utilities
>> such as i2c-tools.  In case of no ACKs, we sometimes don't want
>> to see error messages in the console, because such tools are
>> sometimes capable of generating human-friendly console output
>> like,
>>
>> root@localhost:/root> i2cdetect -y -r 2
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- ...
>>
>> root@localhost:/root> i2cdump -y 0 0x49 b
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>> 10: XX XX XX XX XX XX  ....
>>
>> Then how do I change dev_err() here?  I'm not sure dev_dbg() or
>> other variants are acceptable for no ACKs or arbitration cases.
>> Could someone give me a comment?  I'll prepare patches for it.
> 
> Maybe in the case of no-ack, this could be a debug message and erro
> for the case where you have an arbitration problem or other error that
> you wouldn't normally find on an I2C bus?

Thanks, I'll send an additional patch shortly.
-- 
Shinya Kuribayashi
NEC Electronics
