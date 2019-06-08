From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 17/31] i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr
Date: Sat,  8 Jun 2019 07:46:28 -0400
Message-ID: <20190608114646.9415-17-sashal@kernel.org>
References: <20190608114646.9415-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608114646.9415-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Yingjoe Chen <yingjoe.chen@mediatek.com>

[ Upstream commit a0692f0eef91354b62c2b4c94954536536be5425 ]

If I2C_M_RECV_LEN check failed, msgs[i].buf allocated by memdup_user
will not be freed. Pump index up so it will be freed.

Fixes: 838bfa6049fb ("i2c-dev: Add support for I2C_M_RECV_LEN")
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 00e8e675cbeb..eaa312bc3a3c 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -297,6 +297,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 			    rdwr_pa[i].buf[0] < 1 ||
 			    rdwr_pa[i].len < rdwr_pa[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
+				i++;
 				res = -EINVAL;
 				break;
 			}
-- 
2.20.1
