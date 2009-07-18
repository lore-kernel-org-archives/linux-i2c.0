From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: I2C device board info
Date: Sat, 18 Jul 2009 14:57:13 +0100
Message-ID: <20090718135713.GC4120@n2100.arm.linux.org.uk>
References: <20090718105600.GA29887@n2100.arm.linux.org.uk> <20090718150803.68fea223@hyperion.delvare> <20090718131237.GB4120@n2100.arm.linux.org.uk> <20090718152918.09912dea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090718152918.09912dea-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 18, 2009 at 03:29:18PM +0200, Jean Delvare wrote:
> On Sat, 18 Jul 2009 14:12:37 +0100, Russell King - ARM Linux wrote:
> > On Sat, Jul 18, 2009 at 03:08:03PM +0200, Jean Delvare wrote:
> > > Note that this is not an isolated case, although this one is worse
> > > because I2C_BOARD_INFO() and .type do not agree on the chip name. But
> > > there are several redundant .type definitions in arch/arm/mach-* and
> > > one in arch/blackfin/mach-bf527. Time to fix them?
> > 
> > That is my intention - I'm preparing patches for Realview and Versatile.
> > This will only leave the MX* series of platforms in arch/arm doing this,
> > which fall into Sascha's domain.
> 
> OK, thank you. I'll send a patch for the blackfin ones then.

Can I get an ack for this please?

Thanks.

Subject: ARM: Realview & Versatile: Fix i2c_board_info definitions

Fix i2c_board_info definitions - we were defining the 'type' field
of these structures twice since the first argument of I2C_BOARD_INFO
sets this field.  Move the second definition into I2C_BOARD_INFO().

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 arch/arm/mach-realview/core.c  |    3 +--
 arch/arm/mach-versatile/core.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index ab615e7..dc3519c 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -208,8 +208,7 @@ struct platform_device realview_i2c_device = {
 
 static struct i2c_board_info realview_i2c_board_info[] = {
 	{
-		I2C_BOARD_INFO("rtc-ds1307", 0xd0 >> 1),
-		.type = "ds1338",
+		I2C_BOARD_INFO("ds1338", 0xd0 >> 1),
 	},
 };
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index afc0f87..975eae4 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -343,8 +343,7 @@ static struct platform_device versatile_i2c_device = {
 
 static struct i2c_board_info versatile_i2c_board_info[] = {
 	{
-		I2C_BOARD_INFO("rtc-ds1307", 0xd0 >> 1),
-		.type = "ds1338",
+		I2C_BOARD_INFO("ds1338", 0xd0 >> 1),
 	},
 };
 
