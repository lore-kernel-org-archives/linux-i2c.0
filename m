From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 0/10] ARM-PNX4008-clocking update patches (repost)
Date: Tue, 22 Dec 2009 00:21:12 +0100
Message-ID: <083DF309106F364B939360100EC290F804F592E900@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


These patches were originally submitted by Russell King to
update the PNX4008 platform clock functions. These add
better support for CLKDEV and I2C and WDT clocking updates
needed for other platforms with this same IP.

These changes have been tested on the LPC32xx platform
which uses the same I2C and WDT peripherals as the
PNX4008 platform.

Kevin
