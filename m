From: Wen Yang <wenyang@linux.alibaba.com>
Subject: [PATCH] i2c: core: fix use after free in of_i2c_notify
Date: Fri,  8 Nov 2019 16:36:48 +0800
Message-ID: <20191108083648.56503-1-wenyang@linux.alibaba.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>
List-Id: linux-i2c@vger.kernel.org

We can't use "adap" after it has been freed.

Fixes: 5bf4fa7daea6 ("i2c: break out OF support into separate file")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/i2c/i2c-core-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 6f632d54..7eb4199 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -245,14 +245,14 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 		}
 
 		client = of_i2c_register_device(adap, rd->dn);
-		put_device(&adap->dev);
-
 		if (IS_ERR(client)) {
 			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
 				 rd->dn);
+			put_device(&adap->dev);
 			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(client));
 		}
+		put_device(&adap->dev);
 		break;
 	case OF_RECONFIG_CHANGE_REMOVE:
 		/* already depopulated? */
-- 
1.8.3.1
