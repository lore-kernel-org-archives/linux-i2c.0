From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 13:18:41 +0530
Message-ID: <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dan.carpenter@oracle.com
Cc: linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

parport starts using device-model and we now have parport under
/sys/bus. As the ports are discovered they are added as device under
/sys/bus/parport. As and when other drivers register new device,
they will be registered as a subdevice under the relevant parport.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/parport/procfs.c |  15 ++-
 drivers/parport/share.c  | 236 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/parport.h  |  29 +++++-
 3 files changed, 267 insertions(+), 13 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 3b47080..1ce363b 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -21,6 +21,7 @@
 #include <linux/parport.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -558,8 +559,18 @@ int parport_device_proc_unregister(struct pardevice *device)
 
 static int __init parport_default_proc_register(void)
 {
+	int ret;
+
 	parport_default_sysctl_table.sysctl_header =
 		register_sysctl_table(parport_default_sysctl_table.dev_dir);
+	if (!parport_default_sysctl_table.sysctl_header)
+		return -ENOMEM;
+	ret = bus_register(&parport_bus_type);
+	if (ret) {
+		unregister_sysctl_table(parport_default_sysctl_table.
+					sysctl_header);
+		return ret;
+	}
 	return 0;
 }
 
@@ -570,6 +581,7 @@ static void __exit parport_default_proc_unregister(void)
 					sysctl_header);
 		parport_default_sysctl_table.sysctl_header = NULL;
 	}
+	bus_unregister(&parport_bus_type);
 }
 
 #else /* no sysctl or no procfs*/
@@ -596,11 +608,12 @@ int parport_device_proc_unregister(struct pardevice *device)
 
 static int __init parport_default_proc_register (void)
 {
-	return 0;
+	return bus_register(&parport_bus_type);
 }
 
 static void __exit parport_default_proc_unregister (void)
 {
+	bus_unregister(&parport_bus_type);
 }
 #endif
 
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 3fa6624..452b2c0 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -10,6 +10,8 @@
  * based on work by Grant Guenther <grant@torque.net>
  *          and Philip Blundell
  *
+ * Added Device-Model - Sudip Mukherjee <sudip@vectorindia.org>
+ *
  * Any part of this program may be used in documents licensed under
  * the GNU Free Documentation License, Version 1.1 or any later version
  * published by the Free Software Foundation.
@@ -29,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/kmod.h>
+#include <linux/device.h>
 
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -100,6 +103,11 @@ static struct parport_operations dead_ops = {
 	.owner		= NULL,
 };
 
+struct bus_type parport_bus_type = {
+	.name           = "parport",
+};
+EXPORT_SYMBOL(parport_bus_type);
+
 /* Call attach(port) for each registered driver. */
 static void attach_driver_chain(struct parport *port)
 {
@@ -157,6 +165,7 @@ int parport_register_driver (struct parport_driver *drv)
 
 	if (list_empty(&portlist))
 		get_lowlevel_driver ();
+	drv->devmodel = false;
 
 	mutex_lock(&registration_lock);
 	list_for_each_entry(port, &portlist, list)
@@ -167,6 +176,57 @@ int parport_register_driver (struct parport_driver *drv)
 	return 0;
 }
 
