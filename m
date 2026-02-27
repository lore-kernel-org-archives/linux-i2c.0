Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74A3603C2
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172999; cv=none; b=dVWCIuhmtfqx7BzHIVh+UgSJ1QV9vPdnsV/fAXkBt0NU/qPjnNJ1Hxa2x71ErhDGCx5+aiakq3iRShLJ7zdu5a9P0jJAbfbTcYdp5wYRfHe1CY1N4Og4uivQmXA4ZI02nteovOZoDzj2Iy3FKO+7X+qDrrR5j+P7dDAh6w6TyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172999; c=relaxed/simple;
	bh=D1Gi1McYR1m65rTqXdYBG3amvrj05iPto+b2RK5eR0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfdbfX3PTsXche7iFwQHinLNgseAXRynmbbNtGjrkij23lSaShE3wsw+lFLBt4hdiaSvW+ZZLhd4GY/BOVO6TUGrJV8LQHVVaH5BrwIWSSXwBdv8X0R+dh1suNkWBhsPdIc+Vs+kN+foaoWPgBTZh9MEJuvi00TVQl1rhfyaCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsU9Ql3y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZD9pSFg7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsU9Ql3y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZD9pSFg7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2JxCq2403019
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LtpuUMj+X8N
	gU/uMTBj7nNlXFHnl4hMIn+8zl6Agua4=; b=jsU9Ql3y0a4jDVez5OQ2vAje4EZ
	cwZPzl+DGWPPo35gSaOnVNvAHrLu3+Grfdfj2miudCd/xtkc5avNclC0hbbbL1jm
	o5cJRVxFfhmBjEtm+ZBFukSOMR2YhH04HU+UbC6Nbv7GQinYxHLXKbVv6KVLrwM2
	MrDkgpe+OdUaqyOiOw5JP/9QAOa331qjBLkpirDyFwpe43okOkrSpv1O/R77xzH7
	0rfYmAqU0QhvX0KdkZ//BNIMoWeVaPoTqWE5uO7E4ohdHwhW87dGxKtpah95RDS+
	0jCPwVAvb9r42gyAka7eLrwjowtArf37fBEnwMf4xxpegqOkBGLqxxQjFRQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw239kmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adb1bdf778so17072995ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172996; x=1772777796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtpuUMj+X8NgU/uMTBj7nNlXFHnl4hMIn+8zl6Agua4=;
        b=ZD9pSFg7lj2lCHtEHfFHumDqQYQ1VuCGeFGxy1WI2lqTXY7+JDTT4cBs4fH7tfAl0X
         JmI4X+RSfBXT717VgKr5Kmno35wsZXGmWhJWDd76mQDOk2RzmTkE8DBQnFaBvLO7W0SJ
         qS3307MucIkIVqbOLxiXB/u3RGC2JqhZ7meJcs19JFupyjlFD9XtTn0ZZnicNYx2Oaln
         LGtXM+6USfNzg3S7UbVvCt45oPVPcOkUZUVrpYOlNExGPqeYm3zluuwNRcmX0s2R4ieI
         z188IDtsV5v0sYtu580ON8wIrAKbYVqnT6seM0TxSDvw1KNNX2N3cPjBjzSqI6QdGGbr
         TgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172996; x=1772777796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LtpuUMj+X8NgU/uMTBj7nNlXFHnl4hMIn+8zl6Agua4=;
        b=u/ruiAtv9wULP5Qx9KVdOSenSRu9EUb8DS3/1GBuJeOYo3pfWrmzYgr4GEStb9+B19
         V9d17g82XMiI7GsNCVIfyhBS9iyAVXnuFGCH9Ec/3TsEnO13rYtJ44SJWUnOO7BlhpNR
         XcheUPVzbLzaRoiF4KqiVZ8FcV6YSypdft6Zk8gUAqAAqMvA06V3BHOr8PVnbiKea9zw
         hI8gcmZClm2qGAZCnR+84SD591Pq6DWnMz5P/KtDbAdczgmkFAJsx0hberayrsrfeeQx
         AzxaAX++yJhLfAHOUw0vrrwrJA3zqGbZVf6uszFh/Knzmohy3Md64iNoGW50igScz5hj
         xxqA==
X-Forwarded-Encrypted: i=1; AJvYcCXFXQJc7t/89nxj8Y81fcp1+0z6Rkult0owR7l2/plRee7zTghIw6c1UBnpm47L8J+dQ8wpqLKwsYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpT0NKTlewXcgdD3P6SwfLCwb+EjYZpRDnYSet1LoW1Zz1v/Pt
	momumi4UKGo6cjyi8zZVwMOZcVRDV9M5ub9LOlcWrAiFrOcNcPqDMTUJyqlemUglAggUc3RJ7A/
	Q+OyEDPIEMoXjcsLyKt5HNIdJhxe09ShydCu7gH+GUEk63ynh+NgxePZLkDH2Ipo=
