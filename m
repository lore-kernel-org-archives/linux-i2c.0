From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 1/2] mfd: dln2: fix _dln2_transfer return code
Date: Tue, 11 Nov 2014 14:20:56 +0200
Message-ID: <1415708457-18798-2-git-send-email-octavian.purdila@intel.com>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: laurentiu.palcu@intel.com, johan@kernel.org, wsa@the-dreams.de, julia.lawall@lip6.fr, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-i2c@vger.kernel.org

If wait_for_completion_interruptible_timeout returns a positive value
it may be propagated as the return value of _dln2_transfer. This
contradicts the documentation of the function and exposes unnecessary
internals to the callers.

This patch makes sure to set the return value to 0 in that case.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/mfd/dln2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 9765a17..f0747a1 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -462,7 +462,8 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
 		if (!ret)
 			ret = -ETIMEDOUT;
 		goto out_free_rx_slot;
-	}
+	} else
+		ret = 0;
 
 	if (dln2->disconnect) {
 		ret = -ENODEV;
-- 
1.9.1
