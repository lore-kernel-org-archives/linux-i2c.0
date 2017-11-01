From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: [PATCH] i2c: use macro IS_ENABLED in header i2c.h
Date: Wed,  1 Nov 2017 21:06:41 +0100
Message-ID: <20171101200641.11323-1-contact@stefanchrist.eu>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from stcim.de ([78.46.90.227]:58360 "EHLO stcim.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755173AbdKAUph (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 16:45:37 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, wsa@the-dreams.de

From: Stefan Lengfeld <slengfeld@inovex.de>

Using the macro IS_ENABLED to check the option CONFIG_I2C=(y|m) makes
the code nicer.  No functional change.

Signed-off-by: Stefan Lengfeld <contact@stefanchrist.eu>
---
 include/linux/i2c.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index d501d3956f13..9245a269d160 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -55,7 +55,7 @@ typedef int (*i2c_slave_cb_t)(struct i2c_client *, enum i2c_slave_event, u8 *);
 struct module;
 struct property_entry;
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 /*
  * The master routines are the ones normally used to transmit data to devices
  * on a bus (or read from them). Apart from two basic transfer functions to
@@ -352,7 +352,7 @@ struct i2c_board_info {
 	.type = dev_type, .addr = (dev_addr)
 
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 /* Add-on boards should register/unregister their devices; e.g. a board
  * with integrated I2C, a config eeprom, sensors, and a codec that's
  * used in conjunction with the primary hardware.
@@ -704,7 +704,7 @@ i2c_unlock_adapter(struct i2c_adapter *adapter)
 
 /* administration...
  */
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+#if IS_ENABLED(CONFIG_I2C)
 extern int i2c_add_adapter(struct i2c_adapter *);
 extern void i2c_del_adapter(struct i2c_adapter *);
 extern int i2c_add_numbered_adapter(struct i2c_adapter *);
-- 
2.13.5
