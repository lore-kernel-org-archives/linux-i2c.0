From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] hwmon: Add tempX_emergency to sysfs ABI
Date: Thu, 26 Aug 2010 08:54:45 -0700
Message-ID: <1282838085-7210-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "Ira W. Snyder" <iws-lulEs6mt1IksTUYHLfqkUA@public.gmane.org>, "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
tempX_emergency will be used by max6696. It can also be used for other chips
supporting three upper temperature limits.

 Documentation/hwmon/sysfs-interface |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index ff45d1f..1ceb2b9 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -310,6 +310,12 @@ temp[1-*]_crit_hyst
 		from the critical value.
 		RW
 
+temp[1-*]_emergency
+		Temperature emergency value, typically greater than
+		corresponding temp_crit values.
+		Unit: millidegree Celsius
+		RW
+
 temp[1-*]_lcrit	Temperature critical min value, typically lower than
 		corresponding temp_min values.
 		Unit: millidegree Celsius
-- 
1.7.0.87.g0901d
