From: Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 5/6] drivers/i2c: Remove caller signal_pending branch predictions
Date: Thu, 15 Nov 2018 16:27:12 -0800
Message-ID: <20181116002713.8474-6-dave@stgolabs.net>
References: <20181116002713.8474-1-dave@stgolabs.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116002713.8474-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: dave@stgolabs.net, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org

This is already done for us internally by the signal machinery.

Cc: linux-i2c@vger.kernel.org
Cc: peda@axentia.se
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 6f6e1dfe7cce..d78023d42a35 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -437,7 +437,7 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 				break;
 			}
 
-			if (unlikely(signal_pending(current))){
+			if (signal_pending(current)){
 				DBG("%d: poll interrupted\n", dev->idx);
 				ret = -ERESTARTSYS;
 				break;
-- 
2.16.4
