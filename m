From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 08/11] i2c: match vendorless strings on the internal string length
Date: Mon,  7 Nov 2016 12:47:43 +0000
Message-ID: <1478522866-29620-9-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

If a user provides a shortened string to match a device to the sysfs i2c
interface it will match on the first string that contains that string
prefix.

for example:
  echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
will match as3711, as3722, and ak8975 incorrectly.

Correct this by using sysfs_streq to match the string exactly

Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

---
Changes from v7
 - strncasecmp usage converted to sysfs_streq

 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c338c8f3b3db..8b93a262e237 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1810,7 +1810,7 @@ i2c_of_match_device_sysfs(const struct of_device_id *matches,
 		else
 			name++;
 
-		if (!strncasecmp(client->name, name, strlen(client->name)))
+		if (sysfs_streq(client->name, name))
 			return matches;
 	}
 
-- 
2.7.4
