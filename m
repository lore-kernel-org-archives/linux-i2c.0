Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974C33344C
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173005; cv=none; b=MYNelSJCayahHxeYe8zU9lVAD13rYcHojuJ44mjqOeowX6bSH0xiM19FRYsGzG3RNExu1IIShnQhWwtU6+blJ2q2wR4/m9qkWhfspHLloAiJNAVv2tCf0K64R9bmouNXSUkgbWaHyes+cCE7E/L6ucmxHJy0KiQBR5RNftkAPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173005; c=relaxed/simple;
	bh=r+NuYoZ1+qXStZvaIZDliMZWk1kzoc6TJhJUEDoPnvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8IpuGjPv4WXdr5d8fp18TEA+z4FXTYnynZ/w/7n1bqS4Ut+npBgsi2h2yJGZzgfZa+0ZdqHP45m69ZHB//CadV4kIM7uJVGN9/1oThF60gT4PlUArZEqb+8v5zqZyL+cz3BBsYljSEJmb1cQVJGVfFTG7rp6LoK4QtghPl5EB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d6eSjE6E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XeXOMCad; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d6eSjE6E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XeXOMCad"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2JxTl3761428
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KRLuQ2KM5IF
	ptPVplD9gxuDqOBRonDICntxFIs5jCF4=; b=d6eSjE6Eyh7zHbnmcpJdhMiwA+L
	ipZ7bKHH3sdjkX3Ak+CAnrFIbUQ2MQF87CpouUkE+D9tlQLPXz/PUeVBTXbniwc9
	qVae4yO86wS8u48/+rM2RaPsHAFWWYjyJB1kwJYb8Z84Mfdkvi3PJqSTUymLRPge
	MURoJ6eulYGRHUuokG0+A6UmxvhuIQuScplKITfPSbHQ+LZdotrAo1ZvrEeFnKg3
	LzEza4R6IVyAkXWd/9Hb3A/GwO3Y0x4xTc5WAuSPdC6rX3dzeurD63vw65bqvoX7
	mS44CG4gVfM0XGBOqcxU2KHE4QNWGChfu8qZth3s9uhpKtdrrarXzWTGJkA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt7yacqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2add1118c19so10529225ad.2
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772173003; x=1772777803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRLuQ2KM5IFptPVplD9gxuDqOBRonDICntxFIs5jCF4=;
        b=XeXOMCadAHJJS/OFzH+R0xf8EKaVaAlTcNnZJbVJ7YNftr9ovuzGXtwwF4WMlFNsfB
         JnnDq9EbcRD0ALBHbMH8Zyq+y8Tc9s59C+nlla5b1xjM0qBs+i16xeQtfEuTrDLWyUHR
         kQpDivzK/hfj6VTrDitm382gPs+Hpocmx6Oz6cr5k3ieICuFs4f0NGUf5CwR+yXPRTD9
         IJJ4OUlnf4oVhYUeZzSildiCEaJU/m2VA1gv9agiwaBzDEUoyJAMyfuCUXAjRqM7thg4
         e4e72v9xYG9l2WaYRtiw/CfArTYwUq01rCRhe26tqoWPLoA7ZTopZqdfWJd9agaMB5kr
         MTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173003; x=1772777803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRLuQ2KM5IFptPVplD9gxuDqOBRonDICntxFIs5jCF4=;
        b=Yn5YyzB8ikeYXALm4R2SPZFJpdUm39tb1gjNxi6ZSA6kLpcu3RyoWfvcNRpDM8Ea6I
         eElux5clVC/lwvWTSMEc/6CtvebcRdlbE/jc/27zg7JuuczD8q1OdG3pKYwHBY5/LIMM
         0J97bculLuXKRYlLPReTVYw8ZrxgX47/5QclE5+BC3Ht9oQJSZ3TYpWBLp26M/3MTHEW
         SOfMBkABzhd1cj3ScRhxMqjqfhUyWMK1eaML8Iu8wr6GczHfY56Try3iM92QTqegxm0X
         FOFh2X/vtMpZWbBVK1vHwjCgEpilKv2i1i2+pVgIcxm1rEZgijXhO8l7M74L2UU1ud/A
         qQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUE49+0vCW73pu7CNUJOPrNYHRTec+bbldf0UwIZ3QTwOwnHqiClkJCsdLoFJRBfmt0WfqkxyR4kY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpExPjVot2cljzuM3NhlO/vJvkAaTiwk5wcNVIMfZ8UBoubJ7L
	QLAxcvn65LXikyyNsr2YprczUsbQ1cA2IvY1qYE1iE530fRJj8Mma32U8ExTQ6jMcq+8bKCDa7q
	mXmdxpdCMVI7CLMbTTLdpWXSZGKUMQ32AOBqYUu9MVxlnKA7fBjB8DWvLNZUrnHg=
