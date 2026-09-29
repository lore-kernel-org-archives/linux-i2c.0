Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927951D532
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684762; cv=none; b=UrOF/FJ3bou1zj6rJQZtt2YDw0eDTf3QMvwYp5argSI0IMlosgEGFch31dLPgM2tFH3eHDe0GHqyQk4n/8IA5iA7/AhsiGyW3y6Bq7dwPEJn5/cQ6fjGBw+4RMmRK/R8ms/bHLUX0yeAMbluSRPXBR4P67tGYdtT+erb0fkMP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684762; c=relaxed/simple;
	bh=VB1fq1RKiKGVJL/jXTuCtxqg6mIar30rpelwiVPPn4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fn8kRn7YDHpx9nR4eP04TcAcX5C1Au1CVSDOSONwJWLZGAxMlKhVTzo2YCmjKQG3fffcaJw5DM7ngrbmfiftesQ7BMionrrNpE+xGzDXb0UwHRXCUOAynRVz1guheQcZQ1MMm4FTN5A7Kc6uELUYQaA/M+qraM3zf1LvsiGCmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMYVkWXT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aV7agCs4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMYVkWXT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aV7agCs4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCE7on528979
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Zd8H7pUQjwRPH2i35MnsVti9s3z6U0qbD41nLQ6bk4=; b=YMYVkWXTo2z2PNEj
	zV3iLKsbKemrzIx7Q1db+emmf7YZ/da6h04bH/qDFWcElGDBScFOptnChrONOtp8
	Y0mY6l+gd6S2d0gkffkthpZ/oe7A4KzcNZeksP0p0BORInYfGvMX8hinsUuNsii/
	Z8+EOzb21TDnDTBxJVWiPz3XzFJgU0c9H0eX2vriqfRcC1l0ZqDsLQirB/0FlGQX
	ooKlzWDmZQjy8Ws2l01Ffy2cmoc8pwzUwKmH7H1SAdr+lv34I+Dw70cBOzVWZTU+
	Ju8MtJNi4kNgqjyd/xJKyUQ82Nc3VfGz5hhll538nD1PkMsMwmdrWU1sK33bUtbz
	73gS1A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew2d92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9123be39eeaso85988876d6.2
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790684757; x=1791289557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Zd8H7pUQjwRPH2i35MnsVti9s3z6U0qbD41nLQ6bk4=;
        b=aV7agCs4o59hCS/5z1sI8DYqtkRcYMqggkarIqiK+B2SNbuftD4Jkimfu27NXkct4m
         eUHOpqE6lxSgP36EzWm+L/DJ3EJy41LryhJJwVxGfZfqXixuYKpZxcr7jfFGEXuTdfO1
         Zh0GUpqIpRAUWH4dLG4pKZUPN4Ge5BASWOBGfTwAVsjPDfaN3Iwdi1Uv27sH1zQSD95U
         HcGwKBG38X/N4jA624JvQUbGxf+SUAfyHeF7bJDTcdBhQkxq9BpE2wEJwPL7Se0cICtj
         vVZRJjtIMR9xkxLGrpfdEM3C74/H78JlRkUj0+u7n2wcC7TKELv7wSfjTxuJc3pL6rKB
         bnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684757; x=1791289557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Zd8H7pUQjwRPH2i35MnsVti9s3z6U0qbD41nLQ6bk4=;
        b=SRW3/4osb5CYe5jyzokHoEJTvK6uGe1VrHP0fNleFNHJecq08S+KpUzCRkQGMCdi0i
         fMNKXgS4ZVRgmGNlJDaiqDLIS/4wncz+UXG+fga3BdXA0BrGhVX6U5xZZb4hfXbKggLf
         9X1Yu2+2aF1bnsgkyFFiGBVvIxTdc75/Vw2wAuIY2ArdNRJ9fK9pCzVA+JaQu0KEEnD5
         wCuC1FPX2CJr46+sZtb3RMPF9Lajro8cTlci3N7Nj7vZD4DIwO/GyABsKeYmaETDOJxi
         v5LwlKhX256ON6Ypf10fE60AY6NMGCExWuiRtb8TzaBgwMZdCINXzJLtDnKJGra4w2T3
         Yk7g==
X-Gm-Message-State: AFuF++lWzVT/gk+atf0YGG0jNW71s1x1DYHMoN6fUDQvRcZOUL4r3xb1
	oRD2GY3ky6XMJk0G1dzBcSDLGZEHy3DOe8mammLQ5034xMAswrsJ4mgfpCHnz5tUs7RVEM4ONr4
	UyT37JQUG3vEHcmcwA3ElQOD4knADUhJw3zjh1cPkeN2NENssbS63rsF++I9/BG0=
