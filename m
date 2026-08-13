Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5E481675;
	Thu, 13 Aug 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629705; cv=none; b=lwcQbWjGf1MStcgstb7O6aNIMvEGkkKdYiI1PgT/2r94mBAFk8iKvWJE6iWjCDRuVKRty+IshRA0DnmURTh34vHsmbOr22jxXlWP1md9TrgKfWEOIrjb04yqkXi1IQi22NWn9V7k21Zlvqz4SwbHN93i2ntlZRsfRHxReKgf0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629705; c=relaxed/simple;
	bh=qvhc3sH/C80I5CIWp1Hm8e8Gzso8SiGUHkw3gNHZlIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC8DDJXdlB/1tYPJh1D6O7Oo5an57Ip0Wn+GFyxDokr88xw3NJHmJvDFM5xPxj/Y9BRD+Gitq1ba4pmI8GrhLduIQtfeNlstuK/OKMYlvLAwhTNAQ4aSpUeE3D4b8SWA3uMNmeZpSxX0zRPVLNCWpV5LMTFTjZuSJuXSvNPCM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oqp0Mh9B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqp0Mh9B"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCJl463286573;
	Thu, 13 Aug 2026 14:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gncGXLRseGH
	4Jw76rkIFNyOOx78hm5OrN222SbhQbM0=; b=oqp0Mh9BqKM86kjZg0PBCCEom+x
	95JVRYwaQs2bpjNIsMO6/kBZDhEngBpLG433BkOmXNEiIyrYHaY2lWxPhkYLkn82
	5ax0VJHAzCQ8ATKb5DUfbOQR88wBDt63IF/stJKS1LX24J9wPZ7Ofb6pCKy2WlhY
	ZTG69ZJuWTOhtKNhwBBq4GtDhWYEZhxwxPm30wo3duqTg10yx9Sp2Vycs0u549vk
	v6GlHZvOOpEfzDZsnKC/PjBc7manI2ocLBISEaab395MwnlBJsz3IhnWE214bGau
	fPubFQ0+6rtIPqs6s5idnEj8iRQrfC/YzPLcurdQXKaDAn3FTR8ltQ9yapQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18c5hy3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:37 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DE1X53009004;
	Thu, 13 Aug 2026 14:01:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g0bs34pvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:33 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67DE1Xqk008924;
	Thu, 13 Aug 2026 14:01:33 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 67DE1XLa008884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:33 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 7883B220EC; Thu, 13 Aug 2026 19:31:32 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        brgl@kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v9 3/4] soc: qcom: geni-se: Keep pinctrl active for multi-owner controllers
Date: Thu, 13 Aug 2026 19:30:42 +0530
Message-ID: <20260813140047.1006478-4-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX8euovX4vCRtl
 11uzOl9HgEKkglqHkB5RQNuLhjk+kwlPZwgHXHgl2iYjNK0rMXb47BNBL8I9aJ/oY//QbsvfLLO
 pMsnHvcSlrczIEdc7BL6QEz1fN2GXvw=
X-Proofpoint-GUID: -ySvlkJIuD1IkCvm48sCd0YcqcOuiER2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX03vJWvEtmiA3
 4urfRPXcHV+rgVe28pGidZgd2TNG19lZ6F+Hl5oPf8kiNnE2greWnS3chIja0oEdr4wuW8n4Q6Q
 QtK2IgSszPAJ+2iPeQsmEOGQLoAmDKrkxXrSQ70MYLSMlJgbY85BcF5bRrjx6AliNvj6DOWY4V8
 EobwUWV9DDPUNsLaSCH4Mgu49LW2p7UGqLaqH0j2D9D0+ErMeWyxNtHRZ6NQoWEq4q0FfGCWvsU
 nxQ/wJIFu9C/6NsDDE3zDfyrwe7Rg161qVfzsi12NRCpH9iScnS8Fp+tZShuTqZOwRXBborGrcw
 5W5e388bbSXqs28uCP5UAV3BdUjLKpTL80xPBQ25dlJxe8QjLFCOxMNG/FbsOza/Ach9n4X/5S8
 M6B5yFbYaYUfgBgFid+pZyPcfj5ITR8Bi/9Je9y0nEKNSqFTkjxNDQ6PrBrkWSv7x2ebFHD2TnO
 NDv4zyo/ovWmbpGoGTw==
X-Proofpoint-ORIG-GUID: -ySvlkJIuD1IkCvm48sCd0YcqcOuiER2
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a7dce41 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=yjsoBxkUdLS_pUp0TqoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130100

On platforms where a GENI Serial Engine is shared with another system
processor, selecting the "sleep" pinctrl state can disrupt ongoing
transfers initiated by the other processor.

Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
when the Serial Engine is marked as shared, while still allowing the
rest of the resource shutdown sequence to proceed.

This is required for multi-owner configurations (described via DeviceTree
with qcom,qup-multi-owner on the protocol controller node).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 14 +++++++++++---
 include/linux/soc/qcom/geni-se.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 873bfbd6b2b7..a4da75d54d6c 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -610,9 +610,17 @@ int geni_se_resources_off(struct geni_se *se)
 	if (has_acpi_companion(se->dev))
 		return 0;
 
-	ret = pinctrl_pm_select_sleep_state(se->dev);
-	if (ret)
-		return ret;
+	/*
+	 * Select the "sleep" pinctrl state only when the serial engine is
+	 * exclusively owned by this system processor. For shared controller
+	 * configurations, another system processor may still be using the pins,
+	 * and switching them to "sleep" can disrupt ongoing transfers.
+	 */
+	if (!se->multi_owner) {
+		ret = pinctrl_pm_select_sleep_state(se->dev);
+		if (ret)
+			return ret;
+	}
 
 	geni_se_clks_off(se);
 	return 0;
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29a53bbc0dd4..725f89a44551 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -66,6 +66,7 @@ struct geni_icc_path {
  * @icc_paths:		Array of ICC paths for SE
  * @pd_list:		Power domain list for managing power domains
  * @has_opp:		Indicates if OPP is supported
+ * @multi_owner:	True if SE is shared between multiple owners.
  */
 struct geni_se {
 	void __iomem *base;
@@ -78,6 +79,7 @@ struct geni_se {
 	struct geni_icc_path icc_paths[3];
 	struct dev_pm_domain_list *pd_list;
 	bool has_opp;
+	bool multi_owner;
 };
 
 /* Common SE registers */
-- 
2.43.0

