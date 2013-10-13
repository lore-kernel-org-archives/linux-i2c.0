From: RAGHAVENDRA GANIGA <ravi23ganiga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c: i2c-core: fix paranthesis coding style issue in
 i2c-core.c
Date: Mon, 14 Oct 2013 00:40:03 +0530
Message-ID: <525AF00B.4000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ravi23ganiga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>From 46aed97f5e5a434e8ec24c14e085a138958ba559 Mon Sep 17 00:00:00 2001
From: Raghavendra Ganiga <ravi23ganiga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 13 Oct 2013 19:13:46 +0530
Subject: [PATCH 1/2] i2c: i2c-core: fix paranthesis coding style issue in
 i2c-core.c

This is a patch to the i2c-core.c file that fixes the paranthesis
warning found by the checkpatch.pl tool

Signed-off-by: Raghavendra Chandra Ganiga <ravi23ganiga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..b1197bb 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -637,7 +637,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
        struct i2c_client       *client;
        int                     status;

-       client = kzalloc(sizeof *client, GFP_KERNEL);
+       client = kzalloc(sizeof(*client), GFP_KERNEL);
        if (!client)
                return NULL;

-- 
1.7.10.4