X-Gm-Gg: AYBFou1Ai4Fv+lu3R9OqAicfO4VbJ+hzjVBcsdqqSd3WnniiUUKnJIIIlVvI8nDNSNP
	sogWHZXHgKAIbE2l2OmFuz97+ozaMVo6CL3dsSyorrTJydUY3oXVqvC54B9tXzPWrx2bk9cHWGQ
	0+J8buef+zB3eS4+uk17nDMSHejZCSOWVZBZMJLTpmMaeA4HpZ8FqUbjBXyZ4eaTAoCYiW/S4X3
	hBWoLXup/ZFrLHjK4Y/x4DcSBj1Lb093z56StnrM2f0byxx7nZYJ5a2pt6QGjvN9IGjPL35FeB1
	12263uwy1tVrvgQAvszIcreK7nEnxZcILGj6bQMBVqMnJm8xbvvcu+/Rl0k8aoR0kWhnC98S18A
	D6/1zM2igByjC8zaH7a8bg8beROezbRjodMN7Ws3mFDBRrIhLAI+7Rx1JZlnfyXRZqHiEjNmKeY
	mhbtRZSvzXAT0RiS+JCtQ7XdX2B5/1Wh3zjwR2R6kyPHPnisVVfYk=
X-Received: by 2002:a05:6214:2528:b0:914:4c57:510e with SMTP id 6a1803df08f44-9144c577f72mr184412436d6.19.1790684756514;
        Tue, 29 Sep 2026 05:25:56 -0700 (PDT)
X-Received: by 2002:a05:6214:2528:b0:914:4c57:510e with SMTP id 6a1803df08f44-9144c577f72mr184411926d6.19.1790684756033;
        Tue, 29 Sep 2026 05:25:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d302482sm9103956d6.12.2026.09.29.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:25:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:25:46 +0200
Subject: [PATCH v6 2/5] i2c: qcom-cci: Support per-mode CCI clock rates
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-cci-clk-fix-v6-2-62a268cccb0f@oss.qualcomm.com>
References: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>
In-Reply-To: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX0WsnyQXMsSCL
 GsWof+p0X1InZyBNv6YUwZYbMQ33Fg59PEIRtj43xtMFcVNyZOSV2pPshcluU3za5vTWwJZTdtx
 IFeAbtz/YCE23pKZx3ACrqkgK5V9Q+w=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbae55 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=xxoTSpZZo30Qa_5IT24A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX+7/ZM6Qh2OTw
 fDZfepzLPMQO9IL/HmvA758G0SdO0zqqE0Tv2VTeptmB/q5MCyMHx8423thJULrOluxXEwcraPy
 1AKLYdk+2i6jSnssSRNENl1H2wprixiJy85pgHtyWfmSk50DmK0QlyIvTGDGOWI+rtrfPuQqr2m
 bVrsIldtRJM7ogMJYNx7NAl+6aeVSSwv+HSTjgxL1O946Be7yqKF7MybL0GwwWm6TNFNAdnpVya
 pftCG5RjB3WEQxNM5mp3okwBKOisWHlXaAzun+H8Ynkq39oJIEnAaI5pW/rjsqESXGtMaMHna5X
 MNbFH/RqNiBCRIK7lqANjRr8E4GxexaB9XtCgs4rnC+ZciGveEdDFaDXxSzjFCGm1pXi1ao7MSs
 budUmncPiORVpSRTYWWd+ol8exe892tdo4FkakEQY9X/BNljl/e89KPDZhk+/jAF2eaLhHpIL9z
 5WsJen3iFzp4yC5YCXQ==
X-Proofpoint-GUID: -J2lWDkd0ngA33OV9XH38CG2z_6nIZiy
X-Proofpoint-ORIG-GUID: -J2lWDkd0ngA33OV9XH38CG2z_6nIZiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049

The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
clock ticks and are only valid at the specific CCI clock rate they were
calibrated for. Different I2C modes may be calibrated for different
rates, and the single CCI clock is shared by all masters.

Turn the timing table into a two-dimensional [rate][mode] matrix so a
given rate can carry timing sets for each mode, and select the entry
matching the currently running clock rate at init time. The existing
per-variant values are moved under their calibrated rate (19.2 MHz for
v1/v1.5, 37.5 MHz for v2), no timing values are changed.

