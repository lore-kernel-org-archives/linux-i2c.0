From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: davinci: use correct format identifier for size_t
Date: Wed, 18 Oct 2017 00:17:09 +0200
Message-ID: <20171017221709.24992-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54874 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756594AbdJQWRU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Oct 2017 18:17:20 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>

Fixes this warning (found by build testing with 64bit):

format ‘%i’ expects argument of type ‘int’, but argument 3 has type
‘size_t {aka long unsigned int}’ [-Wformat=]

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a2d9f7c56dacdc..2ead9b9eebb79a 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -504,7 +504,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		/* This should be 0 if all bytes were transferred
 		 * or dev->cmd_err denotes an error.
 		 */
-		dev_err(dev->dev, "abnormal termination buf_len=%i\n",
+		dev_err(dev->dev, "abnormal termination buf_len=%zu\n",
 			dev->buf_len);
 		dev->terminate = 1;
 		wmb();
-- 
2.11.0
