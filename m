Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B052D2D9
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069128; cv=none; b=nNSId82E2qdj2BiEmCcc11wTA98j6beRYWaPQwfazG8C8ADrReR/quQ4SppuafQ9CmORW550Rda0aEfocvv+tpGQWGfXNcoIVe1u19GiVZ+idxwLAlWb9pvRExD/Qhwp2L3b0ryrTWbH1ivyliXj4E+WekHh6jFyuDn1ZH+eGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069128; c=relaxed/simple;
	bh=+/7B6+KUNNec4YWmQ4JNwvQrLYiUUliG5f8LtCctDC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vxh2ZF1/QXvlgF538okLUlVbK4xDPYt4rcX2ErhWnzWb8mfKAXajW5LKKh8/DnCNC23kal07R9IMp9EwsA3TIOrQ1r9sQO3zpBeG1UlAXT6iuh6l8T/YWy+cIJOnq/X9a3rvVtED6Qe6C5QRfws+LzerVv6EdejYanw95/IoyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mUnzuwGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QPGE9mKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mUnzuwGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QPGE9mKc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jVr12416905
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WhXW32ULll9zpgefHefrkMytXocm7R9Jk8nCG3El2sM=; b=mUnzuwGTHpxO7hSq
	kbG5hR56HTwd+13wpdZ2jQ5U3y+WmZUIWJzJ3m8LiLr/utLFLT3U4z0G77M2UOMr
	xh1rRh1ltjxiICl4veSnwDM1A7UbG/tDvBNsbB/ebNlLmhvNuKab6v8aJSh934ez
	bwkaazSoJA5/CpBpwVfeV7O0Lce7WffvAJKdaQwrL5TLQ3BWMXmFeZo/yRVpdzRO
	EKUpzvR6R82PbjoisnB44apDFWbcpz2NodBj8FXVCbc4wWiGbDOsDci+U7u0Wx8H
	u3suT5AokRakVNdOw990LCtwH5hFQa+I6X1FgB3E4M2XyM7RVWLP6rwhdGfsDp4r
	m7BPFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhj5my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:58:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e60770381cso47580955ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069125; x=1792673925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhXW32ULll9zpgefHefrkMytXocm7R9Jk8nCG3El2sM=;
        b=QPGE9mKceVf91sUFoSRlwtuLq54JLe1TDoK+bJVg4a8w555I5yC8WAVeJ+q6Rz5Q4Y
         P686upbLtv44GpB8GelrWl5GPIxuWKf+rwkUGZ5GKnL+6U56SRuBoPlP07IQoSuLvvUA
         Zpk0gFuXoJGjQMrqTctctwBp9ws2CbDAPe/WCOTuw219bCyBMlKIVBFrRH5HUrhbzbMN
         jU2pzvPfY42BFuQangMa4uyLSqegl8oQZQcSsXpwB3x3DdcYiS58gHyGFTb4UDDNZ5ao
         L53A1XyzYxhvMhoiCDa4m+gsGTNHgEK774Vfm5XXMxLq1A2YOmo5tdWGp2JizpYetqGP
         +sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069125; x=1792673925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhXW32ULll9zpgefHefrkMytXocm7R9Jk8nCG3El2sM=;
        b=xv1Vk8Jm4E7y2pXccUBDdt0UZ8iCp68JViqGXKA6C7SFj8BD83zH8/G7N57RLPXu0g
         YmTMaZWCZIaA1fL7YT5aeyesJ4EpG9GgvWpuxMqMtF4TEVDt0iFaBlEGTKKMBHQV+qbv
         YetyCMnmdw9v6lqDRxMWCRPaslnehVD5yuX8OpmWwYJ8fjKRBwN9t2qS44L1T8Asl758
         KqsOzAUPQxjKDA9s3PveVAYvbJ3MLxdgK0JbdYjh/B5kszDmQC4j49WEq5HbpkMMcrdt
         AmbaN06T8I025LkSya1qQNxtTlQI/svszLVLNDsYVSwi+j2zhWEM+iQes8EGF0jqcZoq
         4kKw==
X-Forwarded-Encrypted: i=1; AKwUvBwfzWFIbCsyrt0Y+tJ0Mu55kWqcMBkcN8ckWaa8NcTdIxq3j+UvimG/O4LX08g1TOtCPg47su1+dTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgytgGis+XGx86hVqxwxU5YDDHy/6K4UXYP9+VmVYJdXyQjllL
	QwkItNjyMvd9BoTxLhQ05g9Sv1Pwpu407C5Y6oWrxSKQCJT5mG8b45V0V/JsWdz2aT1XJFIvt58
	TPfd2KZ/ATP/sKY1EaJsK4WgxMQHlr/mYqsaTUdTxiUjlKDupA6bPPCSZb0y8jgc=
X-Gm-Gg: AYBFou30aRktbObpDfQcsKI4jkz/NVvb1mSL6eKIQ/JzAmsCm1lVEkkGpy6JfvW5Exd
	tkx0+a0i1s4lOxE0iywPb0QfYhHtEsGiwF+3UiwXrGGZDM2A2BPkM66g9ww5BO9jvuWVPrdR7R+
	WQUfoygiXdjr2OF8RrCFgB0D1VdZmKiNItBQlETHECZdYsPEhUPHWgGGUsqEMpwtmqxfKUZLFtZ
	bB73O9BMtOghMAWUc5t72x9V2v+E7Vrt0M57pXC3xP/qfwpWWi4pa3ZHr0L1CulN1ElIKPD4UiN
	hrTPP8CYZz5KlYAIbDd47HoDSgMf86MgC2E9f4Aw97I5VOe3ba84LCNRZmvYEOl4kUY2TgTZLEO
	KgFn5gjSNkGg1XvcepAwAmCZ1T6ecB+fRdQ==
