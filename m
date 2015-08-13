From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [RFC PATCH 1/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Thu, 13 Aug 2015 16:59:18 -0700
Message-ID: <1439510358-16664-2-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Set an ACPI companion for I2C mux channels enumerated through ACPI and
ensure they are scanned for devices.

Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
---
 drivers/i2c/i2c-core.c | 10 ++++++++++
 drivers/i2c/i2c-mux.c  |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d1..23cc8e9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -171,8 +171,18 @@ static void acpi_i2c_register_devices(struct i2c_adapter *adap)
 	if (!adap->dev.parent)
 		return;
 
+	/*
+	 * Determine where to start walking the ACPI namespace.  The common
+	 * case is to start at the adapter's parent device.  However, in
+	 * the case of a "virtual" I2C adapter created to represent a mux
+	 * channel the parent dev (pointing to the mux device) does not
+	 * have an ACPI handle.  Walk starting at the adapter instead.
+	 */
 	handle = ACPI_HANDLE(adap->dev.parent);
 	if (!handle)
+		handle = ACPI_HANDLE(&adap->dev);
+
+	if (!handle)
 		return;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 2ba7c0f..2731b99 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 
 /* multiplexer per channel data */
 struct i2c_mux_priv {
@@ -173,6 +174,13 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 		}
 	}
 
+	/*
+	 * Now try to populate the mux adapter's ACPI node.
+	 */
+	if (has_acpi_companion(mux_dev))
+		acpi_preset_companion(&priv->adap.dev, ACPI_COMPANION(mux_dev),
+				      chan_id);
+
 	if (force_nr) {
 		priv->adap.nr = force_nr;
 		ret = i2c_add_numbered_adapter(&priv->adap);
-- 
2.1.4
