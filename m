Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470532B994
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172971; cv=none; b=lbSuL1KsL7wG9kTfs2Oq80UiMMd/+nJRqg6a6f8x3230PlnXOTr3TqzXCwpRx/k0Haa0D+DYbLdqL1cAjY8aR8IsYSNJNqBpK2bSGhLPGUF8s+5x5J+BvoI+H8oz36/f4hsFiSZ/AGsss1+hmvJkBSM+SEFdYTw/+Qh2eYNv1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172971; c=relaxed/simple;
	bh=85mnIBih5TefJNp/bHk7qTk7tspz31Q1DwJ4d0ufNMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZYLx4neA7RXVZeTKOS+QnPVdRUd9hVTa9D8DM6ujBwvxYzuOv/vt1uLKAwjIC1wYLTtbEbW7PtwpcpDcfC+9ci1XaMbzRWbDmHSe9tdpzn/HI2PtL82p0w3L4hgOx/EK6zBLYxGyXDBs6PfLL4S6f3VbY7Kph55+9svb3n+nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HONesOLC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CuU+1nhg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HONesOLC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CuU+1nhg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2Jush3746989
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GkgK+E57psN
	HC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=; b=HONesOLCedQ9+wzv5b5Wfspo7aM
	BcjMYWNsF3vn3zLNFLA9uYem4eCRV1g5hVk23tdqbt2PYs5VtXDC2zfiFjRWVs2V
	bwpRWsDo5ltkKIvK8jARoHcv0d0lk0WReUQrVCyaWxHKdO2NRMYLtrUSZy6XGzRM
	a+ZBEUiBi6FAMeslkusa4WI2EG7yokhSjWMTyuiFCdQ2BPdOEh/KtV06ccNYwdV3
	rbqZoa7dI/CVvFuHSUubOsxIxsaltlVjWhL3pZJWVgX993FNuCB/QXE/S/LRxkTG
	jekYiluG8w/GtsaBSrsMtlHVQGItC5p6n77AFLjQcUDXkBYpeAW1JUEFdjQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur1tn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adb1bdf778so17068965ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172968; x=1772777768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkgK+E57psNHC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=;
        b=CuU+1nhgFrYmMr1LPszIVutrm6uKYNk4joN0/D/cKwwdpZLedqNaZr2+YczB4FWsU4
         FrAagrYLVF/0dCqYpXsPo4hjaUsN6JJ7BCtekFXTTOHof5JTBYJR1z24SGMIxHMQWhMt
         yT2oPN998RBQOatehfowacmHS1zb5FpFlNdM+Wmr0LBZOgiu09b1npq31FjP4R3ulNCR
         SqMDs1dnk49B+GpY8Ewc67C/e3yNNkDV7VZxiTFIdUijJ2I+gkyB45f3Bbnq727fO1uk
         ZbAr5iTmOosqd19qollMSiCKtGPyqrXp01Io1f+jwogMfGwRZLWYB0bW0npfVQg+8Mqd
         TrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172968; x=1772777768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkgK+E57psNHC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=;
        b=LYBm/DBoo9EaWUL4qcy5zaE1aOx15QRlUeD6aHSIdD0leanr2xqs9im6dQ5aUAm5QI
         R0Mb5elI68EX/IhHybOzt6pzlxdzPaS2yZSu79vsfQvCIsqxScCUxXF3yMl2p/+aDrzU
         N3PAz1NS50sRjvFDos52BNSn8aeZ51FBv6DmCrxafVKesjpuT0e796GlcZEM6djLRdKS
         T0tUE8vzZxqmyI/EMzSDBS20oCBxQLLmBQvC9hpjANp678bJWaPFwgTOXK2gW0XRs3KK
         qJ0gciPOlFPj8yZe3+sxMe2bMXaTpeTIQGa2ofCU4zDjordCSH69bm0UM3alivYUBDdy
         LveQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoE+HUsDUz+qHLdJWrsu1MI0efQlCATeZhXq7OLCP1MkiYalXPXnlPX3eRzbsC37EW+3hUs/EhRNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98O+MFtlvS/D3Y+AWfub+KY1BBgXsxd/CdrWeUsCylhmRcvqv
	4bkMwj87wwLSO/3JM9HUlql0wW01GPfyvJLIHEtiII+KJDDrrTv4yKPjv1mkagJMn+ra/iOHjxS
	cxJ6XMj5NpQGsqGq4qB7YTx/SN3aVPaetPpOvIDs7FkWP+EgHvsuETIgc9B/98Ld6lrt3nuA=
