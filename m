From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: I2C device board info
Date: Sat, 18 Jul 2009 14:12:37 +0100
Message-ID: <20090718131237.GB4120@n2100.arm.linux.org.uk>
References: <20090718105600.GA29887@n2100.arm.linux.org.uk> <20090718150803.68fea223@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090718150803.68fea223-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 18, 2009 at 03:08:03PM +0200, Jean Delvare wrote:
> Note that this is not an isolated case, although this one is worse
> because I2C_BOARD_INFO() and .type do not agree on the chip name. But
> there are several redundant .type definitions in arch/arm/mach-* and
> one in arch/blackfin/mach-bf527. Time to fix them?

That is my intention - I'm preparing patches for Realview and Versatile.
This will only leave the MX* series of platforms in arch/arm doing this,
which fall into Sascha's domain.
