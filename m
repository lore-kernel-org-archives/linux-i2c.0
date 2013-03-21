From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6/7] i2c-designware: use usleep_range() in the busy-loop
Date: Thu, 21 Mar 2013 14:09:59 +0200
Message-ID: <1363867800-23861-6-git-send-email-mika.westerberg@linux.intel.com>
References: <1363867800-23861-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363867800-23861-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, ben-linux@fluff.org, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

This is not an atomic context so there is no need to use mdelay() but
instead use usleep_range().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 0e4f531..0849648 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -350,7 +350,7 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 			return -ETIMEDOUT;
 		}
 		timeout--;
-		mdelay(1);
+		usleep_range(1000, 1100);
 	}
 
 	return 0;
-- 
1.7.10.4
