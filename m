From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 1/2] PM: Prototype the pm_generic_ operations
Date: Mon, 20 Dec 2010 14:33:12 +0000
Message-ID: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The pm_generic_ operations are all exported but are not prototyped in any
header file for direct use. Do so.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 include/linux/pm.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 40f3f45..f7b5bed 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -610,4 +610,11 @@ extern unsigned int	pm_flags;
 #define PM_APM	1
 #define PM_ACPI	2
 
+int pm_generic_suspend(struct device *dev);
+int pm_generic_resume(struct device *dev);
+int pm_generic_freeze(struct device *dev);
+int pm_generic_thaw(struct device *dev);
+int pm_generic_restore(struct device *dev);
+int pm_generic_poweroff(struct device *dev);
+
 #endif /* _LINUX_PM_H */
-- 
1.7.2.3
