From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/6] parport: add device-model to parport subsystem
Date: Wed, 20 May 2015 20:56:57 +0530
Message-ID: <1432135622-8288-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

parport subsystem starts using the device-model. Drivers using the
device-model has to define devmodel as true and should register the
device with parport using parport_register_dev_model().

Tested-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

patch:	renaming of cnt and one label, added one comment.
	instead of probe check for devmodel. Define a default probe.
       	No change in core functionality.

v5:
	a) addition/removal of ports are now handled.
	b) is_parport moved to the core level
	c) common parport_driver_register code
	d) parport_register_dev_model now accepts instance number.

v4:	use of is_parport() is introduced to check the type of device
	that has been passed to probe or match_port.

v3:	started use of parport_del_port(). previously it was creating
	some ghost parallel ports during port probing.
	parport_del_port() removes registered ports if probing has
	failed.

v2:	started using probe function. Without probe,whenever any driver
	is trying to register, it is getting bound to all the available
	parallel ports. To solve that probe was required.
	Now the driver is binding only to the device it has registered.
	And that device will appear as a subdevice of the particular
	parallel port it wants to use.

	In v1 Greg mentioned that we do not need to maintain our own
	list. That has been partially done. we are no longer maintaining
	the list of drivers. But we still need to maintain the list of
	ports and devices as that will be used by drivers which are not
	yet converted to device model. When all drivers are converted
	to use the device-model parallel port all these lists can be
	removed.

 drivers/parport/parport_pc.c |   4 +-
 drivers/parport/procfs.c     |  15 +-
 drivers/parport/share.c      | 345 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/parport.h      |  43 +++++-
 4 files changed, 379 insertions(+), 28 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 53d15b3..78530d1 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2255,7 +2255,7 @@ out5:
 		release_region(base+0x3, 5);
 	release_region(base, 3);
 out4:
-	parport_put_port(p);
+	parport_del_port(p);
 out3:
 	kfree(priv);
 out2:
@@ -2294,7 +2294,7 @@ void parport_pc_unregister_port(struct parport *p)
 				    priv->dma_handle);
 #endif
 	kfree(p->private_data);
-	parport_put_port(p);
+	parport_del_port(p);
 	kfree(ops); /* hope no-one cached it */
 }
 EXPORT_SYMBOL(parport_pc_unregister_port);
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 3b47080..c776333 100644
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
+	ret = parport_bus_init();
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
+	parport_bus_exit();
 }
 
 #else /* no sysctl or no procfs*/
@@ -596,11 +608,12 @@ int parport_device_proc_unregister(struct pardevice *device)
 
 static int __init parport_default_proc_register (void)
 {
-	return 0;
+	return parport_bus_init();
 }
 
 static void __exit parport_default_proc_unregister (void)
 {
+	parport_bus_exit();
 }
 #endif
 
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 3fa6624..99d03ed 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/kmod.h>
+#include <linux/device.h>
 
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
@@ -100,13 +101,91 @@ static struct parport_operations dead_ops = {
 	.owner		= NULL,
 };
 
