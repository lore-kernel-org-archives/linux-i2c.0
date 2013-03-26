From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] x86: Add basic support for the Congatec CGEB BIOS interface
Date: Tue, 26 Mar 2013 10:38:50 +0100
Message-ID: <CAH9NwWdUqH8gF8Vz7K_2UW1X==LWbYEd5dhSTPqqYwEnDuRVuQ@mail.gmail.com>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <1360663374-30951-2-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWdOCo642KqUXk1y5hbwdtW5RYgQnQfZFUEe4FOJzSiByQ@mail.gmail.com>
 <20130326085454.GK1906@pengutronix.de> <20130326092435.GB8553@the-dreams.de> <20130326093139.GL1906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130326093139.GL1906-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2013/3/26 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> Hi Wolfram,
>
> On Tue, Mar 26, 2013 at 10:24:35AM +0100, Wolfram Sang wrote:
>> Hi Sascha,
>>
>> > Any other comments to this series? Is the base cgeb support ok to
>> > include?
>>
>> I had a few comments to the I2C driver.
>
> Yes, thanks, I have seen this and will address them. Atm I'm more
> interested in the base support though, since without it there won't be a
> need for the i2c driver ;)
>

vis@OT:~$ dmesg | grep CGEB
[    2.466519] CGEB: Board name: QBRA


root@OT:/home/vis# i2cdetect -l
i2c-0   i2c             cgeb-i2c                                I2C adapter
i2c-1   i2c             Radeon i2c bit bus 0x90                 I2C adapter
i2c-2   i2c             Radeon i2c bit bus 0x91                 I2C adapter
i2c-3   i2c             Radeon i2c bit bus 0x92                 I2C adapter
i2c-4   i2c             Radeon i2c bit bus 0x93                 I2C adapter
i2c-5   i2c             Radeon i2c bit bus 0x94                 I2C adapter
i2c-6   i2c             Radeon i2c bit bus 0x95                 I2C adapter
i2c-7   i2c             Radeon i2c bit bus 0x96                 I2C adapter
i2c-8   i2c             Radeon i2c bit bus 0x97                 I2C adapter
i2c-9   i2c             Radeon aux bus DP-auxch                 I2C adapter
root@OT:/home/vis# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- 21 -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

I hope to see this patches soon in mainline - I have some Congatec
devices where I
am using an early version of this patch set.

Btw I have a cgeb-backlight driver lying here :)


Tested-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--
Christian Gmeiner, MSc
