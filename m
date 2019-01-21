From: qii wang <qii.wang@mediatek.com>
Subject: [PATCH v3 3/6] i2c: mediatek: remove completion_done()
Date: Mon, 21 Jan 2019 15:59:31 +0800
Message-ID: <1548057574-8061-4-git-send-email-qii.wang@mediatek.com>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

Completion_done() is useless when we don't use its return value,
so we remove it.

Signed-off-by: qii wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 7396449..660de1e 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		return -ETIMEDOUT;
 	}
 
-	completion_done(&i2c->msg_complete);
-
 	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
 		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
 		mtk_i2c_init_hw(i2c);
-- 
1.7.9.5
