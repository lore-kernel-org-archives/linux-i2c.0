From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 02/10] i2c-designware: split of i2c-designware.c into core
 and bus specific parts
Date: Wed, 09 Feb 2011 09:59:37 +0900
Message-ID: <4D51E6F9.2020803@renesas.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
 <1296699608-13227-3-git-send-email-dirk.brandewie@gmail.com>
 <20110205174507.GH15795@trinity.fluff.org> <4D516D48.6000104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4D516D48.6000104-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2/9/2011 1:20 AM, Dirk Brandewie wrote:
> On 02/05/2011 09:45 AM, Ben Dooks wrote:
>>> @@ -347,15 +347,24 @@ config I2C_DAVINCI
>>>         devices such as DaVinci NIC.
>>>         For details please see http://www.ti.com/davinci
>>>
>>> -config I2C_DESIGNWARE
>>> -    tristate "Synopsys DesignWare"
>>> +config I2C_DESIGNWARE_PLATFORM
>>> +    tristate "Synopsys DesignWare Platfrom"
>>>       depends on HAVE_CLK
>>>       help
>>>         If you say yes to this option, support will be included for the
>>>         Synopsys DesignWare I2C adapter. Only master mode is supported.
>>>
>>>         This driver can also be built as a module.  If so, the module
>>> -      will be called i2c-designware.
>>> +      will be called i2c-designware-platform.
>>
>> not so happy about change in module name.

That's what I thought first, but I was optimistic about this.

> I am open to any name,  the current names come from Shinya's feedback.
> I will use what ever name everyone finds reasonable.

Okay, we have two courses.

 1. (re-)use current 'i2c-designware.ko' name for the platform driver
    (I mean i2c-designware-core.c + i2c-designware-plat) not to disturb
    existing users/systems, and give a new name for the PCI version
    (e.g. i2c-designware-pci).

 2. Use the same name both for the platform and the PCI drivers, and
    make only one driver to be configured using Kconfig.

Which one is a preferable course of action, Ben?
-- 
Shinya Kuribayashi
Renesas Electronics
