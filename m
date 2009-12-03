From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Thu, 03 Dec 2009 22:10:52 +0530
Message-ID: <1259858452.24844.16.camel@localhost.localdomain>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
	 <20090707231938.GA9907@fluff.org.uk> <87skh79uai.fsf@deeprootsystems.com>
	 <A69FA2915331DC488A831521EAE36FE40144D8117B@dlee06.ent.ti.com>
	 <1247642943.5981.76.camel@localhost.localdomain>
	 <A69FA2915331DC488A831521EAE36FE40144F1E816@dlee06.ent.ti.com>
	 <1258989866.20007.237.camel@localhost.localdomain>
	 <A69FA2915331DC488A831521EAE36FE40155B773AC@dlee06.ent.ti.com>
	 <1259856743.24844.13.camel@localhost.localdomain>
	 <A69FA2915331DC488A831521EAE36FE40155B77431@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7BmxZoHhGnk4qAseODSW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A69FA2915331DC488A831521EAE36FE40155B77431-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--=-7BmxZoHhGnk4qAseODSW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Murali,

	It was sent already, patch with subject "[PATCH v2] i2c: Davinci i2c
bus recovery procedure to clear the bus". Attaching here for your
convenience.

Regards,
Philby


On Thu, 2009-12-03 at 10:33 -0600, Karicheri, Muralidharan wrote:
> Philby,
> 
> So where is the patch for adding davinci_i2c_platform_data in the platform
> file? Could you send it please?
> 
> Murali Karicheri
> Software Design Engineer
> Texas Instruments Inc.
> Germantown, MD 20874
> phone: 301-407-9583
> email: m-karicheri2-l0cyMroinI0@public.gmane.org
> 
> >-----Original Message-----
> >From: Philby John [mailto:pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org]
> >Sent: Thursday, December 03, 2009 11:12 AM
> >To: Karicheri, Muralidharan
> >Cc: Kevin Hilman; Ben Dooks; davinci-linux-open-
> >source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
> >
> >Murali,
> >
> >	The patch works for DM6446 and DM355 only. To get it to work for
> >DM365
> >one must update the gpio pin number variables (sda_pin and scl_pin) in
> >struct davinci_i2c_platform_data for each platform.
> >
> >I do not have the pin number information for other Davinci platforms.
> >This was mentioned in the comment section of the patch v2...
> >
> >"TODO: Need to add SDA and SCL pin numbers to the respective
> >platforms such as dm355-leopard, dm365, dm646x, da8xx etc.
> >What I have info on is limited to just dm355 and dm6446."
> >
> >If someone can provide me with the relevant information, I could update
> >for all.
> >
> >I used "./i2cset -y 0 0x50 0x00" cause its the only way to kill the i2c
> >bus on a 2.6.18 kernel with DVSDK 2.0. FYI, I do not know how to
> >generate cmem.ko for the Arago tree kernel that would get
> >"fbdev_loopback" running.
> >
> >Regards,
> >Philby
> >
> >
> >On Thu, 2009-12-03 at 09:45 -0600, Karicheri, Muralidharan wrote:
> >> Philby,
> >>
> >> Is this a generic solution which works on DM365 as well?
> >>
> >> Why did you do the following command?
> >>
> >> #./i2cset -y 0 0x50 0x00
> >>
> >> Using the Arago tree kernel I was able to reproduce the issue
> >> by doing
> >>
> >> ./fbdev_loopback -i2 -d0
> >>
> >> and then press Control C. I am not sure why you run the command
> >> ./i2cset -y 0 0x50 0x00
> >>
> >>
> >> Murali Karicheri
> >> Software Design Engineer
> >> Texas Instruments Inc.
> >> Germantown, MD 20874
> >> phone: 301-407-9583
> >> email: m-karicheri2-l0cyMroinI0@public.gmane.org
> >>
> >> >-----Original Message-----
> >> >From: Philby John [mailto:pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org]
> >> >Sent: Monday, November 23, 2009 10:24 AM
> >> >To: Karicheri, Muralidharan
> >> >Cc: Kevin Hilman; Ben Dooks; davinci-linux-open-
> >> >source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> >Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
> >> >
> >> >Hello Murali,
> >> >
> >> >On Thu, 2009-07-16 at 16:22 -0500, Karicheri, Muralidharan wrote:
> >> >> Philby,
> >> >>
> >> >> I tried running this patch against 2.6.31.rc2 (davinci kernel tree).
> >But
> >> >I got a crash as I run the application which is given below....
> >> >>
> >> >> In my case, time out happens when I kill the capture application using
> >> >Cntrl-C. After Cnrtl-C, the mt9t031 i2c device couldn't be contacted by
> >the
> >> >host (during cleanup, i2c commands fails). When the application is run
> >> >again, I get following outputs..
> >> >>
> >> >> i2c_davinci i2c_davinci.1: timeout waiting for bus ready
> >> >> i2c_davinci i2c_davinci.1: timeout waiting for bus ready
> >> >>
> >> >> Here are the complete log....
> >> >>
> >> >> application running and pressed Cntrl-C ====>
> >> >>
> >> >> time:105    frame:33
> >> >> time:105    frame:34vpfe-capture vpfe-capture: stream off failed in
> >> >subdev
> >> >>
> >> >> Running it again .....
> >> >>
> >> >> root-fKfTphxkbEe3Z1R/gWBstg@public.gmane.org:/opt/git# ./fbdev_loopback -i2 -d0
> >> >
> >> >
> >> >I have now verified the code on a DM6446 and DM355, with
> >> >the ./fbdev_loopback test. I had to first do a #./i2cset -y 0 0x50 0x00
> >> >0x0000 w to kill the bus and then run the ./fbdev_loopback test to
> >> >recreate the issue. Recovery seems to happen with the new patch. Could
> >> >you try this out at your end, with the new patch?
> >> >
> >> >Thanks and regards,
> >> >Philby
> >> >
> >>
> 

