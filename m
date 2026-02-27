Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2573E9F80
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173042; cv=none; b=kUGCSk1hN8nDuCY+tiNllc/mf1J6tBd5AWzHZ7+UFuELmGtgIqUv+BW6XefUdgzlYaSeO1MWJw5XIG2KKht2KN7osxcmw0x3K7Zvp/GNZr3mQbWR9D8xCtqMMQ237P8YgWlPRKtVoANU8GMZCgeantKIiXC+Pa8BxFpdKswXZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173042; c=relaxed/simple;
	bh=eY2I5uRUIiwUluElxUUOpi5fOiYU296aE/AH3jfENzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBIhZivZpfBGPyGjmI4UPKnhzGA6rSTloJRhQf1VtmSjGj6QVlRNb2Z5c3LUphj1Ip+lRl9JfUcMhvS8J3CEH1unI9se36tKKaSUxCph3etQJW2kiHk0GRxdqqi6b87QXzOCsZ4lglqjQKiIlHrD5Qc4FPcQYblRn/nLy6OzL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OHTaXLAY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUvvTGhB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OHTaXLAY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUvvTGhB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K1LD1620051
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a6YJVRJhruA
	6Q8Cy2OP0sNlAp+tW66kxMwSkhyUa0XA=; b=OHTaXLAYGCw4TlT9JNPjCwTZUmS
	0Se1rvqUyRGyZXIejWcarn7hUF45jXoXS9ZArc86V2pxXc/fEFTQTT9hXXi/2CRA
	2+2kp8Ve5CiEzxmgj6ea1lxBSy7PcTG6yz0AKmPJVV/uBIJHdkEjivrm6OBpmn9a
	pcZkJIYe19Z6BHEOohsjaJYIAJeMOpouK40SxDP/e+pCRdHVE3u55h3sKYDDYYOz
	ON/fOV6ws19TIYnR7HwUxdw0f8kHhulXrpFx2zyuoEK5K7LdFV6Xu4h+hLMjVbJS
	ulUJmkGS0ZMEQrlC4BiWlpPpXLWK029g0IVSkZQ4B3FBtl95R4C/IMuRRUw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjn0x3epq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:17:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aaf0dbd073so17085035ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772173039; x=1772777839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6YJVRJhruA6Q8Cy2OP0sNlAp+tW66kxMwSkhyUa0XA=;
        b=BUvvTGhBrB5ycz3CbI3M3ZiSDGNl7lxUc9cJIw8zR1Zc5t2WFsWm2h1D3EdV3Fz7O8
         E6j9Lkvvo7Z/G0szbN/WKGhxi90eygxa9DoJIev+THowtkTvbCb5EXgSIMjDYgYp7+9k
         cU5LKkMICLCgOz8TsFnuL01pMHYGLj1hipnhCWY02wcCZnl9iuE5QtAmniHIAXR+Ib6k
         GzuMX1tGQwseqsyHmprx83EXczDE4bZSawGPMCil3gbsn5i0fnmtyNYGT+wlZArtylXs
         lS043eeCauQRYXED0DCHvkgJFUjUdq50W8x3OZh5lg4/Y8EjRRCbO9umNJY341q03fGj
         9j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173039; x=1772777839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6YJVRJhruA6Q8Cy2OP0sNlAp+tW66kxMwSkhyUa0XA=;
        b=EaSflco3TMOxx5OgTTIBsTA0nnpw4KZRNcERHmvVmGJnNYPDDVgAWYe64gvuPVoPEV
         +OHQsV1rmJJ4HFYOUamFdVFeRgaCkozBVR1HoTs5AGwdoUZTRFrEyMx4a8HA3ikhJ9PY
         ctfGH5OW1G1moQTptMM9DKvN49Ve5rvLeiz0adO9oeJkINgTNAdTwQzOG/leq0BDEFp6
         ObjP1Px13ZDeSNTKG3/R8or+pQUCnyCmnIqvsOnWapROFEQ8EBbREesDcWNPYmcV9aJm
         6p6DizgPJwczUGAAU1TuGmgN/cCuOfAOVvuKMkxQn94NVVD3W73mjZ2jw9JFuEKwOMCO
         eGIw==
