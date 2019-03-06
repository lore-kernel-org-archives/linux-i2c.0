From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: improve loopback in timing algorithm
Date: Wed, 6 Mar 2019 15:12:32 +0000
Message-ID: <1551885142-22365-1-git-send-email-bich.hemon@st.com>
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

This avoids useless loops inside the I2C timing algorithm.
Actually, we support only one possible solution per prescaler value.
So after finding a solution with a prescaler, the algorithm can
switch directly to the next prescaler value.

Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 4284fc9..48337be 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -476,8 +476,12 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
 
 					list_add_tail(&v->node,
 						      &solutions);
+					break;
 				}
 			}
+
+			if (p_prev == p)
+				break;
 		}
 	}
 
-- 
1.9.1
