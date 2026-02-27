Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0E32B994
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172964; cv=none; b=XGofV8AYE+Hb5tV5dw2gw/84TCrQNHJSoKv+Vp1Nsnxks2dJR7bTFKcK9zoW+vzsKLorhjrifeWR/oBtt1EncqxY0GtQDWpPCSqzBmKHMxGrWlRpX4myOL8Lu8XUjLw1JZXzfJz7z0MZ8kl+cqH/HgC/QZdSumB91n+HdqATCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172964; c=relaxed/simple;
	bh=Eck/D6KmwOrBysTJIIaZmSoFBAq/RlW1moTUSu+Xl3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQe+yEQahvAn8LhagS8Qy7bijYTkBiumIlxisu0AhdUs7UtXlE2nNcStgLBw3jBnMDXPGyRCroWkeWc4yMoKJjnPeAe5135ei2tmnyuB7koF2l6nbtbJ1xtUKkTUpqZ+qBMKfRKzLOc9w/WvqaoAa7hLgdiSGxUQUbIKzN/n16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TUq8BI5o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6glwckm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TUq8BI5o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6glwckm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K1Yg2353440
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KnpiwG0d//X
	/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=; b=TUq8BI5oP0uCUQMb/aMfSVM7/4U
	rLBldCkEcVQDLwjBG150mjFIK9jWCB/erR5vaw8IOVgeoEhTRLl6Utggp+ATllp3
	tGWIJl2Ct4zmU+TuPxbqRHbF3leCcIpUr5Lq+ReOxv5mXBm6qER7NIBBQ86BNfT1
	zFe+dYAIubWB8s1jLgiGCF7rD+P/RSgP204IJfRRwIXkrehHpBuA7QAvUrSgP0EV
	dINy9xWxlpKQoqzCaAu8UXCYu7C0wrZOXz14oGuL2py7XHMo26W3f6PDSoLNgcc7
	kcw9KVAgMIB5K3h3DY4zvX0qFcn5puFRmpBzCcy1lIL1RWy1M48oo5KDn9Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8u3j5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adae3b2135so74043115ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172961; x=1772777761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnpiwG0d//X/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=;
        b=L6glwckm7SPTRs2PuRdb2xvTV+MebXTvAbU8xmdjy1pFQWI83S1LwwhgEvykaPSGkX
         7TKCeOdqbuSVrANiOisRzduXRck0lE2B76PBy+qQVlg3ZWCFC05CToswMW2y5JsFQ5ir
         7zeUDGjiMTdsulH3OKBaLYTEOJtxC+bImFjYU8qiCvdJghZ37iqzoZ8G/Sh3bL++FNcg
         UBgeij6J6b9c2YGuHLrkvD8KcnCOchhgh9hp6PeaBaeDWGBYglwCCJHJCtvlwi3uR8Zt
         IWqZRtvzkYWSLlyzsdLHDPNF+yRghn7rDc6eyXV1jKFgATVZR6FsQtha5SPBsCqz5tJh
         JlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172961; x=1772777761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnpiwG0d//X/Doe7m+7TdtdTnhg6HQ3OqoiGCkLu8T8=;
        b=sQNC8dU5SeqypnK7VMo84tAJwoQi+rE7KS+mI/lW3fBsuluA43zkGB672nXn4fg1MS
         Yax34t2rXTx5J3qSPzeogq2CZ6uc2PDwEfT4l/pC2m29BjeodSVNDWT8yq0HkE1M7ErO
         hWc5r63WJvETLs4FwmR2Cn3nqt4RTSkYQSSa3sliDPhfXUbgkEF+ti+KbJKZjDpU/goq
         KFyLcYWn8Pf8NxvvhvYk3ZtfjayHaMATaB/p0EbC7CI6eFZUqaixOKh+xgjEA7l5Rw5g
         hS6/6bPwEV5wVwI3P06MeUiXjcDkSV0jDrTZrNXyOna3UndlVEh8NRudxuI0kZbRT+Ll
         CWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdKDSo/A1BO/OQmuamRqt+OcQFGhYPM19xhf28nJOh7vN5Yj90peH5y++F/dXeUTnyVRdzl7HjTSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKe75W5fIq6vQaX4rX0b5QWtEah7YmIpSnmmzKGFHkYTjarAE
	yj2rqOHZwW1EO9ntJ38IIHSBw8zd2ZNmFMxikguJB4XOgN1o6nsHm2AybkbbD/DFvCThUClPj7U
	yDJMitSJNWg2q1nh0XkzC9aeGEMKzvcIek/RDIcJJjiQcAdbQRcKpPe++5i2wbSI0dS2Gc58=
