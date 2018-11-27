From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 02/13] platform/x86: intel_cht_int33fe: Accept errors of i2c_acpi_new_device()
Date: Tue, 27 Nov 2018 17:37:17 +0200
Message-ID: <20181127153728.47866-3-andriy.shevchenko@linux.intel.com>
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

In the future i2c_acpi_new_device() will return error pointer in some cases.
Prepare intel_cht_int33fe driver to support that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 431151d4e611..3ba139d3bd03 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -169,7 +169,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		board_info.properties = max17047_props;
 		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
 		if (!data->max17047)
-			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+		else if (IS_ERR(data->max17047))
+			ret = PTR_ERR(data->max17047);
+		else
+			ret = 0;
+		if (ret)
+			return ret;
 	}
 
 	data->connections[0].endpoint[0] = "port0";
@@ -195,6 +201,12 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
 	if (!data->fusb302)
+		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	else if (IS_ERR(data->fusb302))
+		ret = PTR_ERR(data->fusb302);
+	else
+		ret = 0;
+	if (ret)
 		goto out_unregister_max17047;
 
 	memset(&board_info, 0, sizeof(board_info));
@@ -203,6 +215,12 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
 	if (!data->pi3usb30532)
+		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	else if (IS_ERR(data->pi3usb30532))
+		ret = PTR_ERR(data->pi3usb30532);
+	else
+		ret = 0;
+	if (ret)
 		goto out_unregister_fusb302;
 
 	platform_set_drvdata(pdev, data);
@@ -217,7 +235,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	device_connections_remove(data->connections);
 
-	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	return ret;
 }
 
 static int cht_int33fe_remove(struct platform_device *pdev)
-- 
2.19.2
