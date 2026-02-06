Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F193EDAA5
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399699; cv=none; b=Oj7lwl73mEpwM7HZmUZIXO7Z3PRK3DpBy/JPcTapnHMsp7CrOdlMuXuOsSN9PecVMrvDPvX8NyqAmSPDw7hhYVIQRxDF0hsX2ouRqwvsPsBQaY8vwQnvSCDET5st6tO1jn/M4yDwC6K9KMu5yNOnFNrh9l8pwrcS6B6pw+a1zBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399699; c=relaxed/simple;
	bh=85mnIBih5TefJNp/bHk7qTk7tspz31Q1DwJ4d0ufNMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngk9zUpt1REUenWtNT/AK0XEWUA/U9uvdWf4x0yu6Uhnc5pJwDLPZTP04sHZGvopjqPYrHbFUBnkzFg6ZfqztDadotFEJQFlZ3X0sLMLrFc4qrwbUnpTFbiNTe6A0xoXmaI95e5OJ4sqKShup06jckibUAcZKaEQhOitokSawZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PxT89Rws; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HKwGvyhH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxT89Rws";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HKwGvyhH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616B2mc22938808
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GkgK+E57psN
	HC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=; b=PxT89Rws7YMT1YLT2mfavkWPCrb
	1yOK9dRKKuWLQnSc8S1hn67RlNQPty+vKgafSvbyCu9V7tPnKqTrF1wqHeQBkqwy
	RtFJDVXSpee4mg6dcynUfi7eR7VLBBhplHBvDYh75StxacRZrA8HgpQ8LgiiPKg6
	q9YI5AuWrL91gkgdciLVlM4jDOas4EFhqhktlj2GkR5MDw69/PET/KePceVJuWtZ
	R78hHxIWszluHEOolL9QDCMt31n+4wjnkGs8bqobxDeT8vSP7oUBAW8cogmyTqno
	9UvNecGdrzQGlWJ5fGcMVlWIX6NdXGhMVCpQU5iDldeh6pcRs5s4YKuXEPA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5f35s4fp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:41:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so616725a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399697; x=1771004497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkgK+E57psNHC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=;
        b=HKwGvyhHN1spm/g0zLwBcKERNQmqcj1FVD7wNlUkxPi2CHRwY4bW+DlaM+ZciJV0bh
         SvygjDmbFrzkGTsfWOBKI4cGmAZ8c35FRSBk5qkdqY3Li26WEDvkPte2vgJfwx900sRY
         efN54Ey5+BKnIrLJ4HuwB8Su5wHtaEpBh/ZXxuvFkMarH9ngaUhw5KhdVVPXYvbQKFa1
         JC1CSqQ+mZuLXOqvC1bZ7s37jpDmDMDpB9YupnVSDFn3X0KVpNZMCzoilETe92f40bH3
         shbT5A32VWmfu5Tfq2F0MWY4wJ9M5ZoNdfmUgvTvIbWaeS8xU/ETXiAceYzku2pmrE1y
         A3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399697; x=1771004497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkgK+E57psNHC9wkY83ywNIDVuH2SOJteZ2XuiMuHCw=;
        b=VHKzOdIt7iyQ3GwnvJjcOZfH79TmOsbrCWpVcQ+2RELdshzyD3zIPRbMlnaRF3AkSh
         XaBl0eXkGh6WhrPS+Zx+Lv7lDbb5LcIamTOYiYrkMZAUoVGVe+f0/rMlGzHUa2M//BAL
         CYanq5D1xe9r3gN4LO37J7jVto9UqygawByKdTeHg52dIFY8LjAtnHGEGy6vLf7Xn+TG
         tf3ab+jrlP+JkugNNGKxZdlAsagKZ4L85juMwg+FqH8drkHM6WghuC61zp5u/FC4ifas
         hgQFN+q3fUuAJR/CK6/c08gOj6lUnwEg/RdusaEH08sScSuwwj2zshj0oDGfbHKzFB5o
         HIvw==
