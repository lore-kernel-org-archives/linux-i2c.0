From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] i2c-iop3xx: add iomem annotation
Date: Fri, 3 Dec 2010 07:51:10 +0200
Message-ID: <4284E5DA-DFF5-4507-9633-57EDD5FAA4E4@iki.fi>
References: <1290960420-7484-1-git-send-email-aaro.koskinen@iki.fi> <20101203015914.GC20097@trinity.fluff.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101203015914.GC20097-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 3.12.2010, at 3.59, Ben Dooks wrote:
> On Sun, Nov 28, 2010 at 06:07:00PM +0200, Aaro Koskinen wrote:
>> Eliminate unnecessary casts and the following sparse warnings:
[...]
>> --- a/drivers/i2c/busses/i2c-iop3xx.h
>> +++ b/drivers/i2c/busses/i2c-iop3xx.h
>> @@ -97,7 +97,7 @@
>>  #define	IOP3XX_I2C_IO_SIZE	0x18
>>
>>  struct i2c_algo_iop3xx_data {
>> -	u32 ioaddr;
>> +	char __iomem *ioaddr;
>
> probably should be changed to void if possible without creating extra
> warnings.

Yes, the updated patch is here: https://patchwork.kernel.org/patch/ 
363512/

A.