X-Gm-Gg: ATEYQzy/j44m7y0NELsB6nCW2OASTY8hFi9wU3ER2Kasnx/LxKnipLlz3AykmBiVvM2
	NUH+wQ1lwagveq612vooy8eFYsqwvjNuW91GdL/o0eAc6vb8onNLJlUjq60dB0CzYie4b4SnpYB
	o/Jh+5/YoBGOisJbUFys5jPJS5byY/L3AR1FFELrl2fFOQv/UpVhclQYaosbxEsb5LpIcRm/rj1
	6rsPYHWvo7idn3UnkkYx9L7+dE7zLDklyIu9RE2tgK6vfAM/Pwqx5O7x4regXG7QI7ztfukIspI
	xLRAOFVNmhu0FXesjoxG0deqK333m1ouTgZqVF8LpkwEfpcOMDL2hMNC579aZTEM/zKiTkIRDkh
	dKHLOmRFng1HfSZ6QLnUvpsgHvFuQU3fUHcF/++hWlt/W+2PrO9XiNFw=
X-Received: by 2002:a17:903:298b:b0:2aa:e34c:4c8c with SMTP id d9443c01a7336-2ae2e3f156amr15664755ad.20.1772172960843;
        Thu, 26 Feb 2026 22:16:00 -0800 (PST)
X-Received: by 2002:a17:903:298b:b0:2aa:e34c:4c8c with SMTP id d9443c01a7336-2ae2e3f156amr15664435ad.20.1772172960303;
        Thu, 26 Feb 2026 22:16:00 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:00 -0800 (PST)
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
Subject: [PATCH v6 01/13] soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC path optional
Date: Fri, 27 Feb 2026 11:45:32 +0530
Message-Id: <20260227061544.1785978-2-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfXzo4uaA2raDWL
 xa/fKVxmzkq47P6qkDg44N752cZmc7Y81ybfliqALIQ/NV1ZQ/cQuq7zrt98qpgn+nRcJZAbtw3
 Y5ly8Km2sLKWem+njvgOTvN2h2a2PUSQzu9CtsYdOPPQihz38B1mTV98GlH5h8MFjZZfzDiDyzh
 PULayUBPcZMFFNeqdVikQCUbJFRTD6d6C/lrob1Lja873nF0bDAwbS1MKDE7TltywzulWGvH3he
 CX1FOgYXJpkwgfYFa4fg/pehC207KTViSK3g6TY+iIAoN9d8IZbvZ1auhCefoPl4FBZZnS5kH1T
 B01UiGumXiqthrLqHGV3RtQEafVa6YFcGHtQHGj3EOzvmMk4b6jXud32mCje/6F4+W+vr2+Hzyp
 bspESdjUC25LGnl3VJGy14dLvdYzUJxbJSCw2JGhWsGd6HhevVElOdxpPK5xZI11jXfwYKHK1UW
 HBIGjPJBXVdp1BtArjA==
X-Authority-Analysis: v=2.4 cv=O780fR9W c=1 sm=1 tr=0 ts=69a136a2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Wptve8LSCQjy2B8HgooA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: CJEyA6BzmebUZojUNE0zk39ysMlXxuGE
X-Proofpoint-GUID: CJEyA6BzmebUZojUNE0zk39ysMlXxuGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270050

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

