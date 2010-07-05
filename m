From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH/RFC v2 4/4] hwmon: sysfs API updates
Date: Sun, 4 Jul 2010 21:10:18 -0700
Message-ID: <1278303018-22069-5-git-send-email-guenter.roeck@ericsson.com>
References: <1278303018-22069-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278303018-22069-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 Documentation/hwmon/sysfs-interface |   37 +++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index d4e2917..2dcec0f 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -421,11 +421,12 @@ power[1-*]_accuracy		Accuracy of the power meter.
 				Unit: Percent
 				RO
 
-power[1-*]_alarm		1 if the system is drawing more power than the
-				cap allows; 0 otherwise.  A poll notification is
-				sent to this file when the power use exceeds the
-				cap.  This file only appears if the cap is known
-				to be enforced by hardware.
+power[1-*]_alarm		1 if the system is drawing more power than cap
+				or max allows; 0 otherwise.  A poll notification
+				is sent to this file when the power use exceeds
+				the cap or max limit. If only cap is supported,
+				this file only appears if the cap is known to be
+				enforced by hardware.
 				RO
 
 power[1-*]_cap			If power use rises above this limit, the
@@ -450,6 +451,18 @@ power[1-*]_cap_min		Minimum cap that can be set.
 				Unit: microWatt
 				RO
 
+power[1-*]_max			Maximum power.
+				Unit: microWatt
+				RW
+
+power[1-*]_crit			Critical maximum power.
+				If power rises to or above this limit, the
+				system will take drastic action to reduce power
+				consumption, such as a system shutdown. At the
+				very least, a power fault will be generated.
+				Unit: microWatt
+				RO
+
 **********
 * Energy *
 **********
@@ -471,8 +484,14 @@ limit-related alarms, not both. The driver should just reflect the hardware
 implementation.
 
 in[0-*]_alarm
+in[0-*]_crit_alarm
+curr[1-*]_alarm
+curr[1-*]_crit_alarm
+power[1-*]_alarm
+power[1-*]_crit_alarm
 fan[1-*]_alarm
 temp[1-*]_alarm
+temp[1-*]_crit_alarm
 		Channel alarm
 		0: no alarm
 		1: alarm
@@ -482,10 +501,17 @@ OR
 
 in[0-*]_min_alarm
 in[0-*]_max_alarm
+in[0-*]_lcrit_alarm
+in[0-*]_crit_alarm
+curr[1-*]_lcrit_alarm
+curr[1-*]_crit_alarm
+power[1-*]_min_alarm
+power[1-*]_max_alarm
 fan[1-*]_min_alarm
 fan[1-*]_max_alarm
 temp[1-*]_min_alarm
 temp[1-*]_max_alarm
+temp[1-*]_lcrit_alarm
 temp[1-*]_crit_alarm
 		Limit alarm
 		0: no alarm
@@ -497,7 +523,6 @@ to notify open diodes, unconnected fans etc. where the hardware
 supports it. When this boolean has value 1, the measurement for that
 channel should not be trusted.
 
-in[0-*]_fault
 fan[1-*]_fault
 temp[1-*]_fault
 		Input fault condition
-- 
1.7.0.87.g0901d
