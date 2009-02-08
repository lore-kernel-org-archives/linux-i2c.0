From: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCHv2 1/2] i2c: add missing KERN_* constants to printks
Date: Sun, 08 Feb 2009 15:18:49 +0100
Message-ID: <498EE9C9.4080002@suse.de>
References: <498C3EEA.5060508@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498C3EEA.5060508-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, ukleinek-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, fseidel-l3A5Bk7waGM@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>

According to kerneljanitors todo list all printk calls (beginning
a new line) should have an according KERN_* constant.
Those are the missing pieces here for the i2c subsystem.

Signed-off-by: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pcf.c  |    2 +-
 drivers/i2c/busses/i2c-pca-isa.c  |    5 +++--
 drivers/i2c/busses/i2c-powermac.c |    3 ++-
 drivers/i2c/busses/i2c-pxa.c      |    9 +++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

--- linux-2.6.orig/drivers/i2c/algos/i2c-algo-pcf.c
+++ linux-2.6/drivers/i2c/algos/i2c-algo-pcf.c
@@ -61,7 +61,7 @@ static int i2c_debug;
 
 static void i2c_start(struct i2c_algo_pcf_data *adap) 
 {
-	DEBPROTO(printk("S "));
+	DEBPROTO(printk(KERN_DEBUG "S "));
 	set_pcf(adap, 1, I2C_PCF_START);
 }
 
--- linux-2.6.orig/drivers/i2c/busses/i2c-pca-isa.c
+++ linux-2.6/drivers/i2c/busses/i2c-pca-isa.c
@@ -49,7 +49,8 @@ static void pca_isa_writebyte(void *pd,
 {
 #ifdef DEBUG_IO
 	static char *names[] = { "T/O", "DAT", "ADR", "CON" };
-	printk("*** write %s at %#lx <= %#04x\n", names[reg], base+reg, val);
+	printk(KERN_DEBUG "*** write %s at %#lx <= %#04x\n", names[reg],
+	       base+reg, val);
 #endif
 	outb(val, base+reg);
 }
@@ -60,7 +61,7 @@ static int pca_isa_readbyte(void *pd, in
 #ifdef DEBUG_IO
 	{
 		static char *names[] = { "STA", "DAT", "ADR", "CON" };
-		printk("*** read  %s => %#04x\n", names[reg], res);
+		printk(KERN_DEBUG "*** read  %s => %#04x\n", names[reg], res);
 	}
 #endif
 	return res;
--- linux-2.6.orig/drivers/i2c/busses/i2c-powermac.c
+++ linux-2.6/drivers/i2c/busses/i2c-powermac.c
@@ -191,7 +191,8 @@ static int __devexit i2c_powermac_remove
 	i2c_set_adapdata(adapter, NULL);
 	/* We aren't that prepared to deal with this... */
 	if (rc)
-		printk("i2c-powermac.c: Failed to remove bus %s !\n",
+		printk(KERN_WARNING
+		       "i2c-powermac.c: Failed to remove bus %s !\n",
 		       adapter->name);
 	platform_set_drvdata(dev, NULL);
 	kfree(adapter);
--- linux-2.6.orig/drivers/i2c/busses/i2c-pxa.c
+++ linux-2.6/drivers/i2c/busses/i2c-pxa.c
@@ -210,11 +210,12 @@ static irqreturn_t i2c_pxa_handler(int t
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
-	printk("i2c: error: %s\n", why);
-	printk("i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
+	printk(KERN_ERR "i2c: error: %s\n", why);
+	printk(KERN_ERR "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
 		i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
-	printk("i2c: ICR: %08x ISR: %08x\n"
-	       "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
+	printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n"
+	       readl(_ICR(i2c)), readl(_ISR(i2c)));
+	printk(KERN_DEBUG "i2c: log: ");
 	for (i = 0; i < i2c->irqlogidx; i++)
 		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
 	printk("\n");
