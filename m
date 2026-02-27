Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723E36896C
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173028; cv=none; b=DKUWooA5CW42WzXPPOuSUz4hsEBZj7ov51bXI2qWUlOZS0CMZHg8/NxT3kbaVPLhNH6OiyuFt9ozqIkZaBiUOR9oRfO4w3jpWaAeVb2ex5aR2CSFApcZQ+FwSUhla0Dgq8CaCrIf5YIa1wLZwF/rTVruKCfg6euA5JVsNXo+De4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173028; c=relaxed/simple;
	bh=4hz8Y0hFl09FGAeyghc3sPRwLZBvCKBMPVpOSPqaB18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHmkM7LHSAazEyvKE4DPdPAqB1Ps4zPBIuhsEzR+IHYixiaYxRkqmaplUpuFJQqMVFA45qEaQM92PVhXbv0OqjCFtecRDFNHj9tPajDYGIkwQsFk41ku1tJXo5FG+n5rZUhICbN39y4GkK0LdsjTSuYR4pBJwP8XTWkT/OwXbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Edsnqcay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=exO/4vm+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Edsnqcay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="exO/4vm+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2LFEP1876531
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UVNp5rZqQkb
	HIr5aTVOiOMEIXz0PRqXEj234Ie4S1cU=; b=EdsnqcayOsD+TfAWit70Rm+UA38
	qK+xj0t8pmLfPwHxFKr9Mst2qaYQTVyqY24Mpgt6cmvcxLAMVoN9pHYD6lnfzW6L
	znH52J1NcmHJapRAFNlTDO+SwBsLe+uxIpj/su00x4X7RQWhrvpApvR/keftoqaV
	4CGlJm/ZzvylubnzYYGEffLUFR4P2HzTUhpa2R9MC84nBuKNjyUBYkVnvzF37XJs
	qZDwJ/NBtaEGgjq5P1I6eY4SFeLe6Gko0lHQEe+WCUUuup9l8RhoF3KF5WeVlLdk
	qF91+mIHI3g5Kg86z+4UbQM7Masbx1uaaAP3YmPQP7nbrs+ek9H4Br2gRtg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuytstqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:17:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adc527eaf5so1675605ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772173025; x=1772777825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVNp5rZqQkbHIr5aTVOiOMEIXz0PRqXEj234Ie4S1cU=;
        b=exO/4vm+G7RxYx+WA0l53aFbliI05pPMKG2SJY7exb85gARgeUy0h5TewXPue7ZIH4
         6AWxfDhaUhOxDZNR8HzxOi86b+6jrfgbgdcKwJqAa7GFMvRs+3krDLZqpsQzRnM+Xr4L
         +hxVCdPDkxz29gCbOJF50u5t6KzUZWW6qETHVvHU4H42jE8+IIwTTaJTH+WxEEKFdN0u
         h1H+jD3JVE/SAypRorBDrDTyVkiZS+IKxENh/eB+CXxZDE7avQVv+FNDT13/O9FKUYrx
         8GsvvPmdRtfzDUhTgYLBm4RO3AUbdu/SL/n/N83MxAWU2dM9Zl4oiB4mLKEpZ6Z55BPp
         oMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173025; x=1772777825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVNp5rZqQkbHIr5aTVOiOMEIXz0PRqXEj234Ie4S1cU=;
        b=IsO9muN9GXTQCfid8UdytqIEjEC1MjH0VXhfaSr72qHMaIez77zE8ZRqUT/KBuo79w
         ziaquqbh2wbf/NB5v/uUxsAfQn0kJe/KidXh+jZXlqJ3HgvfJeA8JuuRatQ2UPqqe1Yp
         HrHrI02LpH0k1qbmJ94Xe0F+PojNUo/90yovtaSt5nYo7pw8jPY5Vvh9Nx4prHdD0goq
         dfhuGyt8LNUtyrAkc/xC93EN5tUzK+C9TIXWJfF9vC8z6On8CYG+6tjxTNwbL5xJouVw
         qnTQoD8N11OcEK89sIOiC+3AjuyVLtqI+S0ix1q6tPPJ9kTKBr7JkUarPBVY46oNIFh8
         UiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx3DYINSrOwWYxHoS8wiLbcmHiocrKyExFX6a+sldiXgdcOuTEHduMZwDpHZtZ9NxxWsy4EfoUM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJh+v7UrcTAm32gA2UdOzxflhxEObTdjQsI9ULB41U9xYgYNx
	m0DPOu45yMY3rh61dA+xHgn2UOiPP768+Aqk5kUspMnyxGyW/INBWHP6cT3Dpujs82o8JvgPHE0
	kt+XlCotm/aUcAVE2MREuQi1p53Z3Xrqo0KPysasGNYnWDgavtwclBoxSgXvO4sg=
