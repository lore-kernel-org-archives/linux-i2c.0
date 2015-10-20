From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] i2c: mv64xxx: really allow I2C offloading
Date: Tue, 20 Oct 2015 16:32:24 +0200
Message-ID: <1445351544-26062-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hezi <hezi@marvell.com>, stable@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-i2c@vger.kernel.org

From: Hezi <hezi@marvell.com>

Commit 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix
several problems") completely reworked the offload support, but
stupidly left a debugging-related "return false" at the beginning of
the mv64xxx_i2c_can_offload() function. This has the unfortunate
consequence that offloading is in fact never used, which wasn't really
the intention.

This commit fixes that problem by removing the stupid "return false".

Fixes: 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix several problems")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hezi <hezi@marvell.com>
[Thomas: reworked commit log and title.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Note: the original fix is from Hezi, but I rewrote the commit log,
which is why I authorized myself to treat my own work as being
"stupid". Which it really was.
---
 drivers/i2c/busses/i2c-mv64xxx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 30059c1..5801227 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -669,8 +669,6 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
 	struct i2c_msg *msgs = drv_data->msgs;
 	int num = drv_data->num_msgs;
 
-	return false;
-
 	if (!drv_data->offload_enabled)
 		return false;
 
-- 
2.6.2
