From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: mpc: remove useless variable initialization
Date: Fri, 27 Oct 2017 22:24:44 +0200
Message-ID: <20171027202444.20220-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35434 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932559AbdJ0UY4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 16:24:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

cppcheck rightfully says:

drivers/i2c/busses/i2c-mpc.c:329: style: Variable 'node' is reassigned a value before the old one has been used.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 2b221a51497437..950a9d74f54db3 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -322,7 +322,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
 
 static u32 mpc_i2c_get_sec_cfg_8xxx(void)
 {
-	struct device_node *node = NULL;
+	struct device_node *node;
 	u32 __iomem *reg;
 	u32 val = 0;
 
-- 
2.11.0
