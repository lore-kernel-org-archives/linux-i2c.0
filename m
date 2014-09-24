From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/27] i2c: qup: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:00 +0530
Message-ID: <1411575342-31048-11-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Wolfram Sang <wsa@the-dreams.de>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, Andy Gross <agross@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, Pramod Gurav <pramod.gurav@smartplayin.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/i2c/busses/i2c-qup.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 3a4d64e..9ada3ee 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -518,8 +518,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 		ret = num;
 out:
 
-	pm_runtime_mark_last_busy(qup->dev);
-	pm_runtime_put_autosuspend(qup->dev);
+	pm_runtime_last_busy_and_autosuspend(qup->dev);
 
 	return ret;
 }
-- 
1.7.0.4
