Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB838BF83
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055860; cv=none; b=T8tmtMWxJffRF2QHpDxY1K88ZXlddbikVJ8mhaG+vlXxt5Fvl1IX+Jbyvxfzr8q+7p5EhTf4QC/FgTpWurmHIh909vBK1ON35vHEseaSrAvMrluSUH820u/4FO6TeFY/ccOy7fFiqu9arEaaC7YmKeioyjIRUs8ua83ZQCMmgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055860; c=relaxed/simple;
	bh=zqKO3UGvbDMJ+JT+t551VX1HZg/Yo97PDn3IZ5tzYGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4az2RrUvLZ/umOgqhohSbqNGjac5izbVLM6Zbtvu7hlvqcXvOvbfkEKREU+BoRRQxUiz2dSTq/ktLUe8RyQ+Y/Vwg7xz5aKIQVBKXSXkl2sly2z/OXAIoaGwJQJa7t/GX5PgdSuRuRWiW7AwUbSfgZAHDU5h5iK3f7wX2ozEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ca28SlEW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=asvA2l41; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ca28SlEW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="asvA2l41"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CVOwr256051
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R+ngY54m3iC
	HtNRCdl+T64Wh2WWMDO3stultYRdrKfU=; b=Ca28SlEWBX3L+O/vmn+ZD0CPHmE
	WX8YwUV8J/1W5SHndye/wftlhDMue2A2a6G/qVWdkl16wkLB+qgX2mng6WBLmyVR
	tC/dYWQAMbLsi+xlEGamVZJ/+vbfdZhjqVGVCUV7AbOzi7xxeGqJz8CW7V5jPb1W
	JFVuKtFlPTFj41zPg9E52DJtHUyD+yEfab+UCSfkPZhtGU0V+Uuz6TIiLRGNVWgt
	urmRuyO6VNR9mCN57GzucqiGvAL/VP4tMqXae5mVjnKBVMitGxzedWl8Nm4Y8bBK
	FwYEMVPSAmZLfUci5a5rQwcPiykQQm4En92Z6MJBhblvi4CHJbyde/SbhsA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0kh36q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:10:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-823486f311bso2466939b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055858; x=1770660658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+ngY54m3iCHtNRCdl+T64Wh2WWMDO3stultYRdrKfU=;
        b=asvA2l41LOawFHmCz/JZ7qxtpghLGVs6g9VwHDY2R4WcYwucw16FetXSCCHgBf7IYM
         Ln/ek0Xs2qCfjgRFQiBpvjj+NQWBIZIFYaojK41yRU0j8qLLPSMEFnusMOG+dqCOWK1q
         bONLV025qPmfyXwfGssKPptuWp+qTQU1MZkjIhDOkJT8a6kPrLMURo3vIJgUCMFPEkIK
         livChx8Zo4RF5U6cfaqJDtHtl4CFdOpq7vozRs4JtKaBNKeRbd8doPt+ayQpWk2bmgNw
         /OlC0cUS0n4XRK6rU80v66f1bvbacubHqQBnwwzG9+QJGy6+6t/Vnjc3ACbDBVHXQvQi
         YLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055858; x=1770660658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+ngY54m3iCHtNRCdl+T64Wh2WWMDO3stultYRdrKfU=;
        b=BQqKotv8vt9iUGUTHUCeuZZryQDQYVmmgx7PlvVXLlug8dT6COV7HICshXweJE31cM
         HZrSltBFtg27Ba+Gk+ybc/+BCHDzek3qjzsf2fhvdlzk/XoszJny0xxNAfsTVsAongAX
         syXJWlRFIJ40qkQ7Rlr8nC6fs9I5Md3yQQHYkfAo1s/zYkDORE3TDH1sYCSRR56OEVWw
         v9D57yS6A9Pf3pxCuuv5dML6vtnH4W9H+DQ3+Oamfp9lJP25pYXIKpYDSIqEb++32Nzp
         je1SMgj3VOa80Ei0OHL1dS0bcYWuWGltRfwibqn0nDG7yxMnfMkJvMxaY75+7LUKzxq0
         9DUw==
X-Forwarded-Encrypted: i=1; AJvYcCXpEZUF+uHhODhg8MAvtejgkLPkuF2ED9hFFGQkpEjls5sjX3XDmdYKVcRJ0WaAry12U00Pl5yYIvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2biKini9iGMBHUhGHcHjvcMDzHXUI+oZWSiHdDUywedcvPJD
	sZjN12qCkHC00Dwz5/6wD72vCGfXyf98Qrll9NZ3iVHD9R5yz44Oeo2+ArB/913WiWl+1/6g+ml
	3omtOXHx8J9o59vYR8QRONTN94mcSLLA5oF+px5ep68uMGT7doHH58/EHcAmhXEM=
