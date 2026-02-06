Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654623ECBC2
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399692; cv=none; b=ch1CzSwk40BjDJXtHeuW8Y3+eEGlc2pZH21C7tK0GV9YYe6Co7ZHPg1rNQLG8ml7mSZojllew7Do494CW2vaeCmSvg1exjOeuL9qJ3rpJrBYW3hcrGtfxFoyPxRKET/+vMiW0KBfW+W3uKm81M2Zo1wu+IGmx70mEUJ3i3FIKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399692; c=relaxed/simple;
	bh=Eck/D6KmwOrBysTJIIaZmSoFBAq/RlW1moTUSu+Xl3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCW4QVH/5l7rPwkLCjt2KPmpJ9TELnECqe15kCYwo4xSSEBM9ZwqnZfipEbbK7h3ZNuEA/GCh4sQT9VDYUi9E8kV4OSzcmnYjljMSYd1Cj5fqOcNDEBRrBeJ7TB5JMjr6mMdTQjyouVoZf1SJSGqfcmfv2wFManU5dlChTNsbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nAzfPwn/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jh00MLDl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nAzfPwn/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jh00MLDl"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616C0fOM3012240
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KnpiwG0d//X
	/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=; b=nAzfPwn/nwc85nk9AjCU7xRDEWB
	VpP+SDat/vQvWsVKF3D2qi71cA1E7HNqHnm4nEt6KMTvAoLTafs9VY5v7W0AnaX0
	XcxmortcqPPsaFZvn2OV2mrthnrVkdsuMW4sFH86hCLUnBm+z/1ujsqNbL9gJ41y
	ZbhVj4sN1Qcc3V3nxLYGZlud6+s2YSVQXUYw+v1UO+RZNiRwjM+9/tAaJNNfq2Nb
	R6hwOlDBtRxjjM2xw23xSpcJjHiD3fxn4waAmAsneumbC4yTfePCGP57GNXaxDUt
	UIkTdMuo8cufRhb3wJiiLoKmpaHo3OP/hEqayU5NqMEz/Izh5nbZdyEYKTA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c59ukj7y5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:41:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352e214cce9so1775740a91.1
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399690; x=1771004490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnpiwG0d//X/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=;
        b=jh00MLDlQVPpI88DL5X4vBZRcJCrnAcjMS6eWb8ys9nDimzx0OL2ac5tFQvk0LbWln
         VKwLfVhJHdHX6BZLl15dPADYS0Q2AC9jHSQAIYtd7VcTJXX16eo6KM0/XV9gjHNq940E
         V5o8g7/WydSs6gklf5CsJkhKEi8MHyds8s8jSMHZ2HPkPdHfjMyWD53lLH8Fr0J67m2c
         uLBtByWZJQQzN5zxntqHrlwB6HEBExnBGwUIWxy6q6CyhZnLRAOiguYVZJzkXz/15FLp
         6x+cs1Wbx59Howc/5fzh9YsEK0Doc+fsksgpBFGRB5N2Rvcuzknr63etS1Al8kjNQ1B6
         rztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399690; x=1771004490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnpiwG0d//X/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=;
        b=lJdxW1N/1Ckwfsh4/09SiMPn7GmcEreQyoaAuq1WpbA0gN5YqIc5obbkVTO6nYwHQr
         qU9LU1f6rZqVDlr2KINmhdQAHyyP30emo7hNsPfalBHgNiKfirmi/4Xf/ZVGViZqVVLD
         /EgTxRoOoBFIDka3eqM8m54LlWu9jWLibLC6WHverb0eoD3yd12GSZuE7PQ7c3kbV2Ke
         vDkKzdAXaxJzEAyung9ByFeSyUi6N7Ybc/dN3a8Ppb+6nGlwQYSLIFplCjNiI4fW5s4J
         WRv5+XNbXKjRNc3ZpQgQEj6wrv4TTiaToyG77h7+vfpKnKbZ/qpuWCa0Iak1qDj0fxbl
         mFRw==
