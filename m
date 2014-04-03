From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] i2c: qup: off by ones in qup_i2c_probe()
Date: Thu, 3 Apr 2014 10:22:54 +0300
Message-ID: <20140403072254.GB14286@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Andy Gross <agross@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

These should ">= ARRAY_SIZE()" instead of "> ARRAY_SIZE()".

Fixes: 10c5a8425968 ('i2c: qup: New bus driver for the Qualcomm QUP I2C controller')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index c9d5f78..ee40980 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -633,12 +633,12 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	 * associated with each byte written/received
 	 */
 	size = QUP_OUTPUT_BLOCK_SIZE(io_mode);
-	if (size > ARRAY_SIZE(blk_sizes))
+	if (size >= ARRAY_SIZE(blk_sizes))
 		return -EIO;
 	qup->out_blk_sz = blk_sizes[size] / 2;
 
 	size = QUP_INPUT_BLOCK_SIZE(io_mode);
-	if (size > ARRAY_SIZE(blk_sizes))
+	if (size >= ARRAY_SIZE(blk_sizes))
 		return -EIO;
 	qup->in_blk_sz = blk_sizes[size] / 2;
 
