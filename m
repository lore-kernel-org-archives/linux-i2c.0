Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1F3612F4
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055786; cv=none; b=TUyzGncjp7K1ub3sT9gDGSx4GPAKJrCTLRmV8tDMVPEcCHxj0OLmNWbRHYRDsE3DYd2ojOT4McbXhgcfLrh+BnNrRYv2vwXT+p6teYh9z6j3M57UoZ4zfgHWFxNLVZzG4AhRyOt6leMt8XCleLOBSJKWXnlo1LnYnAGLMpHBRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055786; c=relaxed/simple;
	bh=Eck/D6KmwOrBysTJIIaZmSoFBAq/RlW1moTUSu+Xl3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufOj9foT0leUlJ9oeNh5rTkbZ2t29bIEc7paEN+f4NW6fIzOrfTt0jUG39uvQpGYdnPPHiWrP1ddSD09pwM0C6XOYvZSU0eeyjoEdVA0vUNaNJ6h7miiiwasZUt6DZb0+8k1k516QEeRJlDvt33/9lC7kyvac4pt9qQ1foSGmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MrFDXCev; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMioVjSd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MrFDXCev";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMioVjSd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B5Yum3459184
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KnpiwG0d//X
	/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=; b=MrFDXCevMZoGMSGsD/wleAntvxf
	AW74Fi1cEpBpGjUahvfJeoYZk8GAK6hn2SJImrlbFaGV9//FylSHyKoL1TISz29w
	NHkQ9VqxVDVX2gXIzPDtZjk9AwJZaoifvfNBjjC7Urvnud+UXP0yYVyY1BcbNIVJ
	3ipQQSU7R8MagvNC99hbbk2v39gRVKDd+v+lRzjT2JFxQek7MpRKldXwRkGBsjwc
	Wlc9LAdkEu4ySyIomUH5LQXaNRqxdmmBgP7/ExBoeJ6ZggRi2b/PRN76VqQQCkpB
	nG/5Ph2/x3j6+gq9iG8Mq6wlUX2Fx1dyVWjjIXrA26jrQVB+FPCvgSxOrag==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2trbh9ee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:09:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81ed3e6b917so3928763b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055783; x=1770660583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnpiwG0d//X/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=;
        b=hMioVjSdrXneydsFmw5sbMCk78AIaA+uHhdiHczXIXq0uHq8WidL5/FmsxLoj4gRNc
         va2DGGUPE3TLdF14ChFZy6qHWyzHNZZkpmhvxs+zWxXO8Gl97tgx1kniNO9Av+PuDpsp
         slem+XIrqyLaZPf84oEOF8E7mH2VFzbW5JX+w+oAQCOE8WnmSVK4jrsS2OC6SiylqUuZ
         Yyz2w3NFam0/0ijInUW1BAFIXiY5yYO+QbsY5ZIpFm5NhSnLtx7aB+nC+8l2yVJlD73n
         +iCOwZ853rAGVkhXJmmIun+FZcCufeWxX3LQ8j+Ji6PwKc1Dm6ICpD5Jsip23s+qr7SK
         4dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055783; x=1770660583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnpiwG0d//X/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=;
        b=HOLh2LAqtGrg0GLHozMlaz4dZPYGd/xZVVcVcL+Qr3tzbeNVClHgNpsItoYPeeWfyG
         sSgxGkERiR72sB+p2cBDKcueRYR4qDlYQ4K7miwUVs41UibaqB7cbpm87/zrmM5ccdND
         JTO5LkoeIlrsIK8qXINcBWzbhYU/DzTPImfjjCOO3n/RFxFp19G7q1VbgqRJsORMr23x
         8RRGcE1D/Hlkc+oIu/nsbnWjyXP6xNeox3S4L+J5zjzscMqhX/JhieF555mGi4cDX60f
         Ahrq0aSGYPb9l4bpi8qpUeK0rlmmY/JhVI3QAhqsM8KF3EGV5GD1JOBDzMawwbM95w8T
         ohEg==
X-Forwarded-Encrypted: i=1; AJvYcCUvBhcw9qx9BdOeopIHgJ0EvHSeNbhCSysBDPDtnsvAz04L9SnCnbTFjeYyWVzuJSAwqkHhsTn8viQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wfvkQ7dxnNBAU5AqUnRuNHiZSP64uLtBJbMnaGFW+0DCT7nA
	n/iK/K27LFig0RjMM9qY7ZQNfBpVPrN5fIZIzGKrHBOfixPeHlGmyALEiRUQ2OwX+tgKfq4rD8j
	tDwAkxDSVeAYsCl+lYgtEB2+F0OSJYB6r/qw5ODYcuAy3wJ1Hhpp6+1LnWw5I0MI=
X-Gm-Gg: AZuq6aLOdGc6RzedictJNU+/1I16f/4uPu7Rxq/Scs1pd4lmkhzpZe/nRXjOfmUkfnM
	Hv+BJfoxdt0rRSOWSEwgxfTF6DCP7HE04/bvrVf0RU9ivc1jDm36LLBYl1k58+isYMhTg3jRGid
	QQRukfA+rHpg2TKoF0+NYOcvlmamNPrX4VW/ekk5CbFAyIDEb6fJF9tozzokQ+Rod2P7gJlyWBE
	UPo614OfmtBImWpmxrU9PAaCE8jSM50fZ+dltDwZZgbxX/AKyCer9jAi52J8YOOhdl74AF0BDY7
	dSTPbzh/out7dHZ0iH6hYfPU/ovYboJGZSnqCj+zxNDnUlmpUrZ0iZAhvaTZEya57GDzVxtOO1R
	x84Jqwr/E9Iiqm2/XIl+4hKRaVBgNEfV+61sGVrwoYVU=
