From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] dt-bindings: soc: qcom: Provide option to select FIFO mode
Date: Wed,  4 Sep 2019 12:36:13 +0100
Message-ID: <20190904113613.14997-2-lee.jones@linaro.org>
References: <20190904113613.14997-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904113613.14997-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, bjorn.andersson@linaro.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Used when DMA is not available or the best option.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index dab7ca9f250c..b0e71c07e604 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -40,6 +40,7 @@ Required properties:
 Optional property:
 - clock-frequency:	Desired I2C bus clock frequency in Hz.
 			When missing default to 100000Hz.
+- qcom,geni-se-fifo:	Selects FIFO processing - as opposed to DMA.
 
 Child nodes should conform to I2C bus binding as described in i2c.txt.
 
-- 
2.17.1
