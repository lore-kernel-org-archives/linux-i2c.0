From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: I2C device board info
Date: Sat, 18 Jul 2009 11:56:00 +0100
Message-ID: <20090718105600.GA29887@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Sascha,

I've noticed the following in i2c_board_info initializers:

arch/arm/mach-mx2/pcm038.c:             I2C_BOARD_INFO("rtc-pcf8563", 0x51),
arch/arm/mach-mx2/pcm038.c-             .type = "pcf8563"

However, I2C_BOARD_INFO is defined as:

#define I2C_BOARD_INFO(dev_type, dev_addr) \
        .type = dev_type, .addr = (dev_addr)

so you're initializing .type twice.  Only one of these will be used,
so you may want to correct these entries.  (Looking at Realview, the
one which is used is the second - so in the above case, .type will
be initialized with current gcc to "pcf8563" not "rtc-pcf8563".)
