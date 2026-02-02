Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A738BF8C
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055775; cv=none; b=N7dqmhmr6HSMnV9qSLl7pVn2AIjSRjYp6nGNHaZDYcnV3edInOvCSmzUAt0sgb58OaKmBs/dAhBCrmuwZU+IdoetKQ0qrCoim57+jqenremvbHNEZi4RL0AyrsLZ6PrF8/ZTucnOIVK71d/d54Mq8YKcS9ZI/DDvI4SCdh5H3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055775; c=relaxed/simple;
	bh=nAZMxJaPZ93+y83+6k1pES++idA/vnmjXuZYzre1qSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s6OFfoSPrGvYtfNOTXpbcRobX7AD2AbCIyhtUCpRbZVnBVWo5gneJfUR4mxUlNRhdKhfeRCoIJW0ChfA4khCtfoJCCKBJ8rCihB5OfDgcH06m+vhaT+MX3Wa4p6SACwq/x/kPMSj5hPS6gYTLOprmlBh3DnXaRY56Vh+5Ci+WmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWE2pmnl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drAljPG5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWE2pmnl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drAljPG5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CJTi92884370
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wWnOL8UZfjGMmCa4y7NChRkFDGCYeDJ6A71
	nXpZlX3I=; b=LWE2pmnlyL1H77xuLPVrJ8y/5a7a2J2XtTuO3re7fsBHigw/y5Z
	hx0cn8r14HEbN2Xi8ss6k/GTEib8cC1EmEH+Y/ZrtFozIuJDqzj5Y5/7H7RmhoKj
	WvT9F8cW3+2TbhVEdWY/5+01K5mXwpj8qANRnxAD8mF1GlEHm0RtoYOyqpQ5z+pa
	sfmiog7/+RuojAxtoSQgjyk33U/wb+ijrjUMHLRyEhpudPp3DVvJj+tK+ynruRuG
	IwkIOwdjQkQGCyDjKuuaMy3NGij65bpNXqy0Uc6XxbOsuOUcdgui373qC5+F9lnx
	0RtfnTqVFki1pBcdokZd2cXHx09xZdvkGgg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2uu3h4pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:09:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f42368322so4070158b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055773; x=1770660573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWnOL8UZfjGMmCa4y7NChRkFDGCYeDJ6A71nXpZlX3I=;
        b=drAljPG5dBioKLcwIMqsAZmqmdSHTjiVp/mhpQmSsVNykDHPtZ+AG6h09VTxjWBKcT
         w9YQ2KNbqoTYhcdeuid/9FMC5OFbwEHN+8BTwtoLOTL6cDrWwOoW1xDq+JrVLRKEiG6d
         3C+U8ZK7nYDuEupFhsGUFlcijUJMbl/OojXHQq7tKuiLUm1VeAnJwLHe63o51DzMQp3G
         x2EIS1HTx/AHX9jzznXBN7EGUdLhF76s/N+FTLddM0AzPEcywIh41z9DCC7I6hp6ZsH5
         6KcCB3aNx50AzLO9vj9P+yllD+mE2vYVkQ8U0aBUtqb3CN9sI01MaEnu2M31oUllrWXR
         bg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055773; x=1770660573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWnOL8UZfjGMmCa4y7NChRkFDGCYeDJ6A71nXpZlX3I=;
        b=n3rjZYyyPXgbYo21LKbKxz1pPeJXuyiqH2JnuqBmwYTS14+J2mGNSWewfSGW7wE5pd
         p+ZnGoF+w3WQvbtrvU8SOQ/96doaYoAcGNBoSjZJm0Ygd6BsGo7TnMHLqRd3kA0qRxGW
         mVBGuuX5mRcBDonaJuOzKbaI6+HkjeQTITN13r62F+Af/mGhQUjRYnfJwNNTn/fnDGo7
         vhju02gLldYS5LbMm3/kem1V0Wa1XiyEAQQo8Dfbb5+kW9nMboo+9bFTWm5NTsj1WKjo
         zwDhYO4ek/1ly7Hq47dz8+95VhHY2AJ6BXu5l8JyKD2y3IokouYPx7iFLT608Awn3lRe
         zAnw==
X-Forwarded-Encrypted: i=1; AJvYcCUDvldlcCgIOhGSHADkzG/pgXLe8H7Hjmavygdz28xDUFUIKyxyzZS9AI1bWsnr/Rc9ab1btuzh41w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHk6WMbt+xS1CWVMHMkJDDzRe2nNMs7mLA7PhovdBD8LpI6z/L
	2B03+OND7TQln8COItqi17U+pOm6g+Fs4AbyFV9UbQmWpL+eSVtIjM3FXMYWiBN/hj4EZxlLpR9
	HUb5i6wY/2rrlVRlrq3bed7CsNz4xJE/57Inh1HqnV9lCct/guNd6QYf3avoVHJM=
