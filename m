From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V3 2/8] soc: qcom: geni: Support for ICC voting
Date: Tue, 31 Mar 2020 16:39:30 +0530
Message-ID: <1585652976-17481-3-git-send-email-akashast@codeaurora.org>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, agross@kernel.org, bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, swboyd@chromium.org, mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, mka@chromium.org, dianders@chromium.org, evgreen@chromium.org, Akash Asthana <akashast@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Add necessary macros and structure variables to support ICC BW
voting from individual SE drivers.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Changes in V2:
 - As per Bjorn's comment dropped enums for ICC paths, given the three
   paths individual members

Changes in V3:
 - Add geni_icc_get, geni_icc_vote_on and geni_icc_vote_off as helper API.
 - Add geni_icc_path structure in common header

 drivers/soc/qcom/qcom-geni-se.c | 98 +++++++++++++++++++++++++++++++++++++++++
 include/linux/qcom-geni-se.h    | 36 +++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 7d622ea..9344c14 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -720,6 +720,104 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
 }
 EXPORT_SYMBOL(geni_se_rx_dma_unprep);
 
+int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
+		const char *icc_ddr)
+{
+	if (icc_core) {
+		se->to_core.path = devm_of_icc_get(se->dev, "qup-core");
+		if (IS_ERR(se->to_core.path))
+			return PTR_ERR(se->to_core.path);
+	}
+
+	if (icc_cpu) {
+		se->from_cpu.path = devm_of_icc_get(se->dev, "qup-config");
+		if (IS_ERR(se->from_cpu.path))
+			return PTR_ERR(se->from_cpu.path);
+	}
+
+	if (icc_ddr) {
+		se->to_ddr.path = devm_of_icc_get(se->dev, "qup-memory");
+		if (IS_ERR(se->to_ddr.path))
+			return PTR_ERR(se->to_ddr.path);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(geni_icc_get);
+
+int geni_icc_vote_on(struct geni_se *se)
+{
+	int ret;
+
+	if (se->to_core.path) {
+		ret = icc_set_bw(se->to_core.path, se->to_core.avg_bw,
+			se->to_core.peak_bw);
+		if (ret) {
+			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for core\n",
+						__func__);
+			return ret;
+		}
+	}
+
+	if (se->from_cpu.path) {
+		ret = icc_set_bw(se->from_cpu.path, se->from_cpu.avg_bw,
+			se->from_cpu.peak_bw);
+		if (ret) {
+			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for cpu\n",
+						__func__);
+			return ret;
+		}
+	}
+
+	if (se->to_ddr.path) {
+		ret = icc_set_bw(se->to_ddr.path, se->to_ddr.avg_bw,
+			se->to_ddr.peak_bw);
+		if (ret) {
+			dev_err_ratelimited(se->dev, "%s: ICC BW voting failed for ddr\n",
+						__func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(geni_icc_vote_on);
+
+int geni_icc_vote_off(struct geni_se *se)
+{
+	int ret;
+
+	if (se->to_core.path) {
+		ret = icc_set_bw(se->to_core.path, 0, 0);
+		if (ret) {
+			dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for core\n",
+						__func__);
+			return ret;
+		}
+	}
+
+	if (se->from_cpu.path) {
+		ret = icc_set_bw(se->from_cpu.path, 0, 0);
+		if (ret) {
+			dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for cpu\n",
+						__func__);
+			return ret;
+		}
+	}
+
+	if (se->to_ddr.path) {
+		ret = icc_set_bw(se->to_ddr.path, 0, 0);
+		if (ret) {
+			dev_err_ratelimited(se->dev, "%s: ICC BW remove failed for ddr\n",
+						__func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(geni_icc_vote_off);
+
 static int geni_se_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index dd46494..a83c86b 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_QCOM_GENI_SE
 #define _LINUX_QCOM_GENI_SE
 
+#include <linux/interconnect.h>
+
 /* Transfer mode supported by GENI Serial Engines */
 enum geni_se_xfer_mode {
 	GENI_SE_INVALID,
@@ -25,6 +27,12 @@ enum geni_se_protocol_type {
 struct geni_wrapper;
 struct clk;
 
+struct geni_icc_path {
+	struct icc_path *path;
+	unsigned int avg_bw;
+	unsigned int peak_bw;
+};
+
 /**
  * struct geni_se - GENI Serial Engine
  * @base:		Base Address of the Serial Engine's register block
@@ -33,6 +41,9 @@ struct clk;
  * @clk:		Handle to the core serial engine clock
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
+ * @to_core:	ICC path structure for geni to core
+ * @from_cpu:	ICC path structure for cpu to geni
+ * @to_ddr:	ICC path structure for geni to ddr
  */
 struct geni_se {
 	void __iomem *base;
@@ -41,6 +52,9 @@ struct geni_se {
 	struct clk *clk;
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
+	struct geni_icc_path to_core;
+	struct geni_icc_path from_cpu;
+	struct geni_icc_path to_ddr;
 };
 
 /* Common SE registers */
@@ -229,6 +243,21 @@ struct geni_se {
 #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
 #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
 
+/*
+ * Define bandwidth thresholds that cause the underlying Core 2X interconnect
+ * clock to run at the named frequency. These baseline values are recommended
+ * by the hardware team, and are not dynamically scaled with GENI bandwidth
+ * beyond basic on/off.
+ */
+#define CORE_2X_19_2_MHZ		960
+#define CORE_2X_50_MHZ			2500
+#define CORE_2X_100_MHZ			5000
+#define CORE_2X_150_MHZ			7500
+#define CORE_2X_200_MHZ			10000
+#define CORE_2X_236_MHZ			16383
+
+#define GENI_DEFAULT_BW			Bps_to_icc(1000)
+
 #if IS_ENABLED(CONFIG_QCOM_GENI_SE)
 
 u32 geni_se_get_qup_hw_version(struct geni_se *se);
@@ -416,5 +445,12 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 void geni_se_tx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len);
 
 void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len);
+
+int geni_icc_get(struct geni_se *se, const char *icc_core, const char *icc_cpu,
+		const char *icc_ddr);
+
+int geni_icc_vote_on(struct geni_se *se);
+
+int geni_icc_vote_off(struct geni_se *se);
 #endif
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
