From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] i2c: Encourage move to dev_pm_ops by warning on use of legacy methods
Date: Mon, 20 Dec 2010 21:41:00 +0000
Message-ID: <1292881260-31987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since the PM core wishes to transition away from the legacy suspend
and resume methods and since removing them makes using PM core features
like runtime PM much easier start warning when a driver is registered
using the legacy methods.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---

Clearly this is going to generate reams of warnings when lots of stuff
is built in - I'm willing to work on fixing up drivers - so it should
only be applied after the next merge window to give a chance for an
active effort at migrating drivers before we spam everyone's logs.

 drivers/i2c/i2c-core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6b4cc56..8cd82f4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1140,6 +1140,14 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 	if (res)
 		return res;
 
+	/* Drivers should switch to dev_pm_ops instead. */
+	if (driver->suspend)
+		pr_warn("i2c-core: driver [%s] using legacy suspend method\n",
+			driver->driver.name);
+	if (driver->resume)
+		pr_warn("i2c-core: driver [%s] using legacy resume method\n",
+			driver->driver.name);
+
 	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
 
 	INIT_LIST_HEAD(&driver->clients);
-- 
1.7.1
