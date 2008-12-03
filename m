From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Strange data corruption when read from /sys/class/i2c-adapter/.../eeprom
Date: Wed, 3 Dec 2008 13:37:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812031327440.4717@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

on an i.MX31-based system I observe a strange effect:

cat /sys/class/i2c-adapter/.../eeprom > /tmp/e1
rmmod <adapter-driver>
modprobe <adapter-driver>
cat /sys/class/i2c-adapter/.../eeprom > /tmp/e2

after which the first 0x40 bytes in e2 are zero. The rest is correct - as 
in e1. To recover I have to

rmmod eeprom
i2cdetect ... # incluging eeprom addresses
modprobe eeprom

I would suspect a software bug, but I get this with two alternative 
adapter drivers (mxc and imx - see my recent post to the list), and on a 
laptop with 2.6.26 I don't get this. The kernel on i.MX31 is a pretty 
fresh linux-next. Does this look like a hardware "feature"? Or do we have 
a regression?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
