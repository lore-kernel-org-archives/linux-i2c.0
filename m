From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch v2] MPC Adapter: read class attribute from device tree
Date: Thu, 23 Apr 2009 08:48:33 +0200
Message-ID: <49F00F41.4070607@gmx.de>
References: <49EEC50A.4050707@gmx.de> <9e4733910904220723u68392662vb854188c1dec02fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910904220723u68392662vb854188c1dec02fd-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jon Smirl said the following:
> On Wed, Apr 22, 2009 at 3:19 AM, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wrote:
>> For MPC adapter there is no class assigned as it is done in other
>> adapters. This way no new-style client will ever be instantiated, if not
>> noted in device tree or forced. With this patch class assignment is read
>> from device tree.
>> If class assignment is not set in device tree .class stays default (0)
>>
>> Necessary device tree entry:
>> linux,i2c-class = <1>; /* I2C_CLASS_HWMON (iic.h) */
> 
> When this patch makes it over to the device tree police they are going
> to reject it. They will never allow OS specific entries into the cross
> platform device tree standard.

I feared that, so I will drop it.

Mi-stumped-chael
