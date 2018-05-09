From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] i2c: pmcmsp: return message count on master_xfer success
Date: Wed,  9 May 2018 21:46:29 +0200
Message-ID: <20180509194630.29047-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Returning zero is wrong in this case.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 2aa0e83174c5..ec27e27e8d06 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -567,7 +567,7 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 		return -1;
 	}
 
-	return 0;
+	return num;
 }
 
 static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
-- 
2.11.0