X-Gm-Gg: AZuq6aKGwFR6lXwS4+NGOIwnj11evapWnLKb5uRZzB7IfGqmbkcbZ7PRn0jLRaJK2bp
	XGSMdqsWg/p2USFfnTfD+tu1UMQLY98rVIu5zhLMAeA5lF43C12r6/PxBV33b287WoUPLVeOlpe
	FaVZWNs5GxpWngXrfFm2CVUNVqXpA0oVDUhiF2E/R+NirocdIm/IRLB+vyI5lnSgORUteN/FkBi
	uu5y0sBq+7Q6ozybFll286+P533jT4DZCG/6C8SWYLCH8QdxYS2QfoAHyhzlkH7KNMyJ6UxwRPI
	LNXaIBXmgMPGKbumtkL/TgGQRSq5rBuGFaUSrrbBKcnaAbcgY2asnUO2e/WRhfctl8Vn2bUMfsW
	yJDZfJWrblk3Zb8aUPsDEeTvToSVuH+YirLrIPzuK1mQ=
X-Received: by 2002:a05:6a00:94f4:b0:821:a7b6:10a2 with SMTP id d2e1a72fcca58-823aa940016mr11985939b3a.62.1770055773071;
        Mon, 02 Feb 2026 10:09:33 -0800 (PST)
X-Received: by 2002:a05:6a00:94f4:b0:821:a7b6:10a2 with SMTP id d2e1a72fcca58-823aa940016mr11985902b3a.62.1770055772385;
        Mon, 02 Feb 2026 10:09:32 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:09:31 -0800 (PST)
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
Subject: [PATCH v4 00/13] Enable I2C on SA8255p Qualcomm platforms
Date: Mon,  2 Feb 2026 23:39:09 +0530
Message-Id: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6ZxwCqf9njkdzNJ-bYxjQBQ7YnGpy3NF
X-Authority-Analysis: v=2.4 cv=OrRCCi/t c=1 sm=1 tr=0 ts=6980e85d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8413JC8MLbS8ckBEwAwA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 6ZxwCqf9njkdzNJ-bYxjQBQ7YnGpy3NF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX2KDxIiH8vn1s
 dRJXCxVrVJ/zMuk+naMqNFf1r16JDMa3Ijgxe78Dwyk8TJBQo+lyVcPW4O/NHKot3cbfMrfVgvc
 QMommXBoJkDsMl1oRgSHT7T8+qqKP1i+jIqLSMOrj2bZCEalxkETnDF2boXSe396+TjnLU5z2tj
 gYuHGnbN7L1qs8unaF31gB6GunWfh7pIQq+PzlxosnPHySICEWlwwQjSqhKtJU/N4VIvtlmMerD
 M9fAFbViYu2Z5OLncd6MA3aC8XDNBlNKXGHrR65LdoXB5+kCWudjvb74HT+DJIJRX/sC4Ao3+U6
 acqidTJfu6AQKeGPtP+VtUAuVgKJ0kUJ8VPH607xLOyWkI8LAZvZDiRFnMRJxDOYqqIertsLKTo
 Lzdmbe4MHjtYU+a90SrBaEvfyVpnac/i1/C0utQvA1cL0ddXSk7CftYoMX6kowu3+4EYRlKhA80
 41Ngb6t54u6E5VsMqpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages I2C frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate..

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Praveen Talari (13):
  soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC
    path optional
  soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
  soc: qcom: geni-se: Introduce helper API for resource initialization
  soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and
    geni_se_clks_on()
  soc: qcom: geni-se: Add resources activation/deactivation helpers
  soc: qcom: geni-se: Introduce helper API for attaching power domains
  soc: qcom: geni-se: Introduce helper APIs for performance control
  dt-bindings: i2c: Describe SA8255p
  i2c: qcom-geni: Isolate serial engine setup
  i2c: qcom-geni: Move resource initialization to separate function
  i2c: qcom-geni: Use resources helper APIs in runtime PM functions
  i2c: qcom-geni: Store of_device_id data in driver private struct
  i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
---
v3->v4
- Added a new patch(4/13) to handle core clk as part of
  geni_se_clks_off/on().
---

 .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml   |  64 ++++
 drivers/i2c/busses/i2c-qcom-geni.c            | 303 +++++++++---------
 drivers/soc/qcom/qcom-geni-se.c               | 265 +++++++++++++--
 include/linux/soc/qcom/geni-se.h              |  19 ++
 4 files changed, 476 insertions(+), 175 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml


base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
-- 
2.34.1