X-Forwarded-Encrypted: i=1; AJvYcCUOejIpYMJ/gbTaC2nboaRxjoEfptG4RmPxOmRdd+Xy1isrjMeCn2Oe2GZykvDLEY0p8P2MWjTWB+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUICiznpEaq9zrYvwjLsd2I9guvzEu9aCdPUs1pQMdzCTLaI1s
	YeYL/kZ9DJOKq9A/B8iqnCNe8/B21of4mr35b45nEpL7bc/QnKDbyI22fLnc2qWMGSCH4N3NUrU
	zj+nLHrebSxKjxs6Zus7Huiuw4DJZfXY660/+cYAVdQ1G+1x7vyAMVoeiKCDXjhg=
X-Gm-Gg: AZuq6aK+1jhIu3ez1rIEsCC7yyT8SxCKbDnz7YIAsq9pdAfN20BbFA5+YiFP6wYcdbD
	JzXzQl5LeHi+TIHiT3PtWOWnJemouwzHvmd4x5tc/e1qj18pL6/bNu5L9BEZmyZStmB9+porrPo
	I9vw7ysT8eFFahqIWiyczuQRCqDABRp2I0ORrevsDFT0S5e1VFWdsVGoxSNbK/FdAWc454Nzr5l
	PlwhydPTGUQIZNnqwrl6WaleLsJXmKKS+XH9g5QT5Mqk1lk/Akigf2V+7BOZmq0MKmlSF/QpV99
	ueIsb+vJsVzsluu+gz+UQX4Q+fdvmZ00BcrvDhRg8YldG/paXGU2vQo8UbzOuiWqTxVMgNBYkY8
	FBvuTReccLsbcGTWW/rz6TELd1/bNN8LUebleYMUy6FM=
X-Received: by 2002:a17:90b:3a4b:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-354b3e6c957mr3013288a91.33.1770399689917;
        Fri, 06 Feb 2026 09:41:29 -0800 (PST)
X-Received: by 2002:a17:90b:3a4b:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-354b3e6c957mr3013250a91.33.1770399689320;
        Fri, 06 Feb 2026 09:41:29 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:41:29 -0800 (PST)
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
Subject: [PATCH v5 01/13] soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC path optional
Date: Fri,  6 Feb 2026 23:11:00 +0530
Message-Id: <20260206174112.4149893-2-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OM0qHCaB c=1 sm=1 tr=0 ts=698627cb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Wptve8LSCQjy2B8HgooA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfX5GVH5zFz5gE8
 nbLlNyzjh8eins0j15jCyMVvmUymdFsFrgYj7kDnfThEpiyU3XPJvTepUsTFNSXn80ds3ozM3xF
 5/kg8wi7y2cwuVFG8xjzEH3Y97uz3h9Nwp7yAudvlYmAvgU7Cfys0eNbLDMO94BO0wvW17MWper
 ByCsALE/iqNVKJKNtTrR6bAqjmHHKmTm/jZwXRCK0+4IBfiSxSUEIJpb9C5HE/dvH3wMSRt4zKA
 iRmh0ouE3fW5VoOw04LfzsMRtHDVGxR5rM+ZFSEmKj5+oexm0GFd8ynd9aulbOEFCiQzmWtd11H
 /PbK532xaBLzGfNWzavZ3+puZsEoeIH6msapD5YWhc+KYnebUalS7Pe8fA8xxHrqfb00OOVuGFz
 HMH+RxLdBw+AoJVn8WC/KaAcVy1yUgvp3Im3VTOb+TI5jdlJkDKcI2eHp/ZfWbxITZ70BqS7iTd
 9GulpGt5Peu/UwxZCmQ==
X-Proofpoint-ORIG-GUID: MtqAiKQKc2lU6Md4QVwO0OkUrSmhHS6o
X-Proofpoint-GUID: MtqAiKQKc2lU6Md4QVwO0OkUrSmhHS6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

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

