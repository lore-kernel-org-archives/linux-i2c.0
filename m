From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next][V2] i2c: xiic: fix indentation issue
Date: Mon, 27 Jan 2020 10:23:03 +0000
Message-ID: <20200127102303.44133-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50971 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0KXI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jan 2020 05:23:08 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented one level too deeply, remove
the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: fix type in commit message
---
 drivers/i2c/busses/i2c-xiic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index b17d30c9ab40..90c1c362394d 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
 		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
 		if (time_after(jiffies, timeout)) {
 			dev_err(i2c->dev, "Failed to clear rx fifo\n");
-				return -ETIMEDOUT;
+			return -ETIMEDOUT;
 		}
 	}
 
-- 
2.24.0
