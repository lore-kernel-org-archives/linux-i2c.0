From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH] i2c: remove unnecessary 'else' after 'return' statement
Date: Wed,  6 Aug 2014 12:36:05 +0530
Message-ID: <1407308765-13869-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: kiran.padwal@smartplayin.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Fix the following warning reported by checkpatch.pl:

WARNING: else is not generally useful after a break or return

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/i2c/i2c-core.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 632057a..228bd04 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -351,8 +351,8 @@ static int i2c_device_pm_suspend(struct device *dev)
 
 	if (pm)
 		return pm_generic_suspend(dev);
-	else
-		return i2c_legacy_suspend(dev, PMSG_SUSPEND);
+
+	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
 }
 
 static int i2c_device_pm_resume(struct device *dev)
@@ -361,8 +361,8 @@ static int i2c_device_pm_resume(struct device *dev)
 
 	if (pm)
 		return pm_generic_resume(dev);
-	else
-		return i2c_legacy_resume(dev);
+
+	return i2c_legacy_resume(dev);
 }
 
 static int i2c_device_pm_freeze(struct device *dev)
@@ -371,8 +371,8 @@ static int i2c_device_pm_freeze(struct device *dev)
 
 	if (pm)
 		return pm_generic_freeze(dev);
-	else
-		return i2c_legacy_suspend(dev, PMSG_FREEZE);
+
+	return i2c_legacy_suspend(dev, PMSG_FREEZE);
 }
 
 static int i2c_device_pm_thaw(struct device *dev)
@@ -381,8 +381,8 @@ static int i2c_device_pm_thaw(struct device *dev)
 
 	if (pm)
 		return pm_generic_thaw(dev);
-	else
-		return i2c_legacy_resume(dev);
+
+	return i2c_legacy_resume(dev);
 }
 
 static int i2c_device_pm_poweroff(struct device *dev)
@@ -391,8 +391,8 @@ static int i2c_device_pm_poweroff(struct device *dev)
 
 	if (pm)
 		return pm_generic_poweroff(dev);
-	else
-		return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
+
+	return i2c_legacy_suspend(dev, PMSG_HIBERNATE);
 }
 
 static int i2c_device_pm_restore(struct device *dev)
@@ -401,8 +401,8 @@ static int i2c_device_pm_restore(struct device *dev)
 
 	if (pm)
 		return pm_generic_restore(dev);
-	else
-		return i2c_legacy_resume(dev);
+
+	return i2c_legacy_resume(dev);
 }
 #else /* !CONFIG_PM_SLEEP */
 #define i2c_device_pm_suspend	NULL
@@ -622,8 +622,8 @@ static int i2c_trylock_adapter(struct i2c_adapter *adapter)
 
 	if (parent)
 		return i2c_trylock_adapter(parent);
-	else
-		return rt_mutex_trylock(&adapter->bus_lock);
+
+	return rt_mutex_trylock(&adapter->bus_lock);
 }
 
 /**
-- 
1.7.9.5