X-Gm-Gg: ATEYQzygR09/Nwi81I9Kj8kKzM/aMvJZhwU8nQI4pg63orE7kaY0vBjTjInj0OrHfyU
	TEnZzQ17VYHDQBeuwe8FrCcAjJvtxHy1VxdUJItY/QNJlCwPR3c8UmyWNk2/wsDvibuBSekP7uD
	qwQon8/9tyANWDHjsMoocPFlYjJ+u59Vjwh5MdekqorpzRuNTIEH+x4d0KWib+dzrstj9qCMxhL
	zMm8LWlWFDYBVuwobmfCyLu8BFZKvRrVZVv18MocTG7zWvQISmDWb2BTLVf0VuSqkRmohx0iDYD
	FeaarimCgn/anaOPKIS6VnXh91Bo8FA6lwx0myu3sYhQS1iHFHURLAz4Lj6H8z7J31WAlz2lTEJ
	zTuKRAkyHy4F4LxCYfW41k7H+brxxiCgMURcBXuES8DlZBGOZKFU37cg=
X-Received: by 2002:a17:902:ce03:b0:2ad:cede:2fe5 with SMTP id d9443c01a7336-2ae2e405766mr12514865ad.13.1772172996196;
        Thu, 26 Feb 2026 22:16:36 -0800 (PST)
X-Received: by 2002:a17:902:ce03:b0:2ad:cede:2fe5 with SMTP id d9443c01a7336-2ae2e405766mr12514645ad.13.1772172995649;
        Thu, 26 Feb 2026 22:16:35 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:35 -0800 (PST)
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
Subject: [PATCH v6 06/13] soc: qcom: geni-se: Introduce helper API for attaching power domains
Date: Fri, 27 Feb 2026 11:45:37 +0530
Message-Id: <20260227061544.1785978-7-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-GUID: A8-uZwmKhsK822TxdFN4mnqRZjjwIlV0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX/m2Wk5EiLhJ6
 fa+7NLg/Yal7PwWjS8/IRwuGaufAc9vMHZI2kgy422kezjwjaE7hpkwyZoEnSxEhzHDNwrQboF9
 H8NWKO6Zbb/84a3H/xMI+Ir8mGUpLVvE0ufbsr61bH1DwolDZ/DyhFR5e73pfEXYYef1sY5W1Ik
 vn2N8321Di/0SdWUBbxjyTpkT+ph9IF5Lw7CXeiJwjMNPZtnstoF3Rthq7sPI8ai9FgLhSfgYJT
 /c5+qNhjlHniUq9H4ZiqSRSdeR9oEmWor+gfCMJUymP6ZRWSo/usA9Qg4eohkhdhQOBaLOBrg4O
 9DBLhdSzdXdLUYqdKqVtva+BRDw6ZmNCYxPU4FhBna8o290dKwDGj4wZ0JAs8gp2ZXqOLSzNS53
 1JIRKBhlZ8zhHoXlaORbVc63Xb5b8946PbQSe5sBMRVL95RqFB/yXDar0mXjGJAZxmTkJp3CMt0
 goKXw/W6dpEeD7uW73w==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a136c5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=PijyICl8wWZdqj615XkA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: A8-uZwmKhsK822TxdFN4mnqRZjjwIlV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
the attachment of power domains. This often leads to duplicated code
logic across different driver probe functions.

Introduce a new helper API, geni_se_domain_attach(), to centralize
the logic for attaching "power" and "perf" domains to the GENI SE
device.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v5->v6
Konrad
- Updated return values

v4->v5
Konrad
- Used devm_pm_domain_attach_list()

v3->v4
Konrad
- Updated function documentation
---
 drivers/soc/qcom/qcom-geni-se.c  | 31 +++++++++++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 6e58568701b0..13ad3a51b58c 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/soc/qcom/geni-se.h>
 
@@ -1095,6 +1096,36 @@ int geni_se_resources_activate(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_se_resources_activate);
 
+/**
+ * geni_se_domain_attach() - Attach power domains to a GENI SE device.
+ * @se: Pointer to the geni_se structure representing the GENI SE device.
+ *
+ * This function attaches the power domains ("power" and "perf") required
+ * in the SCMI auto-VM environment to the GENI Serial Engine device. It
+ * initializes se->pd_list with the attached domains.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int geni_se_domain_attach(struct geni_se *se)
+{
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_flags = PD_FLAG_DEV_LINK_ON,
+		.pd_names = (const char*[]) { "power", "perf" },
+		.num_pd_names = 2,
+	};
+	int ret;
+
+	ret = devm_pm_domain_attach_list(se->dev,
+					 &pd_data, &se->pd_list);
+	if (ret == 0)
+		return -ENODEV;
+	else if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(geni_se_domain_attach);
+
 /**
  * geni_se_resources_init() - Initialize resources for a GENI SE device.
  * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 36a68149345c..5f75159c5531 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -64,6 +64,7 @@ struct geni_icc_path {
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
+ * @pd_list:		Power domain list for managing power domains
  * @has_opp:		Indicates if OPP is supported
  */
 struct geni_se {
@@ -75,6 +76,7 @@ struct geni_se {
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
+	struct dev_pm_domain_list *pd_list;
 	bool has_opp;
 };
 
@@ -546,5 +548,7 @@ int geni_se_resources_activate(struct geni_se *se);
 int geni_se_resources_deactivate(struct geni_se *se);
 
 int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
+
+int geni_se_domain_attach(struct geni_se *se);
 #endif
 #endif
-- 
2.34.1

