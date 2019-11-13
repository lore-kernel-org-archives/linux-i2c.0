From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 119/209] i2c: zx2967: use core to detect 'no zero length' quirk
Date: Tue, 12 Nov 2019 20:48:55 -0500
Message-ID: <20191113015025.9685-119-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit e2115ace4196bcd2126446fb874bcfc90cba79be ]

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index 48281c1b30c6d..b8f9e020d80e6 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -281,9 +281,6 @@ static int zx2967_i2c_xfer_msg(struct zx2967_i2c *i2c,
 	int ret;
 	int i;
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	zx2967_i2c_flush_fifos(i2c);
 
 	i2c->cur_trans = msg->buf;
@@ -498,6 +495,10 @@ static const struct i2c_algorithm zx2967_i2c_algo = {
 	.functionality = zx2967_i2c_func,
 };
 
+static const struct i2c_adapter_quirks zx2967_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct of_device_id zx2967_i2c_of_match[] = {
 	{ .compatible = "zte,zx296718-i2c", },
 	{ },
@@ -568,6 +569,7 @@ static int zx2967_i2c_probe(struct platform_device *pdev)
 	strlcpy(i2c->adap.name, "zx2967 i2c adapter",
 		sizeof(i2c->adap.name));
 	i2c->adap.algo = &zx2967_i2c_algo;
+	i2c->adap.quirks = &zx2967_i2c_quirks;
 	i2c->adap.nr = pdev->id;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
-- 
2.20.1
