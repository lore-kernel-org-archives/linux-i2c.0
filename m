Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E040F8DF
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399781; cv=none; b=MR8MEVDj4r12LNdD8XJ1RohFkEnQPa9TEc3aNeMzWiOWVqjr1nfT84NhJ0GGUNFt9F9m+ow1jMVbsK4Vuug/bgZujPrPkXYNwVCgDMtkZ7M4ZV5wzbz7eC0iDRdL9UJ0cgF09J+t2EFZYqMyVaBzUBhbdLHnT3Imm/ihOiYANFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399781; c=relaxed/simple;
	bh=vLJsaTbwLSxqS35M14DCmMeySl42SBb+4n+kKoraVRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKk18QwAHxp1tigq0z1Xjxq/GSvR3Z/k7HU4uJ3Geju+ZcQqOTISPYNbfOc+SbdixgNjQokdRJMJ2ZmSUzS4JFuIiCUHXh4qMc7a8Clm79zuz9o6/h6tQcviJcAZh/lr+CeTooVbUg0Gl24xuJarGcDMILlFWmY7tUjMIfyPWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FYBpiziP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bSPebR3N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYBpiziP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bSPebR3N"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616B4P9K3764220
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JdbbozLruhe
	G7fmmV59QuHISGYrAXtPnLDfWr1IiNvs=; b=FYBpiziPoG2ziU+D3kD3JAkOW++
	ghsXw4Z+MZ6d+zhsE2IYY+cBbgSEcprlx0qk1XVR37hJVUJAlzUZPv0QOkDRd/uq
	pVBBzszFKs2pupH5ohb4jgc9WGqu7Dvbn61PRT58qXWzsvTxSk4zXM+5M9UieyaA
	c2tWZM1oE6a5Wa7EpASmLAVlanpq73fXT54HbRGmyU1MgfhKOlsrL6HpR2aXfnnz
	y52aMULyRcjmevMUB21m6UCmwtjqLJcEzDZhRFtUvMoJ8pCiljrOM5vHtc5zrWHq
	sLNrElTF0eaw7F0CuZnvvkQiguyaaHwKgTe6A7aK+X7CI0WLgwfSCp4vT2A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5f3wh4v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:43:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso552763a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399779; x=1771004579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdbbozLruheG7fmmV59QuHISGYrAXtPnLDfWr1IiNvs=;
        b=bSPebR3NlObwsE61fbrt6xAMltXRCQ6TEnnWimCiBQhlfBiVHQdCwABlzeIyvtJiEn
         /KYkPfTPu3QASc9ByVj8Wq5MX7Xubqxnpx8kQ0XjVBPp6ZZ6b/t6Po8UZUj/za/Vs2Kc
         E7ddCP1Tm31wg1trCSAc174k+QHSNsrIVwD3Qam+v9DTVhrkJNJu2TLEvUROkj2UyI9M
         yHRl91GJCgXjZ1dGYb2tjioT1mT1fEnFZQrzPkXQLd+aaq1y1N0Nj2uHxAN9Q3dpvFXL
         TpjAmb3bugfxE228goIO2KozNnhE+gZq03vAJGs87bRnx6htKBOcLBfhkjJirLJJBMWE
         tcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399779; x=1771004579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JdbbozLruheG7fmmV59QuHISGYrAXtPnLDfWr1IiNvs=;
        b=GrflLToSsdryjmb8GBMqi79Y9fXRgjVZZTc01V/57sMRCHfIx3A1UA5a7CgdR30mEy
         RJMLNZ6TB1AAMBlcJa41ZjT7SJNOr0FnqgZZ7CoGdjcvfiAf4XXLCto3ck/KGnNOqVDN
         OA+GsExNMw5fAsz5q93BnyqNduAfl5xVZ8spb7q4JO7t7FzVbaQ6Z1PZOCiryY2VjhcW
         bkPoNow1S15lSAX0lK+/xWmI+nDSmVToPsRd3xkKSeE8dsBjBi2+vg2iD1V9ir/IeUUN
         3ZS4bP+To3LNK/o9t+gGtIyBk1NBcbaWroOb56PbLaG1ugFIyO1YAqxl7TYbyR4EOhSz
         dK5w==
