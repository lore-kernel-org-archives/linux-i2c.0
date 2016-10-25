From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv6 07/11] i2c: match dt-style device names from sysfs interface
Date: Tue, 25 Oct 2016 17:41:51 +0100
Message-ID: <1477413715-22894-8-git-send-email-kieran@bingham.xyz>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
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
 drivers/i2c/i2c-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2003334b5246..01bce56f733a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1692,6 +1692,16 @@ i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
 	const char *name;
 
 	for (; matches->compatible[0]; matches++) {
+		/*
+		 * Adding devices through the i2c sysfs interface provides us
+		 * a string to match which may be compatible with the device
+		 * tree compatible strings, however with no actual of_node the
+		 * of_match_device() will not match
+		 */
+		if (!strncasecmp(client->name, matches->compatible,
+				strlen(matches->compatible)))
+			return matches;
+
 		name = strchr(matches->compatible, ',');
 		if (!name)
 			name = matches->compatible;
-- 
2.7.4
