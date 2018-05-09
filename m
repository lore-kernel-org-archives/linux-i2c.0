From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] i2c: pmcmsp: fix error return from master_xfer
Date: Wed,  9 May 2018 21:46:30 +0200
Message-ID: <20180509194630.29047-2-peda@axentia.se>
References: <20180509194630.29047-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509194630.29047-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Returning -1 (-EPERM) is not appropriate here, go with -EIO.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index ec27e27e8d06..dae8ac618a52 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -564,7 +564,7 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 		 * TODO: We could potentially loop and retry in the case
 		 * of MSP_TWI_XFER_TIMEOUT.
 		 */
-		return -1;
+		return -EIO;
 	}
 
 	return num;
-- 
2.11.0
