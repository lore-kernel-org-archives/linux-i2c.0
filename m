Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB22D94B0
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172977; cv=none; b=NHijw17xt6GGXIDsQ0VnF+C+MIqee3wuvaRVkLFrQCRqFPcDErEoMeigIt/BXA8xIO48NU0t3tmVVyx16X63OSBo4BFu0MsoTPZPme8be2POgcmnxw8OzXbCb/LCIx8wuCwDehBaH2m2hvcAhKlB3jwcFOOUJEKfBmtddPtpMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172977; c=relaxed/simple;
	bh=ugzI2X4T4Eu6du95zdaOBWO3+LJFBYSONj4KCG0BUk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWqkBVc2OiDfP9e3O4Y2UjibSbXfAznlh+zVTsKVrKNhlGJwRVFVvNgN2dZUfcGnLwHkVNy66JRiOZlfmue++9dpCFRnEMc8S7xaZqgKN9kgg4mZlj5pE36n+NFPwveDfcgtX3iVkz/+1FgVvz84+a1jBdMyx0vWinnZJfLu/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emUr0a9g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UmTyvNJa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emUr0a9g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UmTyvNJa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2KHQ51874438
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=slQCzeC9waI
	6hA1xDFtb4CgPu+7qSKt+eKegC+Sl/tk=; b=emUr0a9g7T58XcL/OgtRlEkwkKc
	5FnuSngX6H3kxE/HdBNez+1TxkEvvmeCOq8a5UhJiwv+exQYNVI+o7ptca2EEXGy
	brT4XDDipCMc/P1B6TJvjyY3tKInlCP/u8UNt1DDOOC7g+GjvPanjpx9MffMYX5d
	VJ7FOGsegx019p3QTqRslcCImXv4E223+pEF7cUg8uCDAClcX8uLX4pfO949r/1O
	j2OSqk6a1n+JhUUoUfmNSvZ04TRNDIcLcuRrHt0qmByZEPUp7I2FDr9FdaBQ3sfb
	y7PLvCzC1QcsVVCsCp2lSJ7dCpbPZ+nCrhXBxOyZzRV3vtfYjTFeOTCgeOQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuytstmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adaa9c4b89so29203245ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772172975; x=1772777775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slQCzeC9waI6hA1xDFtb4CgPu+7qSKt+eKegC+Sl/tk=;
        b=UmTyvNJa5yphuXz+txfcBScvY0jxaYN8I3fu/35qUpNMnZUD4kegr+aK+eA/4Qn8b9
         pf2uE0iAtE9YBmKBstMLbPVB43ivilOegXqRTnxA/Q6OKnDu/lfhV0TTnnfoBIwGC3ul
         XNpelp9WUGt7JkVIA0xjfeSfuFVZF4VXdy1kP2eWX7YhhnvC76TUKJhb72tPANIjt4jj
         wkvv9TpfNnaOABUXXXuHfLCG0W7QSvMgBME/mc+02LPYTk1kYEsG6THuaqRGT+5cF6aj
         JOUZ64zdAOrZCRNYyiAUdirZF900HIV4YusmgNovACYy7w5cw1JCgGfb2JEaxFclhjjc
         QCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172975; x=1772777775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slQCzeC9waI6hA1xDFtb4CgPu+7qSKt+eKegC+Sl/tk=;
        b=w66lAdowWgDyHobNVXICvjY+QHON7FFvxaBeuVBjWmtgTvkny1uVdz95hHRA1+6EQv
         3EwK/Sqdo3xzfN44+FfccIqvbG+seeIAPdrVMz2uPL5Sken9hiPtYYChrEicbnSUDV3k
         m8+CbD2TunfB+pP/labbtNXkHzCyj7SieBvfRGHJrGtj5vUvJD41GkMXmKvxTvnlTrjJ
         XY6Q7jxomS+O1z6T+bTHCtHkGY9TTG/6HQAbsBgOGf0OA22n6eQrdPVPbFpZ4O65CsXI
         N3R28YgiyYved1zHVJ9sopfCjf/s4SL5nS7hjEyfL2U6BBS/aNqpcNjwesskTx2gAC9K
         ZFMA==