X-Received: by 2002:a05:6a00:2290:b0:7e8:4398:b369 with SMTP id d2e1a72fcca58-823ab76e335mr13009933b3a.60.1770055783035;
        Mon, 02 Feb 2026 10:09:43 -0800 (PST)
X-Received: by 2002:a05:6a00:2290:b0:7e8:4398:b369 with SMTP id d2e1a72fcca58-823ab76e335mr13009886b3a.60.1770055782473;
        Mon, 02 Feb 2026 10:09:42 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:09:42 -0800 (PST)
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
        jyothi.seerapu@oss.qualcomm.com
Subject: [PATCH v4 01/13] soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC path optional
Date: Mon,  2 Feb 2026 23:39:10 +0530
Message-Id: <20260202180922.1692428-2-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AetFiPBZC6xUytsfsmxoKZVqEw4Zu-Uw
X-Authority-Analysis: v=2.4 cv=dcmNHHXe c=1 sm=1 tr=0 ts=6980e868 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Wptve8LSCQjy2B8HgooA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: AetFiPBZC6xUytsfsmxoKZVqEw4Zu-Uw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX8xTsOaxqzZPu
 1rWWXP+mGzEGf8+zccOZ+Dj499cGo4pstRsvUw0w7OoKKSZetE0jXKylLw4kJs16J07qqIBJ/Hp
 LrhifUjaMENkl4i5D9wkLPJ4KMkBaFRgwNLYXtKClLPs0Vd4VP2OrKNvglZS/WOip8lxugdMito
 AFr/kh8c/jJohYuR5q7wzKovBB/pD8i5vwCfYY4uymq4WglEFwhDJS0XhJess9rtsGdJzmQxI76
 BudSrg8Ey7PoKgksKyANvGLCpKgXDvWao7whnqTNDmdUk9uJh6N6HpjLlWkVdxUn1J6n1OMr0lP
 +m6tUuZmxZDMsIEHTTuc52QblLFkLTLYUwzfFysH3KOffnFdX0E/hL6MLZREzX1rybNBynR0NpV
 PI04xKhNAia7tmI64gCXV8MNGDRfOFIvAQVUHz+PlijMzH8839+oNcTExIomjKey3qVnHFTYuiB
 b6vnRqvXKXfmQwtkTLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

The "qup-memory" interconnect path is optional and may not be defined
in all device trees. Unroll the loop-based ICC path initialization to
allow specific error handling for each path type.

The "qup-core" and "qup-config" paths remain mandatory and will fail
probe if missing, while "qup-memory" is now handled as optional and
skipped when not present in the device tree.

Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2:
Bjorn:
- Updated commit text.
- Used local variable for more readable.
---
 drivers/soc/qcom/qcom-geni-se.c | 36 +++++++++++++++++----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index cd1779b6a91a..b6167b968ef6 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -899,30 +899,32 @@ EXPORT_SYMBOL_GPL(geni_se_rx_dma_unprep);
 
 int geni_icc_get(struct geni_se *se, const char *icc_ddr)
 {
-	int i, err;
-	const char *icc_names[] = {"qup-core", "qup-config", icc_ddr};
+	struct geni_icc_path *icc_paths = se->icc_paths;
 
 	if (has_acpi_companion(se->dev))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(se->icc_paths); i++) {
-		if (!icc_names[i])
-			continue;
-
-		se->icc_paths[i].path = devm_of_icc_get(se->dev, icc_names[i]);
-		if (IS_ERR(se->icc_paths[i].path))
-			goto err;
+	icc_paths[GENI_TO_CORE].path = devm_of_icc_get(se->dev, "qup-core");
+	if (IS_ERR(icc_paths[GENI_TO_CORE].path))
+		return dev_err_probe(se->dev, PTR_ERR(icc_paths[GENI_TO_CORE].path),
+				     "Failed to get 'qup-core' ICC path\n");
+
+	icc_paths[CPU_TO_GENI].path = devm_of_icc_get(se->dev, "qup-config");
+	if (IS_ERR(icc_paths[CPU_TO_GENI].path))
+		return dev_err_probe(se->dev, PTR_ERR(icc_paths[CPU_TO_GENI].path),
+				     "Failed to get 'qup-config' ICC path\n");
+
+	/* The DDR path is optional, depending on protocol and hw capabilities */
+	icc_paths[GENI_TO_DDR].path = devm_of_icc_get(se->dev, "qup-memory");
+	if (IS_ERR(icc_paths[GENI_TO_DDR].path)) {
+		if (PTR_ERR(icc_paths[GENI_TO_DDR].path) == -ENODATA)
+			icc_paths[GENI_TO_DDR].path = NULL;
+		else
+			return dev_err_probe(se->dev, PTR_ERR(icc_paths[GENI_TO_DDR].path),
+					     "Failed to get 'qup-memory' ICC path\n");
 	}
 
 	return 0;
-
-err:
-	err = PTR_ERR(se->icc_paths[i].path);
-	if (err != -EPROBE_DEFER)
-		dev_err_ratelimited(se->dev, "Failed to get ICC path '%s': %d\n",
-					icc_names[i], err);
-	return err;
-
 }
 EXPORT_SYMBOL_GPL(geni_icc_get);
 
-- 
2.34.1

