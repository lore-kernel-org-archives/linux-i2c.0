From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Tue, 5 Jul 2011 12:06:13 -0500 (CDT)
Message-ID: <8829587.204.1309885573653.JavaMail.root@zmail.rockbochs.com>
References: <6D7A567890E70E4BA49B8A9B365980FA12D99C14BE@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6D7A567890E70E4BA49B8A9B365980FA12D99C14BE-QQHDSDV1ERZpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I've done that:

root@aaa:~# lsmod | grep i2c
i2c_dev                 3382  0
i2c_core               12703  1 i2c_dev

But, nothing of interest in dmesg other than:

[108414.944722] i2c /dev entries driver

and running i2cdetect still turns up nothing:

root@aaa:~# i2cdetect -l

Any thoughts? Does this specific Winbond chip require a device specific kernel module to operate such as those found in /lib/modules/2.6.32-5-486/kernel/drivers/i2c/busses  ?

Tim Nelson
Systems/Network Support
Rockbochs Inc.
(218)727-4332 x105

----- Original Message -----
> You have to install i2c-dev.ko with "insmod i2c-dev.ko". Good luck :)
> 
> BR
> 
> Shijie
> 
> -----Original Message-----
> From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Tim Nelson
> Sent: Tuesday, July 05, 2011 10:46 PM
> To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Winbond W83L604G
> 
> Greetings-
> 
> I've got a board with a Winbond W83L604G GPIO controller and I'd like
> to use it with Debian 6.x for controlling attached LEDs. However,
> using i2cdetect, I'm not seeing any I2C busses on the system, nor any
> I2C devices. Does this controller require a specific kernel module for
> operation? Any tips or pointers on how to make it available for
> control using I2C?
> 
> I've not found a current kernel module for this chip, nor found any
> reference when grep'ing through the current source tarball. Maybe
> there simply isn't a module available to use it?
> 
> Thanks!
> 
> --Tim
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c"
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
