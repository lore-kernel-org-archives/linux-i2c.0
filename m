Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50C40FDB3
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399773; cv=none; b=PueVzqMjGqnheUJ3dyMyN410I71s4mHN1ahcyWmdjd1P6jO6bRRTCQ9sE4Y7sxN31u56I5+zBrdoR5dJX/d46k/9rC2hnLM+2mDhN6DyYc8fHp6NB/T39qWyqYCVJJSaX5pmjzyniNkLIanCJcV6Sbn9Lz8WIxBMwlNV2cnN/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399773; c=relaxed/simple;
	bh=BbBD5tNkBQrd31zYVx7NjYHcGjoQsLjnUX+bRHK0MRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UnjB79M1OtA1P/naUP3ziBoK8eT///Jp5+RAxwknNpEoOmHE/7V6TfSDv9wR8KEpql2nXXODxjXdEajdZqDPzT2CYLWNSKYYCVFctaIDkR1kOp/oCBOQsLEr1G1O/l4F7Tk40CAqUs2qegzZF6J4TAcCUfxa0jsxSB4ADTcFZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHEAzNIX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acEcr2x1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHEAzNIX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acEcr2x1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616Ewf2F1852685
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2xdIWjPvFPu
	WeaF1ghJotVpCXxOBg3ohkTZp+i91ty8=; b=oHEAzNIXXfYjfDDZC5U+wj2rtj8
	FxziysDKKFears/mcM2gzH2YRQ27n/JjVN7irbCH7emZh+Pz5D3FJY7FxkjfAvI4
	UplIwCvJMyis1f2++BPtzApetx2P7i1RGPEjYV1e9a9k6su1Nnzmyvg60I9oTTUe
	aq058mqVpooKCFST6lD+5dB/mjVVqr2bH+dd+cbQcLpcjbrgDn46capIT6MHYbeO
	Z3yUuqBX2FNkz69E7qQdl+OhqUeEIi73RzsDyYmXFdVHZK++4PEL+qRDFvycyVlT
	1TUV3O8+I2Jt9fLMoB0Wza4ogkLMlGS1q9yeg0AE5ppxBkMEf+hyys7TB7g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c149t78-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:42:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c54e81eeab9so1516530a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399772; x=1771004572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xdIWjPvFPuWeaF1ghJotVpCXxOBg3ohkTZp+i91ty8=;
        b=acEcr2x1ofCvwftyacNsPPt0SAgFIAU6LfpTYytkD7OboMIZiZW+dhc9P/91Pfogn4
         P803X6fMGWRHvWRAfcwlkIIJhW0qSynphBTMWgt39vewkIpbaG90VEtLkk+uBQKOFDUG
         eK9KoCTpdpyY/Mn74+EdighDHm/Xfi6I72zU9pUIwhnOamEtLwmVOCeetBp1pUNQ2Usl
         /bwmcEvCaZ7w8fYu7OCRtyzNAqcuFdyxN7iVkOEBwigtbM2FQKUDSxwRYa2sn38iOHc2
         6a+/TJtpVh23lhZkIRVqtfb/epv8SxICoDTg9v1x9cF6jU42a5TcNcBcyDGppXRH+MoI
         CiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399772; x=1771004572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2xdIWjPvFPuWeaF1ghJotVpCXxOBg3ohkTZp+i91ty8=;
        b=pz/YKZiYoWAzi/jcKf0dqPRgmajAKASI9hNIeONxXHub+wWuX0DVpVI0L1rAiEoBNP
         nWjt3FXxxBs8BNsOM7yEf16PyHSpg1+4XNjku9qcUrAwfPffvXCdrMZWhZBpzcYQ9jq5
         vEKJ7U9dc2ra6H+Vqph3Qjm3VJyq6VPxDnAM17cqDyile/ivjh/JC8LLMbAqpTBDDpvP
         gqFGgFqOG84QEBAj7ID8esr+gMpvOyTpBRXdW4uCAEwM+PywQjZ5n38PffkQSpb6WQ1S
         FI/9uufcY6l5nX5AN92OqPO7vgZEmPpegQVCAKWlyyGjDwYb3r442bTdxTXORjep9HRo
         3gmw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Bfx2ezWcwD9rnDVx2vNzJGViqonyHdPAsHtntkG6UCUstVv6HdrxXfSSJaTzkiJiSPjQtJdGilc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPH37JN9dnDwrgma/ZSc181DhtaqlR7yZBHtp93j3RcNvvFh0c
	+wsom3V56on/xjReXnam3tJW0ov15Pl3JFjug8B4MorNpSVBG4nFW0M3ZObN+ctHgi4jPDyjipJ
	TqodSbAf6HdrZhT9JZxVJQEqTdSNamYrQRl0PIedBbF7qYD2flzwKa5lOx8/Mej0=
