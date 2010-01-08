From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 08 Jan 2010 13:36:31 +0100
Message-ID: <4B4726CF.9020605@scram.de>
References: <20100108020253.GJ3388@radix50.net> <4B471647.8050806@scram.de> <20100108121723.GD4004@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100108121723.GD4004-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Baurzhan,

> Oh, that's an interesting point. No, it isn't present, only i2c. How did
> it work in 2.6.25.7? I'd also appreciate pointers about that, if there
> are any.

It was probably probed by some userspace tool. This has been turned off as probing i2c might be 
problematic on Soc boards. See:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0a346dacee18ff69f6162d9860d723a058f47321

You could try to add the property "linux,i2c-class=1" to the i2c controller in your dts to see if 
this commit is the cause of difference.

> Currently I'm trying to understand why the new i2c infrastructure
> doesn't call ds2482_probe, which creates the w1_bus_master1 directory.
> Other ideas also welcome.

You should definitely add your ds2482 to the device tree so it is auto loaded by the i2c subsystem.

Thanks,
Jochen
