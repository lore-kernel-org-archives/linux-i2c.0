Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2B4219EA
	for <linux-i2c@vger.kernel.org>; Fri,  6 Feb 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399715; cv=none; b=crWq/Zz8ypMe04w2kbj2EuCIrWeR3/lUXoMbB5zFjxwBRPmvh85pJHZcBFLswGC235ZBwQJzQCadvPdgNAIBpdV7OJk71Gj4K9ErO9D4z+HBTdeB7p6hmTY/iSuZd49faU1ipjvNH1PSpzRk6NAnxq6YQKTbMzw8PHMIR330384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399715; c=relaxed/simple;
	bh=vinpJK3AdlE6QuECVjsA4xyKYusB2fCdpA1B0h1Sv7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzSRjpEbp79fYMnppuxTM/tiQTpGjleoNV5NX3v09IxgthgzvfkdvJ3OOTUjYq7FO+S/qsH7sekftnQIDlx/hvTiiaJo8Z//WpmFquUbfP7Mvmu19B05snkZr6ncK4kALLmPYUVmG/qhbp+YmrNGOnBzePQhAmx+pbD1dJEAO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MIgtPWhP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4ys4HuJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MIgtPWhP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4ys4HuJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616G3m3S2490278
	for <linux-i2c@vger.kernel.org>; Fri, 6 Feb 2026 17:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iEGuO6CekKn
	dAjKBDhzD10xpNyXSXQXlYftFADS5L1E=; b=MIgtPWhP1cB88SA9xggokBWzRX5
	rX6lduVj09Kktz0Dt60q8ul9cFQCZZd4Xs2ZGaVHkRZ/PZud7fy7d3eawJ8Dy0Px
	YuMND4PVzf2nxL4irND+grUbzMUtQzofAf0i+XI1P1vXsWvSzACYxzyY1EQkPq1z
	wltk3Cofzv7No0wAbfgS+tjb46o5DZry1cjtMFVaxdeoQcVWro+g/0AwJsQ7xy+6
	CgAfLkctMq+8nwysVak/dccvpXRVtZxQe8A49/46vrcdrvanTIz7S+TxoByfpdIo
	pcBJb7++BuHQ4FVufMJ+xwUd0oQCKzF3BXdAu6kNeqiNpjMXjUIOckde/nQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c9c1rp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 17:41:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6366048135so2203608a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 06 Feb 2026 09:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770399713; x=1771004513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEGuO6CekKndAjKBDhzD10xpNyXSXQXlYftFADS5L1E=;
        b=Q4ys4HuJNF8u7jrx9qspgnjLabRD++vfzTJnCcnomL+j19OLfFFKMMtMohF76a3yY5
         m/4L2AFRM0R8otaRVitPtJ+SV0axETGpq64SO/1Ok7b0YG9G8FJ7iAz0ut4HOtvNuyd7
         i6Zp/RYcmJXrDVXO26xIbzKiKDgejLaTw3Chv0jSeWTqMoyZ5l7U3V8LEnnnDJoLV0sU
         pTgLDNQROt4el6V7YWOWkEfXZxM6YtPcPqkgLyLl9L4gp7I3HnZxFZ+/zldMtLLLOGrR
         sVB9+HZz2nLNO5mmcMUR3wBsTCoVUI/G32Is8JYkojUzmf3P23QQ6W8SmNwrBACZ59X4
         2wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399713; x=1771004513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEGuO6CekKndAjKBDhzD10xpNyXSXQXlYftFADS5L1E=;
        b=MbHBKwmEhcm/ykoOypLHGqQITF22Q9XDywctbz5+cxQcZYyb5kAIItU9aJaRKs73ZA
         iTx8qphx53MR4Etqw7LaiKfWKm+Jv7/r64R6urXIVHE9EH/xg3adAnJTGty/UZvIP/Ko
         vCa18d9w0XLHhXhmTKwhcdXCf+oOJR5Jbf3g2W9KMrzbDKpLHcCDGT0sSwIenFfBOq6T
         4vzQfjcGmTlWhCXSJHPssKazOMCbGk972fwJ69+Qf6j3UALekXINZRbJXDVDbbd9buXJ
         HZaAyIM7GX5H7DWEY3xX4Af1t7FThBibV6pXFACDX5HH9g/XwIMBomVQhCa6BPbzfPAg
         LDlg==
X-Forwarded-Encrypted: i=1; AJvYcCUM9oqx6h313TDLkatR8qG1VMiwOCrPl5Pu2Cx8OZAacPs6eoOXx+DO00Z8fJMv8ODLwjD2pboe1kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhNhiT78Db2HnM0IqEWAjHwzL2nb/1NWsO6Bjt0Vnt6k5UEpg
	b5c2eY1cbALaO07VpvVUv3gabpsBokv0vzaisl9bdo75poYPSgWKfll2ZuWn3MI1tQ9GGittPaV
	brHq2CeXBKHL/gYCOdkMunjRc8bSiVGKurxa6Q35D7jW66uaNB2QJ4fYSqakqr48=
