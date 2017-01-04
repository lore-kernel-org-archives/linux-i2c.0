From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 09:54:56 -0800
Message-ID: <20170104175456.GA40341@dtor-ws>
References: <20170104091845.GB3499@pali>
 <20170104101306.GR5767@mail.corp.redhat.com>
 <20170104102118.GD3499@pali>
 <20170104103233.GT5767@mail.corp.redhat.com>
 <20170104112223.GE3499@pali>
 <20170104120031.GG3499@pali>
 <20170104130252.GV5767@mail.corp.redhat.com>
 <20170104160643.GH3499@pali>
 <20170104173928.GW5767@mail.corp.redhat.com>
 <20170104174619.feke27q3ehwkylfs@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104174619.feke27q3ehwkylfs@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 04, 2017 at 06:46:19PM +0100, Wolfram Sang wrote:
> 
> > How about:
> > ---
> > From daa7571bbf337704332c0cfeec9b8fd5aeae596f Mon Sep 17 00:00:00 2001
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Date: Wed, 4 Jan 2017 18:26:54 +0100
> > Subject: [PATCH] I2C: add the source of the IRQ in struct i2c_client
> > 
> > With commit 4d5538f5882a ("i2c: use an IRQ to report Host Notify events,
> > not alert"), the IRQ provided in struct i2c_client might be assigned while
> > it has not been explicitly declared by either the platform information
> > or OF or ACPI.
> > Some drivers (lis3lv02d) rely on the fact that the IRQ gets assigned or
> > not to trigger a different behavior (exposing /dev/freefall in this case).
> > 
> > Provide a way for others to know who set the IRQ and so they can behave
> > accordingly.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/i2c/i2c-core.c |  7 +++++++
> >  include/linux/i2c.h    | 11 +++++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index cf9e396..226c75d 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -935,8 +935,12 @@ static int i2c_device_probe(struct device *dev)
> >  			irq = of_irq_get_byname(dev->of_node, "irq");
> >  			if (irq == -EINVAL || irq == -ENODATA)
> >  				irq = of_irq_get(dev->of_node, 0);
> > +			if (irq > 0)
> > +				client->irq_source = I2C_IRQ_SOURCE_OF;
> >  		} else if (ACPI_COMPANION(dev)) {
> >  			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
> > +			if (irq > 0)
> > +				client->irq_source = I2C_IRQ_SOURCE_ACPI;
> >  		}
> >  		if (irq == -EPROBE_DEFER)
> >  			return irq;
> > @@ -947,6 +951,8 @@ static int i2c_device_probe(struct device *dev)
> >  		if (irq < 0) {
> >  			dev_dbg(dev, "Using Host Notify IRQ\n");
> >  			irq = i2c_smbus_host_notify_to_irq(client);
> > +			if (irq > 0)
> > +				client->irq_source = I2C_IRQ_SOURCE_HOST_NOTIFY;
> >  		}
> >  		if (irq < 0)
> >  			irq = 0;
> > @@ -1317,6 +1323,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
> >  	client->flags = info->flags;
> >  	client->addr = info->addr;
> >  	client->irq = info->irq;
> > +	client->irq_source = I2C_IRQ_SOURCE_PLATFORM;
> >  
> >  	strlcpy(client->name, info->type, sizeof(client->name));
> >  
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index b2109c5..7d0368d 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -213,6 +213,13 @@ struct i2c_driver {
> >  };
> >  #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
> >  
> > +enum i2c_irq_source {
> > +	I2C_IRQ_SOURCE_PLATFORM,
> > +	I2C_IRQ_SOURCE_OF,
> > +	I2C_IRQ_SOURCE_ACPI,
> > +	I2C_IRQ_SOURCE_HOST_NOTIFY,
> > +};
> > +
> >  /**
> >   * struct i2c_client - represent an I2C slave device
> >   * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
> > @@ -227,6 +234,9 @@ struct i2c_driver {
> >   *	userspace_devices list
> >   * @slave_cb: Callback when I2C slave mode of an adapter is used. The adapter
> >   *	calls it to pass on slave events to the slave driver.
> > + * @irq_source: Enum which provides the source of the IRQ. Useful to know
> > + * 	if the IRQ was issued from Host Notify or if it was provided by an other
> > + * 	component.
> 
> I'd think some documentation somewhere makes sense why we need to
> distinguish this in some cases?

I'd rather drivers be oblivious of the source of interrupt. If they need
to distinguish between them that means that our IRQ abstration failed.

> 
> >   *
> >   * An i2c_client identifies a single device (i.e. chip) connected to an
> >   * i2c bus. The behaviour exposed to Linux is defined by the driver
> > @@ -245,6 +255,7 @@ struct i2c_client {
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >  	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
> >  #endif
> > +	enum i2c_irq_source irq_source;	/* which component assigned the irq */
> >  };
> >  #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
> > 
> > Dmitry, Wolfram, Jean, would this be acceptable for you?
> 
> Adding something to i2c_driver is not exactly cheap, but from what I
> glimpsed from this thread, this is one of the cleanest solution to this
> problem?
> 

