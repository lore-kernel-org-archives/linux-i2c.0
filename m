From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch v2] MPC Adapter: read class attribute from device tree
Date: Wed, 22 Apr 2009 15:52:22 -0400
Message-ID: <9e4733910904221252t2de83a7cn7c2b1720db096fe1@mail.gmail.com>
References: <49EEC50A.4050707@gmx.de>
	 <9e4733910904220723u68392662vb854188c1dec02fd@mail.gmail.com>
	 <49EF62AF.5070004@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EF62AF.5070004-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 22, 2009 at 2:32 PM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
> Jon Smirl wrote:
>> On Wed, Apr 22, 2009 at 3:19 AM, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wrote:
>>> For MPC adapter there is no class assigned as it is done in other
>>> adapters. This way no new-style client will ever be instantiated, if not
>>> noted in device tree or forced. With this patch class assignment is read
>>> from device tree.
>>> If class assignment is not set in device tree .class stays default (0)
>>>
>>> Necessary device tree entry:
>>> linux,i2c-class = <1>; /* I2C_CLASS_HWMON (iic.h) */
>>
>> When this patch makes it over to the device tree police they are going
>> to reject it. They will never allow OS specific entries into the cross
>> platform device tree standard.
>
> But sometimes the device tree police turns a blind eye :-).

I doubt it, in the last six months they removed all of the platform
specific stuff from the dts files in the kernel.
There should be some way to accomplish this without needing the i2c-class entry.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
