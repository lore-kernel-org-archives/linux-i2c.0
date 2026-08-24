Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3ED40D587
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570787; cv=none; b=hJ7qxRmrWbXnJu9MEtS05gzM4Kmy+64iktssg5rP02r6SFAdeN9BXe5SyVHkI2bO+xBbm3hDHJd2kOErpdc76oehxqHEZXw6hamY+6ZVVV3Vdc1JwllqV0gCPw73Ngxcs0weQHEYMQMUts0KLMHrtjOnv0EvhN9uuxeACx/bZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570787; c=relaxed/simple;
	bh=WrxAo54F0PNxjIKywqioE+0bNvoyH2vqjLWAaOJpeAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bC8jxcig3YoLw3mReerefNtzGdfSz2/ZznPUj0xa/ykf0PpsnpOrZB8GR0mBYMAEWDeAKVnnU9ztXsRGxTGLiu1hwiqBkrsIUA1MITX4k447HAfH6DrPiwtzwXKUibIpD3NNvBy5Vk64ZQ4xePQdlW9M+ok/+CLXNvmt11GUcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eMOUwrJb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WHUIj0KZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eMOUwrJb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WHUIj0KZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMgUt2864707
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	daDy3e63G0aS4Qk0qxsOt8Z6YU9UhNvw1bujjTlM55w=; b=eMOUwrJb0lXriREP
	lxwqGpXhU3AQt3AmiNDqsYGLWCvIE798QR9AyTHWbsbxOxu012S5l6Z4Vr9XHEky
	M7y4m2nYVPBf6yOGvEeSEyqSlqXX73EFUpo3C12f3odZ+jTwkYonnqYAwvMvMMnI
	J88Bl9wcHlxRVSFB1iDq1hTYhqNW7aO49qJ/Pj8cP2HzHS1Bne2pCl2j5BNYnYzO
	HxS3RDotjMJLLY/Pf3d6o+nVBf98FUhPoa7m30CMF27+5ucun/jc/uO6vOYuUuwc
	loj6pydEqKrzpivFACQVVYGp6IeprrstPf0lRxR6gkLySoQNWAffcl4JL0cdX0mW
	2oyvIw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr26h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:26:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso6012890a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787570784; x=1788175584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daDy3e63G0aS4Qk0qxsOt8Z6YU9UhNvw1bujjTlM55w=;
        b=WHUIj0KZ9izl6phhnVyu2lEGU1w4teZIi30tw7YeA7m8dKk00rBlWyqrtlpj6U/17Z
         s7AzbDseNPPtNzAYolb8l1MPgum0r5C03QrFHsw2JKl2XJH4sFShh+nhZ+07ewO7cQbY
         v7qMSfLRREesI+mM2imf7uOfMcsc/7WHeGEftocGiXR2GJtu8n1HdoL1GJuxTLTwnrXY
         EAY9lB1R62F+y8EK5T47Rbl6VfvAUfvbNYrq/2yzN+eHdoMNnIMg+9raLGsmtwq6yoHH
         TpTRC+3v8NaGOnmxT7Q9gAdZJ194loGj1GSwTO+p/hqo43M6Mn/TG0we8PGJ6xhTip/t
         amrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570784; x=1788175584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daDy3e63G0aS4Qk0qxsOt8Z6YU9UhNvw1bujjTlM55w=;
        b=couVZs8n9gcO2OM2KbMUu2KUQEMbevuY9Ele8QV1iODsxXnj7Q2HXDkUvExm2Gomaq
         5n/k3tvCGoCNSdc5H7tY+3XJ9HNVtNFcjXdIZ+PQc7eGKJp81PhVLRNCxUjxh93V5PZM
         Gok1Wur/zqzUmogb635KigUDN0aaHJgp5Xfl8MbV7npy/vij0DyAkllaDzu0AYlvQJrY
         5aP4B3W1EGAksE9JB7gonN5vNduyZkn+zHq7MszUiRsyjVCCwQsUNOWQesG3sPQLAUla
         ICxjQcd8KxrzpX/yeRkI43uTvCdZL8fGhGk60+6kW2dzunB/dhsX2tRRml/Ys5rACgOp
         NZpw==
