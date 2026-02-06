Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964941C2EE
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399729; cv=none; b=tsvWpZ91C4HsNZu+EfYuHck6wdKEtKZI7a4LfFQGc4lpno1BbL0vxENpCUFt8jRmXNnsrFLQ6d8YoL81gm8FvY3ldD8Fpl1fM/5Zf3/DFPvPa3vl+bVaWqd1ApMmfQ1kkl0mPrMtsoJzW2vpPI0UpvME1sYeMhc3hPaahNV1Suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399729; c=relaxed/simple;
	bh=ga6zv2X08xWdzWRz3TuiP7Yq07BTW+J17Yasvwfw7GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hoso8X0g0JEhM/DbpSxkXhzvVtHLmoJMRbykgmLukXoChJ+9zggAfEI+4oiaX4xCiZPMIyJbBQEbfpZ9zhHJwEzuTh+leO7ikpicFON6Hui7Wapbig2qMxBu1EQLbXKwMFpsKVFnh5/m+6nh6wBjgVNFNwX4lT+zd8UeulDc8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dS0HqYh8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ny8Muqqj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dS0HqYh8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ny8Muqqj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616G3m3U2490278
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6g1n4zS8IqK
	CO/ZoCH8PjgZhBqCIfpcPG7bciUpyApU=; b=dS0HqYh8o0eJs/EnS0cBl0I5WEx
	cnBp3ZngbaUQpnxMkkTKmcYGXCu6aLFaMotHWb0zWnRdaXZvFL6dlSZLGFuotKYc
	s4NI15/1ZQDuWTEJkVY6/g50py/DWvzQP9walvPz1LJH1WdgnnLqUuLZPpLJPTt+
	RV4k+dRgduWyOHQ9Rs39b9pQ3spnCpBzZH3zNmMyUkxr53HtTdngpswW8HUv/fhI
	Yhzj1sSNrN9Co84C8VtQz9+SuWciCiC0OYCW8+ZhBIa5yqkLxTROdW/mtkpbf+7S
	ZjQp0H6xMTBnMbWDr/3yU0Fr9Fdbf4R2Kj7l2XCEjueplS5UFYWsw0mvzmw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c9c1rpv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:42:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3547cd89bcfso5373526a91.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399727; x=1771004527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g1n4zS8IqKCO/ZoCH8PjgZhBqCIfpcPG7bciUpyApU=;
        b=Ny8MuqqjB2Zdvz6FNY946K02lRB1sb2zKqZGAxAZ2DX+RoZA4kuWj9aNSeM0r8OiEb
         rTnly5MpxunvgVTToo7lU6QfP/BsUoj+51EUvQKJVYXiXfCCUmovEq8tzMByODGmogNh
         agDE5PW1tk3CLGDZXVFyLonF6OLqI93QsM1POMlOzRtFH9T18mzv9PsC+UdkSJ7kfFkn
         7AGdVWCxnoZ2fmKH2bCCQHdeOyOIw6KTfT+2sTSJ/corIGWGARIZJnCD57vOI/OnFXDL
         ptIwR6IrcHpSQ9gtv6U7KC1HorghX76bGiPJ1CqmjWcnlikpVXYuyV8QVnSuoz4ZLczF
         cuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399727; x=1771004527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6g1n4zS8IqKCO/ZoCH8PjgZhBqCIfpcPG7bciUpyApU=;
        b=tHRYFVAEEPHDbvq85fb1E9h8pYuUfIA93c6IjID5p150LE0MTCI8jN4Dbm7Rso6+za
         qoMKNA7k/DePyEAhukaAJKxmyScMjdu0oJhqs5SGNCIJ8kv1BwwWOXp4sob2wTRRB9kN
         HXozFa702SgD1NICVXrPuZHbiCHTVpPtESTfKnMd4lijFqAja5Ys44tSsFSX6wgwZwGl
         Hg4RH8/8iMNk2anM7z/o/agyl06UA45ATssx22PmZvKpAzzFZsHQ5Rk25DiIXMmNHICp
         U7p7iflVmc+QmE2XS8RgOiDRKddLnzdvQajj0tFUwntxiEucqSr8Xr0EAeql0F5PEmVW
         rvCw==
