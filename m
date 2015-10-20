From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH] i2c: busses: Use setup_timer
Date: Tue, 20 Oct 2015 23:47:19 +0530
Message-ID: <1445365039-23695-1-git-send-email-falakreyaz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Muhammad Falak R Wani <falakreyaz@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Use timer API function setup_timer instead of init_timer to
initialize the timer.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/i2c/busses/i2c-pnx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index e814a36..cdbf632 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -659,9 +659,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (IS_ERR(alg_data->clk))
 		return PTR_ERR(alg_data->clk);
 
-	init_timer(&alg_data->mif.timer);
-	alg_data->mif.timer.function = i2c_pnx_timeout;
-	alg_data->mif.timer.data = (unsigned long)alg_data;
+	setup_timer(&alg_data->mif.timer, i2c_pnx_timeout,
+			(unsigned long)alg_data);
 
 	snprintf(alg_data->adapter.name, sizeof(alg_data->adapter.name),
 		 "%s", pdev->name);
-- 
1.9.1
