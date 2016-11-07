From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 07/11] i2c: match dt-style device names from sysfs interface
Date: Mon,  7 Nov 2016 12:47:42 +0000
Message-ID: <1478522866-29620-8-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

A user can choose to instantiate a device on an i2c bus using the sysfs
interface by providing a string and address to match and communicate
with the device on the bus. Presently this string is only matched
against the old i2c device id style strings, even in the presence of
full device tree compatible strings with vendor prefixes.

Providing a vendor-prefixed string to the sysfs interface will not match
against the device tree of_match_device() calls as there is no device
tree node to parse from the sysfs interface.

Convert i2c_of_match_device_strip_vendor() such that it can match both
vendor prefixed and stripped compatible strings on the sysfs interface.

Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

---
Changes from v7
 - strncasecmp usage converted to sysfs_streq

 drivers/i2c/i2c-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3d377598647a..c338c8f3b3db 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1795,6 +1795,15 @@ i2c_of_match_device_sysfs(const struct of_device_id *matches,
 	const char *name;
 
 	for (; matches->compatible[0]; matches++) {
+		/*
+		 * Adding devices through the i2c sysfs interface provides us
+		 * a string to match which may be compatible with the device
+		 * tree compatible strings, however with no actual of_node the
+		 * of_match_device() will not match
+		 */
+		if (sysfs_streq(client->name, matches->compatible))
+			return matches;
+
 		name = strchr(matches->compatible, ',');
 		if (!name)
 			name = matches->compatible;
-- 
2.7.4
