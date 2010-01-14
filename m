From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] Check component type register
Date: Thu, 14 Jan 2010 07:37:44 -0500
Message-ID: <4B4F1018.6010602@octasic.com>
References: <20100113193224.753273000@octasic.com> <20100113193421.139644000@octasic.com> <20100114011101.GK3738@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100114011101.GK3738-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


>> +		if (0x44570140 != comp_type) {
>> +			dev_err(&pdev->dev, "Unknown Synopsys component type: "
>> +					"0x%08x\n",	comp_type);
>> +			r = -ENODEV;
>> +			goto err_iounmap;
>> +		}
>> +	}
>> +	{
>>     
>
> The general convention in linux is to do (if x = constant).
>   
Old coding habits are difficult to get rid of ;-). I'll change it in the 
updated patchset, once all comments have been collected.

thanks,
jh
