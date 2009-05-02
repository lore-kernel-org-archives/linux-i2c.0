From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/6] i2c: Drop i2c_probe function
Date: Sat, 2 May 2009 11:41:14 +0200
Message-ID: <20090502114114.27cf131f@hyperion.delvare>
References: <20090502113856.39940f1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090502113856.39940f1e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The legacy i2c_probe() function has no users left, get rid of it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |  137 ------------------------------------------------
 include/linux/i2c.h    |    8 --
 2 files changed, 145 deletions(-)

--- linux-2.6.30-rc4.orig/drivers/i2c/i2c-core.c	2009-04-30 18:05:25.000000000 +0200
+++ linux-2.6.30-rc4/drivers/i2c/i2c-core.c	2009-04-30 18:05:54.000000000 +0200
@@ -1042,144 +1042,7 @@ EXPORT_SYMBOL(i2c_master_recv);
  * Will not work for 10-bit addresses!
  * ----------------------------------------------------
  */
-static int i2c_probe_address(struct i2c_adapter *adapter, int addr, int kind,
-			     int (*found_proc) (struct i2c_adapter *, int, int))
-{
-	int err;
-
-	/* Make sure the address is valid */
-	if (addr < 0x03 || addr > 0x77) {
-		dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
-			 addr);
-		return -EINVAL;
-	}
-
-	/* Skip if already in use */
-	if (i2c_check_addr(adapter, addr))
-		return 0;
-
-	/* Make sure there is something at this address, unless forced */
-	if (kind < 0) {
-		if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
-				   I2C_SMBUS_QUICK, NULL) < 0)
-			return 0;
-
-		/* prevent 24RF08 corruption */
-		if ((addr & ~0x0f) == 0x50)
-			i2c_smbus_xfer(adapter, addr, 0, 0, 0,
-				       I2C_SMBUS_QUICK, NULL);
-	}
-
-	/* Finally call the custom detection function */
-	err = found_proc(adapter, addr, kind);
-	/* -ENODEV can be returned if there is a chip at the given address
-	   but it isn't supported by this chip driver. We catch it here as
-	   this isn't an error. */
-	if (err == -ENODEV)
-		err = 0;
-
-	if (err)
-		dev_warn(&adapter->dev, "Client creation failed at 0x%x (%d)\n",
-			 addr, err);
-	return err;
-}
-
-int i2c_probe(struct i2c_adapter *adapter,
-	      const struct i2c_client_address_data *address_data,
-	      int (*found_proc) (struct i2c_adapter *, int, int))
-{
-	int i, err;
-	int adap_id = i2c_adapter_id(adapter);
-
-	/* Force entries are done first, and are not affected by ignore
-	   entries */
-	if (address_data->forces) {
-		const unsigned short * const *forces = address_data->forces;
-		int kind;
-
-		for (kind = 0; forces[kind]; kind++) {
-			for (i = 0; forces[kind][i] != I2C_CLIENT_END;
-			     i += 2) {
-				if (forces[kind][i] == adap_id
-				 || forces[kind][i] == ANY_I2C_BUS) {
-					dev_dbg(&adapter->dev, "found force "
-						"parameter for adapter %d, "
-						"addr 0x%02x, kind %d\n",
-						adap_id, forces[kind][i + 1],
-						kind);
-					err = i2c_probe_address(adapter,
-						forces[kind][i + 1],
-						kind, found_proc);
-					if (err)
-						return err;
-				}
-			}
-		}
-	}
-
-	/* Stop here if we can't use SMBUS_QUICK */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
-		if (address_data->probe[0] == I2C_CLIENT_END
-		 && address_data->normal_i2c[0] == I2C_CLIENT_END)
-			return 0;
-
-		dev_dbg(&adapter->dev, "SMBus Quick command not supported, "
-			"can't probe for chips\n");
-		return -EOPNOTSUPP;
-	}
-
-	/* Probe entries are done second, and are not affected by ignore
-	   entries either */
-	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {
-		if (address_data->probe[i] == adap_id
-		 || address_data->probe[i] == ANY_I2C_BUS) {
-			dev_dbg(&adapter->dev, "found probe parameter for "
-				"adapter %d, addr 0x%02x\n", adap_id,
-				address_data->probe[i + 1]);
-			err = i2c_probe_address(adapter,
-						address_data->probe[i + 1],
-						-1, found_proc);
-			if (err)
-				return err;
-		}
-	}
-
-	/* Normal entries are done last, unless shadowed by an ignore entry */
-	for (i = 0; address_data->normal_i2c[i] != I2C_CLIENT_END; i += 1) {
-		int j, ignore;
-
-		ignore = 0;
-		for (j = 0; address_data->ignore[j] != I2C_CLIENT_END;
-		     j += 2) {
-			if ((address_data->ignore[j] == adap_id ||
-			     address_data->ignore[j] == ANY_I2C_BUS)
-			 && address_data->ignore[j + 1]
-			    == address_data->normal_i2c[i]) {
-				dev_dbg(&adapter->dev, "found ignore "
-					"parameter for adapter %d, "
-					"addr 0x%02x\n", adap_id,
-					address_data->ignore[j + 1]);
-				ignore = 1;
-				break;
-			}
-		}
-		if (ignore)
-			continue;
-
-		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
-			"addr 0x%02x\n", adap_id,
-			address_data->normal_i2c[i]);
-		err = i2c_probe_address(adapter, address_data->normal_i2c[i],
-					-1, found_proc);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(i2c_probe);
 
-/* Separate detection function for new-style drivers */
 static int i2c_detect_address(struct i2c_client *temp_client, int kind,
 			      struct i2c_driver *driver)
 {
--- linux-2.6.30-rc4.orig/include/linux/i2c.h	2009-04-30 18:04:20.000000000 +0200
+++ linux-2.6.30-rc4/include/linux/i2c.h	2009-04-30 18:05:36.000000000 +0200
@@ -419,14 +419,6 @@ extern void i2c_release_client(struct i2
 extern void i2c_clients_command(struct i2c_adapter *adap,
 				unsigned int cmd, void *arg);
 
-/* Detect function. It iterates over all possible addresses itself.
- * It will only call found_proc if some client is connected at the
- * specific address (unless a 'force' matched);
- */
-extern int i2c_probe(struct i2c_adapter *adapter,
-		const struct i2c_client_address_data *address_data,
-		int (*found_proc) (struct i2c_adapter *, int, int));
-
 extern struct i2c_adapter *i2c_get_adapter(int id);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
 

-- 
Jean Delvare