X-Gm-Gg: AZuq6aKmx7/41llfeeB0D/hpKGAd1mMAiPD6AnATKH+cgVwPTA6wgS9cdlhd1H3iC+7
	+YvlwkOa5p6/VAgnfiU+PBWXwRrHOxyGcnKXQYuzIogznhZNPeMUNuq1k0glODnW1tWCetcR4Sd
	oVgU8PhDXZ126pGM8fz+WkX/eDcCYTUkw53kk3g8lEz6fESz8PtdC7wAj9q6xlmudlILFtNPLra
	Ues8sl40Y5ZUy/NYWUk4O7Stjjmzi/eKJBjyIcgfyygJ0UuHW7yy+REDR8EobGcOMm0ZGcTWE7Q
	yBqzR5nm4dI7me8bNKS9baaofBppLK51FXTw0uDWgbkr2ew/+YpnWbCZpukDciwKqti20rfMIDP
	Ibpg8EI6kIEKp5U0xIFGAWZP0s3HDG9xdvH+pY/gNIJw=
X-Received: by 2002:a05:6a00:8d87:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-823ab695dd1mr12685377b3a.28.1770055858031;
        Mon, 02 Feb 2026 10:10:58 -0800 (PST)
X-Received: by 2002:a05:6a00:8d87:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-823ab695dd1mr12685340b3a.28.1770055857462;
        Mon, 02 Feb 2026 10:10:57 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:10:57 -0800 (PST)
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
Subject: [PATCH v4 11/13] i2c: qcom-geni: Use resources helper APIs in runtime PM functions
Date: Mon,  2 Feb 2026 23:39:20 +0530
Message-Id: <20260202180922.1692428-12-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=6980e8b2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3PeDo36KSfG0vlEF63sA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfXxhbLSQAGx/Fy
 /YUx1M0ea9J2tU9DqYLGv97EVXzd/h0spQNBPyJHGRcHXKTL01+b+dLle5vYCy2g6nRkR0XhD43
 F3H7hXkRZ1pAgz3+rRvc3HQV3s1pNYUikk+ZqgUx2RFBpmi+HMeNZEmyRg4JWYQU3XniMhx102b
 rQPp1n+z3QXtZWZn7rNqVqrmLIp9GVvJj6F3UYJJgGOhcVCHA04+7cjHxizmbqH6Uz247KY8Dcj
 TigDXmqaDSOoNQwLCw7QMEAFRiORbAMYn5mpgQknPqIMW04AdqU1gg75chJfgAOuyKDEwqpni0D
 tDMpHye8j71I8XKQEiGWLxMvN/zBj0O2dZn3x+D5A/ivobNMlz40liwHlcKskUN9DFsjaXsARNZ
 LqNrIYKDAtuhRbXeEAXlJkB9qNEWE9mzE/W3skOhPrDHdk3wKfvurSRSkUz6PEthZ6ULdLW/Ci2
 iPhIPJ3SRLOn8ZtGm+A==
X-Proofpoint-GUID: NJpZRDdBEq_UbX7NirouuWoCR9wOR5Pl
X-Proofpoint-ORIG-GUID: NJpZRDdBEq_UbX7NirouuWoCR9wOR5Pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

To manage GENI serial engine resources during runtime power management,
drivers currently need to call functions for ICC, clock, and
SE resource operations in both suspend and resume paths, resulting in
code duplication across drivers.

The new geni_se_resources_activate() and geni_se_resources_deactivate()
helper APIs addresses this issue by providing a streamlined method to
enable or disable all resources based, thereby eliminating redundancy
across drivers.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v3->v4:
- Added Acked-by tag.

v1->v2:
Bjorn:
- Remove geni_se_resources_state() API.
- Used geni_se_resources_activate() and geni_se_resources_deactivate()
  to enable/disable resources.
---
 drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 56eebefda75f..4ff84bb0fff5 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1163,18 +1163,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	disable_irq(gi2c->irq);
-	ret = geni_se_resources_off(&gi2c->se);
+
+	ret = geni_se_resources_deactivate(&gi2c->se);
 	if (ret) {
 		enable_irq(gi2c->irq);
 		return ret;
-
-	} else {
-		gi2c->suspended = 1;
 	}
 
-	clk_disable_unprepare(gi2c->core_clk);
-
-	return geni_icc_disable(&gi2c->se);
+	gi2c->suspended = 1;
+	return ret;
 }
 
 static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
@@ -1182,28 +1179,13 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
-	ret = geni_icc_enable(&gi2c->se);
+	ret = geni_se_resources_activate(&gi2c->se);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(gi2c->core_clk);
-	if (ret)
-		goto out_icc_disable;
-
-	ret = geni_se_resources_on(&gi2c->se);
-	if (ret)
-		goto out_clk_disable;
-
 	enable_irq(gi2c->irq);
 	gi2c->suspended = 0;
 
-	return 0;
-
-out_clk_disable:
-	clk_disable_unprepare(gi2c->core_clk);
-out_icc_disable:
-	geni_icc_disable(&gi2c->se);
-
 	return ret;
 }
 
-- 
2.34.1