X-Received: by 2002:a17:903:1af0:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2e964b9a8a2mr17283675ad.19.1792069124657;
        Thu, 15 Oct 2026 05:58:44 -0700 (PDT)
X-Received: by 2002:a17:903:1af0:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2e964b9a8a2mr17283245ad.19.1792069124039;
        Thu, 15 Oct 2026 05:58:44 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:58:43 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:21 +0530
Subject: [PATCH v3 1/8] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=3334;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=+/7B6+KUNNec4YWmQ4JNwvQrLYiUUliG5f8LtCctDC8=;
 b=fFiCNnShKg/JXYqcb5rRMrHGBdzcQNaF+nbOiZty5cBjDCrCjmBi4o9iRX9bQn6GzC0VxXrLH
 mgj0y4acWl+CdV09lM3ZfUH/UfH0tg05NyT1/BVoK7hGzhqNi1Cz+hy
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXy/b3bIwy+vvw
 LfJdBcMm+lbbQLP0/tyKcjmxSsRdtzHakaGrn1WAgePHBXJFrCtimCeYQ7HMIuoX4/63zAu/I/b
 SbumAL94ov1gqGM4VXiVf3tEN9qSTbzf7MhRXFhHRrStDB/o52vA6eztaLQ31aszeNu3UFb0jBS
 9bZrTcVrdPPTJpIbLIWWt90+lEcYz0p2bF9Wx5EjKzRxazpfGykTpyHZrgFTZm+I3E5HAZFdzie
 CZSC1nCWxkZL/ZVbdjeTc9s7epTkaDOhQgwX4CBSEED6conTOe6KHX8ifHqbSAv4Y5Wadew48xz
 tY62gfRuJnaMt0M4Mpmp8oNGqa/gSspmmT5Mw2zd/ftpYIc5xU6H6Rkznjas3a9CIm25MREYDqZ
 c1y2lR0jhA2gmAy888sR/rbz9iE09cXMQRz+xGuCiU1Zz8f8eEyevNYdT38sbNoM2S8IqgMtKB6
 viin6l/xVKORYpS4QQQ==
X-Proofpoint-GUID: 4iPf8IhTI1FWOPSt9pLlXsIO6gPtuBIU
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0ce05 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CVJBOM8IPza3kUTEG1YA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX37tHMZHvA+D5
 mg5hDW+tK8UZJOKlqlY/veU5VjyjYTNrohuMYYX9o/Q8D+CvlFojgVSA7EHKuSXfcfl13q+kRBl
 yGKxqzmmHgtpZJoWrAzwOD3tUGXtZdw=
X-Proofpoint-ORIG-GUID: 4iPf8IhTI1FWOPSt9pLlXsIO6gPtuBIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

Currently, on the SA8255P platform, protocol drivers attached via
geni_se_domain_attach() treat each OPP on the perf domain as directly
corresponding to a protocol value such as a baudrate or requested
frequency, and simply request that OPP via
geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
computing a source clock and divider combination for a protocol
requested frequency, unlike the Linux clock managed path which derives
this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
applies the matched source clock frequency with dev_pm_opp_set_rate().

Change this by treating the OPP table exposed on the perf domain
device as representing the actual SE HW supported source clock
frequencies, the same role clk_perf_tbl plays for the Linux clock
managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
iterating over this OPP table in geni_se_domain_attach(), so that
protocol drivers on the firmware managed (SA8255P) path can also use
geni_se_clk_freq_match() to pick the closest supported source clock
frequency and calculate the required divider, and apply it with
dev_pm_opp_set_rate() the same way as it is done for the Linux clock
managed path, instead of relying on a direct frequency/baudrate-to-
perf-level mapping.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 074087c592cc..95eeb9438a29 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1159,7 +1159,8 @@ EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
  *
  * This function attaches the power domains ("power" and "perf") required
  * in the SCMI auto-VM environment to the GENI Serial Engine device. It
- * initializes se->pd_list with the attached domains.
+ * initializes se->pd_list with the attached domains, and populates
+ * se->clk_perf_tbl from the OPP table of the "perf" domain device.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -1170,7 +1171,12 @@ int geni_se_domain_attach(struct geni_se *se)
 		.pd_names = (const char*[]) { "power", "perf" },
 		.num_pd_names = 2,
 	};
+	struct device *perf_dev;
+	struct dev_pm_opp *opp;
+	unsigned int level;
+	int num_opps;
 	int ret;
+	int i;
 
 	ret = devm_pm_domain_attach_list(se->dev,
 					 &pd_data, &se->pd_list);
@@ -1179,6 +1185,32 @@ int geni_se_domain_attach(struct geni_se *se)
 	else if (ret < 0)
 		return ret;
 
+	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	num_opps = dev_pm_opp_get_opp_count(perf_dev);
+	if (num_opps < 0)
+		return num_opps;
+	if (num_opps == 0)
+		return -ENODEV;
+
+	se->clk_perf_tbl = devm_kcalloc(se->dev, num_opps,
+					sizeof(*se->clk_perf_tbl),
+					GFP_KERNEL);
+	if (!se->clk_perf_tbl)
+		return -ENOMEM;
+
+	level = 0;
+	for (i = 0; i < num_opps; i++) {
+		opp = dev_pm_opp_find_level_ceil(perf_dev, &level);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		se->clk_perf_tbl[i] = level;
+		dev_pm_opp_put(opp);
+		level++;
+	}
+	se->num_clk_levels = num_opps;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(geni_se_domain_attach);

-- 
2.34.1