X-Forwarded-Encrypted: i=1; AJvYcCVEUshDOTgiqdHMVqVhBG3mrvNB0j2QcxzW4EJemfFgeqB5jZvhlGihlG0dEt/wOt8aCkKfN4YRi/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaszXst1hLZ+Pdz0kimAA4OPPPbdeBcvrITX5zmlv81bZVQcKY
	NnBVHqSarpbPV8rnn1uVAWn+N92i1Ft9BRZNhM+EJ8IAgKae6H01GTKqVRmDTJP9CO9YoPxFomp
	i7+npBB4cv6XEZGfseSkxAJMAWDGak8kZ+kv37M95ve0WcsHW5Jr05weNYx0/bN0=
X-Gm-Gg: ATEYQzweV6ad5UboRu78TvoCBWyE9Bal7XjvyjSiCuNkbV/wMSduBgQpzae1mlBh1Bp
	MvIS3EoWGxi2PyvxVpxxbS+MMPgo2jT4u7hSoE8+E9+b+iUkFAd1JHZwd60nomjPJZwhIrL09si
	TuOUmRnrcTSK2VY9JjM6fpO7R2/jdGK1F+bmgbi1EffL8kpFTYbGcY62y9KN5EKL73x0y5Ex9nz
	4lX2FHLh8PmtPHYeq1t6VLhC+6uOojsc0mlsotBjOo09ZmqZv91N3T7rw05Hw16ZAue3YQ7cp9f
	MNHpPgS7AiaSJWKhCJkgSO8lBv3Udebhl0X9p/jDACmNwhqUI4pVWydx8nkfDYyeRTHKy+8cHDb
	+nf5HsbIDNzaK9Uw48Yz2m9ygu3G37K91BuWGryl0D1P2TW2v37XiWM8=
X-Received: by 2002:a17:902:d484:b0:2ad:ba04:40cd with SMTP id d9443c01a7336-2ae2e40faccmr14904515ad.22.1772173038779;
        Thu, 26 Feb 2026 22:17:18 -0800 (PST)
X-Received: by 2002:a17:902:d484:b0:2ad:ba04:40cd with SMTP id d9443c01a7336-2ae2e40faccmr14904245ad.22.1772173038179;
        Thu, 26 Feb 2026 22:17:18 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:17:17 -0800 (PST)
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
Subject: [PATCH v6 12/13] i2c: qcom-geni: Store of_device_id data in driver private struct
Date: Fri, 27 Feb 2026 11:45:43 +0530
Message-Id: <20260227061544.1785978-13-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-GUID: N95VZ29k3dq7w9QFlRUm2x22JCEkLxY5
X-Authority-Analysis: v=2.4 cv=I9Johdgg c=1 sm=1 tr=0 ts=69a136ef cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=L-JS82rCYefCJmJZhRoA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX7LFg5mj8KRWv
 rIbihUY7S2FwIS7yCO9BgKl2pJdeaAK2i3CqwYGFTRaYSk5D/nF/10U6LNBHG1H3KRbF/yYiF3q
 G60crfaVQlY4HwY0YfW6zC3jfn2WwFxfxZZJATY5cxhQvq7NZsOJy+R97ieYt1pYm/VoIUHGaor
 vp7jUqJzClDsZeaqhrfjIlGOqxyoAe21iDXdjLhx8otF3Hk4Uqa9sDzfop6ByL1yZq/b+VGkU/a
 H6lXaVzrSVnHGKU15OOcRga8PAvLVNoPslzrMqPbsIZ+dnLHRK9g6fnaDmh4D/mvwxJYJlByuSQ
 Vpu3uHqUHMhRNQEvpgWhrYr11p+k3QlSmNdPo55xA0AriO1oodU/D0YSQfthd3CADqhTwJzyJyR
 SxgOIuGmwQi0RSKFj7mTJ/aUqezrjYlO5mURr3DwtG9dheZ0TEAlMz52S8ec/qCN8WRIz3zzl6+
 ReADhF/+ylipQrSAfGA==
