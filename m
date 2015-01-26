From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: I2C slave support
Date: Mon, 26 Jan 2015 17:17:45 +0100
Message-ID: <20150126171745.3d6d0fec@endymion.delvare>
References: <20150124210825.521bf923@endymion.delvare>
	<20150126113329.GB1052@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150126113329.GB1052@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 26 Jan 2015 12:33:29 +0100, Wolfram Sang wrote:
> > I find it confusing that I2C slave support is included even when
> > CONFIG_I2C_SLAVE is not set. I don't know if this was discussed before?
> 
> I was thinking about it but was undecided between "size of code added
> unconditionally" and "ugly #ifdeffing the code".
> 
> > I am considering adding ifdefs around the code to only include it when
> > CONFIG_I2C_SLAVE is set. Alternatively the code could be moved to a
> > separate module altogether. What do you think?
> 
> Own module: Again, undecided. On the one hand it makes for a nice
> encapsulation, on the other hand there is overhead for having another
> module. I am very happy that the core code for slave support is so slim.

I gave a try to the separate module approach and I have to agree that
it seems overkill given the small amount of code.

> Mabye #ifdef is a good start. I could do it as well, I don't mind.

Something like this?

From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: i2c: Only include slave support if selected

Make the slave support depend on CONFIG_I2C_SLAVE. Otherwise it gets
included unconditionally, even when it is not needed.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 ++
 include/linux/i2c.h    |    4 ++++
 2 files changed, 6 insertions(+)

--- linux-3.19-rc6.orig/drivers/i2c/i2c-core.c	2015-01-26 12:47:26.467671896 +0100
+++ linux-3.19-rc6/drivers/i2c/i2c-core.c	2015-01-26 12:50:23.541420438 +0100
@@ -2962,6 +2962,7 @@ trace:
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 {drivers/i2c/i2c-smbus.c
 	int ret;
@@ -3009,6 +3010,7 @@ int i2c_slave_unregister(struct i2c_clie
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+#endif
 
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus main module");
--- linux-3.19-rc6.orig/include/linux/i2c.h	2015-01-26 12:47:26.470671959 +0100
+++ linux-3.19-rc6/include/linux/i2c.h	2015-01-26 12:52:00.027462551 +0100
@@ -222,7 +222,9 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
+#endif
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -247,6 +249,7 @@ static inline void i2c_set_clientdata(st
 
 /* I2C slave support */
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 enum i2c_slave_event {
 	I2C_SLAVE_REQ_READ_START,
 	I2C_SLAVE_REQ_READ_END,
@@ -263,6 +266,7 @@ static inline int i2c_slave_event(struct
 {
 	return client->slave_cb(client, event, val);
 }
+#endif
 
 /**
  * struct i2c_board_info - template for device creation


-- 
Jean Delvare
SUSE L3 Support
