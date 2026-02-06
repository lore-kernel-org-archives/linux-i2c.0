Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261D4219E8
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399722; cv=none; b=pCzKhQois2ySowl0S3Y4dT0zWO7q0LN6Yi87E7dxn8Z/r360KWBBlmje4iupb15I1D7EFEycFo4xqtnBIjD/ykrESCXH1tdy3wtROx1UTAT5jbgu/qveKtqSbdCgmOMmYNNbQfsrqToVXHkjfKRpMl+xNTwcMGOcQ0jRE7j2IV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399722; c=relaxed/simple;
	bh=YvDpB7qQYZYVOQXO85zT2NahDMXsH90zbRqny+QJ8yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yo59qFmbcFdErUOBHLvK9e+Y9gQ5x13w8xq76Bi++8KLUria4U+hmzZEBP5VSCtekyNlkrjdbmTbSjJPNWBO53gq8r3efbdvge0qRs1DYPNhcoVIVSo+NwnK5LDd2dPPUT6gmud/gHhXbW5MLErOucGGCh6kKPSvnKKlu00Lodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQWxAZP0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iii8MRWV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQWxAZP0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iii8MRWV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616HaFft695363
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kKXwW780GCF
	A4P65AgkdepAec9RfmiOIRknJ6nGTg7I=; b=ZQWxAZP0koHBDPLSKgclgZp8riw
	frHqIU9vF7WrB/at3EInHp4hh5mn8FzS6COVVr6h9p7xpqX4ExSkw9QAWdsBtFn2
	YkZVw9cvZiHAbxC6EdaziPWrnpDXtNYDgQ6VQTI0OLWjFGOlF/97kpJoNKgREavQ
	UDu+IlX+4NX6zey0XaI7JnZlzTMIRLTLfJRHOzhI4sjVIfXemMZHJjdN/PcH08J8
	O8IKVXjHdUK7PTpbPQnwLL1wblPnZDix9efWmQVDtybnQStO9mBY7MvIfL14KFOe
	adLTM/uIIqbQgI4/6qVoYQ+1hZthFTpwBXSkzZFhgRTSGOU+aehd5yO/d+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c53qvbcr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:42:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c67e92aad79so1394133a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399720; x=1771004520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKXwW780GCFA4P65AgkdepAec9RfmiOIRknJ6nGTg7I=;
        b=iii8MRWV2Y5HP1he40oV2QrmG9L4R6szsIJK15VUs7orSS6XOuBWCkaf6BzNElP7ru
         rexIDI2urTeNy0SuM8pMbYm+c7WA0lmh3odYE9nSxBDNssTiQ36yk/lnp3MsSQNIRtGo
         14KeOVqyAH9iKCyAE28UJDblfYyOFmgX7jRQ17PBnW8RYyMB0N2bmZkj7czGNuLA5AtD
         ORopEDjhdvh/olIZ9N5YMOEQfygNg4pPhpOllI7uZnoGUh0Ba7vSBD0oaIzkZqacAlzb
         F+DE8D7/wk69u8poz8Jd2I0z6Nej3mLC7Nc5My0sMwIH4kaBaIR6LRkwmTzXxGlC5bGs
         WVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399720; x=1771004520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKXwW780GCFA4P65AgkdepAec9RfmiOIRknJ6nGTg7I=;
        b=bkd2lKDD7wqopDWCHhu+N5iDvlz7ggBE7z8C//PkptufcXtENu6xyf9dbNn/ruzwqn
         LE4yJJOvmQuBxsxQrB8lMD5aPdjNHWaqbUhlUrOXn2cETp89+mk+5CR2zhOhueOKzy2X
         WBVEyBoLk7sq9ruKkl8j+Kltg5LWCeNI/OttYjEU4j/zTQnFAY3N0AcP8toSlh/4+EXu
         KgSv8BLl8bWEDtMpXmgAhlt4921FfWmKtPgOQWV+fyoTop7cM+DqxyQTjNF06stYenUR
         oivN7InL0xz10IkZpiAS6XgOR5vjx9e7S8k80AWQGfgxiGV/517bXKwrBmAV8QC087m8
         ypkA==
X-Forwarded-Encrypted: i=1; AJvYcCWVkWbnGbEYyrLwpF1Y2NSciKuqqAK112S6F7TUNqzoZhLeaYUXXyXGbHOj5CyL84tmfvysHKNHpX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLyiFtdxZfQqlU9f8gX5yY+dmjyRir/SqIIQCN76P7wwjyZ/l
	z//x2k+TTnBKM4f7mHkTFivLGctjXJjXS3MuSoMv+7ijRLC+mM02A79vb6tLNqzgMqbf4Q7//ga
	nHgkMzYOQQd775HkepxAqwurF31ArEjJL3P/kRRSACQJ0N/BXNPrnuzBb7UqNyp4=
X-Gm-Gg: AZuq6aIfEOSs3uQnFy1M9DTHvHLbWADMNxllK2FfVs/QrlXJ9aojJTU5TFUoqLB3uIf
	bUDJ4xDi4gB8aGA41A4srVlFWmdo2mHG1JeNh4yW5+hjCfozHBDWDbErGYDUdlHjm1Bu5Xg2NbT
	HRu5uL8Y+DLGGHMBM+1nXZ9fS6YOe/Z8PtH3pRAe9NVeAkNV/gUfWrC3IsxZOvcEfb54SmlrL2l
	4OpcpMjTwNj2MNfuSoqtez4gvMf3nFFvtwoTVaUfsZJ0s3bzsujpEwo+TT+9fvoIKba7Csl8Cl3
	bJBSmUHrCdFSa/P0FmkShhpiS2aFq8LiIfEmfaZO+wS+zbgMDkPpwx1xclijouQqLddtdczUPVp
	XTFm57oMa3/tiPQSVpNM662y4ODve8BfcAemM6mPbUMA=