X-Forwarded-Encrypted: i=1; AJvYcCWzYiTKRviOxFuxeFNYwxssIqSabIu5N/NqfbmuEVaWcZNKJaYjAFfUXEgbpUc+k64XpjYSg3SRt9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGckDAGc4Y2VcFyf4BjFgxZQ89W9Czh5YXPqqCg/FlIAKDXQ/r
	AAZp/jWax2LfvmjqEidN2MjJZBAIkhNzPlmqFPY5Mp/eRGEe+bxHg2+doxpipd0vFNN5UuHT7NJ
	BupVDn2HaHId0hpEj+wRCCMB0shoyUr79zyItcXa9ZhF/ZYZJ+D7pwtHdk+8VrQk=
X-Gm-Gg: AZuq6aINrmfZ7N6HdJWV4As7mBHQgvA2FprzEAXkEm6PG5e6iYXwXvTsqdp+xQkRyae
	oE8RttCFz27jVWqnOafsvnc6xOsC7LYEegShcvs3TsBR36GBfIOWTArJ29Za6URgdBheGiD3BBz
	hTIO97Dp9JXV88H5NQP5Tx7AH6MPRPqQB0l6oX+YlAg5QRAniY04DXwlJQF2TounJLZ1HihvJ5q
	dfMXliatoQw0kmQonz5wWikYyJJ7+b5FRKTB4SG78T7uKuFbbGtdH/epMNxvT64FQhXWPcdMoPJ
	I43nsAJVuoWsmfqZ2EK6IGo3mY636paM9RdRGxiTpHPSUltBjpHz5oDX+dX2YRXuLmY5X1JCs4M
	r6wEWJ3HXAhr22+hqkBz49bkTyIkDMxuS/VqQVVmqx0U=
X-Received: by 2002:a05:6a21:6d9b:b0:38e:9ae0:3d5f with SMTP id adf61e73a8af0-393acfd32f7mr3821818637.17.1770399697286;
        Fri, 06 Feb 2026 09:41:37 -0800 (PST)
X-Received: by 2002:a05:6a21:6d9b:b0:38e:9ae0:3d5f with SMTP id adf61e73a8af0-393acfd32f7mr3821776637.17.1770399696631;
        Fri, 06 Feb 2026 09:41:36 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:41:36 -0800 (PST)
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
Subject: [PATCH v5 02/13] soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
Date: Fri,  6 Feb 2026 23:11:01 +0530
Message-Id: <20260206174112.4149893-3-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-GUID: wUabFhe9A1vsJMwn00oirfx-G9x21Hee
X-Proofpoint-ORIG-GUID: wUabFhe9A1vsJMwn00oirfx-G9x21Hee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfX0nfcxJE6kVb5
 AxtenJiypF8Gk4j00sxdMevDGEEKRMYEhnf44x7b0ZqEKLRJWUaiOL0qAHveKUOW94RHSzXNQbn
 v5bdxvmOM9DwMYk5Xr8OajlH2ZYLGDqG/9SENaWGQV1aCOtyf16Rhm10aETAK1mCqzMqpywLF20
 Xs88FQlQpMMopdCmpeh/yvhHDV2M96j+Cv+hmVGOwIrsMIoTL+VfFFOcTtwyxA4Zg/RgFVercuI
 GB2gx3NvE6UOghIg6ECcfFOr2aRjihB7MHHuSymNI1C3xMbUBARrmLPmjVcHTtd9sOwZFi0lwj7
 iwJ5gRbu/YdEwfl5yJhlvY21tPBr32aVZb3eJtRTqAaJd9/HeY2R1r/s7p5APBf/VtPQgyvXCc7
 ObukgUJYxzcAYmpQfZUbIYkcuqB/fUpTqQ6wDqhkn8LC3IEy1KbUs8rt07yjPI8L2o3B/TT9IOd
 qRwbcP/DQbU15PvoApg==
X-Authority-Analysis: v=2.4 cv=ApnjHe9P c=1 sm=1 tr=0 ts=698627d1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=BVB3BO4C9w_THQaB-9MA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

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

