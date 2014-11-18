From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 1/4] mfd: dln2: fix _dln2_transfer return code
Date: Tue, 18 Nov 2014 14:57:57 +0200
Message-ID: <1416315480-2053-2-git-send-email-octavian.purdila@intel.com>
References: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: wsa@the-dreams.de, julia.lawall@lip6.fr, dan.carpenter@oracle.com, johan@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-i2c@vger.kernel.org

If wait_for_completion_interruptible_timeout returns a positive value
it may be propagated as the return value of _dln2_transfer. This
contradicts the documentation of the function and exposes unnecessary
internals to the callers.

This patch makes sure to set the return value to 0 in that case.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/mfd/dln2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 9765a17..cf22841 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -462,6 +462,8 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
 		if (!ret)
 			ret = -ETIMEDOUT;
 		goto out_free_rx_slot;
+	} else {
+		ret = 0;
 	}
 
 	if (dln2->disconnect) {
@@ -484,10 +486,8 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
 		goto out_free_rx_slot;
 	}
 
-	if (!ibuf) {
-		ret = 0;
+	if (!ibuf)
 		goto out_free_rx_slot;
-	}
 
 	if (*ibuf_len > rsp->hdr.size - sizeof(*rsp))
 		*ibuf_len = rsp->hdr.size - sizeof(*rsp);
-- 
1.9.1
