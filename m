From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: mxs: use true and false for boolean values
Date: Tue, 23 Jan 2018 11:38:27 -0600
Message-ID: <20180123173827.GA24756@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-i2c@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/busses/i2c-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index d4e8f19..e617bd6 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -181,7 +181,7 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 
 	if (msg->flags & I2C_M_RD) {
-		i2c->dma_read = 1;
+		i2c->dma_read = true;
 		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_READ;
 
 		/*
@@ -239,7 +239,7 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 			goto read_init_dma_fail;
 		}
 	} else {
-		i2c->dma_read = 0;
+		i2c->dma_read = false;
 		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_WRITE;
 
 		/*
-- 
2.7.4