At this stage the driver only validates the running rate against the
table, the timings are only valid at the exact rate they were calibrated
for, so if the current rate has no matching entry for a master's mode,
fail initialization rather than program incorrect timings. A following
patch actively enforces the required rate so this becomes a safety net.

Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 74 +++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 0a216c4d08114f267c8441925e8811ca64f1a909..1092ce0371429ef64c7cc44cc23a42ba4c135af5 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -82,6 +82,13 @@ enum {
 	I2C_MODE_STANDARD,
 	I2C_MODE_FAST,
 	I2C_MODE_FAST_PLUS,
+	NUM_I2C_MODES,
+};
+
+enum {
+	CCI_CLK_RATE_19_2MHZ,
+	CCI_CLK_RATE_37_5MHZ,
+	NUM_CCI_CLK_RATES,
 };
 
 enum cci_i2c_queue_t {
@@ -117,7 +124,7 @@ struct cci_data {
 	unsigned int num_masters;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
-	struct hw_params params[3];
+	struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
 };
 
 struct cci {
@@ -127,6 +134,7 @@ struct cci {
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
+	struct clk *cci_clk;
 	struct cci_master master[NUM_MASTERS];
 };
 
@@ -225,7 +233,34 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	return 0;
 }
 
-static void cci_init(struct cci *cci)
+static const unsigned long cci_clk_rates[NUM_CCI_CLK_RATES] = {
+	[CCI_CLK_RATE_19_2MHZ] = 19200000,
+	[CCI_CLK_RATE_37_5MHZ] = 37500000,
+};
+
+static int cci_clk_rate_idx(unsigned long rate)
+{
+	int i;
+
+	for (i = 0; i < NUM_CCI_CLK_RATES; i++)
+		if (cci_clk_rates[i] == rate)
+			return i;
+
+	return -EINVAL;
+}
+
+static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
+{
+	unsigned long rate = clk_get_rate(cci->cci_clk);
+	int ri = cci_clk_rate_idx(rate);
+
+	if (ri >= 0 && cci->data->params[ri][mode].thigh)
+		return &cci->data->params[ri][mode];
+
+	return NULL;
+}
+
+static int cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -249,7 +284,12 @@ static void cci_init(struct cci *cci)
 		if (!cci->master[i].cci)
 			continue;
 
-		hw = &cci->data->params[mode];
+		hw = cci_get_hw_params(cci, mode);
+		if (!hw) {
+			dev_err(cci->dev, "no timing for mode %d at CCI clock %lu Hz\n",
+				mode, clk_get_rate(cci->cci_clk));
+			return -EOPNOTSUPP;
+		}
 
 		val = hw->thigh << 16 | hw->tlow;
 		writel(val, cci->base + CCI_I2C_Mm_SCL_CTL(i));
@@ -266,6 +306,8 @@ static void cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
+
+	return 0;
 }
 
 static int cci_reset(struct cci *cci)
@@ -283,9 +325,7 @@ static int cci_reset(struct cci *cci)
 		return -ETIMEDOUT;
 	}
 
-	cci_init(cci);
-
-	return 0;
+	return cci_init(cci);
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -488,8 +528,7 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	if (ret)
 		return ret;
 
-	cci_init(cci);
-	return 0;
+	return cci_init(cci);
 }
 
 static const struct dev_pm_ops qcom_cci_pm = {
@@ -570,6 +609,11 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
 	cci->nclocks = ret;
 
+	cci->cci_clk = devm_clk_get(dev, "cci");
+	if (IS_ERR(cci->cci_clk))
+		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
+				     "failed to get CCI clock\n");
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
@@ -652,7 +696,7 @@ static const struct cci_data cci_v1_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
 		.tsu_sto = 28,
@@ -664,7 +708,7 @@ static const struct cci_data cci_v1_data = {
 		.trdhld = 6,
 		.tsp = 1
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
 		.thigh = 20,
 		.tlow = 28,
 		.tsu_sto = 21,
@@ -685,7 +729,7 @@ static const struct cci_data cci_v1_5_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
 		.tsu_sto = 28,
@@ -697,7 +741,7 @@ static const struct cci_data cci_v1_5_data = {
 		.trdhld = 6,
 		.tsp = 1
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
 		.thigh = 20,
 		.tlow = 28,
 		.tsu_sto = 21,
@@ -718,7 +762,7 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,
 		.tsu_sto = 204,
@@ -730,7 +774,7 @@ static const struct cci_data cci_v2_data = {
 		.trdhld = 6,
 		.tsp = 3
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
 		.thigh = 38,
 		.tlow = 56,
 		.tsu_sto = 40,
@@ -742,7 +786,7 @@ static const struct cci_data cci_v2_data = {
 		.trdhld = 6,
 		.tsp = 3
 	},
-	.params[I2C_MODE_FAST_PLUS] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
 		.thigh = 16,
 		.tlow = 22,
 		.tsu_sto = 17,

-- 
2.34.1

