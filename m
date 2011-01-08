From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [i2c-tools][PATCH] honor CROSS_COMPILE
Date: Sat, 08 Jan 2011 14:32:21 -0600
Message-ID: <4D28C9D5.8050401@ti.com>
References: <1294426874-24973-1-git-send-email-nm@ti.com> <20110108192345.GB4045@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110108192345.GB4045-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote, on 01/08/2011 01:23 PM:
> Then again, the vast majority of userspace-projects do not use CROSS_COMPILE.
> Build systems like ptxdist and buildroot have done fine with overriding CC so
> far. I don't see much gain in that addition.
>
The same is true for CROSS_COMPILE as well.. since the patch does still 
allow CC to be over-ridden (as was the previous behavior), why not add 
CROSS_COMPILE as well considering folks who could be cross compiling 
just i2ctools without using buildroot and the likes?

-- 
Regards,
Nishanth Menon
