From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] [ARM] pxa: lx: add PCON i2c driver
Date: Sat, 18 Apr 2009 16:29:00 +0200
Message-ID: <20090418162900.0dc16531@hyperion.delvare>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk>
	<1240064452-14691-1-git-send-email-linux@arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1240064452-14691-1-git-send-email-linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 18 Apr 2009 15:20:48 +0100, Russell King wrote:
> The PCON device on the LX platform is the heart of the platform,
> managing the power, providing battery information, booting, suspend/
> resume and keyboard services to the PXA CPU.
> 
> Communication between the PXA and PCON is via a multi-master I2C bus,
> where both the PCON and PXA behave like an 256 byte EEPROM, and each
> reads and writes locations within that namespace.
> 
> It has a nasty habbit of resetting the PXA CPU if it sees something
> it doesn't like, so we have to be careful how we communicate with the
> PCON.  This happens (eg) if we hold the I2C bus for any "unreasonable"
> length of time, or ignore the PCON's attempt to address us as a slave.
> 
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> CC: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> CC: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> ---
>  arch/arm/mach-pxa/include/mach/lx-pcon.h |  117 ++++++++
>  drivers/i2c/chips/Kconfig                |   10 +
>  drivers/i2c/chips/Makefile               |    1 +

Nack. Really, people, please read the files you modify, it isn't that
hard.

-- 
Jean Delvare
