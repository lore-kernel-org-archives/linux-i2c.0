Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F533344C
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172992; cv=none; b=JK2M3kT8/6s9UYlQPdWhJmptxE3lBpRqsd+P/4JeyjckcLs1ToeZlu/5IsZ4mvKUNONV4s8WeG8zjwYJ2yX1aro58iUagH5KLcCrPDKCK2AkwsdwVJAP4FkA5TZ31DPtV7I2/u5Ju3u6RF24ueYwPsNRTo4QIayd//hMf4FAj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172992; c=relaxed/simple;
	bh=zYwjncLuxAcNRFxhVZP0hv9VGpjetfTguK5Hzpt5cIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nY3RLK7YTqqX0hqdtaB+nki/NRCltuXiORas5mT/Y+NqEc/eFGQgilk0euowIz8zY6eAG1gnclNSSKRHG8coVg7kwRlqJu1RllNTzPs9Sa1Cr/aBzKs8J8w37XM+0mYPua1Hewuzxe0PH8SBEaIrLEaUr1wTbViTtCdmY1+/px8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ob8G30SH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BYkc8qLK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ob8G30SH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYkc8qLK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2JxTe3761428
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=S+NcvlPxnrw
	tBt7YIuw1NzxBgtp69duQfhINk9XVHew=; b=Ob8G30SHwaGta5UAa3PgyvtuGes
	AMBaUpSHJsobr33mMyH7vORy089ZE84rUIGRTiKxWjCboaAEI8b1EPfBC4ti/swY
	1TluvGDqw3/ypAO2EnA9Hp/iWswp6js05rlc9KWk+OWnzlqr3LWFAHXiFWlIY87z
	9da2j7JcDg9n7dUFrJZnLyulDwRImGTdeN/hlNPDWovs92pngZ9hr2cV9+kqi51r
	oO+HTklBG2PdJofDnjEsVuyZP7vvxt1/NEDgIMx46RlhWKFL5SSIrI/ycRWaMxOe
	xzlFxSqwxC+i3t9ueYdnbfmLt2n4Z8nUFembWuBg9Q/j1o0kM6p1+6P/wqg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt7yacq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adfb6df9d6so112900805ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172989; x=1772777789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+NcvlPxnrwtBt7YIuw1NzxBgtp69duQfhINk9XVHew=;
        b=BYkc8qLKl4s3wXlNZVfxW4KB5gzsaIKbzKMwTn3g1CZyOIK8LTnJo7/vCbeIDeDtvF
         syc7F+TedU85VD/PRgXu5uJkp5mezoGZ0ftvx2VtAUaeZA3dWVo+8mBHo0cxDH4S5sdC
         dG5vUqxK9tjsmhEaU5d5F0UZ9YR80JaOxbaaWVkKXRk3Q+ke5dHLk1H86hDAKjHMojWa
         lrEVsNtFLbUr3pIryZx309nE/m6znUJO7PqAF40ETKINjbSFQnmsYO4MTpc32xXt+mzK
         ELQYUU4QAvPYIMp2OQHPcjZoNDdcvLQtevVMmbapB+aG6ElJw+qoIJaUX9rp4MZWElHZ
         vkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172989; x=1772777789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+NcvlPxnrwtBt7YIuw1NzxBgtp69duQfhINk9XVHew=;
        b=EXpRQdDuSWr5D+WiOGufQI4N32YFOEK+owR+RKSfiGooGqol6djpvMFMDp957d0T43
         9gtCcftx+OawaoqXlbuJZlm4xtMJc2R9WYDr6RkqCvIe+pxaSQE8rgxmNS+3A35mr+rH
         AOBunkc8YIux+8jeDWefvyHK9JG3od1+fJz1x4YPyLZ1crHoxRz9rl/EiUUa68G6vg2I
         /+3qg4lgYpATnA4L5UUXj/Pdrs00kzBMboAb9uk4pbV78/PsxAOphYDO93IzD9Zg4FQR
         9gvkEqgCYy/4Hmg4hzHhz/6qnaGp9f8iA5o3FKR3j0ovVI6gsHycq67+grJ+l+aepD3e
         3+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyyT2soTE8T/njiPg/Ao9+Q4cSdJRARg3X0lS/FkWpbcSqqb1eJBT8i/k1xvg2AFD+yg1vp4G/mls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweegtszx0KEUgSknClWPwPLgLep72Dn+6DZ6hYBGEIqkG+esjv
	99cvb6g10ZHdY8SlfvNEzhHSegJA/eXBjIQevOIxGhZ4nsS2HFL7BJ+r19uVZ4f3S24DLuE0Qoo
	2jRv9r1ErU4N+x/19uEGHUTVop39WIRGZPIQzbizcXYD2hJjBk9tmWlGUFVTltr8=
X-Gm-Gg: ATEYQzxV3gBNP9tEwYQkHELLpOsk56zNcPBBmilZK7kGbNk59JiT/NrufNQw1vrqfxq
	1Y4KY+BsWM2QostEIoVrmbRo2slTMqIG4EzYOFhlcf2lBNHJXNuHwDcLa9UrVDRslIuYIWCk/pc
	gQHG7vLYRTddQicPYmq/4xVbehKgPAtTR/SaGrAgGn/HaOit07DbYqq785vppBrydufPmRDhT/M
	NZuyTIvEZzQXaFOIgExIIvc2eh84b22chAP/Iv8BDycRTjrQzlnEKcLuXIb0sOXCBk/eoVozsVA
	iGeqJVbyy0yLv1uo4PwXphAD9DKrF8uZmlg8fU2d2YtWJ8BbDUy0MlmSeyW0HgSQpQ9TDMvJZ54
	2mxwxNvYNjL5t+fQp0g3DHe6S4vAjRpNOvUyxe+tuFbrR7JSHXa7pgx0=