X-Forwarded-Encrypted: i=1; AJvYcCXeNu9Ki7vFVhjOz2TP0oG6pPo3LV2p+SB4KYlDZHfllq8fawDnR57lUnnZWdqWVIS0lGfEnQbZTAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzTVHbRVAi88QtO3vdFEvwiTGsHeFoQ+tfohi1udsiZ2Ja0Sk
	MQF6lXFzUI5rZm2VEr6n+2dAQyPZRNhdPCT+BI5Jf/A1GNErN5254n3NL2r6QK2t0sK4kBp8iUm
	eLFaH3y5bcYa+YyX5G7DJIY3ySfSlUttslol8o8kMj7jyuDfqZFvfwJh+twA5tGQ=
X-Gm-Gg: AZuq6aKU1fEI8uk/WI9fGOZUhZ0ug8m1ZMOsXJSwUJE4lsMz/tmKcSEZ4Kda9EdWysU
	FZrcp/ObssC/EF6SWw93zfMxSUOVwDZJ2dI73oz/hiIJX+c83GjzUfBoKE5FsRJEppDrJ4oZtH+
	PKGp3mkg/mJulRDmcWAHbR3YJBDiiG6EcA4QVnSp5SBLJqAv7QHrlon4pcGLuwamBWgElSm+ULQ
	hxS5DF9DGD7crRvnFEX3gLQtdYw1H7Izk5WgHb/lw1+d3Iw5Rx8ksvHZ8Lg1XbsJXpZ9dStjyyC
	mGovcngwj9TKCJvfha+AlMPv5qstGBehS5JihDaj1Ug+oSILxLbKMbOFrXQohM8JLiOdVD6Qf7P
	NgQqO9m8ujfG1mk7y7EpaMN5HJJMqljWbRph+XkbbyYo=
X-Received: by 2002:a05:6a21:1fc1:b0:38d:f405:709f with SMTP id adf61e73a8af0-393ad33a8cemr3428816637.48.1770399778891;
        Fri, 06 Feb 2026 09:42:58 -0800 (PST)
X-Received: by 2002:a05:6a21:1fc1:b0:38d:f405:709f with SMTP id adf61e73a8af0-393ad33a8cemr3428782637.48.1770399778305;
        Fri, 06 Feb 2026 09:42:58 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:42:57 -0800 (PST)
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
Subject: [PATCH v5 13/13] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
Date: Fri,  6 Feb 2026 23:11:12 +0530
Message-Id: <20260206174112.4149893-14-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfX4IfjGDlx8mek
 1cFe/w2s6u4rG2YRD8suPcBJpdb4/CfKjOq68jC5fW6NKqs8/V1Qf3xOUvRTdwtIrI5zVNhbNFu
 0cMCGA9N5Axj4wlCWjc8HU4/UMuHNRgyuNnOEZDpoksNk8OtyFZzthJcB6tBNVIJnK9ZSrdzo+t
 c+1YcNz4b00ta84yJX0xeFHPNvcj8KUtUSh1UGcRw/Vgi9gVqnteBsmP2pXjho25sTJdUhZgRh7
 HY6cvL88/znmehP1CzU2gf+7VgBG4ed+4KQYTMV8t8R8P+brZTRAPWmypfRIK+qZVKTKGcOTAiw
 vX7/Avk/69CmHIkVbgXEUTArMK7cAHqHnOjJWN1shQfPWVD3qp0inxXX8UnSsdAcr/K+i1rxF9D
 5djcDRM3ecoCObdRBt9QkU9NNsRfJWHsuW0HigjVunUBAG9Jqj5hQyrmedVxo0NVyz4QZaWOS8x
 YlGGOUzqaWlR5OUntvw==