X-Forwarded-Encrypted: i=1; AHgh+Rqt0TwMjMwNk1p2DOTLaXfqSmngdfPUGBmvHjYf2C1DB3Ub3d8W+fcms91Rjd2UylD+R4ptDHHu03k=@vger.kernel.org
X-Gm-Message-State: AFuF++n31wcTQqNB8lKaXaNuxoajI4tsIw/4FODnHc4sL9zQSK4UbiYJ
	ZXD24EvePB4y0VCER8qyYFSCjsH27a/y18HxbSoHZ8wEWpOv92MzJkt0Je9jyHdHX/WITJz3zOP
	fS9RsC9UuVukGHRo3zO4OwxkpUfU1krk1g4COLyy0Pa1oej/hcr2+xnBLSpipZ40=
X-Gm-Gg: AR+sD123EVGOBlY8hUJvEumZqA6qlZ9Mmx/5EgZqlVBhC+F83OixbYpGTcrHFhL84li
	ttec95wA5wo2bC7nnfmnyr0PpcUSuJ4Q0wH2mrYe/25zkgD/V1DSAZ+l/1sYn+In677nFqFZ//+
	+JnCuwVpTANDBjuR23H+Tfk7TtEjhvC/xJPvsU1TqtngR6z8gfAsJFj25+76tV8zaXmksbsqB20
	nYaBbVkc79+rK5VZai7H66U4nXu5VlVGVQzZKdViOyd6lckl8qBD3mpzCL9EoEYKWCa/O3hVeN2
	3d35Awl55M4EwkH05XVw1In5d5l8dNG4Mlkkgvwbe1gokhv+C9oIv6skGGgT6+gBtwxFyolNK61
	Rsw1kt6ZLyTlCETGcK+TZIIx92ZCFaQW/zqo=
X-Received: by 2002:a17:90b:58cf:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-395deec0e5amr34549143a91.6.1787570783790;
        Mon, 24 Aug 2026 04:26:23 -0700 (PDT)
X-Received: by 2002:a17:90b:58cf:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-395deec0e5amr34549034a91.6.1787570783254;
        Mon, 24 Aug 2026 04:26:23 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a1597csm9767137a91.13.2026.08.24.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:26:22 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:55:49 +0530
Subject: [PATCH 2/2] i2c: qcom-geni: Add support for I2C High-Speed mode
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-i2c-hs-v1-2-8dd94e5c6113@oss.qualcomm.com>
References: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
In-Reply-To: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570769; l=9461;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=WrxAo54F0PNxjIKywqioE+0bNvoyH2vqjLWAaOJpeAs=;
 b=lbgWB+9vzlrxP8LuBgkhtkArf5m2UFgWqdLEhQqO67h5+wRIMNqTg29M0DELY6xx8QUyAP+2N
 V403qE1+ZA4DyvBm6nOuRXidESL6WG7aoBU4iKMJYZsbbZByF5/D+4+
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NSBTYWx0ZWRfX55kSVIhFdelS
 XVEbrxlPXL3Ey6gtijLnddtYEjbysMywqMhYvOE4lzFFfaHSRDNg15cjUmLqUNbM9yVYwtfCVPe
 FAD6B2+6ocrQKw7BVQ3yhbjQFKe9fJpTz7R/405zs5laKFdQrcdrbX2RT3vfdsjNg6I0OHPa/mY
 zqUsz2cA917L9gmhvO5EZfeaOtVl66JknicXruPxYZ548aq7rjws6cFGRgIuFKk7fjeXVNmP84G
 J0gb9YwC6Y3RTsG6eGMRNygrrDQmge0E18Q0+4Z5TZqyEXIobwc+SBFPFg9diACehMzXlrgB41g
 2pKbe+9O18sXFkgld3zhaHnziq7E6DVnDpxBKNzKQTu5sHywWIyhDK2WGPC6lQgQtyWYklRXp/b
 KsJZwpKa8PveI9qyiHgmAKqYrcGdTY4h7UNWsStIlZqWHkXeMnLumaUo8wEuqbFXqXhlcyxW+2M
 AeunQXSGlzhc9t2QwnA==
