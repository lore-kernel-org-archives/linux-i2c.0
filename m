From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: jz4780: drop superfluous init
Date: Sun,  5 Jun 2016 11:41:42 +0200
Message-ID: <1465119702-4417-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42306 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbcFEJl4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 5 Jun 2016 05:41:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Axel Lin <axel.lin@ingics.com>, Wolfram Sang <wsa@the-dreams.de>, David Binderman <dcb314@hotmail.com>

David reported that the length for memset was incorrect (element sizes
were not taken into account). Then I saw that we are clearing kzalloced
memory, so we can simply drop this code.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only compile tested, due to no HW.

 drivers/i2c/busses/i2c-jz4780.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index ba14a863b451f9..cd9872594fe2a0 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -791,10 +791,6 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 
 	jz4780_i2c_writew(i2c, JZ4780_I2C_INTM, 0x0);
 
-	i2c->cmd = 0;
-	memset(i2c->cmd_buf, 0, BUFSIZE);
-	memset(i2c->data_buf, 0, BUFSIZE);
-
 	i2c->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, i2c->irq, jz4780_i2c_irq, 0,
 			       dev_name(&pdev->dev), i2c);
-- 
2.8.1