X-Gm-Gg: AZuq6aIQLTtOt8d8I7xU2IjzlllLA1B2a8Cdge2Ch0M9V+cR+EfXynxWi9CLu19A5CX
	cDhROV/5seYwaz2NB5VkQLiy6jkUZF4MYxXpPwropGlX5t73KZhUjkkZHfU/jTiOIAzObQQGKR0
	3usNPX/OaCeiWNo1g5ou909Gw5KQcUBO9QKka2ndQ5fpgXtHiAfxCEpMh7B8LN/ETFTJ+Y7aXpq
	P4jGhl4QDPCl6v+0NMGR22/q+RgpvjU6korNANmjGjNFJ/heo6LjYRRvL89VYuO9yNGOKKbQ8cS
	ZImNYkf9iJ4iSuNP1u1ol+Befk/pJjSjIOfAzFigNsqj8oMsUKBqZvl4AWsGJgoQ1e/c/2eBtzq
	qbI+pDwxzIGDDtiNRDKRZLljsAsbPA/6XzArPnS00b7Y=
X-Received: by 2002:a05:6a20:5481:b0:38b:e55a:97c9 with SMTP id adf61e73a8af0-393aef57a70mr3241481637.28.1770399771678;
        Fri, 06 Feb 2026 09:42:51 -0800 (PST)
X-Received: by 2002:a05:6a20:5481:b0:38b:e55a:97c9 with SMTP id adf61e73a8af0-393aef57a70mr3241454637.28.1770399771109;
        Fri, 06 Feb 2026 09:42:51 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:42:50 -0800 (PST)
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
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
Subject: [PATCH v5 12/13] i2c: qcom-geni: Store of_device_id data in driver private struct
Date: Fri,  6 Feb 2026 23:11:11 +0530
Message-Id: <20260206174112.4149893-13-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P5k3RyAu c=1 sm=1 tr=0 ts=6986281c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=VoGDZ86lKm6tgvVT7R0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfX8rF5LUDeR8hF
 3yuMK+kP2GQAHevTWMivN4BDzZ2RbEQENKS7rOD6YwaL8sFMjwlygSlqQuIyT/ny9i5BzkDFKj/
 Bbwrh9hDOFZSq50946KcidOWZiAQaCfhuQn18IRnpWmi+504GddR7cl5mUsxYp7SYqdYhKrBH1q
 Z++pjEzlS8XFf6Mu6rsBU856HoTGscZe08Ui2WjNsro6ckJFAe48FQjiC11q09BIfZcm4B2z726
 HAHfeqUYXivY0J/cxL2xcV0VVCmv8iK9wEm8QjbN/SmfGjhxJEvZT8zw+8BA6KD6YCbyeH12NqP
 PM6z7k2oPgvK3xyoTx3Dyms41g0IldacHDra1l+5Dopc9cAuwORiRzkMc9B9hwtBwUFWifkHqvX
 dXjJlHaqb6P2lH+zmMonj+Vh7Cr40mUF2ni89Cb2sQhm8uIUAT+T92krARy01S35QmqI8ysu0mn
 acztl46D0dc5U3xPlGg==
X-Proofpoint-ORIG-GUID: ousvQd0cDvuaCQ0PmW0-LRTx1_lwiXuK
X-Proofpoint-GUID: ousvQd0cDvuaCQ0PmW0-LRTx1_lwiXuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

To avoid repeatedly fetching and checking platform data across various
functions, store the struct of_device_id data directly in the i2c
private structure. This change enhances code maintainability and reduces
redundancy.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4->v5
Konrad
- Added a null check after platform data struct.

v3->v4
- Added Acked-by tag.

Konrad
- Removed icc_ddr from platfrom data struct
---
 drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0ddfeef6d1b2..9045187ad0b5 100644
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
@@ -976,7 +977,6 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
 
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
-	const struct geni_i2c_desc *desc = NULL;
 	u32 proto, tx_depth;
 	bool fifo_disable;
 	int ret;
@@ -999,8 +999,7 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		goto err;
 	}
 
-	desc = device_get_match_data(gi2c->se.dev);
-	if (desc && desc->no_dma_support) {
+	if (gi2c->dev_data->no_dma_support) {
 		fifo_disable = false;
 		gi2c->no_dma = true;
 	} else {
@@ -1020,8 +1019,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
 
 		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
-		if (!tx_depth && desc)
-			tx_depth = desc->tx_fifo_depth;
+		if (!tx_depth && gi2c->se.core_clk)
+			tx_depth = gi2c->dev_data->tx_fifo_depth;
 
 		if (!tx_depth) {
 			ret = dev_err_probe(gi2c->se.dev, -EINVAL,
@@ -1064,7 +1063,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	struct geni_i2c_dev *gi2c;
 	int ret;
 	struct device *dev = &pdev->dev;
-	const struct geni_i2c_desc *desc = NULL;
 
 	gi2c = devm_kzalloc(dev, sizeof(*gi2c), GFP_KERNEL);
 	if (!gi2c)
@@ -1076,7 +1074,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(gi2c->se.base))
 		return PTR_ERR(gi2c->se.base);
 
-	desc = device_get_match_data(&pdev->dev);
+	gi2c->dev_data = device_get_match_data(&pdev->dev);
+	if (!gi2c->dev_data)
+		return -EINVAL;
 
 	ret = device_property_read_u32(dev, "clock-frequency",
 				       &gi2c->clk_freq_out);
@@ -1215,13 +1215,15 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 									NULL)
 };
 
+static const struct geni_i2c_desc geni_i2c = {};
+
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 };
 
 static const struct of_device_id geni_i2c_dt_match[] = {
-	{ .compatible = "qcom,geni-i2c" },
+	{ .compatible = "qcom,geni-i2c", .data = &geni_i2c },
 	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
 	{}
 };
-- 
2.34.1