+static struct device_type parport_device_type = {
+	.name = "parport",
+};
+
+static int is_parport(struct device *dev)
+{
+	return dev->type == &parport_device_type;
+}
+
+static int parport_probe(struct device *dev)
+{
+	struct parport_driver *drv;
+
+	if (is_parport(dev))
+		return -ENODEV;
+
+	drv = to_parport_driver(dev->driver);
+	if (!drv->probe) {
+		/* if driver has not defined a custom probe */
+		struct pardevice *par_dev = to_pardevice(dev);
+
+		if (strcmp(par_dev->name, drv->name))
+			return -ENODEV;
+		return 0;
+	}
+	/* if driver defined its own probe */
+	return drv->probe(to_pardevice(dev));
+}
+
+static struct bus_type parport_bus_type = {
+	.name = "parport",
+	.probe = parport_probe,
+};
+
+int parport_bus_init(void)
+{
+	return bus_register(&parport_bus_type);
+}
+
+void parport_bus_exit(void)
+{
+	bus_unregister(&parport_bus_type);
+}
+
+/*
+ * iterates through all the drivers registered with the bus and sends the port
+ * details to the match_port callback of the driver, so that the driver can
+ * know about the new port that just regsitered with the bus and decide if it
+ * wants to use this new port.
+ */
+static int driver_check(struct device_driver *dev_drv, void *_port)
+{
+	struct parport *port = _port;
+	struct parport_driver *drv = to_parport_driver(dev_drv);
+
+	if (drv->match_port)
+		drv->match_port(port);
+	return 0;
+}
+
 /* Call attach(port) for each registered driver. */
 static void attach_driver_chain(struct parport *port)
 {
 	/* caller has exclusive registration_lock */
 	struct parport_driver *drv;
+
 	list_for_each_entry(drv, &drivers, list)
 		drv->attach(port);
+
+	/*
+	 * call the driver_check function of the drivers registered in
+	 * new device model
+	 */
+
+	bus_for_each_drv(&parport_bus_type, NULL, port, driver_check);
+}
+
+static int driver_detach(struct device_driver *_drv, void *_port)
+{
+	struct parport *port = _port;
+	struct parport_driver *drv = to_parport_driver(_drv);
+
+	if (drv->detach)
+		drv->detach(port);
+	return 0;
 }
 
 /* Call detach(port) for each registered driver. */
@@ -116,6 +195,13 @@ static void detach_driver_chain(struct parport *port)
 	/* caller has exclusive registration_lock */
 	list_for_each_entry(drv, &drivers, list)
 		drv->detach (port);
+
+	/*
+	 * call the detach function of the drivers registered in
+	 * new device model
+	 */
+
+	bus_for_each_drv(&parport_bus_type, NULL, port, driver_detach);
 }
 
 /* Ask kmod for some lowlevel drivers. */
@@ -126,17 +212,39 @@ static void get_lowlevel_driver (void)
 	request_module ("parport_lowlevel");
 }
 
+/*
+ * iterates through all the devices connected to the bus and sends the device
+ * details to the match_port callback of the driver, so that the driver can
+ * know what are all the ports that are connected to the bus and choose the
+ * port to which it wants to register its device.
+ */
+static int port_check(struct device *dev, void *dev_drv)
+{
+	struct parport_driver *drv = dev_drv;
+
+	/* only send ports, do not send other devices connected to bus */
+	if (is_parport(dev))
+		drv->match_port(to_parport_dev(dev));
+	return 0;
+}
+
 /**
  *	parport_register_driver - register a parallel port device driver
  *	@drv: structure describing the driver
+ *	@owner: owner module of drv
+ *	@mod_name: module name string
  *
  *	This can be called by a parallel port device driver in order
  *	to receive notifications about ports being found in the
  *	system, as well as ports no longer available.
  *
+ *	If devmodel is true then the new device model is used
+ *	for registration.
+ *
  *	The @drv structure is allocated by the caller and must not be
  *	deallocated until after calling parport_unregister_driver().
  *
+ *	If using the non device model:
  *	The driver's attach() function may block.  The port that
  *	attach() is given will be valid for the duration of the
  *	callback, but if the driver wants to take a copy of the
@@ -148,21 +256,57 @@ static void get_lowlevel_driver (void)
  *	callback, but if the driver wants to take a copy of the
  *	pointer it must call parport_get_port() to do so.
  *
- *	Returns 0 on success.  Currently it always succeeds.
+ *
+ *	Returns 0 on success. The non device model will always succeeds.
+ *	but the new device model can fail and will return the error code.
  **/
 