--=-7BmxZoHhGnk4qAseODSW
Content-Disposition: attachment; filename*0=0001-Davinci-i2c-bus-recovery-procedure-to-clear-the-bus.patc; filename*1=h
Content-Type: text/x-patch; name="0001-Davinci-i2c-bus-recovery-procedure-to-clear-the-bus.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 0372e68cfd14ab37595498234abe39f2f10787d5 Mon Sep 17 00:00:00 2001
From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Date: Mon, 23 Nov 2009 18:08:33 +0530
Subject: [PATCH] Davinci i2c bus recovery procedure to clear the bus

Come out of i2c time out condition by following the
bus recovery procedure outlined in the i2c protocol v3 spec.
The kernel must be robust enough to gracefully recover
from i2c bus failure without having to reset the machine.
This is done by first NACKing the slave, pulsing the SCL
line 9 times and then sending the stop command.

This patch has been tested on a DM6446 and DM355

Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Srinivasan, Nageswari <nageswari-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c  |    2 +
 arch/arm/mach-davinci/board-dm644x-evm.c |    2 +
 arch/arm/mach-davinci/include/mach/i2c.h |    2 +
 drivers/i2c/busses/i2c-davinci.c         |   60 +++++++++++++++++++++++++++---
 4 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index a9b650d..a20b2de 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -111,6 +111,8 @@ static struct platform_device davinci_nand_device = {
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 400	/* kHz */,
 	.bus_delay	= 0	/* usec */,
+	.sda_pin	= 15,
+	.scl_pin	= 14,
 };
 
 static struct snd_platform_data dm355_evm_snd_data;
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index fd0398b..b5ce36b 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -628,6 +628,8 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 20 /* kHz */,
 	.bus_delay	= 100 /* usec */,
+	.sda_pin	= 44,
+	.scl_pin	= 43,
 };
 
 static void __init evm_init_i2c(void)
diff --git a/arch/arm/mach-davinci/include/mach/i2c.h b/arch/arm/mach-davinci/include/mach/i2c.h
index c248e9b..21be118 100644
--- a/arch/arm/mach-davinci/include/mach/i2c.h
+++ b/arch/arm/mach-davinci/include/mach/i2c.h
@@ -16,6 +16,8 @@
 struct davinci_i2c_platform_data {
 	unsigned int	bus_freq;	/* standard bus frequency (kHz) */
 	unsigned int	bus_delay;	/* post-transaction delay (usec) */
+	unsigned int	sda_pin;	/* GPIO pin ID to use for SDA */
+	unsigned int	scl_pin;	/* GPIO pin ID to use for SCL */
 };
 
 /* for board setup code */
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 67d88cc..be18cab 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 
@@ -43,6 +44,7 @@
 /* ----- global defines ----------------------------------------------- */
 
 #define DAVINCI_I2C_TIMEOUT	(1*HZ)
+#define DAVINCI_I2C_MAX_TRIES	2
 #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
 				 DAVINCI_I2C_IMR_SCD | \
 				 DAVINCI_I2C_IMR_ARDY | \
@@ -134,6 +136,44 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
+/* Generate a pulse on the i2c clock pin. */
+static void generic_i2c_clock_pulse(unsigned int scl_pin)
+{
+	u16 i;
+
+	if (scl_pin) {
+		/* Send high and low on the SCL line */
+		for (i = 0; i < 9; i++) {
+			gpio_set_value(scl_pin, 0);
+			udelay(20);
+			gpio_set_value(scl_pin, 1);
+			udelay(20);
+		}
+	}
+}
+
+/* This routine does i2c bus recovery as specified in the
+ * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
+ */
+static void i2c_recover_bus(struct davinci_i2c_dev *dev)
+{
+	u32 flag = 0;
+	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+
+	dev_err(dev->dev, "initiating i2c bus recovery\n");
+	/* Send NACK to the slave */
+	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
+	flag |=  DAVINCI_I2C_MDR_NACK;
+	/* write the data into mode register */
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+	if (pdata)
+		generic_i2c_clock_pulse(pdata->scl_pin);
+	/* Send STOP */
+	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
+	MOD_REG_BIT(flag, DAVINCI_I2C_MDR_STP, 1);
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+}
+
 /*
  * This functions configures I2C and brings I2C out of reset.
  * This function is called during I2C init function. This function
@@ -221,19 +261,26 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
 					 char allow_sleep)
 {
 	unsigned long timeout;
+	static u16 to_cnt = 0;
 
 	timeout = jiffies + dev->adapter.timeout;
 	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
-	       & DAVINCI_I2C_STR_BB) {
-		if (time_after(jiffies, timeout)) {
-			dev_warn(dev->dev,
-				 "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
+			& DAVINCI_I2C_STR_BB) {
+		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
+			if (time_after(jiffies, timeout)) {
+				dev_warn(dev->dev,
+					"timeout waiting for bus ready\n");
+				to_cnt++;
+				return -ETIMEDOUT;
+			} else {
+				to_cnt = 0;
+				i2c_recover_bus(dev);
+				i2c_davinci_init(dev);
+			}
 		}
 		if (allow_sleep)
 			schedule_timeout(1);
 	}
-
 	return 0;
 }
 
@@ -310,6 +357,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 						      dev->adapter.timeout);
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		i2c_recover_bus(dev);
 		i2c_davinci_init(dev);
 		dev->buf_len = 0;
 		return -ETIMEDOUT;
-- 
1.6.3.3.MVISTA


--=-7BmxZoHhGnk4qAseODSW--
