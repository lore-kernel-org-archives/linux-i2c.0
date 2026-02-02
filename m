Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760438BF7F
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055809; cv=none; b=fpinYusC/mMzuGqeAAjHcHBlLHnwI+LF1QGR3365KlH2DYDgP+fiH8yGEcVKF4hjQTFdLb3GybySKQ3wwsJPXLU76SYwbWrcleWKAe8yKPSmi1CQJqvP3cU3Y0HCEVw0+ACHdd3R97lgAlR4xbhkXvQX1oLgn47228+R44Zo+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055809; c=relaxed/simple;
	bh=jI29xu22h/aOLZUcJch+Uw8kf8cbeFFY9Pk+gWe9Kig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOychxjJBhvTJ7pORNH6uy3QEM77CcVbAXfp8EUML7v+BO71LyiRLeolZLxLUEd0bFGj5OltL4/FSkMt23hNB5xCobbFFn1CEuvVXVomBxd4mnkTzFNwYb5izjUcEo7e+zdA0/8uefkM1R02HPjshWs24rTFMh/Gerv5GKkFzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AFGdS8eP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gtD/ALvP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFGdS8eP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gtD/ALvP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B4FpQ2848628
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qe3vIqAk4Km
	3Plesr4c+NFgSaiZDJPqNZPQYZwG4wuw=; b=AFGdS8eP37rD+sXQSFDnIkiieoI
	RGO9hMpu2rX1VsUB8eV5JtfkZ3ABWzot3jB35bcHWyhb2W/XpI3M4IOLr3vmrljk
	TnEbRmJXqK0G+ZU2VX4cssocaOSpasKbm0XBgHZydqjSglxjY6ikJPK6nC6NHAV8
	1aHji5BXQOMbpTjSfiJqtKbgaJzd9npec/zY36mtzAE3ngTMJFa25FH1UUssk3Ru
	PYeDFU9Dsg/Emwq4VQ1zWn2f6Qftuk1luokMimIDiII60MlOa7g5P7unVDa/igUO
	3dT7ycHKMIOMDYr/abTQZ2FUHUoOsCtu7WQTHBedTR9/CJcjZAJ7yr9AExw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tqthbxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:10:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8231f407512so6092734b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055807; x=1770660607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe3vIqAk4Km3Plesr4c+NFgSaiZDJPqNZPQYZwG4wuw=;
        b=gtD/ALvPdVVyFOIW5s8VWjijwxxNRXW6hta0oJi5+bBoSYcQiCLRwnzkm/OUsPHq9E
         VFZtiS90Tl3pmy3V6rabbYwJ53eivVy/PH0oQ1QYD61DTKJk0bsXZ/dcHd17AZtFjile
         nvUn3s7Strdo9aoHuzDOlB1XPKCYTrQIbj2WKaupiVtKbmh9VBk2b5qE836rFuWJiljF
         vOU6SYB96Aa1EqA5AWL+qUb93PuiHS73Si3qsEhvS4T6dmyuhfsae2q3+bmr1C34mRXb
         gxcApizvhQxHg4nd0e4kt3oZN5YhW640wpaPhpAHY3+1Qv7UB2MatmBRDSYCsQjyf8ng
         2Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055807; x=1770660607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qe3vIqAk4Km3Plesr4c+NFgSaiZDJPqNZPQYZwG4wuw=;
        b=CczgXkNydrJDGopgOdLe/JzqJ5pxWqjf925pk9cFSdzwHksTOumoy4ZmBfnutaAEWP
         WV5/+mLMZv8NGSd6TaPXRZZ/erYQoDd88wvujg+9Mrg5BOO+1sTLaDEjHdWMdFyp7BkB
         rHZQCNBwkbe4KBuboW30zbN6p4RoUEIOlbXjkXfKkyJ4apJS3Or8+81OdMH33z+A1xYE
         5jH1CTN6r2Af3cKiWcCUW9JPi5MMmEiN+Ww+AvO0gqaZkbpkytuM5Ogg+EI8qGpuUWnB
         18HWqhUOeCMr4flVDcWZMztZwjAopzpP6yZ6KNp/oydrWh4Gf2aIPxp8vKS6I+rG8RuP
         lcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFJ4NFBMIdl1Ipxt7VxveFyq8CCmowP7zzw7kA+iGFoeceoW6x8h00VfzvoVL5iKWb/kjR+eOMjnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizCklBKqcn6QuBcv/RjvUYwWKNUiW1FTcUmiKCnHXPUEzKO8z
	2j5++Jv8d5ZUfQCdrieB2oxtaL8gK0FceuQzeXT5hfXO18SfgWVfDj4rs9fXigHiDP5EiBFklDA
	680UzFUUITVs4vhW1id6FRnZYy0l7ag8hNlLIAg2dExD/VJmrI0hmDGA2r5XuDp4=
