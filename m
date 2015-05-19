From: Robert Dolca <robert.dolca-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RFC] i2c: Use ID table to detect ACPI I2C devices
Date: Tue, 19 May 2015 17:03:29 +0300
Message-ID: <1432044209-27858-1-git-send-email-robert.dolca@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Dolca <robert.dolca-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For i2c devices enumerated with ACPI you need to declare both
acpi_match_table and id_table. When using ACPI, the i2c_device_id structure
supplied to the probe function is null and you have to handle this case
in the driver.

The current name for the i2c client when using ACPI is "HID:UID" where the
UID has 7 or 8 characters and the UID has 2 characters. The UID is not
relevant for identifying the chip so it does not have any practical
purpose.

Modifying i2c_match_id we make the comparison by ignoring the UID from the
client name when the device was discovered using ACPI. The comparison is
case insensitive because the ACPI names are uppercase and the DT and ID
table names are lowercase. It would not make sense to have two different
chips with the same name and the only diference being the capitalized
letters.

With these changes the probe function gets a valid i2c_device_id and the
driver doesn't have to declare acpi_match_table.

Signed-off-by: Robert Dolca <robert.dolca-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fec0e0d..c9b30b7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -447,8 +447,18 @@ static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
+	char name[I2C_NAME_SIZE], *c;
+
+	strlcpy(name, client->name, sizeof(name));
+
+	if (ACPI_HANDLE(&client->dev)) {
+		c = strchr(name, ':');
+		if (c)
+			*c = 0;
+	}
+
 	while (id->name[0]) {
-		if (strcmp(client->name, id->name) == 0)
+		if (strncasecmp(name, id->name, sizeof(id->name)) == 0)
 			return id;
 		id++;
 	}
-- 
1.9.1
