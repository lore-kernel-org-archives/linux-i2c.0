From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 08 Jan 2010 12:25:59 +0100
Message-ID: <4B471647.8050806@scram.de>
References: <20100108020253.GJ3388@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100108020253.GJ3388-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Baurzhan,

> There are boot messages about both. Creating /dev/i2c-0 and reading from
> it result in appropriate debug messages. However,
> /sys/devices/w1_bus_master1 is not created; the path described in
> http://marc.info/?l=linux-i2c&m=125365009130579&w=2 does not exist. What
> is the fastest way to get the application running on 2.6.27.25?

What does your dts look like? Is the ds2482 present in the dts?

Thanks,
Jochen