X-Gm-Gg: AZuq6aIExYrHYW041ynpHNGhDS5eR5taOn+FDFEYaMYDoHLbf7gZP5696h5TxCG1V5/
	8z4u86t3jhxxywgA6SUxn/t8/Wbf0MfMPxVyb4qCPu112Chjg8CN94ua38fDVct2wXqol7kewJK
	zodBvbupOvhEhyptKVorhROeVRqETpKThE2619vge3tnpoNQzbbUfZ+1cPITNw92oq0m7nLYvHa
	Om3Oent79v+f7e/CEBzsdmXE22KQYFcdy/xtCbMUCjfbFN98otPlI55j1ztIVvtkzqeQJpJ9irL
	9TfY8YHSIP84RHIAR9DOPPpIgbxXJME8zJ9PQFK5r7n/pgqFgdKCfeWL9FBIJgahrncz67aCqTi
	LzNHkma2g6tAwHQpo1kTFK04y8QoVLV4EUkur8f5k2uQ=
X-Received: by 2002:a05:6a00:2ea3:b0:823:1212:8e87 with SMTP id d2e1a72fcca58-823ab748a2amr10756622b3a.32.1770055807147;
        Mon, 02 Feb 2026 10:10:07 -0800 (PST)
X-Received: by 2002:a05:6a00:2ea3:b0:823:1212:8e87 with SMTP id d2e1a72fcca58-823ab748a2amr10756572b3a.32.1770055806518;
        Mon, 02 Feb 2026 10:10:06 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:10:06 -0800 (PST)
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
Subject: [PATCH v4 04/13] soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and geni_se_clks_on()
Date: Mon,  2 Feb 2026 23:39:13 +0530
Message-Id: <20260202180922.1692428-5-praveen.talari@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=6980e87f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fzsqq50RfsZR9heXkngA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: QIUejsMtv7ECpxoyj45lV5T4EWCzgEL9
X-Proofpoint-ORIG-GUID: QIUejsMtv7ECpxoyj45lV5T4EWCzgEL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX0BcYJjDZoOxw
 f86tUggXtAHElOluvR7IqAuyRPpJxhDAJ26lY+2a7Ii0Q9Spyu/CRl5FiVi6zHE1O5BpA/mVUzf
 Xx7LUbkKDMK8zgpf0V1N2i1BnoGshOGmASUP3VFxTKuOEj54IaFS3d84b0U189BW5TLpJtJRam0
 EszEkx++RCw/KePdq+iimNlR06ygzBooo00SlVTmF1LEIReBd0xOe4JoQ7tjWq1Nbu5Gu39u9hf
 TFuqfaU3+d/Zbn4MR1p4+2fX3dqqMci77e7vjBIYeIdCnSF2EEcVapWNYV80Oo8sgIud+XTfQJh
 o/FEmIAzcnQrnFwCBD69s0WKYJLtL8OCLqcO9J2OBPpR1WxyhKUPp36XZ22OiMG5Ao7NS1fEPhS
 +WalVVF28S5tPPpSf+p8bgYO4kFpzQ11XZIbf/wIf1QEYAtTw1Dx3is7TEtMH8TKMKQRU3YReU7
 q1B8J9uUiPn/JG2otkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

Currently, core clk is handled individually in protocol drivers like
the I2C driver. Move this clock management to the common clock APIs
(geni_se_clks_on/off) that are already present in the common GENI SE
driver to maintain consistency across all protocol drivers.

Core clk is now properly managed alongside the other clocks (se->clk
and wrapper clocks) in the fundamental clock control functions,
eliminating the need for individual protocol drivers to handle this
clock separately.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
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

