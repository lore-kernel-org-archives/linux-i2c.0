Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665B2248A8
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055794; cv=none; b=h+lNKYliM1IA3d+Eurm6lRfdOOYoTNviURtw+JpABZ6YQmanP8mKQW/3Tto8ZpGO/DMMHI40Vpld+1G20iuEnLclYY5P0q3OznHkwTF81MMlCQP+/WNsf0yCBYkR29k+23Qb9joD7cTrWFDssHh1LnmCTo3tU3qTLzgWrI9V6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055794; c=relaxed/simple;
	bh=85mnIBih5TefJNp/bHk7qTk7tspz31Q1DwJ4d0ufNMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYsZpW3XRewFojryT/OgNWgbhhQi4EFlCl7zkOB9/DKvtVSaBtUHTyxDtpwV9ksXdUYX8PYNx89bbAPPr54RLo1nBbvjPpZkIBDKG6znS1G9yz+ykIi7t/6wBSmPvZsaE8nk0Yqbi89WIvEJ7y28r2KAPlcK8WtITppm+c1Lisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cdj1Q6fD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=htB4Gip2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cdj1Q6fD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htB4Gip2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612EeZt61592873
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GkgK+E57psN
	HC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=; b=Cdj1Q6fDwfbIA7S8o3QrPI6EXwK
	r61AdGiJkwPjx86OAXq4z/EP/0otQHvMhXG85d4DcdX6G+q82wzhjFZ5g5Ez1a0j
	EP4E6/54G9eg+4LBXcSCtgqlm2RciIxtMUkNLXFljaGtgeuNc4cxaXOibwAw4Cjr
	xsqBhoH6vqXiNvWEonCPC/iwy/VZIFHgCY8exoLRNkioOyNo4T+JNIqtuTz9yV67
	Empjhkj0mdOfh9P8AbGCpSrMthecPGo8iUtzpUb9Xaleos2ckuZg9kk+ejsg9ucv
	IPh16qNTm0LHGGMerF6ToX8olLrSqs6fJ4dXlE1QU0W+M74Nw9VW7XlxgVQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c23h1m70h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:09:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82317005ee6so2386554b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055791; x=1770660591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkgK+E57psNHC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=;
        b=htB4Gip25l4Wh3IErK3RG+2tAAOeICaaYd7ZWZRi5Wpr5xwFz3b1tg3K/t8FElm1Ef
         2DHjTO03Uq4EbvFPJxXK6JYiE6quWQ9gCFFbV91gHvuV4baS/o6sSBIUlDHeDxXHXDgz
         wC6veiPK5Kq3e3TZriAttJQINkG70pwQQxHqZ2ohurqul1P/gIMvt6ZGikA/Taroo2MW
         X6pw0Bjv2fKYTHdAx28JJE2ezS0RDa6WpnnoRhun7bUD3lL+e/IA3h+4nL6SVXkIS6PQ
         4/lSLvH1SlrHHGZnDJUt/nDP74MaAqHqXqZUPnMSQEqyZJPE0vsb/qv+PteF4YAG9BYB
         No/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055791; x=1770660591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkgK+E57psNHC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=;
        b=WgkEI5TjUZcAOntPds+Bij+e8AVZxOVKe/MxTcnP0JPD3+9QELIK8l0/+Y5vuFCxQx
         vc/5c+gTgQbwRxmJP9hkrYH/x4evesolkwYtA3o3uWnjJmOEXvzNoZaNdi8NuMTxpmId
         7XHgJmk+P3No++uISixeMZaloz/+lsHf0b1aiTfRpmWNtWvMR+gF2bcv5e6iyDNf0gEC
         jtUQiyWkvsYytuqwwLDlTyQWHPEu3dME6eeEbolPKGv/QrDf1rThgbmq8Ce2kEL+59rw
         Yb2mO7+qrngPsUf+i8ntE161QY7I9oTUsobmBrXoLjEYgtSZpAfXzBCaq50R5dOr0Mjb
         OBbA==
