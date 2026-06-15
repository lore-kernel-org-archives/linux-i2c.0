Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAEC3CF02E
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512485; cv=none; b=agb7pG6uPZJ5QQ5cLMGobYVf+qs/XYBXx9jvPe9YAA4Q7Hw6vnmPn4odJBZlRQd/VkbLaYcK6JL/1Qlvcu1879T2ph96LZppUzH1v2/N73gG83cvfKRcQKswyKQC8KrGa4fQe3s/LXjJ63QwsZX+DfjFOgX6Q2ZM8HAstWVxD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512485; c=relaxed/simple;
	bh=QUAOHVDW4Udars0Jbe5wX7sJIZNINY1ZT2YyhfvvXAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNkWkvNEZyUOAKx04l11mQ5pFRlbU1Kr8ZCU1NeBpqgtIsnkoOE8XsdhO0uCUv9/d3VF8kyajibh/7mJA7wN/dmj2Mu8VuPNe1kdwJixn/aEO2jJf5AAP0eqed1JiuUvnb8FZzHDmQRZlMPClavkTEOOKIwiZcJrnvYesWqKGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C5bCOD31; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OBAlHkwx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5bCOD31";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBAlHkwx"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6Kxlw3888456
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	au/dR6Wd3jTT560wWLDqtcWcjYZ7Z3B9jdL0VywUhbM=; b=C5bCOD31o9X8JCPB
	EH2SV7jxXq7pOagOvmzO9qdzXMV1FzPgAgfTTe03s8GZtVAC0R4ARKpnb9Aur9Mj
	euFZsY8I13LIJlZYeBDbhlDLmuDi71OkTV/D73twgXMIEcdZ1V6Lw0ZlwKU632D3
	L4FJv5d7s5xXZgfEdhf8S6sjH+CLxMSMBVHljkwQMZirYPNFRzrWV83blw19li5P
	DOyU80Q6zRXw82R8F0SRWD4yeAG8iRcEPio1kTTpo/4QAFc51pg1ZrIWI5KKLjTL
	dYTDcKktDUTmn8TzNp1VMdYjuABtr8OKdee4cdwnpmoc7Tb+UNSj/6BuaJIeixLP
	UmDp5g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wxema-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c2b64850easo13180115ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781512477; x=1782117277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au/dR6Wd3jTT560wWLDqtcWcjYZ7Z3B9jdL0VywUhbM=;
        b=OBAlHkwxg+mXOBZOaVcETdKRWQKV/bFnpgxQScbGKAnm4XvaWRXbxAWZwjmBt6T90N
         8vokZLQ7hzLPK9t5BvmMmTzxYWphuHMXVzI8FKR0mUgmq3qV7q+l94vyHO+8EIKWzdsq
         6TrP+TeRhssePPkamqP3iAScLNTVEe2RszAu979PcKE6Ls8ZaK1+eARzzUA0RaZGkdtn
         NjjNzHIVSoERqZ1eYVe6tVHgFsrBwBLz8DlRN2MJM2A5JQEFXTxujmLV/Al416PiPOUv
         cUQkMtmZP/FzSwM5teouEfiZpUiaNbQ04LHex+w1/jchZgH1SFn2I7N/8Tnzk/5iXY14
         mjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512477; x=1782117277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=au/dR6Wd3jTT560wWLDqtcWcjYZ7Z3B9jdL0VywUhbM=;
        b=W0ssShsIdfASsvclDimnJmW8OO3IU8fNotdZsKiyyAMcsjGpQvSq/7vEACGA+Hj5hS
         SeEYOvEwtJyohi56cAcsMU5cxylQe1V6xgVH5rzqEAkczqpXM+75B9LlOBZ9kdUPyHXQ
         0sLDaZLVWLwAOKSBBvJP/fvhOU/qB9DN1WJ0XWQ5HVnTn5xphEsP3i+2l4klK+/Fkm+7
         aOSM1H/gToLsZhR/O6b26bQAfwLqJHGwE6jQ/+i+WEZMcCiEO0A/dYRT2Z+4JS7GegnR
         +c/PT+faVd6k5VtSnspJVzuWWycQQi8z2MivgSV8wIVFu2+edA6SPqMzDOqpZvn41tLS
         1d1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+xK3l64u8SXQJboaIYMnTuCHH6WcFlK5VfhY+S/KVGtwIAHiyfAbecXFJzNHmeq0eFsIiZyVDhmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYulANN5sPALqqpNzfS7CCMsmPlQwSA+5FjqdWz3bdbd0JuukI
	im+cIaEk9CWfCuYUz4lpxVmEoqNYB8sCA/gh9inyWvQ2zdbuUaTY41azS+EhqMjdUSAg2e7RBoz
	v6OkDDWsGOtoQb/UFg5Jq5u7n9lmjWCC0dt02laxMCz7RIZGLDgassDiSklK38H0=