X-Proofpoint-ORIG-GUID: gXBsXexuyy7wFnviadMgKQfD74NSeNpD
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=69862824 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=zgZzUwpPmSg69XYvEVoA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: gXBsXexuyy7wFnviadMgKQfD74NSeNpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power on/off.

The SCMI performance protocol manages I2C frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate..

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v3->v4:
- Added Acked-by tag.

V1->v2:
From kernel test robot:
- Initialized ret to "0" in resume/suspend callbacks.

Bjorn:
- Used seperate APIs for the resouces enable/disable.
---
 drivers/i2c/busses/i2c-qcom-geni.c | 56 ++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9045187ad0b5..6b936c7552c9 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -80,6 +80,10 @@ enum geni_i2c_err_code {
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
+	int (*resources_init)(struct geni_se *se);
+	int (*set_rate)(struct geni_se *se, unsigned long freq);
+	int (*power_on)(struct geni_se *se);
+	int (*power_off)(struct geni_se *se);
 };
 
 #define QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC	2
@@ -201,8 +205,9 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
-static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
+static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 {
+	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
@@ -215,6 +220,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
 	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
 	val |= itr->t_cycle_cnt;
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
+	return 0;
 }
 
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
@@ -906,7 +912,9 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 		return ret;
 	}
 
-	qcom_geni_i2c_conf(gi2c);
+	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	if (ret)
+		return ret;
 
 	if (gi2c->gpi_mode)
 		ret = geni_i2c_gpi_xfer(gi2c, msgs, num);
@@ -1041,8 +1049,9 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
-static int geni_i2c_resources_init(struct geni_i2c_dev *gi2c)
+static int geni_i2c_resources_init(struct geni_se *se)
 {
+	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	int ret;
 
 	ret = geni_se_resources_init(&gi2c->se);
@@ -1097,7 +1106,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
 
-	ret = geni_i2c_resources_init(gi2c);
+	ret = gi2c->dev_data->resources_init(&gi2c->se);
 	if (ret)
 		return ret;
 
@@ -1156,15 +1165,17 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
 
 static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 {
-	int ret;
+	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	disable_irq(gi2c->irq);
 
-	ret = geni_se_resources_deactivate(&gi2c->se);
-	if (ret) {
-		enable_irq(gi2c->irq);
-		return ret;
+	if (gi2c->dev_data->power_off) {
+		ret = gi2c->dev_data->power_off(&gi2c->se);
+		if (ret) {
+			enable_irq(gi2c->irq);
+			return ret;
+		}
 	}
 
 	gi2c->suspended = 1;
@@ -1173,12 +1184,14 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 
 static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 {
-	int ret;
+	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
-	ret = geni_se_resources_activate(&gi2c->se);
-	if (ret)
-		return ret;
+	if (gi2c->dev_data->power_on) {
+		ret = gi2c->dev_data->power_on(&gi2c->se);
+		if (ret)
+			return ret;
+	}
 
 	enable_irq(gi2c->irq);
 	gi2c->suspended = 0;
@@ -1215,16 +1228,31 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 									NULL)
 };
 
-static const struct geni_i2c_desc geni_i2c = {};
+static const struct geni_i2c_desc geni_i2c = {
+	.resources_init = geni_i2c_resources_init,
+	.set_rate = qcom_geni_i2c_conf,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+};
 
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
+	.resources_init = geni_i2c_resources_init,
+	.set_rate = qcom_geni_i2c_conf,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+};
+
+static const struct geni_i2c_desc sa8255p_geni_i2c = {
+	.resources_init = geni_se_domain_attach,
+	.set_rate = geni_se_set_perf_opp,
 };
 
 static const struct of_device_id geni_i2c_dt_match[] = {
 	{ .compatible = "qcom,geni-i2c", .data = &geni_i2c },
 	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
+	{ .compatible = "qcom,sa8255p-geni-i2c", .data = &sa8255p_geni_i2c },
 	{}
 };
 MODULE_DEVICE_TABLE(of, geni_i2c_dt_match);
-- 
2.34.1

