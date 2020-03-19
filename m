From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: improve nack debug message
Date: Thu, 19 Mar 2020 19:21:55 +0100
Message-ID: <1584642115-15378-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43060 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbgCSSWJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Mar 2020 14:22:09 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: alain.volmat@st.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add information on slave addr in the nack debug message.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 378956ac6d1d..78d40a4cc282 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1431,7 +1431,8 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 
 	/* NACK received */
 	if (status & STM32F7_I2C_ISR_NACKF) {
-		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK\n", __func__);
+		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK (addr %x)\n",
+			__func__, f7_msg->addr);
 		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
 		f7_msg->result = -ENXIO;
 	}
-- 
2.7.4
