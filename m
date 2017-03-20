From: Colin King <colin.king@canonical.com>
Subject: [PATCH] i2c: designware-baytrail: fix potential null pointer dereference on dev
Date: Mon, 20 Mar 2017 11:51:23 +0000
Message-ID: <20170320115123.31536-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment to addr requires a call to get_sem_addr that dereferences
dev, however, this dereference occurs before a null pointer check on dev.
Move this assignment after the null check on dev to avoid a potential null
pointer dereference.

Detected by CoverityScan, CID#1419700 ("Dereference before null check")

Fixes: fd476fa22a1f432 ("i2c: designware-baytrail: Add support for cherrytrail")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/busses/i2c-designware-baytrail.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 1749a0f5a9fa..2cbb2e9195ca 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -70,7 +70,7 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
 
 static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 {
-	u32 addr = get_sem_addr(dev);
+	u32 addr;
 	u32 sem = PUNIT_SEMAPHORE_ACQUIRE;
 	int ret;
 	unsigned long start, end;
@@ -94,6 +94,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
 	 */
 	pm_qos_update_request(&dev->pm_qos, 0);
 
+	addr = get_sem_addr(dev);
+
 	/* host driver writes to side band semaphore register */
 	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE, addr, sem);
 	if (ret) {
-- 
2.11.0
