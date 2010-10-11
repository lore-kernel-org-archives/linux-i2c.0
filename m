From: jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCH] i2c: skip address detection if provided in board_info
Date: Mon, 11 Oct 2010 16:10:35 -0700
Message-ID: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

If the address of a given device is already provided by platform init
code, e.g. from system firmware, there is no need to call the driver's
detect() function for finding the matching address from the driver's
address list.

Avoiding such detection might save boot time.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6649176..e4f7feb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1499,6 +1499,31 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 	return 0;
 }
 
+static int i2c_scan_board_info(struct i2c_adapter *adapter, struct i2c_driver *driver)
+{
+	struct i2c_devinfo	*devinfo;
+	int ret = -ENODEV;
+
+	down_read(&__i2c_board_lock);
+	list_for_each_entry(devinfo, &__i2c_board_list, list) {
+		if (!strncmp(devinfo->board_info.type, driver->driver.name,
+				I2C_NAME_SIZE)) {
+			dev_info(&adapter->dev, "found i2c board info %s\n",
+				driver->driver.name);
+			if (devinfo->board_info.addr) {
+				ret = 0;
+				goto scan_exit;
+			}
+		}
+	}
+
+scan_exit:
+	up_read(&__i2c_board_lock);
+
+	return ret;
+}
+
+
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 {
 	const unsigned short *address_list;
@@ -1506,6 +1531,13 @@ static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 	int i, err = 0;
 	int adap_id = i2c_adapter_id(adapter);
 
+	/* There is no need to detect i2c address if board info is provided */
+	if (!i2c_scan_board_info(adapter, driver)) {
+		dev_info(&adapter->dev, "Skip address detection for %s\n",
+			driver->driver.name);
+		return 0;
+	}
+
 	address_list = driver->address_list;
 	if (!driver->detect || !address_list)
 		return 0;
-- 
1.7.0.4
