From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv5 1/8] i2c: Add pointer dereference protection to i2c_match_id()
Date: Wed,  4 May 2016 16:14:41 +0100
Message-ID: <1462374888-22888-2-git-send-email-kieran@bingham.xyz>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, javier@osg.samsung.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com, Kieran Bingham <kieran@ksquared.org.uk>
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Here we're providing dereference protection for i2c_match_id(), which
saves us having to do it each time it's called.  We're also stripping
out the (now) needless checks in i2c_device_match().  This patch paves
the way for other, similar code trimming.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
Tested-by: Kieran Bingham <kieran@bingham.xyz>
---
 drivers/i2c/i2c-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e584d88ee337..e980c8257676 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -493,6 +493,9 @@ static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
+	if (!(id && client))
+		return NULL;
+
 	while (id->name[0]) {
 		if (strcmp(client->name, id->name) == 0)
 			return id;
@@ -506,8 +509,6 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
 
-	if (!client)
-		return 0;
 
 	/* Attempt an OF style match */
 	if (of_driver_match_device(dev, drv))
@@ -518,9 +519,10 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 		return 1;
 
 	driver = to_i2c_driver(drv);
-	/* match on an id table if there is one */
-	if (driver->id_table)
-		return i2c_match_id(driver->id_table, client) != NULL;
+
+	/* Finally an I2C match */
+	if (i2c_match_id(driver->id_table, client))
+		return 1;
 
 	return 0;
 }
-- 
2.5.0