X-Gm-Gg: ATEYQzx8Ns9NpMnJEJ8GjvHJRZ8p6h9PEu6cU6HAfFJGU59WdD8ojbs0uIjnmjskw+U
	riB5Ygu469+4X6JNdJns3wFbT+j4Idx3Xzh3FSSWtI4vCvbPAHoVU/Z4BUsN2pIh3hoWRxSYksq
	fpZcxkphRBw+afqeNItnZICHj+8ru7fTcCzYPAFuIaR2u+/Hq/GaBz5iGF0NcIW7Eg5v23T8Q4t
	rG92CHhSygFZNOWqMYVH+y2miacCLnuYLbfcS6BGaGCTZP+9PFt2gMgobLeEv7UIwXhbfFz7fpP
	e+fq7qC0/kqs3EZUinCslL+ot6WhWSi0R+qd17/KjDGzZTXr5pZNAjskJsx8f11tV1JHbXH4IBC
	uuZwJEXp8fzk+880gko7uqyCYR9A0bYHFhIQQvwvtNzVGdQLSgr7wGRY=
X-Received: by 2002:a17:902:e805:b0:2aa:d320:e96d with SMTP id d9443c01a7336-2ae2e4f7f04mr12056555ad.51.1772173003111;
        Thu, 26 Feb 2026 22:16:43 -0800 (PST)
X-Received: by 2002:a17:902:e805:b0:2aa:d320:e96d with SMTP id d9443c01a7336-2ae2e4f7f04mr12056345ad.51.1772173002527;
        Thu, 26 Feb 2026 22:16:42 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:42 -0800 (PST)
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
Subject: [PATCH v6 07/13] soc: qcom: geni-se: Introduce helper APIs for performance control
Date: Fri, 27 Feb 2026 11:45:38 +0530
Message-Id: <20260227061544.1785978-8-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: G9sMC00LO6HvnX1LW5sZZK4cS3epPtqU
X-Authority-Analysis: v=2.4 cv=N7Mk1m9B c=1 sm=1 tr=0 ts=69a136cb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=NwCh5GMA9Nt760FYQHkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: G9sMC00LO6HvnX1LW5sZZK4cS3epPtqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX3Z5fF7CQooMa
 zMnbhMLEtZYubJhoz4cgC9KwgpFOGorfZ6e79oELyJ2KmisNqO43PY8SfrYFaLEyeFEI9PxxxhB
 v3r2DNca5sMGXAICj8p+PgYlagnP7uyoJGDyEbL/DNd2CcpP9Dh3PRzyKOJ29Ka8DwJa75jOP5q
 YPVhtrLKfYsg7RUckNPoXnO8FYi90kxUgr2I2vF+UF7cl94Xk2T4Eb4wYm5GpB32geHZDPDz2H6
 Y72qDpohZFuEA1zCXy11n0Jqsd3RhGs9vTEXolp5XXTvR6pz1h/8OJZ4SZ35PAgAm6fJP4SSirk
 nT931awzk5qLFBBwk4ZUrFON88Ssz7zcrbWcFsVsvLkacGAKlbT8kzE0Pglpfs93FJ6YE59WJuF
 I+UosKc5uI3Ydgmili4R41NgbojknxppaVi7H8jGwMAseslKa02Q5LorPyrXc21q0FcyPRAa2xO
 Lbc/gGi+P2hksJO9KWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

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
index 13ad3a51b58c..15636a8dc907 100644
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
@@ -1096,6 +1102,50 @@ int geni_se_resources_activate(struct geni_se *se)
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

