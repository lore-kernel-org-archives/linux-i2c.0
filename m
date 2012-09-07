From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-core: fix for dep-lock validator
Date: Fri, 7 Sep 2012 15:28:40 +0200
Message-ID: <20120907152840.4de537b3@endymion.delvare>
References: <50473FC9.6000203@gmx.de>
	<5049F005.2040300@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5049F005.2040300-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Fri, 07 Sep 2012 15:00:53 +0200, Michael Lawnick wrote:
> Am 05.09.2012 14:04, schrieb Michael Lawnick:
> > If kernel is compiled with CONFIG_PROVE_LOCKING the
> > validator raises an error when a multiplexer is removed
> > via sysfs and sub-clients are connected to it. This is a
> > false positive.
> > Documentation/lockdep-design.txt recommends to handle this
> > via calls to mutex_lock_nested()
> > 
> > Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
> > ---
> > Documentation originally recommends to use an enum.
> > This is not applicable for a tree with unlimited depth.
> > This is why I use the adapter id which is expected
> > to be unique and monotonic increasing with the depth of
> > the tree.
> > 
> > --- linux/drivers/i2c/i2c-core.c.dist	2012-09-05 09:46:50.000000000 +0200
> > +++ linux/drivers/i2c/i2c-core.c	2012-09-05 09:56:58.000000000 +0200
> > @@ -628,7 +628,7 @@ i2c_sysfs_delete_device(struct device *d
> > 
> >  	/* Make sure the device was added through sysfs */
> >  	res = -ENOENT;
> > -	mutex_lock(&adap->userspace_clients_lock);
> > +	mutex_lock_nested(&adap->userspace_clients_lock, i2c_adapter_id(adap));
> >  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
> >  				 detected) {
> >  		if (client->addr == addr) {
> > @@ -936,7 +936,7 @@ int i2c_del_adapter(struct i2c_adapter *
> >  		return res;
> > 
> >  	/* Remove devices instantiated from sysfs */
> > -	mutex_lock(&adap->userspace_clients_lock);
> > +	mutex_lock_nested(&adap->userspace_clients_lock, i2c_adapter_id(adap));
> >  	list_for_each_entry_safe(client, next, &adap->userspace_clients,
> >  				 detected) {
> >  		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,
> 
> This will get problems with maximum log level :-(

Yes, I noticed the problem too. Actually I have a reply for you in my
draft folder, saying exactly that.

> Please ignore, other solution is under construction.

I do have one too, based on the depth level of each adapter:

--- linux-3.6-rc4.orig/drivers/i2c/i2c-core.c	2012-09-06 17:24:17.449441802 +0200
+++ linux-3.6-rc4/drivers/i2c/i2c-core.c	2012-09-07 10:44:11.339368610 +0200
@@ -636,6 +636,16 @@ static void i2c_adapter_dev_release(stru
 	complete(&adap->dev_released);
 }
 
+static unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
+{
+	unsigned int depth = 0;
+
+	while ((adapter = i2c_parent_is_i2c_adapter(adapter)))
+		depth++;
+
+	return depth;
+}
+
 /*
  * Let users instantiate I2C devices through sysfs. This can be used when
  * platform initialization code doesn't contain the proper data for
@@ -726,7 +736,8 @@ i2c_sysfs_delete_device(struct device *d
 
 	/* Make sure the device was added through sysfs */
 	res = -ENOENT;
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock,
+			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		if (client->addr == addr) {
@@ -869,7 +880,8 @@ static int i2c_register_adapter(struct i
 	if (res)
 		goto out_list;
 
-	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
+	dev_dbg(&adap->dev, "adapter [%s] registered, depth %u\n", adap->name,
+		i2c_adapter_depth(adap));
 
 #ifdef CONFIG_I2C_COMPAT
 	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
@@ -1073,7 +1085,8 @@ int i2c_del_adapter(struct i2c_adapter *
 		return res;
 
 	/* Remove devices instantiated from sysfs */
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock,
+			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,

I was about to test it but was side-tracked by a different issue.

-- 
Jean Delvare