X-Gm-Gg: ATEYQzwS+qh6X3PnWFKpTFq8qMdsAolEpdmlEbxNFbJ3NLGNoqT0fxpfnXUX/uNd8KS
	fQjqi0B8q/AZmLHpY011t42s5JLFwHTkRCuoyty9oDB/nfm83PABB7WKvmOqX/VPOpfKsZPrhHF
	+Wi84pKvLgvNCh/vDsiREvwsrDjaA4UivibRsFyqBR/0z3u0FB4TDQnL68QPAFKtsOv3SwCovg0
	cQGdR6mmKYNUfTP5IBm6Ah4GWpAVqXOL2CZLFikiQDftm0y09rwRWSxm7dI3jpg+3U5Rva75alD
	eFId4Oc7QPvSyzXJTibfZJgbrLUXNPQJuxvaMX4bOTha3ZSNCd+uFEXeOxEBv8ugC7RKiCi+Ezi
	/o13FSo85TPiTQZ3FQNju8uA5JjQ0hlLW/Vl6JeS2ptD3kAe+/9ryPYI=
X-Received: by 2002:a17:903:1a6b:b0:2ad:ae4e:bb6a with SMTP id d9443c01a7336-2ae2e279cb6mr17029295ad.24.1772173024701;
        Thu, 26 Feb 2026 22:17:04 -0800 (PST)
X-Received: by 2002:a17:903:1a6b:b0:2ad:ae4e:bb6a with SMTP id d9443c01a7336-2ae2e279cb6mr17028935ad.24.1772173024124;
        Thu, 26 Feb 2026 22:17:04 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:17:03 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
Subject: [PATCH v6 10/13] i2c: qcom-geni: Move resource initialization to separate function
Date: Fri, 27 Feb 2026 11:45:41 +0530
Message-Id: <20260227061544.1785978-11-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJIb4f+Z c=1 sm=1 tr=0 ts=69a136e1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=T4QVXHuY6bPIseVWQ88A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: gWMM2Y_Zgj_1dJ8kKo6fCOgXUnmGf5wf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfXxRwXKzdDmCOu
 KxhaCML/wODCAeIfo5mV2TcDq6nS5ik6khFxZ4XHNVWauFnV8+70v7BpLyTZeeKKmAlxbIX1Gr4
 auZ3OY1/7ivuFacpVijnNRbI4qc9zsk4W6w4pNH/MAdqJHWQ/fG3Feq1MI9uQ+5nz9yOx9qyh1G
 BGeNhXQg9X9BJxu5s/hvg7MiVB58PsSaHuauv0UkO9FoAnSaOeNUmUk74QgYvurE1EWN+0J5wnF
 1HciwyTfBfGlMfMbq+wByIlEH4aFqBYIxzFxjBIt+E5LJDLgBouoOBi7PSjmb6yDlkx79OwzOJ8
 zpfXfH41p2y2hMck5hlaJBFFzEWZ0f2T/4dDKDAqoM/VHvqHNHEMqasoM3VwSKRo6aw0RFjRSnm
 Uz9tVPY8PF82dHWH5PDYp9jFASivack53aGAT6VQ8D7xLQOD9PkE5INhANnLrw+lnLTmvfPcIYu
 tWRhEE/Yf7+whhV0sGw==
X-Proofpoint-GUID: gWMM2Y_Zgj_1dJ8kKo6fCOgXUnmGf5wf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

Refactor the resource initialization in geni_i2c_probe() by introducing
a new geni_i2c_resources_init() function and utilizing the common
geni_se_resources_init() framework and clock frequency mapping, making the
probe function cleaner.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4->v5:
- Added a Reviewed-by tag.
- Removed core clk, has_core_clk and icc_ddr variable.

