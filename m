From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] i2c-puv3: Improve a size determination in
 puv3_i2c_probe()
Date: Fri, 2 Feb 2018 16:02:12 +0100
Message-ID: <ab401452-cf6c-e4b0-eb8c-f9daf20c981c@users.sourceforge.net>
References: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:63061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752180AbeBBPCT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Feb 2018 10:02:19 -0500
In-Reply-To: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:43:21 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-puv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index 5bd001d01bef..929fd12b92de 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -196,7 +196,7 @@ static int puv3_i2c_probe(struct platform_device *pdev)
 	if (!request_mem_region(mem->start, resource_size(mem), "puv3_i2c"))
 		return -EBUSY;
 
-	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
 	if (adapter == NULL) {
 		rc = -ENOMEM;
 		goto fail_nomem;
-- 
2.16.1
