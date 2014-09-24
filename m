From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/27] i2c: designware: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:44:58 +0530
Message-ID: <1411575342-31048-9-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: subhransu.s.prusty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 3c20e4b..13aa1cc 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -676,8 +676,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = -EIO;
 
 done:
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	pm_runtime_last_busy_and_autosuspend(dev->dev);
 	mutex_unlock(&dev->lock);
 
 	return ret;
-- 
1.7.0.4
