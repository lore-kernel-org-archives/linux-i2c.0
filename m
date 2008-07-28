From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: What is in bjdooks' git
Date: Mon, 28 Jul 2008 13:11:37 +0100
Message-ID: <E1KNRZh-0003XT-Br@kira.home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit c9272c4f9fbe2087beb3392f526dc5b19efaa56b:
  Linus Torvalds (1):
        Merge branch 'hotfixes' of git://git.linux-nfs.org/projects/trondmy/nfs-2.6

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-linus

Ben Dooks (4):
      i2c: S3C2410: Pass the I2C bus number via drivers platform data
      i2c: i2c_gpio: keep probe resident for hotplugged devices.
      i2c: S3C24XX I2C frequency scaling support.
      i2c: Documentation: upgrading clients HOWTO

Michael Hennerich (1):
      i2c: Blackfin I2C Driver: Functional power management support

 Documentation/i2c/upgrading-clients |  281 +++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-bfin-twi.c   |   35 +++--
 drivers/i2c/busses/i2c-gpio.c       |    9 +-
 drivers/i2c/busses/i2c-s3c2410.c    |  129 ++++++++++++++--
 include/asm-arm/plat-s3c/iic.h      |    1 +
 5 files changed, 426 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/i2c/upgrading-clients
diff --git a/Documentation/i2c/upgrading-clients b/Documentation/i2c/upgrading-clients
new file mode 100644
index 0000000..9a45f9b
--- /dev/null
+++ b/Documentation/i2c/upgrading-clients
@@ -0,0 +1,281 @@
+Upgrading I2C Drivers to the new 2.6 Driver Model
+=================================================
+
+Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
+
+Introduction
+------------
+
+This guide outlines how to alter existing Linux 2.6 client drivers from
+the old to the new new binding methods.
+
+
+Example old-style driver
+------------------------
+
+
+struct example_state {
+	struct i2c_client	client;
+	....
+};
+
+static struct i2c_driver example_driver;
+
+static unsigned short ignore[] = { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { OUR_ADDR, I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD;
+
+static int example_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct example_state *state;
+	struct device *dev = &adap->dev;  /* to use for dev_ reports */
+	int ret;
+
+	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
+	if (state == NULL) {
+		dev_err(dev, "failed to create our state\n");
+		return -ENOMEM;
+	}
+
+	example->client.addr    = addr;
+	example->client.flags   = 0;
+	example->client.adapter = adap;
+
+	i2c_set_clientdata(&state->i2c_client, state);
+	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
+
+	ret = i2c_attach_client(&state->i2c_client);
+	if (ret < 0) {
+		dev_err(dev, "failed to attach client\n");
+		kfree(state);
+		return ret;
+	}
+
+	dev = &state->i2c_client.dev;
+
+	/* rest of the initialisation goes here. */
+
+	dev_info(dev, "example client created\n");
+
+	return 0;
+}
+
+static int __devexit example_detach(struct i2c_client *client)
+{
+	struct example_state *state = i2c_get_clientdata(client);
+
+	i2c_detach_client(client);
+	kfree(state);
+	return 0;
+}
+
+static int example_attach_adapter(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, example_attach);
+}
+
+static struct i2c_driver example_driver = {
+ 	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= "example",
+	},
+	.attach_adapter = example_attach_adapter,
+	.detach_client	= __devexit_p(example_detach),
+	.suspend	= example_suspend,
+	.resume		= example_resume,
+};
+
+
+Updating the client
+-------------------
+
+The new style binding model will check against a list of supported
+devices and their associated address supplied by the code registering
+the busses. This means that the driver .attach_adapter and
+.detach_adapter methods can be removed, along with the addr_data,
+as follows:
+
+- static struct i2c_driver example_driver;
+
+- static unsigned short ignore[] = { I2C_CLIENT_END };
+- static unsigned short normal_addr[] = { OUR_ADDR, I2C_CLIENT_END };
+
+- I2C_CLIENT_INSMOD;
+
+- static int example_attach_adapter(struct i2c_adapter *adap)
+- {
+- 	return i2c_probe(adap, &addr_data, example_attach);
+- }
+
+ static struct i2c_driver example_driver = {
+-	.attach_adapter = example_attach_adapter,
+-	.detach_client	= __devexit_p(example_detach),
+ }
+
+Add the probe and remove methods to the i2c_driver, as so:
+
+ static struct i2c_driver example_driver = {
++	.probe		= example_probe,
++	.remove		= __devexit_p(example_remove),
+ }
+
+Change the example_attach method to accept the new parameters
+which include the i2c_client that it will be working with:
+
+- static int example_attach(struct i2c_adapter *adap, int addr, int kind)
++ static int example_probe(struct i2c_client *client,
++			   const struct i2c_device_id *id)
+
+Change the name of example_attach to example_probe to align it with the
+i2c_driver entry names. The rest of the probe routine will now need to be
+changed as the i2c_client has already been setup for use.
+
+The necessary client fields have already been setup before
+the probe function is called, so the following client setup
+can be removed:
+
+-	example->client.addr    = addr;
+-	example->client.flags   = 0;
+-	example->client.adapter = adap;
+-
+-	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
+
+The i2c_set_clientdata is now:
+
+-	i2c_set_clientdata(&state->client, state);
++	i2c_set_clientdata(client, state);
+
+The call to i2c_attach_client is no longer needed, if the probe
+routine exits successfully, then the driver will be automatically
+attached by the core. Change the probe routine as so:
+
+-	ret = i2c_attach_client(&state->i2c_client);
+-	if (ret < 0) {
+-		dev_err(dev, "failed to attach client\n");
+-		kfree(state);
+-		return ret;
+-	}
+
+
+Remove the storage of 'struct i2c_client' from the 'struct example_state'
+as we are provided with the i2c_client in our example_probe. Instead we
+store a pointer to it for when it is needed.
+
+struct example_state {
+-	struct i2c_client	client;
++	struct i2c_client	*client;
+
+the new i2c client as so:
+
+-	struct device *dev = &adap->dev;  /* to use for dev_ reports */
++ 	struct device *dev = &i2c_client->dev;  /* to use for dev_ reports */
+
+And remove the change after our client is attached, as the driver no
+longer needs to register a new client structure with the core:
+
+-	dev = &state->i2c_client.dev;
+
+In the probe routine, ensure that the new state has the client stored
+in it:
+
+static int example_probe(struct i2c_client *i2c_client,
+			 const struct i2c_device_id *id)
+{
+	struct example_state *state;
+ 	struct device *dev = &i2c_client->dev;
+	int ret;
+
+	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
+	if (state == NULL) {
+		dev_err(dev, "failed to create our state\n");
+		return -ENOMEM;
+	}
+
++	state->client = i2c_client;
+
+Update the detach method, by changing the name to _remove and
+to delete the i2c_detach_client call. It is possible that you
+can also remove the ret variable as it is not not needed for
+any of the core functions.
+
+- static int __devexit example_detach(struct i2c_client *client)
++ static int __devexit example_remove(struct i2c_client *client)
+{
+	struct example_state *state = i2c_get_clientdata(client);
+
+-	i2c_detach_client(client);
+
+And finally ensure that we have the correct ID table for the i2c-core
+and other utilities:
+
++ struct i2c_device_id example_idtable[] = {
++       { "example", 0 },
++       { }
++};
++
++MODULE_DEVICE_TABLE(i2c, example_idtable);
+
+static struct i2c_driver example_driver = {
+ 	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= "example",
+	},
++	.id_table	= example_ids,
+
+
+Our driver should now look like this:
+
+struct example_state {
+	struct i2c_client	*client;
+	....
+};
+
+static int example_probe(struct i2c_client *client,
+		     	 const struct i2c_device_id *id)
+{
+	struct example_state *state;
+	struct device *dev = &client->dev;
+
+	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
+	if (state == NULL) {
+		dev_err(dev, "failed to create our state\n");
+		return -ENOMEM;
+	}
+
+	state->client = client;
+	i2c_set_clientdata(client, state);
+
+	/* rest of the initialisation goes here. */
+
+	dev_info(dev, "example client created\n");
+
+	return 0;
+}
+
+static int __devexit example_remove(struct i2c_client *client)
+{
+	struct example_state *state = i2c_get_clientdata(client);
+
+	kfree(state);
+	return 0;
+}
+
+static struct i2c_device_id example_idtable[] = {
+	{ "example", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, example_idtable);
+
+static struct i2c_driver example_driver = {
+ 	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= "example",
+	},
+	.id_table	= example_idtable,
+	.probe		= example_probe,
+	.remove		= __devexit_p(example_remove),
+	.suspend	= example_suspend,
+	.resume		= example_resume,
+};
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 48d084b..3c855ff 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -49,6 +49,8 @@ struct bfin_twi_iface {
 	struct i2c_msg 		*pmsg;
 	int			msg_num;
 	int			cur_msg;
+	u16			saved_clkdiv;
+	u16			saved_control;
 	void __iomem		*regs_base;
 };
 
@@ -565,32 +567,43 @@ static u32 bfin_twi_functionality(struct i2c_adapter *adap)
 	       I2C_FUNC_I2C;
 }
 
-
 static struct i2c_algorithm bfin_twi_algorithm = {
 	.master_xfer   = bfin_twi_master_xfer,
 	.smbus_xfer    = bfin_twi_smbus_xfer,
 	.functionality = bfin_twi_functionality,
 };
 
-
-static int i2c_bfin_twi_suspend(struct platform_device *dev, pm_message_t state)
+static int i2c_bfin_twi_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct bfin_twi_iface *iface = platform_get_drvdata(dev);
+	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
+
+	iface->saved_clkdiv = read_CLKDIV(iface);
+	iface->saved_control = read_CONTROL(iface);
+
+	free_irq(iface->irq, iface);
 
 	/* Disable TWI */
-	write_CONTROL(iface, read_CONTROL(iface) & ~TWI_ENA);
-	SSYNC();
+	write_CONTROL(iface, iface->saved_control & ~TWI_ENA);
 
 	return 0;
 }
 
-static int i2c_bfin_twi_resume(struct platform_device *dev)
+static int i2c_bfin_twi_resume(struct platform_device *pdev)
 {
-	struct bfin_twi_iface *iface = platform_get_drvdata(dev);
+	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
 
-	/* Enable TWI */
-	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
-	SSYNC();
+	int rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
+		IRQF_DISABLED, pdev->name, iface);
+	if (rc) {
+		dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
+		return -ENODEV;
+	}
+
+	/* Resume TWI interface clock as specified */
+	write_CLKDIV(iface, iface->saved_clkdiv);
+
+	/* Resume TWI */
+	write_CONTROL(iface, iface->saved_control);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 79b455a..32104ea 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -77,7 +77,7 @@ static int i2c_gpio_getscl(void *data)
 	return gpio_get_value(pdata->scl_pin);
 }
 
