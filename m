From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] i2c-scmi: remove some bogus NULL checks
Date: Sat, 19 Oct 2013 11:46:22 +0300
Message-ID: <20131019084622.GA9312@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jiang Liu <jiang.liu@huawei.com>, Toshi Kani <toshi.kani@hp.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

"obj" can't be NULL here.

We already know that "pkg->package.elements" gives us a valid pointer
so the next pointer after that is also non-NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index c447e8d..5992355 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -223,7 +223,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		goto out;
 
 	obj = pkg->package.elements + 1;
-	if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
+	if (obj->type != ACPI_TYPE_INTEGER) {
 		ACPI_ERROR((AE_INFO, "Invalid argument type"));
 		result = -EIO;
 		goto out;
@@ -235,7 +235,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	case I2C_SMBUS_BYTE:
 	case I2C_SMBUS_BYTE_DATA:
 	case I2C_SMBUS_WORD_DATA:
-		if (obj == NULL || obj->type != ACPI_TYPE_INTEGER) {
+		if (obj->type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO, "Invalid argument type"));
 			result = -EIO;
 			goto out;
@@ -246,7 +246,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 			data->byte = obj->integer.value;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-		if (obj == NULL || obj->type != ACPI_TYPE_BUFFER) {
+		if (obj->type != ACPI_TYPE_BUFFER) {
 			ACPI_ERROR((AE_INFO, "Invalid argument type"));
 			result = -EIO;
 			goto out;