X-Proofpoint-GUID: IK1-v8VeB0wX-dUSIhdItojcAbPdbqTD
X-Proofpoint-ORIG-GUID: IK1-v8VeB0wX-dUSIhdItojcAbPdbqTD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NSBTYWx0ZWRfX9cxDlvv9s6ZH
 q001tCV1+hhOqOUqZgkJ8bEGm1wlcmHiWfiKCBn45pPjjCJR5qR3aZUZZujzgpht8UFvAZPehGU
 OaQYEYwNizkdwe5Se/lX5+3LcP/Gxzs=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c2a60 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CVQZEhLW7cNm6rAVh1IA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240095

Implement I2C High-Speed (HS) mode for the Qualcomm GENI I2C controller.
Detect HS mode requests based on 3.4 MHz frequency and configure the
hardware accordingly. When HS mode is active, set the source clock to
100 MHz and program timing parameters (TCYCLE=28, TLOW=38).

For FIFO/SE-DMA transfers, use HS-specific opcodes I2C_HS_WRITE (0xa)
and I2C_HS_READ (0xb). Transmit the master code at Fast Mode Plus
timing (1 MHz) before switching to 3.4 MHz for data transfer.

For GPI DMA, extend the configuration with a CONFIG1 TRE to pass HS
timing parameters to the DMA engine. Add gpi_i2c_config1 with
tcycle_cnt and tlow_cnt fields (defaults: 28 and 38).
Use the set_config1 flag in gpi_i2c_config to send CONFIG1 TRE before
the GO TRE in HS mode.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 133 +++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..3712e0dd9e68 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -21,9 +21,21 @@
 #include <linux/spinlock.h>
 #include <linux/units.h>
 
+#define SE_GENI_CFG_REG68		0x210
+#define SE_I2C_HS_TLOW_REG		0x268
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
 #define SE_I2C_SCL_COUNTERS		0x278
+#define SE_I2C_HS_TCYCLE_REG		0x27c
+
+/* I2C High-Speed mode definitions */
+#define I2C_HS_MODE_FREQ		3400000
+#define I2C_HS_SRC_CLK_FREQ		(100 * HZ_PER_MHZ)
+#define I2C_HS_TCYCLE_CNT		28
+#define I2C_HS_TLOW_CNT			38
+/* I2C HS mode support requires QUPv3 core version >= 4.3 per HPG */
+#define QUP_I2C_HS_MIN_MAJOR		4
+#define QUP_I2C_HS_MIN_MINOR		3
 
 #define SE_I2C_ERR  (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |\
 			M_GP_IRQ_1_EN | M_GP_IRQ_3_EN | M_GP_IRQ_4_EN)
@@ -36,6 +48,9 @@
 #define I2C_ADDR_ONLY		0x4
 #define I2C_BUS_CLEAR		0x6
 #define I2C_STOP_ON_BUS		0x7
+#define I2C_HS_WRITE		0xa
+#define I2C_HS_READ		0xb
+
 /* M_CMD params for I2C */
 #define PRE_CMD_DELAY		BIT(0)
 #define TIMESTAMP_BEFORE	BIT(1)