X-Proofpoint-ORIG-GUID: N95VZ29k3dq7w9QFlRUm2x22JCEkLxY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270050

To avoid repeatedly fetching and checking platform data across various
functions, store the struct of_device_id data directly in the i2c
private structure. This change enhances code maintainability and reduces
redundancy.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v5->v6
Konrad
- Updated in geni_i2c_acpi_match() as suggested
- Moved geni_i2c_acpi_match below to avoid errors of geni-i2c

v4->v5
Konrad
- Added a null check after platform data struct.

v3->v4
- Added Acked-by tag.

Konrad
- Removed icc_ddr from platfrom data struct
---
 drivers/i2c/busses/i2c-qcom-geni.c | 46 ++++++++++++++++--------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0ea4abbcd170..f2508038c64c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -77,6 +77,11 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+struct geni_i2c_desc {
+	bool no_dma_support;
+	unsigned int tx_fifo_depth;
+};
+
 #define QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC	2
 
 /**
@@ -121,11 +126,7 @@ struct geni_i2c_dev {
 	bool is_tx_multi_desc_xfer;
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
-};
-
-struct geni_i2c_desc {
-	bool no_dma_support;
-	unsigned int tx_fifo_depth;
+	const struct geni_i2c_desc *dev_data;
 };
 
 struct geni_i2c_err_log {
@@ -928,15 +929,6 @@ static const struct i2c_algorithm geni_i2c_algo = {
 	.functionality = geni_i2c_func,
 };
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id geni_i2c_acpi_match[] = {
-	{ "QCOM0220"},
-	{ "QCOM0411" },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
-#endif
-
 static void release_gpi_dma(struct geni_i2c_dev *gi2c)
 {
 	if (gi2c->rx_c)
@@ -976,7 +968,6 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
 
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
-	const struct geni_i2c_desc *desc = NULL;
 	u32 proto, tx_depth;
 	bool fifo_disable;
 	int ret;
@@ -999,8 +990,7 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		goto err;
 	}
 
-	desc = device_get_match_data(gi2c->se.dev);
-	if (desc && desc->no_dma_support) {
+	if (gi2c->dev_data->no_dma_support) {
 		fifo_disable = false;
 		gi2c->no_dma = true;
 	} else {
@@ -1020,8 +1010,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 
 		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
-		if (!tx_depth && desc)
-			tx_depth = desc->tx_fifo_depth;
+		if (!tx_depth && gi2c->se.core_clk)
+			tx_depth = gi2c->dev_data->tx_fifo_depth;
 
 		if (!tx_depth) {
 			ret = dev_err_probe(gi2c->se.dev, -EINVAL,
@@ -1064,7 +1054,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	struct geni_i2c_dev *gi2c;
 	int ret;
 	struct device *dev = &pdev->dev;
-	const struct geni_i2c_desc *desc = NULL;
 
 	gi2c = devm_kzalloc(dev, sizeof(*gi2c), GFP_KERNEL);
 	if (!gi2c)
@@ -1076,7 +1065,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(gi2c->se.base))
 		return PTR_ERR(gi2c->se.base);
 
-	desc = device_get_match_data(&pdev->dev);
+	gi2c->dev_data = device_get_match_data(&pdev->dev);
+	if (!gi2c->dev_data)
+		return -EINVAL;
 
 	ret = device_property_read_u32(dev, "clock-frequency",
 				       &gi2c->clk_freq_out);
@@ -1215,13 +1206,24 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 									NULL)
 };
 
+static const struct geni_i2c_desc geni_i2c = {};
+
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id geni_i2c_acpi_match[] = {
+	{ "QCOM0220", (kernel_ulong_t)&geni_i2c},
+	{ "QCOM0411", (kernel_ulong_t)&geni_i2c},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
+#endif
+
 static const struct of_device_id geni_i2c_dt_match[] = {
-	{ .compatible = "qcom,geni-i2c" },
+	{ .compatible = "qcom,geni-i2c", .data = &geni_i2c },
 	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
 	{}
 };
-- 
2.34.1

