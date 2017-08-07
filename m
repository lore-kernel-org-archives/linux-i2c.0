From: Stephen Douthit <stephend@adiengineering.com>
Subject: [PATCH 2/2] i2c: ismt: Return EMSGSIZE for block reads with bogus length
Date: Mon,  7 Aug 2017 17:11:00 -0400
Message-ID: <1502140260-13789-3-git-send-email-stephend@adiengineering.com>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:13680
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751761AbdHGVLi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 7 Aug 2017 17:11:38 -0400
In-Reply-To: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: seth.heasley@intel.com, nhorman@tuxdriver.com
Cc: wsa@the-dreams.de, danp@adiengineering.com, stephend@adiengineering.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Compare the number of bytes actually seen on the wire to the byte
count field returned by the slave device.

Previously we just overwrote the byte count returned by the slave
with the real byte count and let the caller figure out if the
message was sane.

Signed-off-by: Stephen Douthit <stephend@adiengineering.com>
Tested-by: Dan Priamo <danp@adiengineering.com>
---
 drivers/i2c/busses/i2c-ismt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 9af2337..22ffcb7 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -341,8 +341,10 @@ static int ismt_process_desc(const struct ismt_desc *desc,
 			break;
 		case I2C_SMBUS_BLOCK_DATA:
 		case I2C_SMBUS_I2C_BLOCK_DATA:
+			if (desc->rxbytes != dma_buffer[0] + 1)
+				return -EMSGSIZE;
+
 			memcpy(data->block, dma_buffer, desc->rxbytes);
-			data->block[0] = desc->rxbytes - 1;
 			break;
 		}
 		return 0;
-- 
2.7.5