X-Forwarded-Encrypted: i=1; AJvYcCV8FK/JRPXIx1e0Q69iIf8Im9XYUyJmwLrB0HFE/ehYUUQUvjZYREenrmyXIYRE2ER+C8Ahrx0a0zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/a6PBzETD9qb5yjKPr0j82xWnicxvf/PBBPIIcY6VUSRVH2P
	UczJ8ZculHAGXcvqq01f3/b+qaJ57rqaT7KlpRFvjPgcUvS2nApESTm38DvORpB70L4LpBhsGgm
	pb2tOjoFRfIs+MXPEBZSm2c6OxiB6ho3YL5d2qFwo8vRI+OMhJXLHgC1FNlD3IfQUMMCRb6M=
X-Gm-Gg: AZuq6aKaI5swcD4EmOuoKfNDC2cTa0FoOjGwbUfoyrL+16Kz3Cq8pOdBF15U6vZc4uf
	CIxysTTX+M2nyIR8VuOBFsygtxwzyD22OJbGji+QMZZ/daBJ/A7l54XTj9MDiwzDjxYYbRlBWJL
	2GagllB1IpaqWLLcGisNGuQFkxWpVNdFqVJ0DKwkDt82juxq78XgQveejwnp9AaNFTy1c3OyNPB
	ZCK5LRUAF10BWQB++vRVbge4FzcoqipqojKpLb5416El4jPHwsKbegTYnioakT05fW0Ayih/8Hy
	SgFJ3pF9JWhBIFCrMsbD1VSYKfDrzJLYQcHPinRa463+eY+svz/AD8ORt7KNTr0+dx05UA3geiv
	lchZQGpw+aJ3Sa+i/lewzYa+lo0de4apT00+/2bEqqEQ=
X-Received: by 2002:a05:6a00:a512:20b0:81f:40e5:34c3 with SMTP id d2e1a72fcca58-823aad8e0c0mr7459921b3a.65.1770055791414;
        Mon, 02 Feb 2026 10:09:51 -0800 (PST)
X-Received: by 2002:a05:6a00:a512:20b0:81f:40e5:34c3 with SMTP id d2e1a72fcca58-823aad8e0c0mr7459882b3a.65.1770055790631;
        Mon, 02 Feb 2026 10:09:50 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:09:50 -0800 (PST)
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
Subject: [PATCH v4 02/13] soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
Date: Mon,  2 Feb 2026 23:39:11 +0530
Message-Id: <20260202180922.1692428-3-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-GUID: jHgROpSKLBjeL9A3T9Pgo5VcX1ZeEcDP
X-Proofpoint-ORIG-GUID: jHgROpSKLBjeL9A3T9Pgo5VcX1ZeEcDP
X-Authority-Analysis: v=2.4 cv=Fu8IPmrq c=1 sm=1 tr=0 ts=6980e870 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=BVB3BO4C9w_THQaB-9MA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX/KMRb2p0Pdb8
 Q8ucowQsuzMEG61ClWRn3K9dbjRU3oE8YnEyhnc10kiji1FOOXw4x6ACTdp9OT6p6B2XAyG6o4i
 0lNFZsfJPZjlg9E046ktaEUhz6L2/X9rRPz4EYfT+vW6a5KMectW3Lwbo6wtM/GfIdVFMde6MtG
 EcOaCHlRaPeB7GccrnAwifdsk5kdUBlsPRhZBvIBZdzq61z1AgZ0XeQHoUE6nHnowqMJd/XkzmW
 F4NtEov84J7nlTOSBTeaeY3n5rLB7ruYTnTtO15YijDHfn1bgynbGThEvnAxytPlvSc2mubw/1o
 G7MUMHjcKPqP1WpqDIYq/1pCp8tq+iKh9gvi1a2AUp2MZ1Cm1+FUrAZx9itYgGL89hKfwIwZZsp
 j6TM8pddTx2WbBl3uI+yWObGtKhpVC96fIMkaP258AGklKhAQYk7ThU09QGGsNG1EXQV3SA9+XU
 3I/WfUUpNeiqGdWHzog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020142

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

