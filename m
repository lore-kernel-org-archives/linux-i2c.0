From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Sanity checks on adapter registration
Date: Fri, 5 Nov 2010 13:42:30 +0100
Message-ID: <20101105134230.16b1fb0b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make sure I2C adapters being registered have the required struct
fields set. If they don't, problems will happen later.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Randy, please apply this patch and check if it catches anything.

 drivers/i2c/i2c-core.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- linux-2.6.37-rc1.orig/drivers/i2c/i2c-core.c	2010-11-05 11:37:34.000000000 +0100
+++ linux-2.6.37-rc1/drivers/i2c/i2c-core.c	2010-11-05 11:54:34.000000000 +0100
@@ -848,6 +848,21 @@ static int i2c_register_adapter(struct i
 		goto out_list;
 	}
 
+	/* Sanity checks */
+	if (adap->name[0] == '\0') {
+		pr_err("i2c-core: Attempt to register an adapter with "
+		       "no name!\n");
+		return -EINVAL;
+	}
+	if (!adap->algo) {
+		pr_err("i2c-core: Attempt to register adapter '%s' with "
+		       "no algo!\n", adap->name);
+		return -EINVAL;
+	}
+	if (!adap->owner)
+		pr_warn("i2c-core: Attempt to register adapter '%s' with "
+		       "no owner!\n", adap->name);
+
 	rt_mutex_init(&adap->bus_lock);
 	mutex_init(&adap->userspace_clients_lock);
 	INIT_LIST_HEAD(&adap->userspace_clients);


-- 
Jean Delvare
