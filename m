From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] of/irq: introduce of_has_named_irqs helper
Date: Fri, 24 Jul 2015 13:16:13 -0700
Message-ID: <20150724201613.GB33241@dtor-ws>
References: <20150724182655.GA22007@dtor-ws>
 <CAL_Jsq+JGpNBwS3HF1fF4HdefRCwhniaYCm5G4_WAnio7t-1og@mail.gmail.com>
 <20150724192619.GA33241@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150724192619.GA33241@dtor-ws>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 24, 2015 at 12:26:19PM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 24, 2015 at 02:14:57PM -0500, Rob Herring wrote:
> > On Fri, Jul 24, 2015 at 1:26 PM, Dmitry Torokhov
> > <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > Sometimes drivers might wish to transition from index-based to named
> > > interrupt descriptions. To aid in decision-making when parsing device
> > > tree data let's provide a helper that will indicate the scheme that is
> > > being used.
> > 
> > Generally, IRQs are retrieved by platform_get_irq or
> > platform_get_irq_byname. Drivers should not call the of_irq_*
> > functions directly in most cases.
> 
> That would be true for platform drivers, but not all devices are
> platform devices.
> 
> > 
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >
> > > The intent is to it like this:
> > >
> > >         if (of_has_named_irqs(np) {
> > >                 /* Wake IRQ is optional */
> > >                 dev->wakeirq = of_irq_get_byname(np, "wakeup");
> > >                 if (dev->wakeirq < 0 && dev->wakeirq != -ENODATA)
> > >                         return dev->wakeirq;
> > >         }
> > 
> > of_irq_get_byname will already return an error if the property is not
> > present. Use that.
> 
> I do not like that it returns -EINVAL when property is missing, can we
> change it to return -ENODATA (so it is the same as when the property is
> defined but such name is missing)?

So here is what I had in mind.. It is based on recent patch by Vignesh
for pixcir touchscreen, but I think it should be made available to all
I2C devices. Completely untested at the moment.

---
 drivers/i2c/i2c-core.c |   43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e6d4935..3971461 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -47,6 +47,7 @@
 #include <linux/rwsem.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/acpi.h>
 #include <linux/jump_label.h>
 #include <asm/uaccess.h>
@@ -631,6 +632,7 @@ static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
+	int wakeirq = 0;
 	int status;
 
 	if (!client)
@@ -639,11 +641,13 @@ static int i2c_device_probe(struct device *dev)
 	if (!client->irq) {
 		int irq = -ENOENT;
 
-		if (dev->of_node)
-			irq = of_irq_get(dev->of_node, 0);
-		else if (ACPI_COMPANION(dev))
+		if (dev->of_node) {
+			irq = of_has_named_irqs(dev->of_node) ?
+				of_irq_get_byname(dev->of_node, "irq") :
+				of_irq_get(dev->of_node, 0);
+		} else if (ACPI_COMPANION(dev)) {
 			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
-
+		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
 		if (irq < 0)
@@ -652,6 +656,15 @@ static int i2c_device_probe(struct device *dev)
 		client->irq = irq;
 	}
 
+	if (dev->of_node && of_has_named_irqs(dev->of_node)) {
+		wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+		if (wakeirq < 0) {
+			if (wakeirq != -ENODATA)
+				return wakeirq;
+			wakeirq = 0;
+		}
+	}
+
 	driver = to_i2c_driver(dev->driver);
 	if (!driver->probe || !driver->id_table)
 		return -ENODEV;
@@ -659,20 +672,34 @@ static int i2c_device_probe(struct device *dev)
 	if (!device_can_wakeup(&client->dev))
 		device_init_wakeup(&client->dev,
 					client->flags & I2C_CLIENT_WAKE);
+
+	status = wakeirq > 0 ?
+			dev_pm_set_dedicated_wake_irq(dev, wakeirq) :
+			(client->irq > 0 ?
+				dev_pm_set_wake_irq(dev, client->irq) : 0);
+	if (status)
+		dev_warn(&client->dev, "failed to set up wakeup irq");
+
 	dev_dbg(dev, "probe\n");
 
 	status = of_clk_set_defaults(dev->of_node, false);
 	if (status < 0)
-		return status;
+		goto err_clear_wakeup_irq;
 
 	status = dev_pm_domain_attach(&client->dev, true);
 	if (status != -EPROBE_DEFER) {
 		status = driver->probe(client, i2c_match_id(driver->id_table,
 					client));
 		if (status)
-			dev_pm_domain_detach(&client->dev, true);
+			goto err_detach_pm_domain;
 	}
 
+	return 0;
+
+err_detach_pm_domain:
+	dev_pm_domain_detach(&client->dev, true);
+err_clear_wakeup_irq:
+	dev_pm_clear_wake_irq(&client->dev);
 	return status;
 }
 
@@ -692,6 +719,10 @@ static int i2c_device_remove(struct device *dev)
 	}
 
 	dev_pm_domain_detach(&client->dev, true);
+
+	dev_pm_clear_wake_irq(&client->dev);
+	device_init_wakeup(&client->dev, 0);
+
 	return status;
 }
 

Thanks.

-- 
Dmitry
