From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 18:39:28 +0100
Message-ID: <20170104173928.GW5767@mail.corp.redhat.com>
References: <20170104081804.GA3499@pali>
 <20170104090522.GN5767@mail.corp.redhat.com>
 <20170104091845.GB3499@pali>
 <20170104101306.GR5767@mail.corp.redhat.com>
 <20170104102118.GD3499@pali>
 <20170104103233.GT5767@mail.corp.redhat.com>
 <20170104112223.GE3499@pali>
 <20170104120031.GG3499@pali>
 <20170104130252.GV5767@mail.corp.redhat.com>
 <20170104160643.GH3499@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104160643.GH3499@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Jan 04 2017 or thereabouts, Pali Rohár wrote:
> On Wednesday 04 January 2017 14:02:52 Benjamin Tissoires wrote:
> > > > > No. DT platforms won't have an issue: they don't change anything, and
> > > > > there will be a new /dev/freefall misc device for the platforms that
> > > > 
> > > > And this is wrong! There should not be any /dev/freefall device
> > > > connected with signal host notify. /dev/freefall is for hardware which
> > > > supports free fall hdd detection.
> > 
> > On the principle, I agree. But let's be realistic: this device will be
> > created but no events will be generated from it.
> 
> And I think this is a problem. This provides false information to kernel
> and also to userspace applications that there is working free fall
> sensor (even there is not).
> 
> > It's a capability for the chip to provide freefall,
> 
> That it is not truth. Not every chip has it. Platform data are there to
> provides this information for driver, if HW has freefall capability or
> not.
> 
> > so I don't see why it's such an issue to
> > have one created which says nothing. (talking about non Dell platforms
> > here too)
> > 
> > > > 
> > > > > don't have the irq set *and* if the device is on a Host Notify capable
> > > > > adapter, currently only i2c-i801.
> > > > 
> > > > I understood, but in future more bus drivers could support host notify.
> > > 
> > > This is really fragile. lis3lv02d will empty IRQ (0) will work on some
> > > i2c buses and on some not. I would really expect that i2c driver
> > > (lis3lv02d) will work in same way with any i2c bus driver. And not that
> > > on i801 will acts differently as on e.g. omap3 i2c bus.
> > 
> > I really don't follow you here. On a bus with no Host Notify, the IRQ
> > will be 0 and it will work in the same way.
> 
> That it OK.
> 
> > On a bus with Host Notify,
> > the IRQ should be set to something negative in the i2c_board_info
> 
> Not only in i2c_board_info but also in DTS. Which means every one DTS
> needs to be updates -- also those outside of linux kernel. Which is for
> me wrong.
> 
> > to be
> > sure to not have an Host Notify irq assigned. In both case the
> > lis3lv02d_i2c driver will just do:
> > 	if (client->irq > 0)
> > 		lis3_dev.irq = client->irq;
> > 
> > So there is no bus adapter specifics in the driver.
> > 
> > > 
> > > > This is basically incorrect if we use one property for two different
> > > > things (host notify and hdd free fall).
> > 
> > Host Notify is a way for a I2C device to report an interrupt without
> > having a dedicated line assigned (and so an IRQ).
> 
> Yes. But lis3lv02d i2c devices which I have uses dedicated IRQ. They
> does not work in way like you describe.
> 
> > So the chip could use
> > Host Notify to report hdd free fall if it supports the feature.
> 
> Old existing HW could not. As those were not designed for such purpose.
> 
> Yes, new HW can be designed in this way, but linux kernel should not
> drop (or modify) correct support for old HW devices just because there
> is new HW design.

I never said we should drop support of old hardware. I was just
explaining what is Host Notify and saying that it is not incompatible
with lis3lv02d. 

> 
> > > > 
> > > > For me it looks like that we should separate these two things into two
> > > > IRQ properties. It is really wrong design if one property is used for
> > > > two different things.
> > 
> > I won't say the design is wrong because Host Notify really is just an
> > IRQ.
> 
> Yes it is IRQ, but different. And lis3lv02d does not issue host notify
> IRQ, so it should not be assigned to lis3lv02d.

Sigh.

> 
> > Where the issue lies now is that lis3lv02d makes the assumption
> > that an irq attached to an i2c_client means that it will report
> > freefall.
> 
> Yes.
> 
> > It was correct before, but now it's not true anymore.
> 
> Agree.
> 
> > So maybe this series should also add a way to provide the source of
> > the IRQ (Host Notify or ACPI or DT). Then, lis3lv02d could ignore or
> > not the incoming IRQ.
> 
> Yes, this is an option how to fix this problem.