X-Received: by 2002:a17:902:f691:b0:2aa:f2f3:bcab with SMTP id d9443c01a7336-2ae2e4d5ef3mr19058935ad.47.1772172989309;
        Thu, 26 Feb 2026 22:16:29 -0800 (PST)
X-Received: by 2002:a17:902:f691:b0:2aa:f2f3:bcab with SMTP id d9443c01a7336-2ae2e4d5ef3mr19058385ad.47.1772172988691;
        Thu, 26 Feb 2026 22:16:28 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:28 -0800 (PST)
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
Subject: [PATCH v6 05/13] soc: qcom: geni-se: Add resources activation/deactivation helpers
Date: Fri, 27 Feb 2026 11:45:36 +0530
Message-Id: <20260227061544.1785978-6-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: cUm2bUvE6FcR1QLcNWxBP_UD9jzQh8l3
X-Authority-Analysis: v=2.4 cv=N7Mk1m9B c=1 sm=1 tr=0 ts=69a136be cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=KBRiQYpxJDLEvAb9SdYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cUm2bUvE6FcR1QLcNWxBP_UD9jzQh8l3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX0ZfY5BO/yPWF
 Z7sWGi4gP8n0trPt7kxHfyD3GGBwEvT7IBuLNPaHXYmnLWVV3IFV+OU0jW3Cod/bV+fx3N6WuyO
 RKtWDSCBrULUP8ST0KT5WmaZjF9ZwizShB4D8kSlZ4PuS7zbwR/wlsmHN6tF8XWgB0J578RQph/
 5V7j0uuuiYUHHLh9OLV5ytcdXyHOgssFb5JmSoNwWpV9x14OHv+oEGa18cf/Vskj7oW5xrv2xFv
 TP+//Jh/w9FLvlOcSglZllZPsc617Apo93SWlQqodHUp1y1Y0PK/mdvHTMlyu0bQLKbFzf/92oY
 VNWcYrC4dN+d7qrgxfTTnFXIltxOjgs7ycn7Xb7WYew4wWtMNR5xLzCQwIjYlvFeV8CRiDkZoEw
 0Gor+tDt0eIb4l7vbQLfFtK5dBLx1wtq1mGB7UZIs7qTZVCcJcLh6DvN7JfOVmPYz6coZgG6lFV
 0vk6GBqHixbsfxWpCkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
activation/deactivation sequences independently, leading to code
duplication.

Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
power on/off resources.The activate function enables ICC, clocks, and TLMM
whereas the deactivate function disables resources in reverse order
including OPP rate reset, clocks, ICC and TLMM.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v5 -> v6
Konrad
- updated kerneldoc for geni_se_resources_activate().

v4 -> v5
Konrad
- updated return value as 0 for geni_se_resources_activate().

v3 -> v4
Konrad
- Removed core clk.

v2 -> v3
- Added export symbol for new APIs.

v1 -> v2
Bjorn
- Updated commit message based code changes.
- Removed geni_se_resource_state() API.
- Utilized code snippet from geni_se_resources_off()
---
 drivers/soc/qcom/qcom-geni-se.c  | 70 ++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  4 ++
 2 files changed, 74 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 2e41595ff912..6e58568701b0 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1025,6 +1025,76 @@ int geni_icc_disable(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_icc_disable);
 
+/**
+ * geni_se_resources_deactivate() - Deactivate GENI SE device resources
+ * @se: Pointer to the geni_se structure
+ *
+ * Deactivates device resources for power saving: OPP rate to 0, pin control
+ * to sleep state, turns off clocks, and disables interconnect. Skips ACPI devices.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int geni_se_resources_deactivate(struct geni_se *se)
+{
+	int ret;
+
+	if (has_acpi_companion(se->dev))
+		return 0;
+
+	if (se->has_opp)
+		dev_pm_opp_set_rate(se->dev, 0);
+
+	ret = pinctrl_pm_select_sleep_state(se->dev);
+	if (ret)
+		return ret;
+
+	geni_se_clks_off(se);
+
+	return geni_icc_disable(se);
+}
+EXPORT_SYMBOL_GPL(geni_se_resources_deactivate);
+
+/**
+ * geni_se_resources_activate() - Activate GENI SE device resources
+ * @se: Pointer to the geni_se structure
+ *
+ * Activates device resources for operation: enables interconnect, prepares clocks,
+ * and sets pin control to default state. Includes error cleanup. Skips ACPI devices.
+ *
+ * Unlike geni_se_resources_deactivate(), this function doesn't alter the
+ * connected genpds' performance states, which must be additionally handled.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int geni_se_resources_activate(struct geni_se *se)
+{
+	int ret;
+
+	if (has_acpi_companion(se->dev))
+		return 0;
+
+	ret = geni_icc_enable(se);
+	if (ret)
+		return ret;
+
+	ret = geni_se_clks_on(se);
+	if (ret)
+		goto out_icc_disable;
+
+	ret = pinctrl_pm_select_default_state(se->dev);
+	if (ret) {
+		geni_se_clks_off(se);
+		goto out_icc_disable;
+	}
+
+	return 0;
+
+out_icc_disable:
+	geni_icc_disable(se);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(geni_se_resources_activate);
+
 /**
  * geni_se_resources_init() - Initialize resources for a GENI SE device.
  * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index c182dd0f0bde..36a68149345c 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -541,6 +541,10 @@ int geni_icc_disable(struct geni_se *se);
 
 int geni_se_resources_init(struct geni_se *se);
 
+int geni_se_resources_activate(struct geni_se *se);
+
+int geni_se_resources_deactivate(struct geni_se *se);
+
 int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
 #endif
 #endif
-- 
2.34.1