+/*
+ * __parport_register_drv - register a new parport driver
+ * @drv: the driver structure to register
+ * @owner: owner module of drv
+ * @mod_name: module name string
+ *
+ * Adds the driver structure to the list of registered drivers.
+ * Returns a negative value on error, otherwise 0.
+ * If no error occurred, the driver remains registered even if
+ * no device was claimed during registration.
+ */
+int __parport_register_drv(struct parport_driver *drv,
+			   struct module *owner, const char *mod_name)
+{
+	struct parport *port;
+	int ret, err = 0;
+	bool attached = false;
+
+	if (list_empty(&portlist))
+		get_lowlevel_driver();
+
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &parport_bus_type;
+	drv->driver.owner = owner;
+	drv->driver.mod_name = mod_name;
+	drv->devmodel = true;
+	ret = driver_register(&drv->driver);
+	if (ret)
+		return ret;
+
+	mutex_lock(&registration_lock);
+	list_for_each_entry(port, &portlist, list) {
+		ret = drv->attach_ret(port, drv);
+		if (ret == 0)
+			attached = true;
+		else
+			err = ret;
+	}
+	if (attached)
+		list_add(&drv->list, &drivers);
+	mutex_unlock(&registration_lock);
+	if (!attached) {
+		driver_unregister(&drv->driver);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__parport_register_drv);
+
 /**
  *	parport_unregister_driver - deregister a parallel port device driver
  *	@drv: structure describing the driver that was given to
@@ -193,11 +253,15 @@ void parport_unregister_driver (struct parport_driver *drv)
 	list_for_each_entry(port, &portlist, list)
 		drv->detach(port);
 	mutex_unlock(&registration_lock);
+	if (drv->devmodel)
+		driver_unregister(&drv->driver);
 }
 
-static void free_port (struct parport *port)
+static void free_port(struct device *dev)
 {
 	int d;
+	struct parport *port = to_parport_dev(dev);
+
 	spin_lock(&full_list_lock);
 	list_del(&port->full_list);
 	spin_unlock(&full_list_lock);
@@ -223,8 +287,9 @@ static void free_port (struct parport *port)
 
 struct parport *parport_get_port (struct parport *port)
 {
-	atomic_inc (&port->ref_count);
-	return port;
+	struct device *dev = get_device(&port->ddev);
+
+	return to_parport_dev(dev);
 }
 
 /**
@@ -237,11 +302,7 @@ struct parport *parport_get_port (struct parport *port)
 
 void parport_put_port (struct parport *port)
 {
-	if (atomic_dec_and_test (&port->ref_count))
-		/* Can destroy it now. */
-		free_port (port);
-
-	return;
+	put_device(&port->ddev);
 }
 
 /**
@@ -281,6 +342,7 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	int num;
 	int device;
 	char *name;
+	int ret;
 
 	tmp = kzalloc(sizeof(struct parport), GFP_KERNEL);
 	if (!tmp) {
@@ -333,6 +395,9 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	 */
 	sprintf(name, "parport%d", tmp->portnum = tmp->number);
 	tmp->name = name;
+	tmp->ddev.bus = &parport_bus_type;
+	tmp->ddev.release = free_port;
+	dev_set_name(&tmp->ddev, name);
 
 	for (device = 0; device < 5; device++)
 		/* assume the worst */
@@ -340,6 +405,13 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 
 	tmp->waithead = tmp->waittail = NULL;
 
+	ret = device_register(&tmp->ddev);
+	if (ret) {
+		list_del(&tmp->full_list);
+		kfree(tmp);
+		return NULL;
+	}
+
 	return tmp;
 }
 
