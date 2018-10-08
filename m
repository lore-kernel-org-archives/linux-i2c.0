From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] i2c: Fix kerneldoc for renamed i2c dma put function
Date: Mon,  8 Oct 2018 07:55:20 -0700
Message-ID: <20181008145520.36810-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This function was renamed in commit 82fe39a6bc7b ("i2c: refactor
function to release a DMA safe buffer") but this kernel doc wasn't
updated to point at the new function. Rename it.

Fixes: 82fe39a6bc7b ("i2c: refactor function to release a DMA safe buffer")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9ee9a15e7134..9200e349f29e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2270,7 +2270,7 @@ EXPORT_SYMBOL(i2c_put_adapter);
  *
  * Return: NULL if a DMA safe buffer was not obtained. Use msg->buf with PIO.
  *	   Or a valid pointer to be used with DMA. After use, release it by
- *	   calling i2c_release_dma_safe_msg_buf().
+ *	   calling i2c_put_dma_safe_msg_buf().
  *
  * This function must only be called from process context!
  */
-- 
Sent by a computer through tubes