v3->v4:
- Added Acked-by tag.

v1->v2:
- Updated commit text.
---
 drivers/i2c/busses/i2c-qcom-geni.c | 64 +++++++++++-------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 2986266695c0..a67634ca0c7c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -107,7 +107,6 @@ struct geni_i2c_dev {
 	int cur_wr;
 	int cur_rd;
 	spinlock_t lock;
-	struct clk *core_clk;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
 	int suspended;
@@ -125,8 +124,6 @@ struct geni_i2c_dev {
 };
 
 struct geni_i2c_desc {
-	bool has_core_clk;
-	char *icc_ddr;
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
 };
@@ -1045,6 +1042,23 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
+static int geni_i2c_resources_init(struct geni_i2c_dev *gi2c)
+{
+	int ret;
+
+	ret = geni_se_resources_init(&gi2c->se);
+	if (ret)
+		return ret;
+
+	ret = geni_i2c_clk_map_idx(gi2c);
+	if (ret)
+		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
+				     gi2c->clk_freq_out);
+
+	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
+				  Bps_to_icc(gi2c->clk_freq_out));
+}
+
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
@@ -1064,16 +1078,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	desc = device_get_match_data(&pdev->dev);
 
-	if (desc && desc->has_core_clk) {
-		gi2c->core_clk = devm_clk_get(dev, "core");
-		if (IS_ERR(gi2c->core_clk))
-			return PTR_ERR(gi2c->core_clk);
-	}
-
-	gi2c->se.clk = devm_clk_get(dev, "se");
-	if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(dev))
-		return PTR_ERR(gi2c->se.clk);
-
 	ret = device_property_read_u32(dev, "clock-frequency",
 				       &gi2c->clk_freq_out);
 	if (ret) {
@@ -1088,16 +1092,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (gi2c->irq < 0)
 		return gi2c->irq;
 
-	ret = geni_i2c_clk_map_idx(gi2c);
-	if (ret)
-		return dev_err_probe(dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
-
 	gi2c->adap.algo = &geni_i2c_algo;
 	init_completion(&gi2c->done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
 
+	ret = geni_i2c_resources_init(gi2c);
+	if (ret)
+		return ret;
+
 	/* Keep interrupts disabled initially to allow for low-power modes */
 	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
 			       dev_name(dev), gi2c);
@@ -1110,23 +1113,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	gi2c->adap.dev.of_node = dev->of_node;
 	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
-	ret = geni_icc_get(&gi2c->se, desc ? desc->icc_ddr : "qup-memory");
-	if (ret)
-		return ret;
-	/*
-	 * Set the bus quota for core and cpu to a reasonable value for
-	 * register access.
-	 * Set quota for DDR based on bus speed.
-	 */
-	gi2c->se.icc_paths[GENI_TO_CORE].avg_bw = GENI_DEFAULT_BW;
-	gi2c->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-	if (!desc || desc->icc_ddr)
-		gi2c->se.icc_paths[GENI_TO_DDR].avg_bw = Bps_to_icc(gi2c->clk_freq_out);
-
-	ret = geni_icc_set_bw(&gi2c->se);
-	if (ret)
-		return ret;
-
 	gi2c->suspended = 1;
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
@@ -1183,7 +1169,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
-	clk_disable_unprepare(gi2c->core_clk);
+	clk_disable_unprepare(gi2c->se.core_clk);
 
 	return geni_icc_disable(&gi2c->se);
 }
@@ -1197,7 +1183,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(gi2c->core_clk);
+	ret = clk_prepare_enable(gi2c->se.core_clk);
 	if (ret)
 		goto out_icc_disable;
 
@@ -1211,7 +1197,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	return 0;
 
 out_clk_disable:
-	clk_disable_unprepare(gi2c->core_clk);
+	clk_disable_unprepare(gi2c->se.core_clk);
 out_icc_disable:
 	geni_icc_disable(&gi2c->se);
 
@@ -1248,8 +1234,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 };
 
 static const struct geni_i2c_desc i2c_master_hub = {
-	.has_core_clk = true,
-	.icc_ddr = NULL,
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 };
-- 
2.34.1