X-Gm-Gg: Acq92OEYMM1WZ87UqxymOROMO4EGnR+PecERSesqHFgr/UUDNy9/MvcqHKoOkeSceB3
	5VDw8g4nEX90PaSvmVjkzxlUZLHVRNT3yh9nt62I75aXVQbjceJllSrSdZMefxyFzQzBqpgFVVk
	xvf+6b1KNM+eRv+gi3T4C7T+d29CuzvrAaUGwiMw/mgSAE3/tqnQBIO/iJiY5yNid2hENVNgXAy
	rOXAfRfK5aSOgc9AJkYEYlK7x4A4dSYXxsCfLGs11Sttxn3POZvDAeD91Y7uY/do+Bw04RX+lFb
	0Q32D/mydK3tr/Dm2jKFnsbnW6MV+IY4UBFj2TdIkQiLG7SJU3KWeAwTjepIfBnDf/zasoMudTc
	TN1mkzpBjguLP62/zGrrcAk/g8jzOgrNJf4yvfsfngO0j4APJ1ge2
X-Received: by 2002:a17:902:e80c:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c664242d9emr117854255ad.20.1781512477200;
        Mon, 15 Jun 2026 01:34:37 -0700 (PDT)
X-Received: by 2002:a17:902:e80c:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c664242d9emr117853835ad.20.1781512476725;
        Mon, 15 Jun 2026 01:34:36 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm122789235ad.25.2026.06.15.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:34:36 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:03:57 +0530
Subject: [PATCH v4 4/6] arm64: dts: qcom: shikra: Add pin configuration for
 mclks
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v4-4-bcb51081735b@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781512439; l=1517;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=QUAOHVDW4Udars0Jbe5wX7sJIZNINY1ZT2YyhfvvXAY=;
 b=/pRrOKK556VJkn2xvypB+WkA7Q98Cm4fvxRg787rFyzv9ZMhta35uNAd777+FV3JUGfvNTb4L
 we04eBxSkVqARtkFVUcK1QgfUuGB183k11kRiNV/HxlK1R5An9FDIos
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: WZKKXbmaELj5n9rDcuVzgj8Ky70FDdkw
X-Proofpoint-GUID: WZKKXbmaELj5n9rDcuVzgj8Ky70FDdkw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfXydwCPOoW7Y62
 0fDkvyEYBx+PK//o8euUpOdiExpih89Q1LcrCEALFjPjrQ9LLlLDHEnMfggLKqgW0Q2aHYw6kk5
 H536KQLQYiULu8dCdYne3syxRT/ENRg=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2fb91e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hvkXKTiNP6R-ltmIA9UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX7NfLjqWOX93L
 ctpM0LAaA6PU9d4qR+qrUBqeGEkYWo7HHnR0E/vvrEbf2bI9Wi89DdBKf1sgWCvB+SGSrieN3O4
 c5lDeLd9v0X4FllIct57XAKWqEyQwQ/x28md+mkDindcz4jjOe0D1CvaMety5qkHo+WHJYckoJX
 QGNyJrUeTuuvAjyeGIVEdJoIiPijDj2lyBRryFI3HPB/+ihTX/aU3NAbB2R9NQ+sgCqRd3dtM1S
 TI42oUqWv7x60tCX6QPbeeVaIhHKJ3HFQrbel6bxcLo6ywHQ+QiOfGJUCPdvsygeXBXAe/+Gs7g
 xpq8jyD9Yrn3+XofUIoPqho4Ae35vOEu+mqdkqjQ3uBgtQrQ05aBwOpVSMQAk11fQtNIB12G8Mu
 I1YufjottexKZOAIghw+LIjlW2NvsLlUdiJL8iL67Foe1wSaVjWFtpdvIQPimiwLoqLczH8JVzT
 mDhXdAATcidEudxObEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150089

Add pinctrl configuration for the four available camera master clocks.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 57732804a6c6a114a407a4a541a1cc7af7635ea2..16b547131e8b14541abc68ff7cda126ba777ad80 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -380,6 +380,34 @@ cci_i2c1_sleep: cci-i2c1-sleep-state {
 				bias-pull-down;
 			};
 
+			cam_mclk0_default: cam-mclk0-default-state {
+				pins = "gpio34";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk1_default: cam-mclk1-default-state {
+				pins = "gpio35";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk2_default: cam-mclk2-default-state {
+				pins = "gpio96";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk3_default: cam-mclk3-default-state {
+				pins = "gpio98";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup0_se0";

-- 
2.34.1

