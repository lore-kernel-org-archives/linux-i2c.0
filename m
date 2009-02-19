From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Thu, 19 Feb 2009 15:17:13 +0100
Message-ID: <gnjplc$hqd$1@ger.gmane.org>
References: <gngvea$eqj$1@ger.gmane.org> <20090218173645.GD3049@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090218173645.GD3049-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang said the following:
> Hi Michael,
> 
>> Can someone give me explanations/links/msg ids?
> 
> Documentation/i2c/upgrading-clients
> 
After re-reading it, I have to state that this document doesn't answer
the questions behind my original ones (which I wanted to answer myself
by following helpful links):
>From which kernel version on should the 'new-binding' model work?
How is attaching of a hot plugged i2c device achieved a) from kernel b)
from user space.
For kernel space init I assume its a call to i2c_new_device(). Here I'm
wondering where I should get the adapter info from.
For user space I'm completely lost (ioctl on /dev/i2cx?).

Our situation: main board is up and running, all drivers loaded.
Now an extension board will be plugged in. It is detected by
periodically polling via I2C for MUX. After detection the drivers e.g.
for temperature an MUX on the secondary board need to be attached to I2C
subsystem. Instances of both drivers are already running for local
devices, re-loading is only a bad option.
Do I really have to read and understand i2c-core.c and i2c-dev.c to find
out?
-- 

Michael Lawnick
Software Design Engineer

Lise-Meitner-Str. 7/1
89081 Ulm
Tel: +49 731 9533 2066

Michael.Lawnick.ext-OYasijW0DpE@public.gmane.org
http://www.nokiasiemensnetworks.com/global/

Think before you print
