Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBE38BF9D
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055831; cv=none; b=gwLm1zXM9so7H3gLXX36gyyoNVoOJ9a3F9YFfNld1C5V2bfz2ze8ddzYZMWrSZ5JoDQBF7gzRpLtzuTWjlW5Jrwo4fO/7JWHxVbM17TiR0UUytiFVxKRZW7q1K1vEHVLlY5YtBCl1ewtCgCYsiYQTjH0vaXVf+Ai0cF2eFyr4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055831; c=relaxed/simple;
	bh=u7ew6qh+piNDH+u5pZnf9q5xI6HsyRCZPq8Bi7+YzDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZmt6VWDdkVc91JZAqydbDv609t1F1zLsw0ydXE3JtaQIJEsrpsjN3qY+62FRMzYY01CrFaAoOh1KEUqspdCo+ZJtI13ptnhcWx+T7zcrNtbrUELaCDb7LzmsGyEQp6n3qoScs5SigepiBhBQ1bjMwKgvABwIvIXKYcuiB/mv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5xcBR0w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SL2gyjO3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5xcBR0w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SL2gyjO3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AvnOO2261754
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+hhRIcP4ObJ
	nfpPZ+yGg/UX1gYqSYL8XEGYmg5LvFnk=; b=O5xcBR0wAjBp3Dgl7D/JTcx3+Tu
	8jQYYV7X4fhmhLqXdmGRQaIuEpaEe9ocqNvRaqJMISDYrfiVdd9Q0Wo3hsVYKdRk
	FzMVtBb2JWLjRKUVaJYceBX3Xz96tZUwm12TWGCK8BRL0JLHnNC7fvhO5l8DbI47
	z6uadSfP/u3fOnJ8CwmGaQL66S2i1LljdlouXYlFzC/ObBPwxHxjpZqXhklsd0Hk
	9ENcu6cg+AQCTeMrhrEi37cahB1RQUSIv4Mz1bh/d1lC6yhXAhn9MsTSHZRnQQwl
	ts64cmYa2zYIfp7lFGJ0B2WYaOkDSUr9Yx2Ft74xyf98Mj9gkcbI/nGYA9w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tmth9b3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:10:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7701b6353so48496885ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055828; x=1770660628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hhRIcP4ObJnfpPZ+yGg/UX1gYqSYL8XEGYmg5LvFnk=;
        b=SL2gyjO3r+05UrgxpDmeLDkI+vIIqxcTEAI0Ye2I7v0ekrl6j66bLcfhgtn9EKAYl5
         ZGi5XZy0xEWA8Bv4KYtOg1jGO+I1JJOZmsFvn7eOEDHflSnXxMzCTBkYV7w0oF+LWIUX
         X94okfWHJjTHxzmUD+9MtuqN+VYCcKAQWg79SWjL391YX3yrggboKLpgLKD42+TXHAeu
         QCMAaDATgUZIUwnQbYW5WgL9i54AwLo3ylwUMHb8rwwkZ6EjE/cVFqGQjdgz6MvwGPtC
         guANJS1QjOlwv9gaCGIw6+y/Pws+s7yK7ntQ5F1xDGK8VronNq9NDpGiyjKubLH4j47t
         5jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055828; x=1770660628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hhRIcP4ObJnfpPZ+yGg/UX1gYqSYL8XEGYmg5LvFnk=;
        b=p/xtomxerpPQ6j9ScyzxEplvnDW3dcLaJ9URXF5aJby54eb/VDgaxA3gta2wiyAfPs
         PtJ8uVJG/daU4EUxDxaWsk0z3mz/VXQsfciJ9cV7N2J+5ou6E7awJISTLRt9vf+fKN74
         wZwjsc50lDDzh8tThBCer9zvEJFNhKfmQjy83z3cUwdk9Gq1Eu/qprcyiG6CpmI56Zpw
         lj6Vqgh/n9SSIXpfd30pZb00Smr0NMViK7OQSuhjQ/Bw/XQ5VK5YGHwmPW90yCvdptJy
         dA7ftx/xdKqWLPShUUfux7RQd5RcW/9kkni8kgs3oX4GCl96svfai+mzmpG6ydM0sO+3
         4w3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeW14taaVx3T/6O1O5J3tT4FZrEiJMDT/m8+qPcN1OMYwzhcaePUYc1zIybYTZClSO3eFGTR20BrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtld2Jt+ZphSHQHZ6DqnXaFSkxCcSrmriLTmf+C8KbQt3yV6la
	JjkwrA4YWbdUiCCDVk/bJco9TFugNcI8eI595IM1sHxezL+cykKpoJFNPVrNwRQk+vNlifOfwQf
	WhlgFynS6vIFJ/dUPVZ9nNE9szFDjHxHNGYA0RfLccC2T1O4tQ7tr7RQD2hcfLV0=
X-Gm-Gg: AZuq6aJ94idFJkH67Ot0YfhwG/aSXfIOAODThtR7oy52R0+RjwKLjTt5iOf0LuvuJfj
	EMG+cT0414JmGnjD9JNaaXyjWPSPB/dsb9BW1NHj66jqF2+TVjkn5O0HGuMDKtqRbarkReQsrDe
	QhBAXpGIwnX1wEUWLzTtCsUj3DuNoFyx4aP7o7Zqs3elkqCa75pGwSZiKtBgAwlwXOT2tb0ZpE8
	sTtQAPbvgzIN6sJdZmq4+0bd7tEFgPvl9SOf4qNCdxHo/+Hj8Ec4HU9nB6g7l8WaPLGsKlonHw5
	stcPJqJciRKAFBDUTt21ARLfUwh4Vt0973CR6TQ7lFwA01RCQDFxHWDIUjhqdV4XsbyVMHlHKzw
	Vh6B9pM3jDJuOImvyMOPd9PwaX7f/t221IOOlswoANDk=
