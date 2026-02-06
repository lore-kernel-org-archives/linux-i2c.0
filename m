Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B14218A8
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399766; cv=none; b=o5RwMWd2wu5nRfm9H/Gi2l0slzhBEOyqgx7vZ1+APZFWKMuCWiV3VCvrwGezH7jfpQCmXyy5ysFyePBV1vH2eoii+XW6bmMYFe21OrygboVjw/Faa+Os/PfSRnOOvQBSz8aHkWkDyh6s4WixOqewk1J9hPNB5HeL6SKOvfBK11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399766; c=relaxed/simple;
	bh=INGstpgJLmbXtSQabWLbgnYYayWnJH8f7H+COx7b8d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNy5uQhXw7iGvw5MgGEmbIMeIsAchqYWbBrGYiQ6tKn2HvL89xEKDw/E1MTEJsNwt+X8fclg3/geY1KUmT6Me2KeSqthsDenfDe0kyOqF3wIoijaXvIJGXMW6O9gKamGRQEE4cTs5Z6QucRXJI3xFqRfw9+IhJIp5TPKNI6WVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgMXsDSv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ApzYFOhX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgMXsDSv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ApzYFOhX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616H6xGg3924240
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WwOaKjslk41
	m/3sPlhy3wTfRdNt9ldvgK3Mn5lILziQ=; b=cgMXsDSvVDF+BrT7dY/t2F1V2PW
	AMGcVPcSr334O4cIH6ccS/YV6EvY5m/xlz7cIdeG7Xzn65/0r2MfhzbCmkfH7ENG
	BZ548M6nibpNAYLLMfQQz38t8ERIuXGWAJGhiLGlcaoruHaUV9gm0f02XQA1UFsj
	Y9qxEXfUB5FkWrUqZZacLq0TLwJGrEEccnhVdqBDotGeQrynvZ9R2VDbJ6XBoN+h
	C6y3/3IeGLKVYL4gYOrEuSaevaHrSsyXvnuZvzhUkwlTimPli9Oy4MS/atOz2h70
	R0cbsqux2Ll40ESXu2W9/hXe+XMNaF6pMu+a9mvEdSCS48Gw0vteeQPTu5g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5mdur328-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:42:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5eed9a994dso572344a12.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399765; x=1771004565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwOaKjslk41m/3sPlhy3wTfRdNt9ldvgK3Mn5lILziQ=;
        b=ApzYFOhXaIyRECKPCtL9xHJbZFeVFqkNvzUpUdJ/wcd+0iMK71S4vnxb9W9zUlpQ5t
         +3vG0kGYQT6gb0z544Kk6xsMIjAF449C2vJXexbIMX+XHJnEt62CfVVXYu4AUopDmYZj
         GXOqMh3km90yFCbev3fzsa69BhHQwRBxbnJAFtK/5CE7XGDya2sds3g7aXO54PuJTEpD
         9J+aAisPLveIPTdLGiRkkuEp4lzx0dKEMK7zkNGGZ+xKTuQrz/KjJNFhyhGl55TjBCzA
         CiMQxMo5ztZ5mCN8ZSRL4AhdlF78z1AQpaharUsSXwdrpWaX6WSP0qU8rTxE2wQAtiYm
         yfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399765; x=1771004565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WwOaKjslk41m/3sPlhy3wTfRdNt9ldvgK3Mn5lILziQ=;
        b=O1tcXQETgdrguZMIfmw9ozZwaxKvn7onVg4n4RS3fYN9FDHQMZFcXk3ZtY0y5D+QKh
         jppoy0qkKKKDetGQh6hdV7OAZ4M7fMbsHIKxAVyia7hyKbJmiUJP/mYJQshkvURsEb9r
         LXX0wHqyRt9AiXUhpjPyMmI2CJFE2tvcn6ve1rjvgqR8llAlpd8J9hGzusW6PRC9OWpa
         fMvtFE3R1o0y+V/6wi3zkD/EqyBlR6viIm2Bh/StDRjHK7gbu/hPSX33cXK4X6bm97t8
         5Rztjt4jL6/IJfDxtqnhnSdGVdjVr4NeJfcuJzlhYa4Pi1GPUTQqTjs/eAa9Ftx6PDEY
         Nyug==
X-Forwarded-Encrypted: i=1; AJvYcCX+wtZIbaj5QXtPj/zl5l3ok/jdVsNdKYQGI6dDKCN6TSUN6LkigHBn6AWc1QzzzxDzTCv3xtoAmuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dYyJilJ0jeAbbsNjyJWrif/jNhg2hSHg3AiD17X6QVKbX0Ch
	dPF/F3cvZyaSBpnFIGy/EIaDQP3mEjaDuaex3JgSgrNIYPBuh5EI05MhpYB3HW/KkHSyrJJ4N1f
	C00Nki5bL9Inoqfic4wIE3V2I74kcz4VODbBX0X/zR7qrbDuPfghh0Ac4VEP6xQA=
