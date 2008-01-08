From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 15:18:17 +0100
Message-ID: <20080108151817.35e05c6c@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712291905.15160.david-b@pacbell.net>
	<20080106122356.78556b8a@hyperion.delvare>
	<200801061130.31774.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801061130.31774.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sun, 6 Jan 2008 11:30:31 -0800, David Brownell wrote:
> On Sunday 06 January 2008, Jean Delvare wrote:
> > > +static struct i2c_client *verify_client(struct device *dev)
> > > +{
> > > +	if (dev->bus != &i2c_bus_type)
> > 
> > Is this paranoia, or can this test really succeed? I thought that all
> > children of an i2c adapter node would always be i2c clients.
> 
> Let's call it well-founded paranoia.  I know that when the SPI
> code got a "remove class_device" patch, I had to fix an oops
> caused by an unexpected child ... and at the top of my current
> GIT snapshot is 911833440b498e3e4fe2f12c1ae2bd44400c7004 which
> fixed similar oopsing in SCSI.

OK, fine with me.

> > > --- a/drivers/i2c/i2c-dev.c
> > > +++ b/drivers/i2c/i2c-dev.c
> > > 		...
> > > -	}
> > > -	mutex_unlock(&adapter->clist_lock);
> > > +	if (!dev->bus || strcmp("i2c", dev->bus->name) != 0)
> > 
> > Please just export i2c_bus_type is you need it, or even verify_client
> > (then renamed to i2c_verify_client)? If the bus type check is really
> > needed then we'll need it for the 3 v4l drivers I mentioned earlier
> > anyway.
> 
> Good point.  I didn't like this part much, and that function can
> have other uses.  I updated kobj_to_i2c_client() to use it too.

I wouldn't change kobj_to_i2c_client(). Drivers using it already know
that their kobj is an i2c_client, so there's no need to check for that,
and the use cases I've seen are in runtime paths that should be fast, I
don't want to slow them down without a good reason.

> > Alternatively we could write and export an i2c_for_each_client()
> > function doing all the required checks so that drivers don't have to
> > care. What do you think?
> 
> Less good.  We can't know in advance which things they care about.

device_for_each_child() doesn't know either, and lets the caller pass
an arbitrary pointer as a parameter to the callbask function. My idea
was to do something similar, so i2c_for_each_client() would essentially
be a wrapper for device_for_each_child().

Here's what I have:

---
 drivers/i2c/i2c-core.c        |   28 ++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c         |   10 ++++------
 drivers/media/video/dpc7146.c |    8 ++------
 drivers/media/video/mxb.c     |    8 ++------
 drivers/media/video/tvmixer.c |    9 +++------
 include/linux/i2c.h           |    3 +++
 6 files changed, 42 insertions(+), 24 deletions(-)

--- linux-2.6.24-rc7.orig/drivers/i2c/i2c-core.c	2008-01-08 14:19:39.000000000 +0100
+++ linux-2.6.24-rc7/drivers/i2c/i2c-core.c	2008-01-08 15:09:38.000000000 +0100
@@ -215,6 +215,34 @@ struct i2c_client *i2c_verify_client(str
 }
 EXPORT_SYMBOL(i2c_verify_client);
 
+struct i2c_for_each_client_data {
+	void *data;
+	int (*fn)(struct i2c_client *, void *);
+};
+
+static int __i2c_for_each_client(struct device *dev, void *d)
+{
+	struct i2c_for_each_client_data *_data = d;
+	struct i2c_client *client = i2c_verify_client(dev);
+
+	if (!client)
+		return 0;
+
+	return _data->fn(client, _data->data);
+}
+
+int i2c_for_each_client(struct i2c_adapter *adapter, void *data,
+			int (*fn)(struct i2c_client *, void *))
+{
+	struct i2c_for_each_client_data _data;
+
+	_data.data = data;
+	_data.fn = fn;
+
+	return device_for_each_child(&adapter->dev, &_data,
+				     __i2c_for_each_client);
+}
+EXPORT_SYMBOL(i2c_for_each_client);
 
 /**
  * i2c_new_device - instantiate an i2c device for use with a new style driver
--- linux-2.6.24-rc7.orig/include/linux/i2c.h	2008-01-08 14:19:15.000000000 +0100
+++ linux-2.6.24-rc7/include/linux/i2c.h	2008-01-08 15:09:34.000000000 +0100
@@ -181,6 +181,9 @@ struct i2c_client {
 
 extern struct i2c_client *i2c_verify_client(struct device *dev);
 
+extern int i2c_for_each_client(struct i2c_adapter *adapter, void *data,
+			       int (*fn)(struct i2c_client *, void *));
+
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
 	return i2c_verify_client(container_of(kobj, struct device, kobj));
--- linux-2.6.24-rc7.orig/drivers/media/video/dpc7146.c	2008-01-08 14:37:41.000000000 +0100
+++ linux-2.6.24-rc7/drivers/media/video/dpc7146.c	2008-01-08 14:59:28.000000000 +0100
@@ -87,13 +87,9 @@ struct dpc
 	int cur_input;	/* current input */
 };
 