How about:
---
>From daa7571bbf337704332c0cfeec9b8fd5aeae596f Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 4 Jan 2017 18:26:54 +0100
Subject: [PATCH] I2C: add the source of the IRQ in struct i2c_client

With commit 4d5538f5882a ("i2c: use an IRQ to report Host Notify events,
not alert"), the IRQ provided in struct i2c_client might be assigned while
it has not been explicitly declared by either the platform information
or OF or ACPI.
Some drivers (lis3lv02d) rely on the fact that the IRQ gets assigned or
not to trigger a different behavior (exposing /dev/freefall in this case).

Provide a way for others to know who set the IRQ and so they can behave
accordingly.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/i2c/i2c-core.c |  7 +++++++
 include/linux/i2c.h    | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cf9e396..226c75d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -935,8 +935,12 @@ static int i2c_device_probe(struct device *dev)
 			irq = of_irq_get_byname(dev->of_node, "irq");
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
+			if (irq > 0)
+				client->irq_source = I2C_IRQ_SOURCE_OF;
 		} else if (ACPI_COMPANION(dev)) {
 			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+			if (irq > 0)
+				client->irq_source = I2C_IRQ_SOURCE_ACPI;
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
@@ -947,6 +951,8 @@ static int i2c_device_probe(struct device *dev)
 		if (irq < 0) {
 			dev_dbg(dev, "Using Host Notify IRQ\n");
 			irq = i2c_smbus_host_notify_to_irq(client);
+			if (irq > 0)
+				client->irq_source = I2C_IRQ_SOURCE_HOST_NOTIFY;
 		}
 		if (irq < 0)
 			irq = 0;
@@ -1317,6 +1323,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->flags = info->flags;
 	client->addr = info->addr;
 	client->irq = info->irq;
+	client->irq_source = I2C_IRQ_SOURCE_PLATFORM;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b2109c5..7d0368d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -213,6 +213,13 @@ struct i2c_driver {
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
+enum i2c_irq_source {
+	I2C_IRQ_SOURCE_PLATFORM,
+	I2C_IRQ_SOURCE_OF,
+	I2C_IRQ_SOURCE_ACPI,
+	I2C_IRQ_SOURCE_HOST_NOTIFY,
+};
+
 /**
  * struct i2c_client - represent an I2C slave device
  * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
@@ -227,6 +234,9 @@ struct i2c_driver {
  *	userspace_devices list
  * @slave_cb: Callback when I2C slave mode of an adapter is used. The adapter
  *	calls it to pass on slave events to the slave driver.
+ * @irq_source: Enum which provides the source of the IRQ. Useful to know
+ * 	if the IRQ was issued from Host Notify or if it was provided by an other
+ * 	component.
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
  * i2c bus. The behaviour exposed to Linux is defined by the driver
@@ -245,6 +255,7 @@ struct i2c_client {
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
 #endif
+	enum i2c_irq_source irq_source;	/* which component assigned the irq */
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
-- 
2.9.3
---

Dmitry, Wolfram, Jean, would this be acceptable for you?

> 
> I would rather introduce new IRQ property in both DTS and lis3lv02d
> platform data (e.g. irq-freefall) which will unambiguously identify
> freefall IRQ.

Sigh. You asked above to not break existing DT bindings, so I don't
understand why you suddenly want to change every bindings by introducing
a change which breaks backward compatibility.

> 
> But I do not think it should be part of my Dell patch. It is
> independent fix for lis3lv02d driver for bug which was introduced by
> commit 4d5538f5882a.

It's not part of the dell patch, but it can be part of the series you
are about to send. Please remember that the current state is that there
is no breakage (only a spurious /dev/freefall which you are not happy
about). The only breakage is with your patch, so it doesn't hurt to have
both sent together so you can control all the requirements at once.
So please incorporate my patch in your series if Wolfram, Jean and Dmitry
agree, and also add the fix in lis3lv02d_i2c to make use of the IRQ source.

Cheers,
Benjamin

> 
> > 
> > Cheers,
> > Benjamin
> > 
> > > > 
> > > > > But given that they are DT and not
> > > > > ACPI, this won't conflict with dell-smo8800, so there won't be any
> > > > > errors, just a dangling unused device node.
> > > > 
> > > > Yes, for upcoming Dell in this patch (with IRQ -1) it is not a problem.
> > > > 
> > > > > This approach is IMO the best if you want to have this in the kernel.
> > > > > 
> > > > > Cheers,
> > > > > Benjamin
> > > > 
> > > 
> > > -- 
> > > Pali Rohár
> > > pali.rohar@gmail.com
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