-static int __init i2c_gpio_probe(struct platform_device *pdev)
+static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
@@ -174,7 +174,7 @@ err_alloc_adap:
 	return ret;
 }
 
-static int __exit i2c_gpio_remove(struct platform_device *pdev)
+static int __devexit i2c_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_adapter *adap;
@@ -196,14 +196,15 @@ static struct platform_driver i2c_gpio_driver = {
 		.name	= "i2c-gpio",
 		.owner	= THIS_MODULE,
 	},
-	.remove		= __exit_p(i2c_gpio_remove),
+	.probe		= i2c_gpio_probe,
+	.remove		= __devexit_p(i2c_gpio_remove),
 };
 
 static int __init i2c_gpio_init(void)
 {
 	int ret;
 
-	ret = platform_driver_probe(&i2c_gpio_driver, i2c_gpio_probe);
+	ret = platform_driver_register(&i2c_gpio_driver);
 	if (ret)
 		printk(KERN_ERR "i2c-gpio: probe failed: %d\n", ret);
 
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 007390a..4864723 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -33,6 +33,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -64,6 +65,7 @@ struct s3c24xx_i2c {
 	unsigned int		tx_setup;
 
 	enum s3c24xx_i2c_state	state;
+	unsigned long		clkrate;
 
 	void __iomem		*regs;
 	struct clk		*clk;
@@ -71,6 +73,10 @@ struct s3c24xx_i2c {
 	struct resource		*irq;
 	struct resource		*ioarea;
 	struct i2c_adapter	adap;
+
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+#endif
 };
 
 /* default platform data to use if not supplied in the platform_device
@@ -501,6 +507,9 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c, struct i2c_msg *msgs, int
 	unsigned long timeout;
 	int ret;
 
+	if (!readl(i2c->regs + S3C2410_IICCON) & S3C2410_IICCON_IRQEN)
+		return -EIO;
+
 	ret = s3c24xx_i2c_set_master(i2c);
 	if (ret != 0) {
 		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
@@ -636,27 +645,28 @@ static inline int freq_acceptable(unsigned int freq, unsigned int wanted)
 	return (diff >= -2 && diff <= 2);
 }
 
-/* s3c24xx_i2c_getdivisor
+/* s3c24xx_i2c_clockrate
  *
  * work out a divisor for the user requested frequency setting,
  * either by the requested frequency, or scanning the acceptable
  * range of frequencies until something is found
 */
 
-static int s3c24xx_i2c_getdivisor(struct s3c24xx_i2c *i2c,
-				  struct s3c2410_platform_i2c *pdata,
-				  unsigned long *iicon,
-				  unsigned int *got)
+static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 {
+	struct s3c2410_platform_i2c *pdata;
 	unsigned long clkin = clk_get_rate(i2c->clk);
-	
 	unsigned int divs, div1;
+	u32 iiccon;
 	int freq;
 	int start, end;
 
+	i2c->clkrate = clkin;
+
+	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
 	clkin /= 1000;		/* clkin now in KHz */
      
-	dev_dbg(i2c->dev,  "pdata %p, freq %lu %lu..%lu\n",
+	dev_dbg(i2c->dev, "pdata %p, freq %lu %lu..%lu\n",
 		 pdata, pdata->bus_freq, pdata->min_freq, pdata->max_freq);
 
 	if (pdata->bus_freq != 0) {
@@ -688,11 +698,79 @@ static int s3c24xx_i2c_getdivisor(struct s3c24xx_i2c *i2c,
 
  found:
 	*got = freq;
-	*iicon |= (divs-1);
-	*iicon |= (div1 == 512) ? S3C2410_IICCON_TXDIV_512 : 0;
+
+	iiccon = readl(i2c->regs + S3C2410_IICCON);
+	iiccon &= ~(S3C2410_IICCON_SCALEMASK | S3C2410_IICCON_TXDIV_512);
+	iiccon |= (divs-1);
+
+	if (div1 == 512)
+		iiccon |= S3C2410_IICCON_TXDIV_512;
+
+	writel(iiccon, i2c->regs + S3C2410_IICCON);
+
+	return 0;
+}
+
+#ifdef CONFIG_CPU_FREQ
+
+#define freq_to_i2c(_n) container_of(_n, struct s3c24xx_i2c, freq_transition)
+
+static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
+					  unsigned long val, void *data)
+{
+	struct s3c24xx_i2c *i2c = freq_to_i2c(nb);
+	unsigned long flags;
+	unsigned int got;
+	int delta_f;
+	int ret;
+
+	delta_f = clk_get_rate(i2c->clk) - i2c->clkrate;
+
+	/* if we're post-change and the input clock has slowed down
+	 * or at pre-change and the clock is about to speed up, then
+	 * adjust our clock rate. <0 is slow, >0 speedup.
+	 */
+
+	if ((val == CPUFREQ_POSTCHANGE && delta_f < 0) ||
+	    (val == CPUFREQ_PRECHANGE && delta_f > 0)) {
+		spin_lock_irqsave(&i2c->lock, flags);
+		ret = s3c24xx_i2c_clockrate(i2c, &got);
+		spin_unlock_irqrestore(&i2c->lock, flags);
+
+		if (ret < 0)
+			dev_err(i2c->dev, "cannot find frequency\n");
+		else
+			dev_info(i2c->dev, "setting freq %d\n", got);
+	}
+
+	return 0;
+}
+
+static inline int s3c24xx_i2c_register_cpufreq(struct s3c24xx_i2c *i2c)
+{
+	i2c->freq_transition.notifier_call = s3c24xx_i2c_cpufreq_transition;
+
+	return cpufreq_register_notifier(&i2c->freq_transition,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
+{
+	cpufreq_unregister_notifier(&i2c->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+#else
+static inline int s3c24xx_i2c_register_cpufreq(struct s3c24xx_i2c *i2c)
+{
 	return 0;
 }
 
+static inline void s3c24xx_i2c_deregister_cpufreq(struct s3c24xx_i2c *i2c)
+{
+}
+#endif
+
 /* s3c24xx_i2c_init
  *
  * initialise the controller, set the IO lines and frequency 
@@ -719,9 +797,12 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	dev_info(i2c->dev, "slave address 0x%02x\n", pdata->slave_addr);
 
+	writel(iicon, i2c->regs + S3C2410_IICCON);
+
 	/* we need to work out the divisors for the clock... */
 
-	if (s3c24xx_i2c_getdivisor(i2c, pdata, &iicon, &freq) != 0) {
+	if (s3c24xx_i2c_clockrate(i2c, &freq) != 0) {
+		writel(0, i2c->regs + S3C2410_IICCON);
 		dev_err(i2c->dev, "cannot meet bus frequency required\n");
 		return -EINVAL;
 	}
@@ -730,8 +811,6 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	dev_info(i2c->dev, "bus frequency set to %d KHz\n", freq);
 	dev_dbg(i2c->dev, "S3C2410_IICCON=0x%02lx\n", iicon);
-	
-	writel(iicon, i2c->regs + S3C2410_IICCON);
 
 	/* check for s3c2440 i2c controller  */
 
@@ -752,9 +831,12 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
+	struct s3c2410_platform_i2c *pdata;
 	struct resource *res;
 	int ret;
 
+	pdata = s3c24xx_i2c_get_platformdata(&pdev->dev);
+
 	/* find the clock and enable it */
 
 	i2c->dev = &pdev->dev;
@@ -832,17 +914,34 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "irq resource %p (%lu)\n", res,
 		(unsigned long)res->start);
 
-	ret = i2c_add_adapter(&i2c->adap);
+	ret = s3c24xx_i2c_register_cpufreq(i2c);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
+		dev_err(&pdev->dev, "failed to register cpufreq notifier\n");
 		goto err_irq;
 	}
 
+	/* Note, previous versions of the driver used i2c_add_adapter()
+	 * to add the bus at any number. We now pass the bus number via
+	 * the platform data, so if unset it will now default to always
+	 * being bus 0.
+	 */
+
+	i2c->adap.nr = pdata->bus_num;
+
+	ret = i2c_add_numbered_adapter(&i2c->adap);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
+		goto err_cpufreq;
+	}
+
 	platform_set_drvdata(pdev, i2c);
 
 	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", i2c->adap.dev.bus_id);
 	return 0;
 
+ err_cpufreq:
+	s3c24xx_i2c_deregister_cpufreq(i2c);
+
  err_irq:
 	free_irq(i2c->irq->start, i2c);
 
@@ -870,6 +969,8 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
+	s3c24xx_i2c_deregister_cpufreq(i2c);
+
 	i2c_del_adapter(&i2c->adap);
 	free_irq(i2c->irq->start, i2c);
 
diff --git a/include/asm-arm/plat-s3c/iic.h b/include/asm-arm/plat-s3c/iic.h
index 71211c8..d08a1f2 100644
--- a/include/asm-arm/plat-s3c/iic.h
+++ b/include/asm-arm/plat-s3c/iic.h
@@ -21,6 +21,7 @@
 */
 
 struct s3c2410_platform_i2c {
+	int		bus_num;	/* bus number to use */
 	unsigned int	flags;
 	unsigned int	slave_addr;	/* slave address for controller */
 	unsigned long	bus_freq;	/* standard bus frequency */

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
