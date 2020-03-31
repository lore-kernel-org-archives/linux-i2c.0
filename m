From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V3 4/8] i2c: i2c-qcom-geni: Add interconnect support
Date: Tue, 31 Mar 2020 16:39:32 +0530
Message-ID: <1585652976-17481-5-git-send-email-akashast@codeaurora.org>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, agross@kernel.org, bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, swboyd@chromium.org, mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, mka@chromium.org, dianders@chromium.org, evgreen@chromium.org, Akash Asthana <akashast@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Get the interconnect paths for I2C based Serial Engine device
and vote according to the bus speed of the driver.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Changes in V2:
 - As per Bjorn's comment, removed se == NULL check from geni_i2c_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

Changes in V3:
 - As per Matthias comment, use common library APIs defined in geni-se
   driver for ICC functionality.

 drivers/i2c/busses/i2c-qcom-geni.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 18d1e4f..373c2ca 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -557,6 +557,26 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	gi2c->adap.dev.of_node = dev->of_node;
 	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
+	ret = geni_icc_get(&gi2c->se, "qup-core", "qup-config", "qup-memory");
+	if (ret)
+		return ret;
+	/*
+	 * Set the bus quota for core and cpu to a reasonable value for
+	 * register access.
+	 * Set quota for DDR based on bus speed, assume peak requirement
+	 * as twice of avg bw.
+	 */
+	gi2c->se.to_core.avg_bw = GENI_DEFAULT_BW;
+	gi2c->se.to_core.peak_bw = Bps_to_icc(CORE_2X_100_MHZ);
+	gi2c->se.from_cpu.avg_bw = GENI_DEFAULT_BW;
+	gi2c->se.from_cpu.peak_bw = GENI_DEFAULT_BW;
+	gi2c->se.to_ddr.avg_bw = Bps_to_icc(gi2c->clk_freq_out);
+	gi2c->se.to_ddr.peak_bw = Bps_to_icc(2 * gi2c->clk_freq_out);
+
+	ret = geni_icc_vote_on(&gi2c->se);
+	if (ret)
+		return ret;
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {
 		dev_err(dev, "Error turning on resources %d\n", ret);
@@ -579,6 +599,10 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = geni_icc_vote_off(&gi2c->se);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
 	gi2c->suspended = 1;
@@ -623,7 +647,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
-	return 0;
+	return geni_icc_vote_off(&gi2c->se);
 }
 
 static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
@@ -631,6 +655,10 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	ret = geni_icc_vote_on(&gi2c->se);
+	if (ret)
+		return ret;
+
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
