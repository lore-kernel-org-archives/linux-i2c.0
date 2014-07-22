From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 1/5] i2c: Don't start transfers when suspended
Date: Tue, 22 Jul 2014 22:20:36 +0100
Message-ID: <20140722212036.GL21766@n2100.arm.linux.org.uk>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com> <53CEB196.9060903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53CEB196.9060903-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 22, 2014 at 09:46:46PM +0300, Grygorii Strashko wrote:
>  I'm not sure, this optimization is safe  (
> Because, in many cases the access to PMIC IC needs to be allowed till late
> stages of suspending (at least till suspend_noirq stage or even later).
> For example, on some OMAP SoC Voltage management code need to use services
> provided by PMIC IC, which is connected to I2C.

This is definitely not safe.  I worked on a PXA platform a while back
where the only way to tell the thing to "sleep" was to send an I2C
message to a microcontroller asking it to remove power.

Plus, as you say, you may also have PMICs that you need to talk to
in order to shut power off to various peripherals (and maybe even
the CPU itself) during the suspend process.

I2C is one of those cases where devices attached to the I2C bus are
themselves responsible for doing their own suspend shutdown at the
appropriate time; it's not the responsibility of the I2C core to
know this kind of system/driver dependent detail.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