X-Forwarded-Encrypted: i=1; AJvYcCXHJ57yzubxt8S8NXX9OW5gWnO932qYi7S4ucw47PUfSjN5ehK5GUmMgAaDmHch98zgj9lUTH9rWdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhC3WW/IhpZVLP9hVvyvE1aC0TYza4tp2Glr8mdiaWlKgfoq3F
	Xm6g1/Axe9gaaDTXSDXcAyRhWtv6dnnUNdXDbP2f8HTc2t6b0qy54zde98m7xk+E4/f3+6xNfqN
	E66sJW1C+v1b8LZ3zR8/zs8+utrbqRLnjTdtema+5bkr3TTIOggVFI8VJeUJTJug=
X-Gm-Gg: ATEYQzwBNV/wJIM87a7jDFEnL1edX9NeL1tnBAsMPlrbCOMt49nTWA/NGPuYllaFX6u
	J1FYbRoV/IoHW9+uuBEyQNQV4ZmCQpXlybgXAavaSPV8KvkdIc4r/+MddpqzFY2uttrr+6B0TWe
	4O+4CchScgcMPYcPl7dQutzOuVOxrP8vjAylN+xN58AANFoLMIZct4BFh0nkIDmbUk9Yh7X0Kf+
	7xQ10tvwz47xnMN7znLvAYw09DubkdBWiNMBUeFGGG9Fasa3YkL9H+sb4qFS7QJqrxK8dnYURTa
	dJ3V5mUbHMy2X3wtsY65hEpHOJHGEm6EUmRt9cKl/mM0OHj1+KEohprkl7/+0CfSn962qtWIJwj
	7wqt7pSZVQz8r0GXr8mVQOY8F8wIbvhH3KooW2MJGaX1MBGMGHYrtN9o=
X-Received: by 2002:a17:902:f543:b0:2ae:d7c:1ec6 with SMTP id d9443c01a7336-2ae2b55872amr17585225ad.0.1772172974676;
        Thu, 26 Feb 2026 22:16:14 -0800 (PST)
X-Received: by 2002:a17:902:f543:b0:2ae:d7c:1ec6 with SMTP id d9443c01a7336-2ae2b55872amr17584995ad.0.1772172974105;
        Thu, 26 Feb 2026 22:16:14 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:13 -0800 (PST)
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
Subject: [PATCH v6 03/13] soc: qcom: geni-se: Introduce helper API for resource initialization
Date: Fri, 27 Feb 2026 11:45:34 +0530
Message-Id: <20260227061544.1785978-4-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=bJIb4f+Z c=1 sm=1 tr=0 ts=69a136af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=OYYzyx7XpuDNtx8IVW4A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KBGWtx0j04vJSXVa5SjWNhRS8Jui0Vbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX1RY66NHQWcIP
 kRmYKv9kMAPJ9BDGIS60WuzNLWjzCCtBAgcjhmwpTbgNxco/13gDxZvSUlybxb1GfWQlVpGIzKk
 z8lg6i36clyhWEmI997PGgQMTzQWD3G+yR4ir4ngv7b1/QG29NfutV3x0R8j4HPU6x43ugH5akO
 xQ+2Kz2SgBR+n8qxRzWkiRDWOoxjalO8q51VH530qSG0/St0LesqFBAsmc+N0NcdUPX6/C0crDG
 3Tsw5lgZQnOm445w+6CbLU75qTWiLK1C+v4xNhaPYwCbXD5wZyYTgiMOkAnDDibikLBqj3Pfzwk
 4v9/FgmTJ/YB6Ztj9Yfyy5csdyZHZFzGjsAgOrQ3q7eRj7uvpGKuZA16uwlv3G+tO9ri8AOKwPP
 XIzHvzycoso/51yr0e9FmfmRcb0fEDcnphsKYTN3V5vsR3yjiz7S1GFUj55EhmPlby9T6+KaKjR
 rdPUMlBDDavuLZY1dow==
