From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Mon, 06 Jan 2014 10:55:19 +0100
Message-ID: <52CA7D87.9070606@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com> <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com> <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch> <20140105172756.GA11280@obsidianresearch.com> <52C99851.70806@gmail.com> <20140105230746.GB11280@obsidianresearch.com> <52C9E6D0.3000406@gmail.com> <20140105234009.GC11280@obsidianresearch.com> <52C9F32D.5080007@gmail.com> <20140106001709.GD4093@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140106001709.GD4093-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On 06/01/2014 01:17, Andrew Lunn wrote:
>>>> Does that power down really disable reading from PCIe controller
>>>> registers or is it just PHY power down?
>>>
>>> I haven't experimented with it, but every block that has a clock gate
>>> has a power down, so I doubt it is just a phy power down.
>>
>> Ok, I see. But it isn't documented in the public FS, is it? If there is
>> an extra powerdown register for each ip block, I guess it will also
>> break reading from its registers.
> 
> Hi Sebastian
> 
> The public Kirkwood FS has a memory power management control register,
> Offset 0x20118. It is unclear what it actually does, and if you can
> still access registers when it is off. We would have to poke it and
> see.

Interesting, this registers is mentioned under the section "Core Clock
Power Saving" in the kirkwood datasheet, so maybe we should add this
register to the gating clock

I found similar registers for Armada XP/370, I am going to test what happen
if the PCxy  Memory Power Down are down.


Thanks,

Gregory



> 
> 	Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
