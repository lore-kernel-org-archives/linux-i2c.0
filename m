From: Pontus Andersson <epontan@gmail.com>
Subject: [PATCH] i2c: ismt: Separate I2C block read from SMBus block read
Date: Mon, 2 Oct 2017 14:45:19 +0200
Message-ID: <20171002124519.GA13496@leonis.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38517 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdJBMpY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Oct 2017 08:45:24 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Commit b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for
block reads") broke I2C block reads. It aimed to fix normal SMBus block
read, but changed the correct behavior of I2C block read in the process.

According to Documentation/i2c/smbus-protocol, one vital difference
between normal SMBus block read and I2C block read is that there is no
byte count prefixed in the data sent on the wire:

 SMBus Block Read:  i2c_smbus_read_block_data()
 S Addr Wr [A] Comm [A]
            S Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P

 I2C Block Read:  i2c_smbus_read_i2c_block_data()
 S Addr Wr [A] Comm [A]
            S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P

Therefore the two transaction types need to be processed differently in
the driver by copying of the dma_buffer as done previously for the
I2C_SMBUS_I2C_BLOCK_DATA case.

Fixes: b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for block reads")
Signed-off-by: Pontus Andersson <epontan@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/i2c/busses/i2c-ismt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 22ffcb73c185..b51adffa4841 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -340,12 +340,15 @@ static int ismt_process_desc(const struct ismt_desc *desc,
 			data->word = dma_buffer[0] | (dma_buffer[1] << 8);
 			break;
 		case I2C_SMBUS_BLOCK_DATA:
-		case I2C_SMBUS_I2C_BLOCK_DATA:
 			if (desc->rxbytes != dma_buffer[0] + 1)
 				return -EMSGSIZE;
 
 			memcpy(data->block, dma_buffer, desc->rxbytes);
 			break;
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			memcpy(&data->block[1], dma_buffer, desc->rxbytes);
+			data->block[0] = desc->rxbytes;
+			break;
 		}
 		return 0;
 	}
-- 
2.14.1