X-Received: by 2002:a05:6300:2206:b0:366:14af:9bd2 with SMTP id adf61e73a8af0-393ad3a27aamr3800627637.72.1770399720273;
        Fri, 06 Feb 2026 09:42:00 -0800 (PST)
X-Received: by 2002:a05:6300:2206:b0:366:14af:9bd2 with SMTP id adf61e73a8af0-393ad3a27aamr3800600637.72.1770399719672;
        Fri, 06 Feb 2026 09:41:59 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:41:59 -0800 (PST)
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
Subject: [PATCH v5 05/13] soc: qcom: geni-se: Add resources activation/deactivation helpers
Date: Fri,  6 Feb 2026 23:11:04 +0530
Message-Id: <20260206174112.4149893-6-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TsPrRTXh c=1 sm=1 tr=0 ts=698627e9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=KBRiQYpxJDLEvAb9SdYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: CF7gv-8dwJw9fpPyWL3LVNC9fn_LvVtJ
X-Proofpoint-GUID: CF7gv-8dwJw9fpPyWL3LVNC9fn_LvVtJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfXxu0h0B90dRNP
 V157DZ6N3ZiK3X4bzPJ7YdvlKTRpoUZ/NP8DMPdIunqTE6UGgZELdmRT8Pl76bexwh+XVFV4hjv
 fLPt7WuOb0U+EMkp6htYVKbob46tCokNBJaHPyhwYEHtqITAp3/P9fVwydxSOigN3BH4cusob63
 WSS+CsNoCvooJxP9UfafYlsSPVRc/mZCixBABhwfkhqAHxlDH/cTi86RStkCJLKJXq+u3p5w3Ib
 +20f5EbXcWq7d4/lUfjrvAJUBZTZvNJic+cDnRnMa/UPvddGVFNR60uCJVF/Oy1YwFP5W8BEvb9
 PdBHCWkaprUpp7t+EXhhRvkhNeX/L4fWCCLVzgG4pD29zPizL+thAMKS/NMsWpKt9eeIg3wn7MZ
 GK0aQbdNspKN8PJzxQFC0xLPDP4mSFNuvMMz/XorKrlVHpVQii97jvPAkNeLV4aQKMryW/9h85B
 6qFtxxppNuLogjq3J2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060129

The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
activation/deactivation sequences independently, leading to code
duplication.

Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
power on/off resources.The activate function enables ICC, clocks, and TLMM
whereas the deactivate function disables resources in reverse order
including OPP rate reset, clocks, ICC and TLMM.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4 -> v5
Konrad
- updated return value as 0 for geni_se_resources_activate().

v3 -> v4
Konrad
- Removed core clk.

v2 -> v3
- Added export symbol for new APIs.

v1 -> v2
Bjorn
- Updated commit message based code changes.
- Removed geni_se_resource_state() API.
- Utilized code snippet from geni_se_resources_off()
---
 drivers/soc/qcom/qcom-geni-se.c  | 67 ++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  4 ++
 2 files changed, 71 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 2e41595ff912..4bd4fce33ea4 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1025,6 +1025,73 @@ int geni_icc_disable(struct geni_se *se)
 }
 EXPORT_SYMBOL_GPL(geni_icc_disable);
 
+/**
+ * geni_se_resources_deactivate() - Deactivate GENI SE device resources
+ * @se: Pointer to the geni_se structure
+ *
+ * Deactivates device resources for power saving: OPP rate to 0, pin control
+ * to sleep state, turns off clocks, and disables interconnect. Skips ACPI devices.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int geni_se_resources_deactivate(struct geni_se *se)
+{
+	int ret;
+
+	if (has_acpi_companion(se->dev))
+		return 0;
+
+	if (se->has_opp)
+		dev_pm_opp_set_rate(se->dev, 0);
+
+	ret = pinctrl_pm_select_sleep_state(se->dev);
+	if (ret)
+		return ret;
+
+	geni_se_clks_off(se);
+
+	return geni_icc_disable(se);
+}
+EXPORT_SYMBOL_GPL(geni_se_resources_deactivate);
+
+/**
+ * geni_se_resources_activate() - Activate GENI SE device resources
+ * @se: Pointer to the geni_se structure
+ *
+ * Activates device resources for operation: enables interconnect, prepares clocks,
+ * and sets pin control to default state. Includes error cleanup. Skips ACPI devices.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int geni_se_resources_activate(struct geni_se *se)
+{
+	int ret;
+
+	if (has_acpi_companion(se->dev))
+		return 0;
+
+	ret = geni_icc_enable(se);
+	if (ret)
+		return ret;
+
+	ret = geni_se_clks_on(se);
+	if (ret)
+		goto out_icc_disable;
+
+	ret = pinctrl_pm_select_default_state(se->dev);
+	if (ret) {
+		geni_se_clks_off(se);
+		goto out_icc_disable;
+	}
+
+	return 0;
+
+out_icc_disable:
+	geni_icc_disable(se);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(geni_se_resources_activate);
+
 /**
  * geni_se_resources_init() - Initialize resources for a GENI SE device.
  * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index c182dd0f0bde..36a68149345c 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -541,6 +541,10 @@ int geni_icc_disable(struct geni_se *se);
 
 int geni_se_resources_init(struct geni_se *se);
 
+int geni_se_resources_activate(struct geni_se *se);
+
+int geni_se_resources_deactivate(struct geni_se *se);
+
 int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
 #endif
 #endif
-- 
2.34.1

