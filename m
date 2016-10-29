From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] i2c: digicolor: use clk_disable_unprepare instead of clk_unprepare
Date: Sat, 29 Oct 2016 16:31:17 +0000
Message-ID: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32891 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbcJ2Qb0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 29 Oct 2016 12:31:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id a136so887237pfa.0
        for <linux-i2c@vger.kernel.org>; Sat, 29 Oct 2016 09:31:25 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Baruch Siach <baruch@tkos.co.il>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

since clk_prepare_enable() is used to get i2c->clk, we should
use clk_disable_unprepare() to release it for the error path.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/i2c/busses/i2c-digicolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
index 49f2084..50813a2 100644
--- a/drivers/i2c/busses/i2c-digicolor.c
+++ b/drivers/i2c/busses/i2c-digicolor.c
@@ -347,7 +347,7 @@ static int dc_i2c_probe(struct platform_device *pdev)
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-		clk_unprepare(i2c->clk);
+		clk_disable_unprepare(i2c->clk);
 		return ret;
 	}