X-Proofpoint-GUID: KBGWtx0j04vJSXVa5SjWNhRS8Jui0Vbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently duplicate
code for initializing shared resources such as clocks and interconnect
paths.

Introduce a new helper API, geni_se_resources_init(), to centralize this
initialization logic, improving modularity and simplifying the probe
function.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4 -> v5:
- Added a Reviewed-by tag

v1 -> v2:
From kernel test robot
- Updated proper return value for devm_pm_opp_set_clkname()
---
 drivers/soc/qcom/qcom-geni-se.c  | 47 ++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  6 ++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index b0542f836453..75e722cd1a94 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/soc/qcom/geni-se.h>
 
 /**
@@ -1012,6 +1013,52 @@ int geni_icc_disable(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_icc_disable);
 
+/**
+ * geni_se_resources_init() - Initialize resources for a GENI SE device.
+ * @se: Pointer to the geni_se structure representing the GENI SE device.
+ *
+ * This function initializes various resources required by the GENI Serial Engine
+ * (SE) device, including clock resources (core and SE clocks), interconnect
+ * paths for communication.
+ * It retrieves optional and mandatory clock resources, adds an OF-based
+ * operating performance point (OPP) table, and sets up interconnect paths
+ * with default bandwidths. The function also sets a flag (`has_opp`) to
+ * indicate whether OPP support is available for the device.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int geni_se_resources_init(struct geni_se *se)
+{
+	int ret;
+
+	se->core_clk = devm_clk_get_optional(se->dev, "core");
+	if (IS_ERR(se->core_clk))
+		return dev_err_probe(se->dev, PTR_ERR(se->core_clk),
+				     "Failed to get optional core clk\n");
+
+	se->clk = devm_clk_get(se->dev, "se");
+	if (IS_ERR(se->clk) && !has_acpi_companion(se->dev))
+		return dev_err_probe(se->dev, PTR_ERR(se->clk),
+				     "Failed to get SE clk\n");
+
+	ret = devm_pm_opp_set_clkname(se->dev, "se");
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(se->dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(se->dev, ret, "Failed to add OPP table\n");
+
+	se->has_opp = (ret == 0);
+
+	ret = geni_icc_get(se, "qup-memory");
+	if (ret)
+		return ret;
+
+	return geni_icc_set_bw_ab(se, GENI_DEFAULT_BW, GENI_DEFAULT_BW, GENI_DEFAULT_BW);
+}
+EXPORT_SYMBOL_GPL(geni_se_resources_init);
+
 /**
  * geni_find_protocol_fw() - Locate and validate SE firmware for a protocol.
  * @dev: Pointer to the device structure.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 980aabea2157..c182dd0f0bde 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -60,18 +60,22 @@ struct geni_icc_path {
  * @dev:		Pointer to the Serial Engine device
  * @wrapper:		Pointer to the parent QUP Wrapper core
  * @clk:		Handle to the core serial engine clock
+ * @core_clk:		Auxiliary clock, which may be required by a protocol
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
+ * @has_opp:		Indicates if OPP is supported
  */
 struct geni_se {
 	void __iomem *base;
 	struct device *dev;
 	struct geni_wrapper *wrapper;
 	struct clk *clk;
+	struct clk *core_clk;
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
+	bool has_opp;
 };
 
 /* Common SE registers */
@@ -535,6 +539,8 @@ int geni_icc_enable(struct geni_se *se);
 
 int geni_icc_disable(struct geni_se *se);
 
+int geni_se_resources_init(struct geni_se *se);
+
 int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
 #endif
 #endif
-- 
2.34.1

