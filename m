From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH] i2c: Fix error print when address is invalid
Date: Mon, 23 Jan 2017 18:24:24 -0800
Message-ID: <20170124022424.18212-1-stephen.boyd@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

When the address is invalid, we print out the address that's
in info.addr, but that member of info hasn't been assigned yet.
It's assigned in the line after we check the address. This causes
the print to show something like

     i2c i2c-1: of_i2c: invalid addr=0 on ...

when we want something like

     i2c i2c-1: of_i2c: invalid addr=0xaf on ...

Just pass addr here, and update the print format to indicate hex
as well.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/i2c/i2c-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cf9e396d7702..9fec1c232d68 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1707,8 +1707,8 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	}
 
 	if (i2c_check_addr_validity(addr, info.flags)) {
-		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
-			info.addr, node->full_name);
+		dev_err(&adap->dev, "of_i2c: invalid addr=%#x on %s\n",
+			addr, node->full_name);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.10.0.297.gf6727b0