X-Gm-Gg: AZuq6aItnlERNA2veVCNOgF0JTJUQOzv3J9KqULXQztXqg9nt6kLXIG/XFbkPND4a+f
	DDVqIe4vtLnbMLhzZqFwznb3sibvzsswvLc5fR4q0DlymtITkfW4QkTX18ZL/Z2T/dejyHBUCi1
	cqbIKF8sb6A9zHvHjnJXVwlyAU7EHd48u5evUDw52R9RVBXw9AQ6ZCRM9UyV+JqItrnA9vqOUwC
	U6XHhuOv2HKp335GR57BdnPYz40k4ajckQSdf0IwsyUzdtXtRNeZCVqBcxkYq+SL3PlK0cdoZae
	hblPOFTAIIlhePzm0r7M92i8arGIyO9S/uw62U8sDnEXtXVyxJYmPGwKJkGhq2iVoV52FVrwFS4
	7X4Ed1j9kFGcgPZNlAQGoKs5o1Y1Hs+wWUJOuy7ORQfA=
X-Received: by 2002:a05:6a20:429e:b0:375:4503:ef0e with SMTP id adf61e73a8af0-3938f9a2322mr6550398637.14.1770399713025;
        Fri, 06 Feb 2026 09:41:53 -0800 (PST)
X-Received: by 2002:a05:6a20:429e:b0:375:4503:ef0e with SMTP id adf61e73a8af0-3938f9a2322mr6550362637.14.1770399712392;
        Fri, 06 Feb 2026 09:41:52 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm2639387a12.19.2026.02.06.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:41:52 -0800 (PST)
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
Subject: [PATCH v5 04/13] soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and geni_se_clks_on()
Date: Fri,  6 Feb 2026 23:11:03 +0530
Message-Id: <20260206174112.4149893-5-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BbzVE7t2 c=1 sm=1 tr=0 ts=698627e2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=fzsqq50RfsZR9heXkngA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: QIsHJN-fPHKX222yW7SXbrFiejBplMWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyOSBTYWx0ZWRfX00+6bNWYrSpa
 wJtMcnB8BvSi3rhHxc9OZ0MgOmMDl26XU2dFjPUMcm1v3W8TQuQXf3AR+DdZj/2NIcG7iAF13BZ
 dLeEf2XbNEQ2GT6J2cqxQwwqyO7RqkDqleiOTdehZvZnmgXsaaeMfhnVccxikmJBCvUGOxA5nPs
 6bE9hJ0DR1clfLK9uUBb0WJFV7QqzPnrRwUBuDIoBrXdcG2Q419+N7VLebfuDERw3+x992dUCsV
 3jEviIEGDYZgbJ8kPY2n2oo5Afp0/w1HK190+calsWA6jEhxKfm5hv3Gh3TN2OX1o0MOP6+8gOS
 NRdw2jv6PS/iANSHgZf+rPtKDWtjx+k2aNb4EqIjfndT7BTSMVmyQWf/ZO7WTJ/N7H7cUmGQd1l
 ziJ++PS5HqDdCHajrvvITuV7hBn/cb6vjn78g6oHzdiyTWPcn+RBohytzyGaUFAwBwHptybeaQ1
 g34gHD1jl+eKq2OvNUg==
X-Proofpoint-ORIG-GUID: QIsHJN-fPHKX222yW7SXbrFiejBplMWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060129

Currently, core clk is handled individually in protocol drivers like
the I2C driver. Move this clock management to the common clock APIs
(geni_se_clks_on/off) that are already present in the common GENI SE
driver to maintain consistency across all protocol drivers.

Core clk is now properly managed alongside the other clocks (se->clk
and wrapper clocks) in the fundamental clock control functions,
eliminating the need for individual protocol drivers to handle this
clock separately.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v4->v5
- Added a Reviewed-by tag
---
 drivers/soc/qcom/qcom-geni-se.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 75e722cd1a94..2e41595ff912 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -583,6 +583,7 @@ static void geni_se_clks_off(struct geni_se *se)
 
 	clk_disable_unprepare(se->clk);
 	clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
+	clk_disable_unprepare(se->core_clk);
 }
 
 /**
@@ -619,7 +620,18 @@ static int geni_se_clks_on(struct geni_se *se)
 
 	ret = clk_prepare_enable(se->clk);
 	if (ret)
-		clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
+		goto err_bulk_clks;
+
+	ret = clk_prepare_enable(se->core_clk);
+	if (ret)
+		goto err_se_clk;
+
+	return 0;
+
+err_se_clk:
+	clk_disable_unprepare(se->clk);
+err_bulk_clks:
+	clk_bulk_disable_unprepare(wrapper->num_clks, wrapper->clks);
 	return ret;
 }
 
-- 
2.34.1