X-Received: by 2002:a17:903:2c04:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2a8d7eaadd2mr123033455ad.12.1770055828486;
        Mon, 02 Feb 2026 10:10:28 -0800 (PST)
X-Received: by 2002:a17:903:2c04:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2a8d7eaadd2mr123033035ad.12.1770055827918;
        Mon, 02 Feb 2026 10:10:27 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:10:27 -0800 (PST)
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
Subject: [PATCH v4 07/13] soc: qcom: geni-se: Introduce helper APIs for performance control
Date: Mon,  2 Feb 2026 23:39:16 +0530
Message-Id: <20260202180922.1692428-8-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Xb6EDY55 c=1 sm=1 tr=0 ts=6980e895 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NwCh5GMA9Nt760FYQHkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: l81MSSjC3wClAjv198EHVMbr6rAye5pl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX9YZhVOp1qTQQ
 cj44QIeNZ4T/oOIrl74Yk80wBDmWcXJFEgmoPdfDF7IpWwfn0e30UAf7QoAjaFVJRy9yZThIU69
 /a5guVVzMykLo5b7jScxLVtIxu+YkuRPcMEzMN5ou6OIJMI3QmYI7BfVXD7ZPQ1dLBVYmHQXIqV
 2+WwlZ6V1cvw25ZyLet4pdFlCJG/oypnG6FqmTODXNjJYfahW+iQggEwHP7VTLIEKMl4JxjXuq1
 TYwpxk/duclS1Lzo4de2cG1xQX6rtcQGoRnP0RW9ipnZZXS9urKeQB+W8YD0Fs0cts0XcvKio30
 bVpo7bNIOaT5RQqr1PtqoMwXYCC9qXZHKlq+C+eJBfRKZAPQfqAxqtCd7hMzIUUnHKjljIZNY5r
 0mYAtpWw4sgJbKjHtyk+F9JoJIiiMB/9SjSBJHv3p4hfrUUr7GKLlTIOvck301Uec+TSfwDR86V
 5+SnSHWt+npLyjCDQ7A==
X-Proofpoint-GUID: l81MSSjC3wClAjv198EHVMbr6rAye5pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
manage performance levels and operating points directly. This resulting
in code duplication across drivers. such as configuring a specific level
or find and apply an OPP based on a clock frequency.

Introduce two new helper APIs, geni_se_set_perf_level() and
geni_se_set_perf_opp(), addresses this issue by providing a streamlined
method for the GENI Serial Engine (SE) drivers to find and set the OPP
based on the desired performance level, thereby eliminating redundancy.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 50 ++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  4 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index d80ae6c36582..2241d1487031 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -282,6 +282,12 @@ struct se_fw_hdr {
 #define geni_setbits32(_addr, _v) writel(readl(_addr) |  (_v), _addr)
 #define geni_clrbits32(_addr, _v) writel(readl(_addr) & ~(_v), _addr)
 
+enum domain_idx {
+	DOMAIN_IDX_POWER,
+	DOMAIN_IDX_PERF,
+	DOMAIN_IDX_MAX
+};
+
 /**
  * geni_se_get_qup_hw_version() - Read the QUP wrapper Hardware version
  * @se:	Pointer to the corresponding serial engine.
@@ -1093,6 +1099,50 @@ int geni_se_resources_activate(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_se_resources_activate);
 
+/**
+ * geni_se_set_perf_level() - Set performance level for GENI SE.
+ * @se: Pointer to the struct geni_se instance.
+ * @level: The desired performance level.
+ *
+ * Sets the performance level by directly calling dev_pm_opp_set_level
+ * on the performance device associated with the SE.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
+{
+	return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
+}
+EXPORT_SYMBOL_GPL(geni_se_set_perf_level);
+
+/**
+ * geni_se_set_perf_opp() - Set performance OPP for GENI SE by frequency.
+ * @se: Pointer to the struct geni_se instance.
+ * @clk_freq: The requested clock frequency.
+ *
+ * Finds the nearest operating performance point (OPP) for the given
+ * clock frequency and applies it to the SE's performance device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
+{
+	struct device *perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
+	struct dev_pm_opp *opp;
+	int ret;
+
+	opp = dev_pm_opp_find_freq_floor(perf_dev, &clk_freq);
+	if (IS_ERR(opp)) {
+		dev_err(se->dev, "failed to find opp for freq %lu\n", clk_freq);
+		return PTR_ERR(opp);
+	}
+
+	ret = dev_pm_opp_set_opp(perf_dev, opp);
+	dev_pm_opp_put(opp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
+
 /**
  * geni_se_domain_attach() - Attach power domains to a GENI SE device.
  * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 5f75159c5531..c5e6ab85df09 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -550,5 +550,9 @@ int geni_se_resources_deactivate(struct geni_se *se);
 int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
 
 int geni_se_domain_attach(struct geni_se *se);
+
+int geni_se_set_perf_level(struct geni_se *se, unsigned long level);
+
+int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq);
 #endif
 #endif
-- 
2.34.1

