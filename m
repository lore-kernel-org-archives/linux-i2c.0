From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] i2c: i801: Fix runtime PM
Date: Tue, 26 Jun 2018 17:39:12 +0300
Message-ID: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Commit 9c8088c7988 ("i2c: i801: Don't restore config registers on
runtime PM") nullified the runtime PM suspend/resume callback pointers
while keeping the runtime PM enabled. This causes that device stays in
D0 power state and sysfs /sys/bus/pci/devices/.../power/runtime_status
shows "error" when runtime PM framework attempts to autosuspend the
device.

This is due PCI bus runtime PM which checks for driver runtime PM
callbacks and returns with -ENOSYS if they are not set. Fix this by
having a shared dummy runtime PM callback that returns with success.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index aa726607645e..3747484c2669 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1731,7 +1731,20 @@ static int i801_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(i801_pm_ops, i801_suspend, i801_resume);
+static int __maybe_unused i801_runtime_nop(struct device *dev)
+{
+	/*
+	 * PCI core expects runtime PM suspend/resume callbacks return
+	 * successfully before really suspending/resuming the device.
+	 * Have a shared dummy callback that returns with success.
+	 */
+	return 0;
+}
+
+static const struct dev_pm_ops i801_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(i801_suspend, i801_resume)
+	SET_RUNTIME_PM_OPS(i801_runtime_nop, i801_runtime_nop, NULL)
+};
 
 static struct pci_driver i801_driver = {
 	.name		= "i801_smbus",
-- 
2.18.0