@@ -138,6 +153,9 @@ struct geni_i2c_dev {
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
 	const struct geni_i2c_desc *dev_data;
+	bool is_hs_mode;
+	bool config1_sent;
+	u32 dfs_index;
 };
 
 struct geni_i2c_err_log {
@@ -162,9 +180,14 @@ static const struct geni_i2c_err_log gi2c_log[] = {
 struct geni_i2c_clk_fld {
 	u32	clk_freq_out;
 	u8	clk_div;
-	u8	t_high_cnt;
-	u8	t_low_cnt;
-	u8	t_cycle_cnt;
+	/*
+	 * In normal mode, these counter values fit within 8 bits.
+	 * In High-Speed mode, HS_TLOW_COUNT and HS_TCYCLE_COUNT are
+	 * 10-bit fields, so u16 is required.
+	 */
+	u16	t_high_cnt;
+	u16	t_low_cnt;
+	u16	t_cycle_cnt;
 };
 
 /*
@@ -194,10 +217,30 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 	{}
 };
 
+/* source_clock = 100 MHz */
+static const struct geni_i2c_clk_fld geni_i2c_clk_map_100mhz[] = {
+	{ I2C_MAX_STANDARD_MODE_FREQ, 1, 449, 548, 998 },
+	{ I2C_MAX_FAST_MODE_FREQ, 1, 76, 167, 248 },
+	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 23, 59, 98 },
+	{}
+};
+
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
 
+	/* Check if HS mode is requested */
+	if (gi2c->clk_freq_out == I2C_HS_MODE_FREQ) {
+		gi2c->is_hs_mode = true;
+		/* For HS mode, source clock should be 100 MHz */
+		itr = geni_i2c_clk_map_100mhz;
+		/* For HS mode, start with 1MHz for master code */
+		gi2c->clk_fld = &itr[2];
+		return 0;
+	}
+
+	gi2c->is_hs_mode = false;
+
 	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
 		itr = geni_i2c_clk_map_32mhz;
 	else
@@ -219,7 +262,12 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	if (gi2c->is_hs_mode) {
+		writel_relaxed(I2C_HS_TCYCLE_CNT, gi2c->se.base + SE_I2C_HS_TCYCLE_REG);
+		writel_relaxed(I2C_HS_TLOW_CNT, gi2c->se.base + SE_I2C_HS_TLOW_REG);
+	}
+
+	writel_relaxed(gi2c->dfs_index, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -500,7 +548,11 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		geni_se_select_mode(se, GENI_SE_FIFO);
 
 	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
-	geni_se_setup_m_cmd(se, I2C_READ, m_param);
+
+	if (gi2c->is_hs_mode)
+		geni_se_setup_m_cmd(se, I2C_HS_READ, m_param);
+	else
+		geni_se_setup_m_cmd(se, I2C_READ, m_param);
 
 	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
 		geni_se_select_mode(se, GENI_SE_FIFO);
@@ -539,7 +591,11 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		geni_se_select_mode(se, GENI_SE_FIFO);
 
 	writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
-	geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
+
+	if (gi2c->is_hs_mode)
+		geni_se_setup_m_cmd(se, I2C_HS_WRITE, m_param);
+	else
+		geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
 
 	if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
 		geni_se_select_mode(se, GENI_SE_FIFO);
@@ -700,7 +756,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		goto out;
 	}
 
-	if (op == I2C_WRITE)
+	if (op == I2C_WRITE || op == I2C_HS_WRITE)
 		map_dirn = DMA_TO_DEVICE;
 	else
 		map_dirn = DMA_FROM_DEVICE;
@@ -737,7 +793,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 	peripheral->set_config = 0;
 	peripheral->multi_msg = true;
 
-	if (op == I2C_WRITE)
+	if (op == I2C_WRITE || op == I2C_HS_WRITE)
 		dma_dirn = DMA_MEM_TO_DEV;
 	else
 		dma_dirn = DMA_DEV_TO_MEM;
@@ -827,6 +883,7 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	peripheral.high_count = itr->t_high_cnt;
 	peripheral.low_count = itr->t_low_cnt;
 	peripheral.clk_div = itr->clk_div;
+	peripheral.clk_src = gi2c->dfs_index;
 	peripheral.set_config = 1;
 	peripheral.multi_msg = false;
 
@@ -836,6 +893,13 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 
 	gi2c->num_msgs = num;
 	gi2c->is_tx_multi_desc_xfer = false;
+	gi2c->config1_sent = false;
+
+	/* Initialize config1 TRE settings for HS mode */
+	if (gi2c->is_hs_mode) {
+		peripheral.config1.tcycle_cnt = I2C_HS_TCYCLE_CNT;
+		peripheral.config1.tlow_cnt = I2C_HS_TLOW_CNT;
+	}
 
 	tx_multi_xfer = &gi2c->i2c_multi_desc_config;
 	memset(tx_multi_xfer, 0, sizeof(struct geni_i2c_gpi_multi_desc_xfer));
@@ -883,14 +947,25 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 		if (i > 0 && (!(msgs[i].flags & I2C_M_RD)))
 			peripheral.multi_msg = false;
 
-		ret =  geni_i2c_gpi(gi2c, msgs, &config,
-				    &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
+		/* Set config1 TRE only for HS mode */
+		if (gi2c->is_hs_mode && !gi2c->config1_sent) {
+			peripheral.set_config1 = 1;
+			gi2c->config1_sent = true;
+		} else {
+			peripheral.set_config1 = 0;
+		}
+
+		ret =  geni_i2c_gpi(gi2c, msgs, &config, &tx_addr, &tx_buf,
+				    gi2c->is_hs_mode ? I2C_HS_WRITE : I2C_WRITE, gi2c->tx_c);
 		if (ret)
 			goto err;
 
+		/* CONFIG1 TRE is only for the TX channel; clear before RX call */
+		peripheral.set_config1 = 0;
+
 		if (msgs[i].flags & I2C_M_RD) {
-			ret =  geni_i2c_gpi(gi2c, msgs, &config,
-					    &rx_addr, &rx_buf, I2C_READ, gi2c->rx_c);
+			ret =  geni_i2c_gpi(gi2c, msgs, &config, &rx_addr, &rx_buf,
+					    gi2c->is_hs_mode ? I2C_HS_READ : I2C_READ, gi2c->rx_c);
 			if (ret)
 				goto err;
 
@@ -1037,6 +1112,7 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
 	u32 proto, tx_depth;
+	unsigned long freq_out;
 	bool fifo_disable;
 	int ret;
 
@@ -1046,6 +1122,39 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		return ret;
 	}
 
+	/*
+	 * For I2C High-Speed mode, first verify QUP HW version supports it
+	 * (requires QUPv3 core >= 4.3 per HPG), then configure 100 MHz source clock.
+	 */
+	if (gi2c->is_hs_mode) {
+		u32 hw_ver = geni_se_get_qup_hw_version(&gi2c->se);
+		u32 major = GENI_SE_VERSION_MAJOR(hw_ver);
+		u32 minor = GENI_SE_VERSION_MINOR(hw_ver);
+
+		if (major < QUP_I2C_HS_MIN_MAJOR ||
+		    (major == QUP_I2C_HS_MIN_MAJOR && minor < QUP_I2C_HS_MIN_MINOR)) {
+			dev_err(gi2c->se.dev,
+				"QUP HW v%u.%u does not support I2C HS mode (requires >= %u.%u)\n",
+				major, minor,
+				QUP_I2C_HS_MIN_MAJOR, QUP_I2C_HS_MIN_MINOR);
+			ret = -EOPNOTSUPP;
+			goto err;
+		}
+
+		ret = geni_se_clk_freq_match(&gi2c->se, I2C_HS_SRC_CLK_FREQ,
+					     &gi2c->dfs_index, &freq_out, false);
+		if (ret) {
+			dev_err(gi2c->se.dev, "Failed to get DFS index for HS mode: %d\n", ret);
+			goto err;
+		}
+
+		ret = clk_set_rate(gi2c->se.clk, freq_out);
+		if (ret) {
+			dev_err(gi2c->se.dev, "Failed to set HS mode clock rate: %d\n", ret);
+			goto err;
+		}
+	}
+
 	proto = geni_se_read_proto(&gi2c->se);
 	if (proto == GENI_SE_INVALID_PROTO) {
 		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);

-- 
2.34.1