@@ -575,6 +647,7 @@ parport_register_device(struct parport *port, const char *name,
 	tmp->irq_func = irq_func;
 	tmp->waiting = 0;
 	tmp->timeout = 5 * HZ;
+	tmp->devmodel = false;
 
 	/* Chain this onto the list */
 	tmp->prev = NULL;
@@ -630,6 +703,133 @@ parport_register_device(struct parport *port, const char *name,
 	return NULL;
 }
 
+void free_pardevice(struct device *dev)
+{
+}
+
+struct pardevice *
+parport_register_dev(struct parport *port, const char *name,
+		     int (*pf)(void *), void (*kf)(void *),
+		     void (*irq_func)(void *), int flags,
+		     void *handle, struct parport_driver *drv)
+{
+	struct pardevice *tmp;
+	int ret;
+	char *devname;
+
+	if (port->physport->flags & PARPORT_FLAG_EXCL) {
+		/* An exclusive device is registered. */
+		pr_debug("%s: no more devices allowed\n",
+			 port->name);
+		return NULL;
+	}
+
+	if (flags & PARPORT_DEV_LURK) {
+		if (!pf || !kf) {
+			pr_info("%s: refused to register lurking device (%s) without callbacks\n",
+				port->name, name);
+			return NULL;
+		}
+	}
+
+	if (!try_module_get(port->ops->owner))
+		return NULL;
+
+	parport_get_port(port);
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp) {
+		pr_warn("%s: memory squeeze, couldn't register %s.\n",
+			port->name, name);
+		goto out;
+	}
+
+	tmp->state = kmalloc(sizeof(*tmp->state), GFP_KERNEL);
+	if (!tmp->state) {
+		pr_warn("%s: memory squeeze, couldn't register %s.\n",
+			port->name, name);
+		goto out_free_pardevice;
+	}
+
+	tmp->name = name;
+	tmp->port = port;
+	tmp->daisy = -1;
+	tmp->preempt = pf;
+	tmp->wakeup = kf;
+	tmp->private = handle;
+	tmp->flags = flags;
+	tmp->irq_func = irq_func;
+	tmp->waiting = 0;
+	tmp->timeout = 5 * HZ;
+
+	tmp->dev.parent = &port->ddev;
+	devname = kstrdup(name, GFP_KERNEL);
+	dev_set_name(&tmp->dev, "%s", name);
+	tmp->dev.driver = &drv->driver;
+	tmp->dev.release = free_pardevice;
+	tmp->devmodel = true;
+	ret = device_register(&tmp->dev);
+	if (ret)
+		goto out_free_all;
+
+	/* Chain this onto the list */
+	tmp->prev = NULL;
+	/*
+	 * This function must not run from an irq handler so we don' t need
+	 * to clear irq on the local CPU. -arca
+	 */
+	spin_lock(&port->physport->pardevice_lock);
+
+	if (flags & PARPORT_DEV_EXCL) {
+		if (port->physport->devices) {
+			spin_unlock(&port->physport->pardevice_lock);
+			pr_debug("%s: cannot grant exclusive access for device %s\n",
+				 port->name, name);
+			goto out_free_dev;
+		}
+		port->flags |= PARPORT_FLAG_EXCL;
+	}
+
+	tmp->next = port->physport->devices;
+	wmb();	/*
+		 * Make sure that tmp->next is written before it's
+		 * added to the list; see comments marked 'no locking
+		 * required'
+		 */
+	if (port->physport->devices)
+		port->physport->devices->prev = tmp;
+	port->physport->devices = tmp;
+	spin_unlock(&port->physport->pardevice_lock);
+
+	init_waitqueue_head(&tmp->wait_q);
+	tmp->timeslice = parport_default_timeslice;
+	tmp->waitnext = NULL;
+	tmp->waitprev = NULL;
+
+	/*
+	 * This has to be run as last thing since init_state may need other
+	 * pardevice fields. -arca
+	 */
+	port->ops->init_state(tmp, tmp->state);
+	if (!test_and_set_bit(PARPORT_DEVPROC_REGISTERED, &port->devflags)) {
+		port->proc_device = tmp;
+		parport_device_proc_register(tmp);
+	}
+
+	return tmp;
+out_free_dev:
+	put_device(&tmp->dev);
+out_free_all:
+	kfree(tmp->state);
+out_free_pardevice:
+	kfree(tmp);
+out:
+	parport_put_port(port);
+	module_put(port->ops->owner);
+
+	return NULL;
+}
+
 /**
  *	parport_unregister_device - deregister a device on a parallel port
  *	@dev: pointer to structure representing device
@@ -691,7 +891,10 @@ void parport_unregister_device(struct pardevice *dev)
 	spin_unlock_irq(&port->waitlist_lock);
 
 	kfree(dev->state);
-	kfree(dev);
+	if (dev->devmodel)
+		device_unregister(&dev->dev);
+	else
+		kfree(dev);
 
 	module_put(port->ops->owner);
 	parport_put_port (port);
@@ -774,6 +977,7 @@ int parport_claim(struct pardevice *dev)
 	struct pardevice *oldcad;
 	struct parport *port = dev->port->physport;
 	unsigned long flags;
+	int ret;
 
 	if (port->cad == dev) {
 		printk(KERN_INFO "%s: %s already owner\n",
@@ -802,6 +1006,13 @@ int parport_claim(struct pardevice *dev)
 		}
 	}
 
+	if (dev->devmodel) {
+		ret = device_attach(&dev->dev);
+		if (ret != 1) {
+			return -ENODEV;
+		}
+	}
+
 	/* Can't fail from now on, so mark ourselves as no longer waiting.  */
 	if (dev->waiting & 1) {
 		dev->waiting = 0;
@@ -926,8 +1137,8 @@ int parport_claim_or_block(struct pardevice *dev)
 			       dev->port->physport->cad ?
 			       dev->port->physport->cad->name:"nobody");
 #endif
