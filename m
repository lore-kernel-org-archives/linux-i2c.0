From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: i2c-core.ko renamed to i2ccore.ko
Date: Thu, 18 Sep 2014 14:17:58 +0200
Message-ID: <1411042678.7338.20.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi guys,

Sorry for jumping in a bit late, but given that I did not get involved
in the discussions that led to this decision, better late than never.

I almost had an heart attack when noticing that module i2c-core.ko has
suddenly been renamed to i2ccore.ko without an hyphen.

Renaming kernel modules is almost always wrong, in particular subsystem
core modules. Such renames have an impact at various levels. We just had
to change a configuration file in the openSUSE Factory kernel to adjust
that change, and this is how I noticed it. But there can be several
other issues, including mkinitrd or equivalent tools, as well as
documentation. The extra work and confusion is a high price to pay, and
it can easily be avoided.

So I am kindly asking that you revert this name change before kernel
v3.17 final. Rename source files if you really have to, git makes it
easy. Or merge the i2c-acpi.c code into i2c-core.c with ifdefs. Or
whatever. Just don't rename i2c-core.ko, please.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
