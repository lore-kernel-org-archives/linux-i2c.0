Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43305421EE2
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399706; cv=none; b=VQ9HOTPmSdlytqIfy5WguNn62KyvK0LwGnOxzJy27tVnO3WfSeA5ODHat0GqGBy/gRAFSe77afZF8ueeXG/YKfTs25hVDWB73c7HdWeIy3w6dw71cKrT6JhCb2Y6xdHDmxlyntlo1AsMOPqWPdIJbd+VZNP/OPUolAuflcZQMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399706; c=relaxed/simple;
	bh=ugzI2X4T4Eu6du95zdaOBWO3+LJFBYSONj4KCG0BUk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJJtelUsqIKQOc4nSPt+nsmfv2UbAvvyXQyuExYGPdWouXp2yXxXJBbAl72tcyTe09v1lXBF7gnAkwbWt7K3O1Qj2GtiloeEOKZx3I86UcpyRVlJ7z6pVJ6ghettiSOaOvsmPDwNxqsNMEX3VHc1LYLDKpY65OfAGLymVB5aQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K7YKkf7c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V/xNEr9u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K7YKkf7c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/xNEr9u"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GQUVl2314916
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=slQCzeC9waI
	6hA1xDFtb4CgPu+7qSKt+eKegC+Sl/tk=; b=K7YKkf7cErmTavUwI7SKaJQ9v/D
	QQkQGBhiXb1/ldL41nvpjRelbComZ1GsQo22ZtuRBA7l+TlkPMYOt3fPjvLnBCud
	x2rAH4CwiSrBlmHDBqyekg8EfYeec4ZMzjBeAkikpHEjENljh2AX0Tmt0eZud6Qg
	DCm7IHslIkUDuviuhSlE6KTvOLooe82eUMo+89BO74fNBGhPozb1H+CkBXIutlS3
	DUjrz0ohSdA8++FO0hTs/WqRvgH+CF7rDF0wcM39CldjfrWoaFJFXnoUGIaTf5GI
	FtTGki7kui3mKUtJqoJ2gy0nTiZJYD6rScxh/kpzjDrbxSjjOAXXW2Vu9kQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c52mrkr5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:41:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6b1b22b134so1400981a12.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399705; x=1771004505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slQCzeC9waI6hA1xDFtb4CgPu+7qSKt+eKegC+Sl/tk=;
        b=V/xNEr9uxfPR8wrVOfF2Rq0qMwm6SRyapQUssM0vpxXr/ULHpp5B6ZEUlqeD2Q8jTL
         WnE9oxZWIR2fd9Kcd9syzOKI+MIWYpE9EUr11doNIKgT7KFhkwdiSZqnCFgWaA1g7OEm
         iDPpNo8x40eF7FUCcQND1ZPhDQg2fsMrPopyranuJZUAmdxTKyi0j57n493S8k7d8gcd
         O/fBQPEsJlBPQ01yP9+P+rZDPAupJ8O6p9UPKWJWDDSkynwcLnkzh9ZPOtQbNC0Mdt9r
         hEpTw21i5+VK26fnGYnL0L/4Vtoj3NRlZDu8dJfE/wmo4d2/IlgkIM502DH0z+Ath0zP
         8avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399705; x=1771004505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slQCzeC9waI6hA1xDFtb4CgPu+7qSKt+eKegC+Sl/tk=;
        b=BnsGZU5As1S66WBTLh+iO6q9OB6aQGOAldtK7JPcuFu7mpnwvKvFwc9s/41QJJZKZ6
         ydSyXL/GlgWxFq1Wt+DgpJyQ7MVGLjqnu2gkd2tpK7VV80gVYwT+Gy3KngbRawckeRfM
         oHCgWzltIPP19dhaJelrsqBaw2WE6en3dkEA1fvza2sGmTx7371vCC/NCJWQji9PFr7M
         H4xvtvPrfGziJI48CMJm8SDoEkqqKqTPJOGzoVBNIhwdyaFTYILTV2x5vGzWLW4UO8Oy
         fqK9R1aE8X+XRXlIfd+mnNRjCh/X6Ixw0EuVXqSNeAXGVGIboQ2wD2cpEeoIG4nv53hJ
         v96Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqnNcA/j3DQOclOwGnXXAWo38O92MpmOTUfG6+r1eYPgCkiIbckJug9BRFF/AT0PFAtsURVL/hD+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QPYsyLRDmpduiRfXaaO4I3cuLM9d16qTztNfquPI9BRhqkF6
	ISc6eC2ptrx1HPoL5gTbQUw1SNqHc2H6Uil61p123Gyl42AQap7m609j8lL1lycgop4KE6o/i5S
	JXyfxNZIXZ1WBK+BNlsMe90wbhp3iNsq5iWW2AuAGUB4u3lHClsG0cQjDEMOXgsw=
