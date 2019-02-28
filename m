From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH v4 2/3] i2c: mux: pca9541: remove support for unused platform data
Date: Thu, 28 Feb 2019 11:43:42 +0000
Message-ID: <20190228114343.36443-3-robertshearman@gmail.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228114343.36443-1-robertshearman@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Shearman <robert.shearman@att.com>
List-Id: linux-i2c@vger.kernel.org

From: Robert Shearman <robert.shearman@att.com>

There are no in-tree users of the platform data, so remove it to
simplify the code slightly.

Remove the now unused pca954x.h platform data header.

Signed-off-by: Robert Shearman <robert.shearman@att.com>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c   |  8 +----
 include/linux/platform_data/pca954x.h | 48 ---------------------------
 2 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 include/linux/platform_data/pca954x.h

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 9e75d6b9140b..50e1fb4aedf5 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -22,7 +22,6 @@
 #include <linux/i2c-mux.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
 
 /*
@@ -287,10 +286,8 @@ static int pca9541_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adap = client->adapter;
-	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
-	int force;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -306,9 +303,6 @@ static int pca9541_probe(struct i2c_client *client,
 
 	/* Create mux adapter */
 
-	force = 0;
-	if (pdata)
-		force = pdata->modes[0].adap_id;
 	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
 			     I2C_MUX_ARBITRATOR,
 			     pca9541_select_chan, pca9541_release_chan);
@@ -320,7 +314,7 @@ static int pca9541_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, muxc);
 
-	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
+	ret = i2c_mux_add_adapter(muxc, 0, 0, 0);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/platform_data/pca954x.h b/include/linux/platform_data/pca954x.h
deleted file mode 100644
index 1712677d5904..000000000000
--- a/include/linux/platform_data/pca954x.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *
- * pca954x.h - I2C multiplexer/switch support
- *
- * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
- * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
- * Michael Lawnick <michael.lawnick.ext@nsn.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-
-#ifndef _LINUX_I2C_PCA954X_H
-#define _LINUX_I2C_PCA954X_H
-
-/* Platform data for the PCA954x I2C multiplexers */
-
-/* Per channel initialisation data:
- * @adap_id: bus number for the adapter. 0 = don't care
- * @deselect_on_exit: set this entry to 1, if your H/W needs deselection
- *                    of this channel after transaction.
- *
- */
-struct pca954x_platform_mode {
-	int		adap_id;
-	unsigned int	deselect_on_exit:1;
-	unsigned int	class;
-};
-
-/* Per mux/switch data, used with i2c_register_board_info */
-struct pca954x_platform_data {
-	struct pca954x_platform_mode *modes;
-	int num_modes;
-};
-
-#endif /* _LINUX_I2C_PCA954X_H */
-- 
2.20.1
