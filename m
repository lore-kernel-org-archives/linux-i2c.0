From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C device board info
Date: Sat, 18 Jul 2009 15:08:03 +0200
Message-ID: <20090718150803.68fea223@hyperion.delvare>
References: <20090718105600.GA29887@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090718105600.GA29887-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Russell,

On Sat, 18 Jul 2009 11:56:00 +0100, Russell King - ARM Linux wrote:
> Sascha,
> 
> I've noticed the following in i2c_board_info initializers:
> 
> arch/arm/mach-mx2/pcm038.c:             I2C_BOARD_INFO("rtc-pcf8563", 0x51),
> arch/arm/mach-mx2/pcm038.c-             .type = "pcf8563"
> 
> However, I2C_BOARD_INFO is defined as:
> 
> #define I2C_BOARD_INFO(dev_type, dev_addr) \
>         .type = dev_type, .addr = (dev_addr)
> 
> so you're initializing .type twice.  Only one of these will be used,
> so you may want to correct these entries.  (Looking at Realview, the
> one which is used is the second - so in the above case, .type will
> be initialized with current gcc to "pcf8563" not "rtc-pcf8563".)

Most probably for historical reasons - the initial implementation of
I2C_BOARD_INFO did define the driver name, and setting the device type
was optional. Apparently the above piece of code was forgotten when
I2C_BOARD_INFO() was modified.

The correct type name for this chip is "pcf8563" so the two lines above
should be turned into:

		I2C_BOARD_INFO("pcf8563", 0x51),

Note that this is not an isolated case, although this one is worse
because I2C_BOARD_INFO() and .type do not agree on the chip name. But
there are several redundant .type definitions in arch/arm/mach-* and
one in arch/blackfin/mach-bf527. Time to fix them?

-- 
Jean Delvare