-	}
-	dev->waiting = 0;
+	} else if (r == 0)
+		dev->waiting = 0;
 	return r;
 }
 
@@ -954,6 +1165,8 @@ void parport_release(struct pardevice *dev)
 		       "when not owner\n", port->name, dev->name);
 		return;
 	}
+	if (dev->devmodel)
+		device_release_driver(&dev->dev);
 
 #ifdef CONFIG_PARPORT_1284
 	/* If this is on a mux port, deselect it. */
@@ -1022,6 +1235,7 @@ EXPORT_SYMBOL(parport_remove_port);
 EXPORT_SYMBOL(parport_register_driver);
 EXPORT_SYMBOL(parport_unregister_driver);
 EXPORT_SYMBOL(parport_register_device);
+EXPORT_SYMBOL(parport_register_dev);
 EXPORT_SYMBOL(parport_unregister_device);
 EXPORT_SYMBOL(parport_get_port);
 EXPORT_SYMBOL(parport_put_port);
diff --git a/include/linux/parport.h b/include/linux/parport.h
index c22f125..61b4e4e 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -13,6 +13,7 @@
 #include <linux/wait.h>
 #include <linux/irqreturn.h>
 #include <linux/semaphore.h>
+#include <linux/device.h>
 #include <asm/ptrace.h>
 #include <uapi/linux/parport.h>
 
@@ -145,6 +146,8 @@ struct pardevice {
 	unsigned int flags;
 	struct pardevice *next;
 	struct pardevice *prev;
+	struct device dev;
+	bool devmodel;
 	struct parport_state *state;     /* saved status over preemption */
 	wait_queue_head_t wait_q;
 	unsigned long int time;
@@ -195,7 +198,7 @@ struct parport {
 				 * This may unfortulately be null if the
 				 * port has a legacy driver.
 				 */
-
+	struct device ddev;	/* to link with the bus */
 	struct parport *physport;
 				/* If this is a non-default mux
 				   parport, i.e. we're a clone of a real
@@ -245,15 +248,22 @@ struct parport {
 	struct parport *slaves[3];
 };
 
+#define to_parport_dev(n) container_of(n, struct parport, ddev)
+
 #define DEFAULT_SPIN_TIME 500 /* us */
 
 struct parport_driver {
 	const char *name;
 	void (*attach) (struct parport *);
 	void (*detach) (struct parport *);
+	int (*attach_ret)(struct parport *, struct parport_driver *);
+	struct device_driver driver;
+	bool devmodel;
 	struct list_head list;
 };
 
+extern struct bus_type parport_bus_type;
+
 /* parport_register_port registers a new parallel port at the given
    address (if one does not already exist) and returns a pointer to it.
    This entails claiming the I/O region, IRQ and DMA.  NULL is returned
@@ -274,8 +284,19 @@ extern void parport_remove_port(struct parport *port);
 /* Register a new high-level driver. */
 extern int parport_register_driver (struct parport_driver *);
 
+int __must_check __parport_register_drv(struct parport_driver *,
+					struct module *,
+					const char *mod_name);
+/*
+ * parport_register_drv must be a macro so that KBUILD_MODNAME can
+ * be expanded
+ */
+#define parport_register_drv(driver)             \
+	__parport_register_drv(driver, THIS_MODULE, KBUILD_MODNAME)
+
 /* Unregister a high-level driver. */
 extern void parport_unregister_driver (struct parport_driver *);
+void parport_unregister_driver(struct parport_driver *);
 
 /* If parport_register_driver doesn't fit your needs, perhaps
  * parport_find_xxx does. */
@@ -301,6 +322,12 @@ struct pardevice *parport_register_device(struct parport *port,
 			  void (*irq_func)(void *), 
 			  int flags, void *handle);
 
+struct pardevice *
+parport_register_dev(struct parport *port, const char *name,
+		     int (*pf)(void *), void (*kf)(void *),
+		     void (*irq_func)(void *), int flags,
+		     void *handle, struct parport_driver *drv);
+
 /* parport_unregister unlinks a device from the chain. */
 extern void parport_unregister_device(struct pardevice *dev);
 
-- 
1.8.1.2