X-Gm-Gg: AZuq6aIgIYfiYrleEXkQcYVIK2Z106akR0RS5jMS6xPDZHoudC9jz2sVz/ZT7xdlJwZ
	vmAHzj/WZUqjm2bMjoioCwnvu/kld6R3+pONV/oO3//nQavswYovmiS82sIxHusnmuYXD4p/YqG
	H4WOIoucybck6tBSBe57bDOQ/zpnVtaxZ0gIgUfBOP/6J7h3VWTP5zDFDYJJbInA6bX5cIsuFmV
	bV8ypFWcKKFHY9pxCaAyOPUMW37c8CKCzfVQiJJzqMeqGsTefWBGOFrbehdzon/O2sIO+dtedza
	r3URmQ9JiY87Z6wTPI7eNdGO8C4mU6iTzba4h6C0cTPt9aMqKWRNyAj5ABG2/vU2y7b4lPZwGGm
	GxVS6sPpFTtkhZHA7NYjr5gF6c6T8tB3I2pVnDLSMVfw=
X-Received: by 2002:a05:6a20:2586:b0:392:e81f:6711 with SMTP id adf61e73a8af0-393acfb10aemr3598679637.8.1770399704404;
        Fri, 06 Feb 2026 09:41:44 -0800 (PST)
X-Received: by 2002:a05:6a20:2586:b0:392:e81f:6711 with SMTP id adf61e73a8af0-393acfb10aemr3598642637.8.1770399703828;
        Fri, 06 Feb 2026 09:41:43 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:41:43 -0800 (PST)
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
Subject: [PATCH v5 03/13] soc: qcom: geni-se: Introduce helper API for resource initialization
Date: Fri,  6 Feb 2026 23:11:02 +0530
Message-Id: <20260206174112.4149893-4-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfXxhDRiUhCuDvh
 YGSJSfuXDWKA5FYSCTDGb6wuxC23TVeK5E6HPjvG9aFXbnNvZUT0nr1OPTjNjZlMpn2UtF301Bp
 yq4ylNbUTFRuF6kblpo6twc7++ahAWywpsRhjOr+WYjjmEWKDWz9QTG08mN8DJn0ZIZfgSYIlHi
 MHCRcV+Wt/GsZDYdHZCq9Gs6zttH61KDKW1h4hDw5cMn63qePfr8HIpP1rqDFcHPUYMWte/taqZ
 xgka34EdUdIF+Y27fqltJTToGxg94hbd0EAuGfk0RzBsAS5LJ26Hc9lPZ/eD+ZRzFNctBdiYCae
 7F5K7VnTr8Hc6IKST5R2NC0oenGrGjqzedu2lTx0uCN1FCTk4T24bbcBhm/B3p5p2Ap8V7dEI2I
 +yVTnixF9oLs4gou3K7aOM4rUgWZTU4185XjoIdh0Wk7jDkNw5wjKveOvladB6Ddr5k5Js1qvsv
 nkAsexRYmUdy41SATCQ==
X-Proofpoint-GUID: okpBjkimlvbxJWPkkvT3XteZUNNoEvq_
X-Authority-Analysis: v=2.4 cv=e4kLiKp/ c=1 sm=1 tr=0 ts=698627d9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=OYYzyx7XpuDNtx8IVW4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: okpBjkimlvbxJWPkkvT3XteZUNNoEvq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

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