X-Forwarded-Encrypted: i=1; AJvYcCWLP6jaxB88dh7ZNBCbiiEwWIY28JvEJZaycyyXfxiDA2W9dtOtipiSyXnac4tbWs7mC+8Gm5BySi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItL2dYl+trRAcx5GvlbG5saUOtBdbm+/h2OH0VGwV3Ejxjx2b
	I5s0LnTrZ8WJDkMuZvrpaV+Ceo3t9cu/fBgH6+KPZh4GJYxQryCLFIsGHcT8w/S5uw9wOPcg/b+
	3uPqSw27u6RFfzpufurah8L+7ZYiYKJWO2l7O0fOdrltM6wQYWiQGx4dlxdeiv0A=
X-Gm-Gg: AZuq6aLeyp6TFHHjoA80jq0UpLugrV7X+C05RIUjHoZajOZ6rIDFy/+EabK/+8Xp2g8
	mQc7j/AhElvddTASsFLVvKHoJn9PM9y4Tdkzp5xpHNCA3PiuzTVbK3qthu91D+DTURth66B9aqq
	yTbne0CBRzaqyD5k0ARADRfr7VstWWTIXgg7uHWeY1EpNb4DMgHJTWJbz992uhxWstMBPhaJFRg
	bxNcQumjS1nZ/ScQUbYxLJEJj8vf3lIemHpuGYjbRduze8dDxlikCfc8fL7Fl+BnPO0MMu1i7wM
	od4CmCOypL2hW6ScUzN4LYFhReWwllF6cNlL62sdPdnKdcIir2AMJjwqLZ8WbSfMrSYD/f5n+dw
	wNh+NVOCbhRn5R8hRchs431YgRV3deOutYdeMTuTlx7g=
X-Received: by 2002:a17:90b:2cc7:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-354b3c41887mr3034802a91.4.1770399727533;
        Fri, 06 Feb 2026 09:42:07 -0800 (PST)
X-Received: by 2002:a17:90b:2cc7:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-354b3c41887mr3034767a91.4.1770399726839;
        Fri, 06 Feb 2026 09:42:06 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:42:06 -0800 (PST)
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
Subject: [PATCH v5 06/13] soc: qcom: geni-se: Introduce helper API for attaching power domains
Date: Fri,  6 Feb 2026 23:11:05 +0530
Message-Id: <20260206174112.4149893-7-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BbzVE7t2 c=1 sm=1 tr=0 ts=698627f0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=WUWHbvwt6nHlCWk_UTEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: V1XEf87NB6cuWYXdt_jn-lZcWMQMW9Re
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfXxx3fpfk+TohI
 M74BilLh5eOPJkt/MM2io4u8KfpG6AqpIoa9KrpH2iaJoYNQcaf4oEh8FGVAdAN1V+TmZioKuND
 ByenK1I0zHvgzgtnjMtx1QDZSUeQrYYkULpbG0YS8t3W+sg5f5ymhMjJtFc9gyDeoWOVFt+fnTL
 gFSDju+HHeypjfWCf/rQ/bsCrqkLHiFi0Laj6jtN5P2LqiPBGy2sFW1jhcVd3VdmYVpSppjQPjt
 f3Bod39LES/OLm+vyWEkP67WJMYNhWtpW120LxKQCLqFoosAVPp/cW8ZZOegsdkSlW4wJhZHabo
 IQDnEGscG+KG/2P55MPF/u/Nh2RYIVWXdl0QQOH17/DykwxOz5owbje9Db3fLw5ZJxTzHzjDQjY
 uap7CACnprZCJBGVR8XwIWSPl/aQx9B8eP0WiGJlUthMO5uvqGpTDQnImO/1MucbgdoigVxnmXI
 uVX5krIK/KVMX7oCkpA==
X-Proofpoint-ORIG-GUID: V1XEf87NB6cuWYXdt_jn-lZcWMQMW9Re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
the attachment of power domains. This often leads to duplicated code
logic across different driver probe functions.

Introduce a new helper API, geni_se_domain_attach(), to centralize
the logic for attaching "power" and "perf" domains to the GENI SE
device.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4->v5
Konrad
- Used devm_pm_domain_attach_list()

v3->v4
Konrad
- Updated function documentation
---
 drivers/soc/qcom/qcom-geni-se.c  | 29 +++++++++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 4bd4fce33ea4..ecac9006acdd 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/soc/qcom/geni-se.h>
 
@@ -1092,6 +1093,34 @@ int geni_se_resources_activate(struct geni_se *se)
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
+	if (ret <= 0)
+		return -EINVAL;
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

