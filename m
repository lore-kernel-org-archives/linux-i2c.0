From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH v2 3/4] mfd: menf21bmc: Add additional sysfs entries for BMC
 status information
Date: Mon, 11 Jan 2016 13:21:50 +0100
Message-ID: <278283b66344e1ca556761abbcb87a20ecb21436.1452514293.git.andreas.werner@men.de>
References: <cover.1452514293.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1452514293.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, sameo@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This patch adds additional sysfs entries to provide status
information to the userland.

The following informations are now provided:
        - Get operation hours counter
        - Get board slot address
        - Get powercycle counter
        - Set/get Hw Variant

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 drivers/mfd/menf21bmc.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
index b11bd6b..dd068c0 100644
--- a/drivers/mfd/menf21bmc.c
+++ b/drivers/mfd/menf21bmc.c
@@ -20,6 +20,10 @@
 #define BMC_CMD_REV_MAJOR	0x80
 #define BMC_CMD_REV_MINOR	0x81
 #define BMC_CMD_REV_MAIN	0x82
+#define BMC_CMD_SLOT_ADDRESS	0x8c
+#define BMC_CMD_HW_VARIANT	0x8f
+#define BMC_CMD_PWRCYCL_CNT	0x93
+#define BMC_CMD_OP_HRS_CNT	0x94
 
 static struct mfd_cell menf21bmc_cell[] = {
 	{ .name = "menf21bmc_wdt", },
@@ -66,11 +70,100 @@ static ssize_t menf21bmc_mode_store(struct device *dev,
 	return size;
 }
 
+static ssize_t menf21bmc_hw_variant_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val;
+
+	val = i2c_smbus_read_word_data(client, BMC_CMD_HW_VARIANT);
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "0x%04x\n", val);
+
+}
+
+static ssize_t menf21bmc_hw_variant_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long hw_variant;
+	int ret;
+
+	if (kstrtoul(buf, 0, &hw_variant))
+		return -EINVAL;
+
+	if (hw_variant < 0 || hw_variant > 0xffff)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_word_data(client, BMC_CMD_HW_VARIANT,
+					hw_variant);
+	if (ret < 0)
+		return ret;
+
+	return size;
+
+}
+
+static ssize_t menf21bmc_pwrcycl_cnt_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val;
+
+	val = i2c_smbus_read_word_data(client, BMC_CMD_PWRCYCL_CNT);
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t menf21bmc_op_hrs_cnt_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val;
+
+	val = i2c_smbus_read_word_data(client, BMC_CMD_OP_HRS_CNT);
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t menf21bmc_slot_address_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val;
+
+	val = i2c_smbus_read_byte_data(client, BMC_CMD_SLOT_ADDRESS);
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "%d\n", val);
+}
+
 static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, menf21bmc_mode_show,
 		   menf21bmc_mode_store);
+static DEVICE_ATTR(hw_variant, S_IRUGO | S_IWUSR, menf21bmc_hw_variant_show,
+		   menf21bmc_hw_variant_store);
+static DEVICE_ATTR(pwrcycl_cnt, S_IRUGO, menf21bmc_pwrcycl_cnt_show, NULL);
+static DEVICE_ATTR(op_hrs_cnt, S_IRUGO, menf21bmc_op_hrs_cnt_show, NULL);
+static DEVICE_ATTR(slot_address, S_IRUGO, menf21bmc_slot_address_show, NULL);
 
 static struct attribute *menf21bmc_attributes[] = {
 	&dev_attr_mode.attr,
+	&dev_attr_hw_variant.attr,
+	&dev_attr_pwrcycl_cnt.attr,
+	&dev_attr_op_hrs_cnt.attr,
+	&dev_attr_slot_address.attr,
 	NULL
 };
 
-- 
2.6.2