As Benjamin said, it is really property of device [instance], not
driver. I.e. driver could handle both wired IRQ and HostNotify-based
scheme similarly, it is device (and board) that knows how stuff is
connected.

Maybe we could do something like this (untested):


>From e362a0277fd1bd6112f258664d8831d9bc6b78da Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 4 Jan 2017 09:33:43 -0800
Subject: [PATCH] i2c: do not enable fall back to Host Notify by default

Falling back unconditionally to HostNotify as primary client's interrupt
breaks some drivers which alter their functionality depending on whether
interrupt is present or not, so let's introduce a board flag telling I2C
core explicitly if we want wired interrupt or HostNotify-based one:
I2C_CLIENT_HOST_NOTIFY.

For DT-based systems we introduce "host-notofy" property that we convert
to I2C_CLIENT_HOST_NOTIFY board flag.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++++++
 drivers/i2c/i2c-core.c                        | 17 ++++++++---------
 include/linux/i2c.h                           |  1 +
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index 5fa691e6f638..cee9d5055fa2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -62,6 +62,9 @@ wants to support one of the below features, it should adapt the bindings below.
 	"irq" and "wakeup" names are recognized by I2C core, other names are
 	left to individual drivers.
 
+- host-notify
+	device uses SMBus host notify protocol instead of interrupt line.
+
 - multi-master
 	states that there is another master active on this bus. The OS can use
 	this information to adapt power management to keep the arbitration awake
@@ -81,6 +84,11 @@ Binding may contain optional "interrupts" property, describing interrupts
 used by the device. I2C core will assign "irq" interrupt (or the very first
 interrupt if not using interrupt names) as primary interrupt for the slave.
 
+Alternatively, devices supporting SMbus Host Notify, and connected to
+adapters that support this feature, may use "host-notify" property. I2C
+core will create a virtual interrupt for Host Notify and assign it as
+primary interrupt for the slave.
+
 Also, if device is marked as a wakeup source, I2C core will set up "wakeup"
 interrupt for the device. If "wakeup" interrupt name is not present in the
 binding, then primary interrupt will be used as wakeup interrupt.
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cf9e396d7702..250969fa7670 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -931,7 +931,10 @@ static int i2c_device_probe(struct device *dev)
 	if (!client->irq) {
 		int irq = -ENOENT;
 
-		if (dev->of_node) {
+		if (client->flags & I2C_CLIENT_HOST_HOTIFY) {
+			dev_dbg(dev, "Using Host Notify IRQ\n");
+			irq = i2c_smbus_host_notify_to_irq(client);
+		} else if (dev->of_node) {
 			irq = of_irq_get_byname(dev->of_node, "irq");
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
@@ -940,14 +943,7 @@ static int i2c_device_probe(struct device *dev)
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
-		/*
-		 * ACPI and OF did not find any useful IRQ, try to see
-		 * if Host Notify can be used.
-		 */
-		if (irq < 0) {
-			dev_dbg(dev, "Using Host Notify IRQ\n");
-			irq = i2c_smbus_host_notify_to_irq(client);
-		}
+
 		if (irq < 0)
 			irq = 0;
 
@@ -1716,6 +1712,9 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	info.of_node = of_node_get(node);
 	info.archdata = &dev_ad;
 
+	if (of_read_property_bool(node, "host-notify"))
+		info.flags |= I2C_CLIENT_HOST_NOTIFY;
+
 	if (of_get_property(node, "wakeup-source", NULL))
 		info.flags |= I2C_CLIENT_WAKE;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b2109c522dec..4b45ec46161f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -665,6 +665,7 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
 #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
 					/* Must equal I2C_M_TEN below */
 #define I2C_CLIENT_SLAVE	0x20	/* we are the slave */
+#define I2C_CLIENT_HOST_NOTIFY	0x40	/* We want to use I2C host notify */
 #define I2C_CLIENT_WAKE		0x80	/* for board_info; true iff can wake */
 #define I2C_CLIENT_SCCB		0x9000	/* Use Omnivision SCCB protocol */
 					/* Must match I2C_M_STOP|IGNORE_NAK */
-- 
2.11.0.390.gc69c2f50cf-goog


-- 
Dmitry
