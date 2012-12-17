From: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] driver i2c-nforce2: fix pointer CodingStyle issues
Date: Mon, 17 Dec 2012 22:04:19 +0100
Message-ID: <1355778259-8445-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

fix these errors reported by checkpatch.pl
- drivers/i2c/busses/i2c-nforce2.c:191
- drivers/i2c/busses/i2c-nforce2.c:193
ERROR: "foo * bar" should be "foo *bar"

- drivers/i2c/busses/i2c-nforce2.c:302:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-nforce2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 392303b..9db5ff5 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -188,9 +188,9 @@ static int nforce2_check_status(struct i2c_adapter *adap)
 }
 
 /* Return negative errno on error */
-static s32 nforce2_access(struct i2c_adapter * adap, u16 addr,
+static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 		unsigned short flags, char read_write,
-		u8 command, int size, union i2c_smbus_data * data)
+		u8 command, int size, union i2c_smbus_data *data)
 {
 	struct nforce2_smbus *smbus = adap->algo_data;
 	unsigned char protocol, pec;
@@ -299,7 +299,7 @@ static u32 nforce2_func(struct i2c_adapter *adapter)
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	       I2C_FUNC_SMBUS_PEC |
-	       (((struct nforce2_smbus*)adapter->algo_data)->blockops ?
+	       (((struct nforce2_smbus *)adapter->algo_data)->blockops ?
 		I2C_FUNC_SMBUS_BLOCK_DATA : 0);
 }
 
-- 
1.7.10.4
