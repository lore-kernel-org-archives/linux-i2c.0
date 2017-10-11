From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH] irqchip/aspeed-i2c-ic: Fix return value check in aspeed_i2c_ic_of_init()
Date: Wed, 11 Oct 2017 10:50:23 +0000
Message-ID: <1507719023-127618-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7971 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbdJKKqG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Oct 2017 06:46:06 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>, Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org

In case of error, the function of_iomap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test..

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/irqchip/irq-aspeed-i2c-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index 815b88d..f20200a 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -76,8 +76,8 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
 		return -ENOMEM;
 
 	i2c_ic->base = of_iomap(node, 0);
-	if (IS_ERR(i2c_ic->base)) {
-		ret = PTR_ERR(i2c_ic->base);
+	if (!i2c_ic->base) {
+		ret = -ENOMEM;
 		goto err_free_ic;
 	}
 
