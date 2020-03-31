From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V3 5/8] spi: spi-geni-qcom: Add interconnect support
Date: Tue, 31 Mar 2020 16:39:33 +0530
Message-ID: <1585652976-17481-6-git-send-email-akashast@codeaurora.org>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail27.static.mailgun.info ([104.130.122.27]:40823 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730683AbgCaLM1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 Mar 2020 07:12:27 -0400
In-Reply-To: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: gregkh@linuxfoundation.org, agross@kernel.org, bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, swboyd@chromium.org, mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, mka@chromium.org, dianders@chromium.org, evgreen@chromium.org, Akash Asthana <akashast@codeaurora.org>

Get the interconnect paths for SPI based Serial Engine device
and vote according to the current bus speed of the driver.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Changes in V2:
 - As per Bjorn's comment, removed se == NULL check from geni_spi_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

Changes in V3:
 - As per Matthias's comment, use helper ICC function from geni-se driver.

 drivers/spi/spi-geni-qcom.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c397242..f1dae2d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -234,6 +234,16 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 		return ret;
 	}
 
+	/*
+	 * Set BW quota for CPU as driver supports FIFO mode only.
+	 * Assume peak bw as twice of avg bw.
+	 */
+	se->from_cpu.avg_bw = Bps_to_icc(mas->cur_speed_hz);
+	se->from_cpu.peak_bw = Bps_to_icc(2 * mas->cur_speed_hz);
+	ret = geni_icc_vote_on(se);
+	if (ret)
+		return ret;
+
 	clk_sel = idx & CLK_SEL_MSK;
 	m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
 	spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
@@ -578,6 +588,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_enable(dev);
 
+	ret = geni_icc_get(&mas->se, "qup-core", "qup-config", NULL);
+	if (ret)
+		goto spi_geni_probe_runtime_disable;
+	/* Set the bus quota to a reasonable value for register access */
+	mas->se.to_core.avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
+	mas->se.to_core.peak_bw = Bps_to_icc(CORE_2X_100_MHZ);
+	mas->se.from_cpu.avg_bw = GENI_DEFAULT_BW;
+	mas->se.from_cpu.peak_bw = GENI_DEFAULT_BW;
+
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
@@ -616,14 +635,24 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
+
+	ret = geni_se_resources_off(&mas->se);
+	if (ret)
+		return ret;
 
-	return geni_se_resources_off(&mas->se);
+	return geni_icc_vote_off(&mas->se);
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 {
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
+
+	ret = geni_icc_vote_on(&mas->se);
+	if (ret)
+		return ret;
 
 	return geni_se_resources_on(&mas->se);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
