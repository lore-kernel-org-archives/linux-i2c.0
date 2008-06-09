From: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Subject: [PATCH, RFC] Earlier I2C initialization
Date: Tue, 10 Jun 2008 09:27:34 +1200
Message-ID: <484DA046.4010804@bluewatersys.com>
References: <200806091541.43899.u.luckas@road.de>
	<20080609135739.GE30971@flint.arm.linux.org.uk>
	<484D947D.1090900@bluewatersys.com>
	<200806091359.12791.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806091359.12791.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

David Brownell wrote:
> On Monday 09 June 2008, Ryan Mallon wrote:
>   
>>> Talk to i2c and framebuffer people about changing the link order.
>>>
>>> i2c should really be initialised before framebuffer devices because
>>> framebuffer devices tend to want to read DDC from monitors, which is
>>> basically a I2C EEPROM in the monitor.
>>>
>>> ... but there's probably some reason why it's done the way it is today,
>>> and changing it could well cause stuff to break.
>>>       
>> We have made i2c the first driver subsystem to come up in our 2.6.20
>> kernel since we use i2c io expanders for power domain control. All we
>> did was change drivers/Makefile so that obj-$(CONFIG_I2C) += i2c/ is at
>> the very top of the file. We didn't have any problems with doing this.
>> YMMV of course.
>>     
>
> OMAP does much the same thing, for the same reason, and the I2C
> adapter gets initialized earlier too (so power management chips
> will be fully usable before driver_initcall code runs).
>
> Unless there's a downside on x86, I'd just suggest someone submit
> a patch moving I2C init "early" so it merges in 2.6.27 ... cc to
> LKML to scare out more potential problems, but I have a hard time
> imagining there'd really be any.
>
> - Dave
>   
Okay, heres the patch. Is untested though (other than our experience 
under 2.6.20), so it probably needs some people to test. I'm not 
subscribed to LKML, so can people CC me if necessary.

Signed-off-by: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>

diff --git a/drivers/Makefile b/drivers/Makefile
index f65deda..9eaf236 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -5,6 +5,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
+obj-y				+= i2c/
 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpio/
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
@@ -61,7 +62,6 @@ obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
-obj-y				+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_POWER_SUPPLY)	+= power/
 obj-$(CONFIG_HWMON)		+= hwmon/


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