-int parport_register_driver (struct parport_driver *drv)
+int __parport_register_driver(struct parport_driver *drv, struct module *owner,
+			      const char *mod_name)
 {
-	struct parport *port;
-
 	if (list_empty(&portlist))
 		get_lowlevel_driver ();
 
-	mutex_lock(&registration_lock);
-	list_for_each_entry(port, &portlist, list)
-		drv->attach(port);
-	list_add(&drv->list, &drivers);
-	mutex_unlock(&registration_lock);
+	if (drv->devmodel) {
+		/* using device model */
+		int ret;
+
+		/* initialize common driver fields */
+		drv->driver.name = drv->name;
+		drv->driver.bus = &parport_bus_type;
+		drv->driver.owner = owner;
+		drv->driver.mod_name = mod_name;
+		ret = driver_register(&drv->driver);
+		if (ret)
+			return ret;
+
+		mutex_lock(&registration_lock);
+		if (drv->match_port)
+			bus_for_each_dev(&parport_bus_type, NULL, drv,
+					 port_check);
+		mutex_unlock(&registration_lock);
+	} else {
+		struct parport *port;
+
+		drv->devmodel = false;
+
+		mutex_lock(&registration_lock);
+		list_for_each_entry(port, &portlist, list)
+			drv->attach(port);
+		list_add(&drv->list, &drivers);
+		mutex_unlock(&registration_lock);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__parport_register_driver);
+
+static int port_detach(struct device *dev, void *_drv)
+{
+	struct parport_driver *drv = _drv;
+
+	if (is_parport(dev) && drv->detach)
+		drv->detach(to_parport_dev(dev));
 
 	return 0;
 }
@@ -189,15 +333,22 @@ void parport_unregister_driver (struct parport_driver *drv)
 	struct parport *port;
 
 	mutex_lock(&registration_lock);
-	list_del_init(&drv->list);
-	list_for_each_entry(port, &portlist, list)
-		drv->detach(port);
+	if (drv->devmodel) {
+		bus_for_each_dev(&parport_bus_type, NULL, drv, port_detach);
+		driver_unregister(&drv->driver);
+	} else {
+		list_del_init(&drv->list);
+		list_for_each_entry(port, &portlist, list)
+			drv->detach(port);
+	}
 	mutex_unlock(&registration_lock);
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
@@ -223,25 +374,29 @@ static void free_port (struct parport *port)
 
 struct parport *parport_get_port (struct parport *port)
 {
-	atomic_inc (&port->ref_count);
-	return port;
+	struct device *dev = get_device(&port->bus_dev);
+
+	return to_parport_dev(dev);
+}
+
+void parport_del_port(struct parport *port)
+{
+	device_unregister(&port->bus_dev);
 }
+EXPORT_SYMBOL(parport_del_port);
 
 /**
  *	parport_put_port - decrement a port's reference count
  *	@port: the port
  *
  *	This should be called once for each call to parport_get_port(),
- *	once the port is no longer needed.
+ *	once the port is no longer needed. When the reference count reaches
+ *	zero (port is no longer used), free_port is called.
  **/
 
 void parport_put_port (struct parport *port)
 {
-	if (atomic_dec_and_test (&port->ref_count))
-		/* Can destroy it now. */
-		free_port (port);
-
-	return;
+	put_device(&port->bus_dev);
 }
 
 /**
@@ -281,6 +436,7 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	int num;
 	int device;
 	char *name;
+	int ret;
 
 	tmp = kzalloc(sizeof(struct parport), GFP_KERNEL);
 	if (!tmp) {
@@ -333,6 +489,10 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	 */
 	sprintf(name, "parport%d", tmp->portnum = tmp->number);
 	tmp->name = name;
+	tmp->bus_dev.bus = &parport_bus_type;
+	tmp->bus_dev.release = free_port;
+	dev_set_name(&tmp->bus_dev, name);
+	tmp->bus_dev.type = &parport_device_type;
 
 	for (device = 0; device < 5; device++)
 		/* assume the worst */
@@ -340,6 +500,12 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 
 	tmp->waithead = tmp->waittail = NULL;
 
+	ret = device_register(&tmp->bus_dev);
+	if (ret) {
+		put_device(&tmp->bus_dev);
+		return NULL;
+	}
+
 	return tmp;
 }
 