X-Gm-Gg: ATEYQzyGAUt1lzwRvsQbuMr8tso6YgU0qpHWg/kBwrVJBzuQUvNImWOC3gI2nQ/1ggn
	O76vioUiopO9ZTlkv4C+ePZ/OLHhAjoV+4DIzjl8DKqK25LnPriv1zNUCyKLmzhZduHE/wuH3UX
	mlg54Lcc3CHav0WLJ7Xbh6CpmkGm0NknAJNChlv5gAIt+8opqhSwVDBrPk+37xurnsdamgx3Rla
	TdHS0B9YxPUkaZSUMmyNUfCTfvE8yVTUcTf65ec0Bw9VLF+itos4JRqoZkH4jEI4uXck+nGMC4E
	veP9DmQwN6KCWsA7vouzHhgf0oN4oanGeTyo0KIw8PqOsnNVoOFdt1eJAKTG03fg/XHPSFDdh7l
	OnvWSKyAxcoQcQCa0Edmls74zHboRTi/rvPYZmBIDjiMAgPjjUIg1DXQ=
X-Received: by 2002:a17:903:11d2:b0:2a0:a0cc:9994 with SMTP id d9443c01a7336-2ae2e4d6114mr18570315ad.47.1772172967678;
        Thu, 26 Feb 2026 22:16:07 -0800 (PST)
X-Received: by 2002:a17:903:11d2:b0:2a0:a0cc:9994 with SMTP id d9443c01a7336-2ae2e4d6114mr18570085ad.47.1772172967100;
        Thu, 26 Feb 2026 22:16:07 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:06 -0800 (PST)
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
Subject: [PATCH v6 02/13] soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
Date: Fri, 27 Feb 2026 11:45:33 +0530
Message-Id: <20260227061544.1785978-3-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-GUID: ia5iSJWiKrMHzroBl5MSST7bfi4NmRCG
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a136a9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=BVB3BO4C9w_THQaB-9MA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfXzyp9BS0KbjO5
 IHEtVCzxPT7w9XVC7sxeGoJwC9/92lyLNYILszFx/08+zYRFXhEFOfGrrxSsjlM5WbLXe4eiFLM
 TPW2ULGY+1YT3RaybqZMOOKw8PvhWGeb3nbV3t14dZPf4RBOMhVpwKnsAcpVKkn1Fja5YpZcfno
 7LblejxkcmqoeRSn3al9cgAiM3uqCashqZ2fZL4lhN2q2iWE7ye3Sqjiy5WfjUlI/jWLIBQKEGM
 TNmn19nXzbHqGVvVumH8fySNtN+YR8jFhr/nhFqBcki6MLwB1lm/AFnRKjlc/azEJ9aowVKjXr1
 vePNjsikVd7kZ89svzztzpNT1AiMk48vhQFMkAGHQAOFvb4HFJg91bikyCY+rMqugJ5SfvBCw+3
 rrPeEoWWJfg8m0kEaXKhCcihxFQs4YTWrbmMOVOBrawQicBhpj/WYSK/AEZ1ymiAUlcCRPe2FzA
 PNAKiP3z9Rm0u8dxiJg==
X-Proofpoint-ORIG-GUID: ia5iSJWiKrMHzroBl5MSST7bfi4NmRCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270050

Add a new function geni_icc_set_bw_ab() that allows callers to set
average bandwidth values for all ICC (Interconnect) paths in a single
call. This function takes separate parameters for core, config, and DDR
average bandwidth values and applies them to the respective ICC paths.

This provides a more convenient API for drivers that need to configure
specific average bandwidth values.

Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 22 ++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index b6167b968ef6..b0542f836453 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -946,6 +946,28 @@ int geni_icc_set_bw(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_icc_set_bw);
 
+/**
+ * geni_icc_set_bw_ab() - Set average bandwidth for all ICC paths and apply
+ * @se:		Pointer to the concerned serial engine.
+ * @core_ab:	Average bandwidth in kBps for GENI_TO_CORE path.
+ * @cfg_ab:	Average bandwidth in kBps for CPU_TO_GENI path.
+ * @ddr_ab:	Average bandwidth in kBps for GENI_TO_DDR path.
+ *
+ * Sets bandwidth values for all ICC paths and applies them. DDR path is
+ * optional and only set if it exists.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int geni_icc_set_bw_ab(struct geni_se *se, u32 core_ab, u32 cfg_ab, u32 ddr_ab)
+{
+	se->icc_paths[GENI_TO_CORE].avg_bw = core_ab;
+	se->icc_paths[CPU_TO_GENI].avg_bw = cfg_ab;
+	se->icc_paths[GENI_TO_DDR].avg_bw = ddr_ab;
+
+	return geni_icc_set_bw(se);
+}
+EXPORT_SYMBOL_GPL(geni_icc_set_bw_ab);
+
 void geni_icc_set_tag(struct geni_se *se, u32 tag)
 {
 	int i;
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0a984e2579fe..980aabea2157 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -528,6 +528,7 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len);
 int geni_icc_get(struct geni_se *se, const char *icc_ddr);
 
 int geni_icc_set_bw(struct geni_se *se);
+int geni_icc_set_bw_ab(struct geni_se *se, u32 core_ab, u32 cfg_ab, u32 ddr_ab);
 void geni_icc_set_tag(struct geni_se *se, u32 tag);
 
 int geni_icc_enable(struct geni_se *se);
-- 
2.34.1

