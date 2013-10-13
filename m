From: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Subject: [PATCH] i2c: i2c-core: fix paranthesis coding style issue in i2c-core.c
Date: Sun, 13 Oct 2013 23:26:16 +0530
Message-ID: <525ADEC0.7020908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ravi23ganiga@gmail.com
List-Id: linux-i2c@vger.kernel.org

>From 46aed97f5e5a434e8ec24c14e085a138958ba559 Mon Sep 17 00:00:00 2001
From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
Date: Sun, 13 Oct 2013 19:13:46 +0530
Subject: [PATCH] i2c: i2c-core: fix paranthesis coding style issue in
 i2c-core.c

This is a patch to the i2c-core.c file that fixes the paranthesis
warning found by the checkpatch.pl tool

Signed-off-by: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
---
 drivers/i2c/i2c-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..b1197bb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -637,7 +637,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	struct i2c_client	*client;
 	int			status;
 
-	client = kzalloc(sizeof *client, GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return NULL;
 
-- 
1.7.10.4