@@ -575,6 +741,7 @@ parport_register_device(struct parport *port, const char *name,
 	tmp->irq_func = irq_func;
 	tmp->waiting = 0;
 	tmp->timeout = 5 * HZ;
+	tmp->devmodel = false;
 
 	/* Chain this onto the list */
 	tmp->prev = NULL;
@@ -630,6 +797,136 @@ parport_register_device(struct parport *port, const char *name,
 	return NULL;
 }
 
+static void free_pardevice(struct device *dev)
+{
+	struct pardevice *par_dev = to_pardevice(dev);
+
+	kfree(par_dev->name);
+	kfree(par_dev);
+}
+
+struct pardevice *
+parport_register_dev_model(struct parport *port, const char *name,
+			   const struct pardev_cb *par_dev_cb, int id)
+{
+	struct pardevice *par_dev;
+	int ret;
+	char *devname;
+
+	if (port->physport->flags & PARPORT_FLAG_EXCL) {
+		/* An exclusive device is registered. */
+		pr_err("%s: no more devices allowed\n", port->name);
+		return NULL;
+	}
+
+	if (par_dev_cb->flags & PARPORT_DEV_LURK) {
+		if (!par_dev_cb->preempt || !par_dev_cb->wakeup) {
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
+	par_dev = kzalloc(sizeof(*par_dev), GFP_KERNEL);
+	if (!par_dev)
+		goto err_put_port;
+
+	par_dev->state = kzalloc(sizeof(*par_dev->state), GFP_KERNEL);
+	if (!par_dev->state)
+		goto err_put_par_dev;
+
+	devname = kstrdup(name, GFP_KERNEL);
+	if (!devname)
+		goto err_free_par_dev;
+
+	par_dev->name = devname;
+	par_dev->port = port;
+	par_dev->daisy = -1;
+	par_dev->preempt = par_dev_cb->preempt;
+	par_dev->wakeup = par_dev_cb->wakeup;
+	par_dev->private = par_dev_cb->private;
+	par_dev->flags = par_dev_cb->flags;
+	par_dev->irq_func = par_dev_cb->irq_func;
+	par_dev->waiting = 0;
+	par_dev->timeout = 5 * HZ;
+
+	par_dev->dev.parent = &port->bus_dev;
+	par_dev->dev.bus = &parport_bus_type;
+	ret = dev_set_name(&par_dev->dev, "%s.%d", devname, id);
+	if (ret)
+		goto err_free_devname;
+	par_dev->dev.release = free_pardevice;
+	par_dev->devmodel = true;
+	ret = device_register(&par_dev->dev);
+	if (ret)
+		goto err_put_dev;
+
+	/* Chain this onto the list */
+	par_dev->prev = NULL;
+	/*
+	 * This function must not run from an irq handler so we don' t need
+	 * to clear irq on the local CPU. -arca
+	 */
+	spin_lock(&port->physport->pardevice_lock);
+
+	if (par_dev_cb->flags & PARPORT_DEV_EXCL) {
+		if (port->physport->devices) {
+			spin_unlock(&port->physport->pardevice_lock);
+			pr_debug("%s: cannot grant exclusive access for device %s\n",
+				 port->name, name);
+			goto err_put_dev;
+		}
+		port->flags |= PARPORT_FLAG_EXCL;
+	}
+
+	par_dev->next = port->physport->devices;
+	wmb();	/*
+		 * Make sure that tmp->next is written before it's
+		 * added to the list; see comments marked 'no locking
+		 * required'
+		 */
+	if (port->physport->devices)
+		port->physport->devices->prev = par_dev;
+	port->physport->devices = par_dev;
+	spin_unlock(&port->physport->pardevice_lock);
+
+	init_waitqueue_head(&par_dev->wait_q);
+	par_dev->timeslice = parport_default_timeslice;
+	par_dev->waitnext = NULL;
+	par_dev->waitprev = NULL;
+
+	/*
+	 * This has to be run as last thing since init_state may need other
+	 * pardevice fields. -arca
+	 */
+	port->ops->init_state(par_dev, par_dev->state);
+	port->proc_device = par_dev;
+	parport_device_proc_register(par_dev);
+
+	return par_dev;
+
+err_put_dev:
+	put_device(&par_dev->dev);
+err_free_devname:
+	kfree(devname);
+err_free_par_dev:
+	kfree(par_dev->state);
+err_put_par_dev:
+	if (!par_dev->devmodel)
+		kfree(par_dev);
+err_put_port:
+	parport_put_port(port);
+	module_put(port->ops->owner);
+
+	return NULL;
+}
+EXPORT_SYMBOL(parport_register_dev_model);
+
 /**
  *	parport_unregister_device - deregister a device on a parallel port
  *	@dev: pointer to structure representing device
@@ -691,7 +988,10 @@ void parport_unregister_device(struct pardevice *dev)
 	spin_unlock_irq(&port->waitlist_lock);
 
 	kfree(dev->state);
-	kfree(dev);
+	if (dev->devmodel)
+		device_unregister(&dev->dev);
+	else
+		kfree(dev);
 
 	module_put(port->ops->owner);
 	parport_put_port (port);
@@ -1019,7 +1319,6 @@ EXPORT_SYMBOL(parport_release);
 EXPORT_SYMBOL(parport_register_port);
 EXPORT_SYMBOL(parport_announce_port);
 EXPORT_SYMBOL(parport_remove_port);
-EXPORT_SYMBOL(parport_register_driver);
 EXPORT_SYMBOL(parport_unregister_driver);
 EXPORT_SYMBOL(parport_register_device);
 EXPORT_SYMBOL(parport_unregister_device);
diff --git a/include/linux/parport.h b/include/linux/parport.h
index c22f125..58e3c64 100644
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
@@ -156,6 +159,8 @@ struct pardevice {
 	void * sysctl_table;
 };
 
+#define to_pardevice(n) container_of(n, struct pardevice, dev)
+
 /* IEEE1284 information */
 
 /* IEEE1284 phases. These are exposed to userland through ppdev IOCTL
@@ -195,7 +200,7 @@ struct parport {
 				 * This may unfortulately be null if the
 				 * port has a legacy driver.
 				 */
-
+	struct device bus_dev;	/* to link with the bus */
 	struct parport *physport;
 				/* If this is a non-default mux
 				   parport, i.e. we're a clone of a real
@@ -245,15 +250,26 @@ struct parport {
 	struct parport *slaves[3];
 };
 
+#define to_parport_dev(n) container_of(n, struct parport, bus_dev)
+
 #define DEFAULT_SPIN_TIME 500 /* us */
 
 struct parport_driver {
 	const char *name;
 	void (*attach) (struct parport *);
 	void (*detach) (struct parport *);
+	void (*match_port)(struct parport *);
+	int (*probe)(struct pardevice *);
+	struct device_driver driver;
+	bool devmodel;
 	struct list_head list;
 };
 
+#define to_parport_driver(n) container_of(n, struct parport_driver, driver)
+
+int parport_bus_init(void);
+void parport_bus_exit(void);
+
 /* parport_register_port registers a new parallel port at the given
    address (if one does not already exist) and returns a pointer to it.
    This entails claiming the I/O region, IRQ and DMA.  NULL is returned
@@ -272,10 +288,20 @@ void parport_announce_port (struct parport *port);
 extern void parport_remove_port(struct parport *port);
 
 /* Register a new high-level driver. */
-extern int parport_register_driver (struct parport_driver *);
+
+int __must_check __parport_register_driver(struct parport_driver *,
+					   struct module *,
+					   const char *mod_name);
+/*
+ * parport_register_driver must be a macro so that KBUILD_MODNAME can
+ * be expanded
+ */
+#define parport_register_driver(driver)             \
+	__parport_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 
 /* Unregister a high-level driver. */
 extern void parport_unregister_driver (struct parport_driver *);
+void parport_unregister_driver(struct parport_driver *);
 
 /* If parport_register_driver doesn't fit your needs, perhaps
  * parport_find_xxx does. */
@@ -288,6 +314,15 @@ extern irqreturn_t parport_irq_handler(int irq, void *dev_id);
 /* Reference counting for ports. */
 extern struct parport *parport_get_port (struct parport *);
 extern void parport_put_port (struct parport *);
+void parport_del_port(struct parport *);
+
+struct pardev_cb {
+	int (*preempt)(void *);
+	void (*wakeup)(void *);
+	void *private;
+	void (*irq_func)(void *);
+	unsigned int flags;
+};
 
 /* parport_register_device declares that a device is connected to a
    port, and tells the kernel all it needs to know.
@@ -301,6 +336,10 @@ struct pardevice *parport_register_device(struct parport *port,
 			  void (*irq_func)(void *), 
 			  int flags, void *handle);
 
+struct pardevice *
+parport_register_dev_model(struct parport *port, const char *name,
+			   const struct pardev_cb *par_dev_cb, int cnt);
+
 /* parport_unregister unlinks a device from the chain. */
 extern void parport_unregister_device(struct pardevice *dev);
 
-- 
1.8.1.2
