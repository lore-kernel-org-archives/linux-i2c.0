From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c : i2c-ibm-iic : use interrupts to perform the data
 transfer
Date: Thu, 21 Nov 2013 13:16:02 +0100
Message-ID: <528DF982.6000803@free-electrons.com>
References: <1384960134-24039-1-git-send-email-jean-jacques.hiblot@jdsu.com> <528CDAEC.3040307@free-electrons.com> <528DD837.5060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528DD837.5060005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Jacques Hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean-Jacques,


[...]
>>
>>> +		if (ext_status & EXTSTS_LA)
>>> +			dev_dbg(dev->dev, "Lost arbitration\n");
>>
>> Ditto
> I don't know if this is really an error. Arbitration loss wan be very
> common in a multi master environement. What about dev_warn ou dev_info

I think dev_warn should be fine but I don't have a strong opinion on it.

> 
>>
>>> +		if (ext_status & EXTSTS_ICT)
>>> +			dev_dbg(dev->dev, "Incomplete transfer\n");
>>
>> Ditto
>>
>>> +		if (ext_status & EXTSTS_XFRA)
>>> +			dev_dbg(dev->dev, "Transfer aborted\n");
>>
>> Ditto
>>
> I'll use dev_err instead for those two.
> 
> 
[...]

>> Is it related to the topic of this patch?
> I needed the pointer to the struct device for the dev_err, dev_dbg etc., 
> so I stored it in the private structure. If it's better I can modify the 
> driver to get it from adap->dev.parent when needed.

What I have in mind was more to write a separate patch for this kind
of improvement


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
