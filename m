From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: Why isn't IRQ shared for i2c-ocore
Date: Thu, 7 May 2015 07:46:29 -0700
Message-ID: <554B7AC5.5040401@freescale.com>
References: <55304D8E.8070204@freescale.com> <55312AF7.7070504@freescale.com> <20150420064231.GE3447@x1> <55352839.70905@freescale.com> <20150420181651.GF3447@x1> <5535460B.2060309@freescale.com> <20150421073534.GK3447@x1> <554A8A8B.1020703@freescale.com> <20150507070149.GB3400@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150507070149.GB3400@x1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Julia.Lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 05/07/2015 12:01 AM, Lee Jones wrote:
>> I have a follow up question regarding interrupt. I see many I2C bus drivers
>> request interrupt with flag = 0. Why not using IRQF_SHARED?
> 
> Probably because that particular IRQ is only used by the I2C
> Controller.  I'm not exactly sure that you're getting at?  Why do you
> think it should be shared?  You should only flag it as shared if it
> is.

I am working on a driver for multifunction card with open core I2C controller.
The interrupt is shared between I2C and other controller.

> 
>> I understand the performance concern. If there is any other reason, I want to
>> know about it before I go too far on my driver.
> 
> This sort of stuff is trivial to fix and shouldn't stand in the way
> of you writing and submitting v1 of your driver.
> 

It is trivial to fix. I just want to know if there is any reason the interrupt
wasn't shared. Seems not.

York
