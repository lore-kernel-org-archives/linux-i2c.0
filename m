From: Yadi Hu <yadi.hu@windriver.com>
Subject: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Tue, 23 Aug 2016 16:55:15 +0800
Message-ID: <1471942515-21278-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:40022 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757496AbcHWI4v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 Aug 2016 04:56:51 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: yadi.hu@windriver.com, jdelvare@suse.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org

From: Hu Yadi <Yadi.hu@windriver.com>

The eg20t driver uses i2c_add_numbered_adapter() to register adapter:

    pch_adap->nr = i;
    ret = i2c_add_numbered_adapter(pch_adap);

Variable i is assigned to 0, it means that i2c_eg20t is the first adapter
by default. if another adapter registers before eg20t, above code return
error for index conflict:

    i2c_eg20t 0000:05:0c.2: pch_i2c_probe :i2c_add_adapter[ch:0] FAILED
    i2c_eg20t: probe of 0000:05:0c.2 failed with error -16

So, we can replace i2c_add_numbered_adapter() with i2c_add_adapter()
interface.since it dynamically allocates the index number.

Signed-off-by: Hu Yadi <Yadi.hu@windriver.com>
---
 drivers/i2c/busses/i2c-eg20t.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 7a51ddc..2f4c2af 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -913,8 +913,7 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 
 		pch_i2c_init(&adap_info->pch_data[i]);
 
-		pch_adap->nr = i;
-		ret = i2c_add_numbered_adapter(pch_adap);
+               ret = i2c_add_adapter(pch_adap);
 		if (ret) {
 			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
 			goto err_add_adapter;
-- 
1.7.5.4
