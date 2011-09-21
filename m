From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 2/7] i2c-eg20t: Modify returned value s32 to long
Date: Wed, 21 Sep 2011 16:51:44 +0900
Message-ID: <1316591509-4433-2-git-send-email-tomoya-linux@dsn.okisemi.com>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qi Wang <qi.wang@intel.com>, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
List-Id: linux-i2c@vger.kernel.org

Type of wait_event_timeout is long not s32.
This patch replaces s32 with long.
Additionally, delete negative processing(ret < 0).

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
---
 drivers/i2c/busses/i2c-eg20t.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 6add59f..21ade63 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -313,13 +313,9 @@ static void pch_i2c_start(struct i2c_algo_pch_data *adap)
  */
 static s32 pch_i2c_wait_for_xfer_complete(struct i2c_algo_pch_data *adap)
 {
-	s32 ret;
+	long ret;
 	ret = wait_event_timeout(pch_event,
 			(adap->pch_event_flag != 0), msecs_to_jiffies(50));
-	if (ret < 0) {
-		pch_err(adap, "timeout: %x\n", adap->pch_event_flag);
-		return ret;
-	}
 
 	if (ret == 0) {
 		pch_err(adap, "timeout: %x\n", adap->pch_event_flag);
-- 
1.7.4.4
