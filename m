From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
Date: Fri,  4 May 2018 20:43:16 -0500
Message-ID: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
which are used to save a series of messages, as mentioned in the comment.
According to the value of the variable "size", msgbuf0 is initialized to
various values. In contrast, msgbuf1 is left uninitialized until the
function i2c_transfer() is invoked. However, mgsbuf1 is not always
initialized on all possible execution paths (implementation) of
i2c_transfer(). Thus, it is possible that mgsbuf1 may still be
uninitialized even after the invocation of the function i2c_transfer(),
especially when the return value of ic2_transfer() is not checked properly.
In the following execution, the uninitialized msgbuf1 will be used, such as
for security checks. Since uninitialized values can be random and
arbitrary, this will cause undefined behaviors or even check bypass. For
example, it is expected that if the value of "size" is
I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
value read from msgbuf1 is assigned to data->block[0], which can
potentially lead to invalid block write size, as demonstrated in the error
message.

This patch checks the return value of i2c_transfer() and also initializes
the first byte of msgbuf1 with 0 to avoid undefined behaviors or security
issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/i2c/i2c-core-smbus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index b5aec33..e8470d5 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -344,6 +344,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	};
 
 	msgbuf0[0] = command;
+	msgbug1[0] = 0;
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		msg[0].len = 0;
@@ -466,6 +467,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
 		return status;
+	if (status != num)
+		return -EIO;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
-- 
2.7.4
