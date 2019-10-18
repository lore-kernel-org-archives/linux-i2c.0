From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH RESEND v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date: Fri, 18 Oct 2019 19:32:13 +0200
Message-ID: <20191018173213.13282-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Cc: tglx@linutronix.de, hsinyi@chromium.org, drinkcat@chromium.org, qii.wang@mediatek.com, wsa@the-dreams.de, matthias.bgg@gmail.com, Fabien Parent <fparent@baylibre.com>, Cengiz Can <cengiz@kernel.wtf>, Ulrich Hecht <uli@fpond.eu>
List-Id: linux-i2c@vger.kernel.org

Since commit abf4923e97c3 ("i2c: mediatek: disable zero-length transfers
for mt8183"), there is a NULL pointer dereference for all the SoCs
that don't have any quirk. mtk_i2c_functionality is not checking that
the quirks pointer is not NULL before starting to use it.

This commit add a call to i2c_check_quirks which will check whether
the quirks pointer is set, and if so will check if the IP has the
NO_ZERO_LEN quirk.

Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for mt8183")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Ulrich Hecht <uli@fpond.eu>

---

v2:
	* use i2c_check_quirks to check the quirks

---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 29eae1bf4f86..2152ec5f535c 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -875,7 +875,7 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 
 static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 {
-	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
+	if (i2c_check_quirks(adap, I2C_AQ_NO_ZERO_LEN))
 		return I2C_FUNC_I2C |
 			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 	else
-- 
2.23.0
