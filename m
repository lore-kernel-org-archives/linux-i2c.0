From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: i2c-mxs: Fix build warning
Date: Thu,  5 Apr 2012 17:09:55 -0300
Message-ID: <1333656595-3600-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix the following build warning:

drivers/i2c/busses/i2c-mxs.c:207:8: warning: 'data' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3d471d5..6a24a86 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -194,7 +194,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
 
 static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
 {
-	u32 data;
+	u32 data = 0;
 	int i;
 
 	for (i = 0; i < len; i++) {
-- 
1.7.1
