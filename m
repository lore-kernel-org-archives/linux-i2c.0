From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] i2c: img-scb: use setup_timer
Date: Sun,  9 Apr 2017 09:41:31 +0800
Message-ID: <0aa459186eb73a97664174c029bc0933c1db5b74.1490602022.git.geliangtang@gmail.com>
References: <0ff6e139159043e3416b0e5bc89e9aa5399bbb8e.1490601847.git.geliangtang@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36637 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdDIBly (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 8 Apr 2017 21:41:54 -0400
In-Reply-To: <0ff6e139159043e3416b0e5bc89e9aa5399bbb8e.1490601847.git.geliangtang@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index db8e8b4..84fb35f 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1362,9 +1362,8 @@ static int img_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Set up the exception check timer */
-	init_timer(&i2c->check_timer);
-	i2c->check_timer.function = img_i2c_check_timer;
-	i2c->check_timer.data = (unsigned long)i2c;
+	setup_timer(&i2c->check_timer, img_i2c_check_timer,
+		    (unsigned long)i2c);
 
 	i2c->bitrate = timings[0].max_bitrate;
 	if (!of_property_read_u32(node, "clock-frequency", &val))
-- 
2.9.3