X-Gm-Gg: AZuq6aLkllyBAwwiYh2JmrDNji6QnetmFgadgAL1qARSreN1m9tSMPZh4x5NyrlZwrR
	EKAuojlTDNszDIe+AFZGzQhnXZRySlBaUixHFIbq/OijF4JV2JwmroWURjqo4P1nqNPWRRMWj4F
	NZl5plE2/H92jas5DUs6ptSIU4ZjeL0t6bg4RCFKqNNvgeatmjUhIl3r1WPCzGG14YgB3RkhMr8
	urGpa9C3/Ib0a9EJvzs0SrzoGn/bE51Ijc6hdXMj3D9fqVez9XYHWO01aVOlupVPST3/1v71QHt
	9vlT/YJH+3AswNak508HO0UsilWtBMQd8Bci0vGJRxlfBlmWQuWyY8EtqrEDgFyzE9I6sVNoc36
	OiRDu0zdX93AcCv8O1/SynU/HIb+mEi2Rs9kdvCiZ99w=
X-Received: by 2002:a05:6a21:6f09:b0:38e:9ebe:5267 with SMTP id adf61e73a8af0-393ad366d21mr3564249637.57.1770399764545;
        Fri, 06 Feb 2026 09:42:44 -0800 (PST)
X-Received: by 2002:a05:6a21:6f09:b0:38e:9ebe:5267 with SMTP id adf61e73a8af0-393ad366d21mr3564217637.57.1770399763929;
        Fri, 06 Feb 2026 09:42:43 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:42:43 -0800 (PST)
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
Subject: [PATCH v5 11/13] i2c: qcom-geni: Use resources helper APIs in runtime PM functions
Date: Fri,  6 Feb 2026 23:11:10 +0530
Message-Id: <20260206174112.4149893-12-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: IzqIz_r7YZY_H-_G0dTMwB3hhihg75EH
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=69862815 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=3PeDo36KSfG0vlEF63sA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: IzqIz_r7YZY_H-_G0dTMwB3hhihg75EH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfX9C21kbSh3B2o
 SMTRAcVgkwEL/TUGxvFZqtvEpKKesKhzAg4Ulvdo1ZJCplxswgYUFLxSl6ND0FHFQDKbHiNtFIH
 jtwCk4rFPDUl4a9UDwxjZgtZLWid0dnN96iA/hnMKQwRvIwBnQuefWolWDgzZFdYerGhJwEIjXp
 TBTfgwL0Wfz6O2qphAexqp/ogTdZicMuNX1tIGOAoAdP+kxSOqQNogzE7hUiEe0sAlDR9ueMkQ6
 EKMkbgONZ58RyuDfzWGHIhlcFFZDXW9cAm/T5kMrIRzPU4u3pQOl4x6Tx8v5GFN5fIahxrEvkCZ
 7k7fFKNB3akM4halNQuUqzGOB4l1TxRadN2rBwrge5VeATF2quZ7hxMWIuqz4AoMSgAs1DT8bCu
 5prI63BFL2qhWe9kr5vZ82TUuKxTxultdhT8mZaHiEgodmmc8WpxtgTpPnfb1LbpIf7U+fpfFcP
 S2znTZ5xtA/4D+jCU4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060129

To manage GENI serial engine resources during runtime power management,
drivers currently need to call functions for ICC, clock, and
SE resource operations in both suspend and resume paths, resulting in
code duplication across drivers.

The new geni_se_resources_activate() and geni_se_resources_deactivate()
helper APIs addresses this issue by providing a streamlined method to
enable or disable all resources based, thereby eliminating redundancy
across drivers.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v3->v4:
- Added Acked-by tag.

v1->v2:
Bjorn:
- Remove geni_se_resources_state() API.
- Used geni_se_resources_activate() and geni_se_resources_deactivate()
  to enable/disable resources.
---
 drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 05f5705b0319..0ddfeef6d1b2 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1160,18 +1160,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	disable_irq(gi2c->irq);
-	ret = geni_se_resources_off(&gi2c->se);
+
+	ret = geni_se_resources_deactivate(&gi2c->se);
 	if (ret) {
 		enable_irq(gi2c->irq);
 		return ret;
-
-	} else {
-		gi2c->suspended = 1;
 	}
 
-	clk_disable_unprepare(gi2c->se.core_clk);
-
-	return geni_icc_disable(&gi2c->se);
+	gi2c->suspended = 1;
+	return ret;
 }
 
 static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
@@ -1179,28 +1176,13 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
-	ret = geni_icc_enable(&gi2c->se);
+	ret = geni_se_resources_activate(&gi2c->se);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(gi2c->se.core_clk);
-	if (ret)
-		goto out_icc_disable;
-
-	ret = geni_se_resources_on(&gi2c->se);
-	if (ret)
-		goto out_clk_disable;
-
 	enable_irq(gi2c->irq);
 	gi2c->suspended = 0;
 
-	return 0;
-
-out_clk_disable:
-	clk_disable_unprepare(gi2c->se.core_clk);
-out_icc_disable:
-	geni_icc_disable(&gi2c->se);
-
 	return ret;
 }
 
-- 
2.34.1

