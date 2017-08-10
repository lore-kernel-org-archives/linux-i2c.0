From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] i2c: use release_mem_region instead of release_resource
Date: Thu, 10 Aug 2017 18:15:45 +0300
Message-ID: <1502378145-12869-1-git-send-email-vasilyev@ispras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bran.ispras.ru ([83.149.199.196]:33957 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751972AbdHJPP4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Aug 2017 11:15:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

Use api pair of request_mem_region and release_mem_region
instead of release_resource.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/i2c/busses/i2c-simtec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-simtec.c b/drivers/i2c/busses/i2c-simtec.c
index b4685bb..adca51a 100644
--- a/drivers/i2c/busses/i2c-simtec.c
+++ b/drivers/i2c/busses/i2c-simtec.c
@@ -127,8 +127,7 @@ static int simtec_i2c_probe(struct platform_device *dev)
 	iounmap(pd->reg);
 
  err_res:
-	release_resource(pd->ioarea);
-	kfree(pd->ioarea);
+	release_mem_region(pd->ioarea->start, size);
 
  err:
 	kfree(pd);
@@ -142,8 +141,7 @@ static int simtec_i2c_remove(struct platform_device *dev)
 	i2c_del_adapter(&pd->adap);
 
 	iounmap(pd->reg);
-	release_resource(pd->ioarea);
-	kfree(pd->ioarea);
+	release_mem_region(pd->ioarea->start, resource_size(pd->ioarea));
 	kfree(pd);
 
 	return 0;
-- 
2.7.4
