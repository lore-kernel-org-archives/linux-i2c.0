From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [V2 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Wed, 15 Apr 2015 00:51:32 -0700
Message-ID: <552E1884.7050007@broadcom.com>
References: <1428004866-13543-1-git-send-email-kdasu.kdev@gmail.com> <20150414134740.GB1375@katana> <552D7AF5.7040005@broadcom.com> <20150415075056.GA1826@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150415075056.GA1826@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>; bcm-kernel-feedback-list" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 4/15/2015 12:50 AM, Wolfram Sang wrote:
> Hi Ray,
> 
> thanks for the review! I agree to all points except one minor thing:
> 
>>>> +#include <linux/device.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/version.h>
>>>> +#include <linux/delay.h>
>>
>> Wolfram would prefer the includes to be sorted in alphabetic order
> 
> Sidenote: And one can see why here: clk.h is included twice.
> 
>>>> +	adap->owner = THIS_MODULE;
>>
>> Not needed...
> 
> This is needed. It is not needed to set it with the platform_driver
> struct, but for the adapter created, this is needed.

Okay that's really good to know. Thanks, Wolfram!

> 
> Thanks again,
> 
>    Wolfram
> 
