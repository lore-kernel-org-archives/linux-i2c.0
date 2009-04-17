From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Fri, 17 Apr 2009 09:33:56 +0200
Message-ID: <20090417093356.79f38e40@hyperion.delvare>
References: <49E6F4F9.3060705@gmx.de>
 <20090416092012.GB3052@pengutronix.de>
 <49E7101E.6070806@gmx.de>
 <20090416114701.GD3052@pengutronix.de>
 <49E7344C.2060704@gmx.de>
 <20090416155555.1c8c0a34@hyperion.delvare>
 <49E82270.4030509@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E82270.4030509-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

please keep the list CC'd.

On Fri, 17 Apr 2009 08:32:16 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> > That's right, but why do you insist on instantiating them at runtime?
> > 
> Because we have 2 different boards with same main processor but
> different on-board peripherals. They should run with same binary kernel
> to avoid duplicate production tests. On boot the system checks on which
> of the boards it is running and loads the necessary drivers with
> matching parameters.

Why would the system check need to be done in user-space? I can easily
imagine a single kernel supporting more than one system, all I2C
devices being described in the kernel and the right subset of I2C
devices being instantiated at boot based on which system the kernel is
running on.

> > The question is: why every other user of i2c-mpc is apparently able 
> > to declare i2c devices through dts and you aren't?
>
> The question was: does dts work for drivers that are loaded on runtime.

Answer is yes.

> I did not check before I asked, because it is a bit complicated here to
> do. In difference to you Wolfram was able to give a verbose 'yes' which
> I will check now.

In difference to Wolfram I have no specific knowledge of embedded
boards. I try to help with i2c in general but I am limited when it
comes to embedded.

-- 
Jean Delvare