-static int dpc_check_clients(struct device *dev, void *data)
+static int dpc_check_clients(struct i2c_client *client, void *data)
 {
 	struct dpc* dpc = data;
-	struct i2c_client *client = i2c_verify_client(dev);
-
-	if( !client )
-		return 0;
 
 	if( I2C_SAA7111A == client->addr )
 		dpc->saa7111a = client;
@@ -128,7 +124,7 @@ static int dpc_probe(struct saa7146_dev*
 	}
 
 	/* loop through all i2c-devices on the bus and look who is there */
-	device_for_each_child(&dpc->i2c_adapter.dev, dpc, dpc_check_clients);
+	i2c_for_each_client(&dpc->i2c_adapter, dpc, dpc_check_clients);
 
 	/* check if all devices are present */
 	if( 0 == dpc->saa7111a ) {
--- linux-2.6.24-rc7.orig/drivers/media/video/mxb.c	2008-01-08 14:37:33.000000000 +0100
+++ linux-2.6.24-rc7/drivers/media/video/mxb.c	2008-01-08 15:00:12.000000000 +0100
@@ -149,13 +149,9 @@ struct mxb
 
 static struct saa7146_extension extension;
 
-static int mxb_check_clients(struct device *dev, void *data)
+static int mxb_check_clients(struct i2c_client *client, void *data)
 {
 	struct mxb* mxb = data;
-	struct i2c_client *client = i2c_verify_client(dev);
-
-	if( !client )
-		return 0;
 
 	if( I2C_ADDR_TEA6420_1 == client->addr )
 		mxb->tea6420_1 = client;
@@ -218,7 +214,7 @@ static int mxb_probe(struct saa7146_dev*
 	}
 
 	/* loop through all i2c-devices on the bus and look who is there */
-	device_for_each_child(&mxb->i2c_adapter.dev, mxb, mxb_check_clients);
+	i2c_for_each_client(&mxb->i2c_adapter, mxb, mxb_check_clients);
 
 	/* check if all devices are present */
 	if(    0 == mxb->tea6420_1	|| 0 == mxb->tea6420_2	|| 0 == mxb->tea6415c
--- linux-2.6.24-rc7.orig/drivers/media/video/tvmixer.c	2008-01-08 14:34:30.000000000 +0100
+++ linux-2.6.24-rc7/drivers/media/video/tvmixer.c	2008-01-08 15:01:27.000000000 +0100
@@ -235,18 +235,15 @@ static const struct file_operations tvmi
 
 /* ----------------------------------------------------------------------- */
 
-static int __tvmixer_adapters(struct device *dev, void *data)
+static int __tvmixer_adapters(struct i2c_client *client, void *data)
 {
-	struct i2c_client *client = i2c_verify_client(dev);
-
-	if (client)
-		tvmixer_clients(client);
+	tvmixer_clients(client);
 	return 0;
 }
 
 static int tvmixer_adapters(struct i2c_adapter *adap)
 {
-	device_for_each_child(&adap->dev, NULL, __tvmixer_adapters);
+	i2c_for_each_client(adap, NULL, __tvmixer_adapters);
 	return 0;
 }
 
--- linux-2.6.24-rc7.orig/drivers/i2c/i2c-dev.c	2008-01-08 14:19:15.000000000 +0100
+++ linux-2.6.24-rc7/drivers/i2c/i2c-dev.c	2008-01-08 15:05:25.000000000 +0100
@@ -182,14 +182,12 @@ static ssize_t i2cdev_write (struct file
 	return ret;
 }
 
-static int i2cdev_check(struct device *dev, void *addrp)
+static int i2cdev_check(struct i2c_client *client, void *addrp)
 {
-	struct i2c_client *client = i2c_verify_client(dev);
-
-	if (!client || client->addr != *(unsigned int *)addrp)
+	if (client->addr != *(unsigned int *)addrp)
 		return 0;
 
-	return dev->driver ? -EBUSY : 0;
+	return client->dev.driver ? -EBUSY : 0;
 }
 
 /* This address checking function differs from the one in i2c-core
@@ -197,7 +195,7 @@ static int i2cdev_check(struct device *d
    driver to it, as NOT busy. */
 static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
 {
-	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
+	return i2c_for_each_client(adapter, &addr, i2cdev_check);
 }
 
 static int i2cdev_ioctl(struct inode *inode, struct file *file,

Admittedly it will slow down things a bit as each iteration of the loop
will have one additional level of indirection. This makes the calling
code somewhat simpler though. Whether it is worth the additional
runtime cost, I just don't know. What do you think?

> Though I was a bit worried it might have bugs in it, since all I had
> time to do was code it, and sanity check it with a couple variants of
> one new-style config.  (I no longer have those monster "build all I2C
> drivers" configs around.)

I'll give it good testing, don't worry too much about that.

-- 
Jean Delvare
