From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Date: Wed, 6 Mar 2019 15:12:16 +0000
Message-ID: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-i2c@vger.kernel.org

From: Nicolas Le Bayon <nicolas.le.bayon@st.com>

It conforms with Reference Manual I2C timing section.

Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 13e1213..4284fc9 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -432,7 +432,7 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
 		 STM32F7_I2C_ANALOG_FILTER_DELAY_MAX : 0);
 	dnf_delay = setup->dnf * i2cclk;
 
-	sdadel_min = setup->fall_time - i2c_specs[setup->speed].hddat_min -
+	sdadel_min = i2c_specs[setup->speed].hddat_min + setup->fall_time -
 		af_delay_min - (setup->dnf + 3) * i2cclk;
 
 	sdadel_max = i2c_specs[setup->speed].vddat_max - setup->rise_time -
-- 
1.9.1
