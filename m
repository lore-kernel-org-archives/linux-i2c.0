Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655795;
	b=DBXG6GV1BY56o2nXyKaHhPPKQ097z6ktpGtFlJ9qhR3MsP7eMwJsF7StkJk0vRw7t1Em
	 229GQIJf1/48enOXnLp4QBONf7Miw4av8BRyrEqfGcg8IwzVivlRo1fcj113Jyco0PS/g
	 muIEt9SDcStqWLF5i/uU3nRVHMBMFnhoSdax1Bjf9XjdNzE3qJs4Vo8h98qDkZhO+Oah6
	 akQ9z+k+W2I+VAqVi2EKX3HR5QemzYb64yjsWqVTWiUlDaAcgB6ngjlfIr4zYPem1MgFO
	 /63oGSpt/0/s/bN7r7YYTSEKDecQR1W/5FDo+NH4kcVDAe2rn/OSkf2B+uGXI/LA0zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pTyV354OgCgsC+UdeFF5DsnhBflmhvuYXStEItKr1io=;
	b=e0Aooa0+tdsPjvD3Ppz+G0gwhfCEyUVMQhw6fw6mIqWDiTalpI/aaGnYyBFi/HpeLISn
	 Z6mwOilwme8G4LwgJt1TNFn25C+TmEPIBLT8xS5vC16Fsl/7S1VuaFsCvYsj1Szd/nlYF
	 DZoXiSC5g7MQdFlpZog4+3Dd/6UdNxBnGSLW39LoU7cSl9Msh5bDeaX0QpCmX6gp5HDXH
	 edFRz0yep3GElunSr2r+C4/scz0zMWKa0n5aPNXZuQSlEi74GH0VibBe8uSbsuxBUw0kS
	 ld39p+KumbQprNqyVLadPt+Zp+BSHrJEcgTMaGBof2Lnj12cmBngHWBj9y1Tp3j79Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKQUzFz4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bTw5mjsl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494AA606A329
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eKQUzFz4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bTw5mjsl
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wJH93164569
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pTyV354OgCgsC+UdeFF5DsnhBflmhvuYXStEItKr1io=; b=eKQUzFz43741krLN
	/oALLtSYyXkq0AcsL/w4XtHfQeZ5csEulv5/mfpFFrY/JJKvqe89fx/f2KSIy+eJ
	dISWagwXVvYwdrmxEgJKlLjP4BRroC9WQU8rXEIBjFB5NVm6p3jYJZAgQzT1jh6y
	y6yNldtHt2cU5ks8MQhQz+iABPoDl+LWmxBTIGkK/+vVPo6tUsfWgQrH7L9kBvBC
	BbZxkXQAC59IKutjCFhj5Hmv0W7oNolY7E95TBTBcGfEOsXLrNls59VgOLQL7RGE
	nAX9B58UXLgmi4qZwcku7szYxEiS0Lp3LGNCnoLEyS7Shlos+vN785DJchulAnly
	gwrJFg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkw8kex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:29:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-55cc3c32e15so2432081cf.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655793; x=1795260593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTyV354OgCgsC+UdeFF5DsnhBflmhvuYXStEItKr1io=;
        b=bTw5mjsl2XeBSnAS/SP8plkBB0HwhuPDpySTU9WUepI10qEYFfjN8fAUhRev7vvGIr
         pW4ewrNwYbvXA3gvIApABSuJuf5UoBYPtfFqRDFRi1CoYje7qp5TZzaOs+7zMDBbmXBM
         RUkAricVyd3Gs+XBAD3wdcOTnqL9sq1QUQOQsul+51BFtUV2376O0bSDl/7dyr9v2ckm
         5MByhdwVK9BEnCyqrsPUZsl+JZCRrwSbq551FgLYZWtUl9+fBe+AHHHHIUhYcgb+N9QB
         TN9Bzy1SjQbZgpmghBxhaat4ard3e2rRpB7ZIROMy1tvSLrz/dArSiCRqPwk8ATyFd+E
         WHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655793; x=1795260593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pTyV354OgCgsC+UdeFF5DsnhBflmhvuYXStEItKr1io=;
        b=dihmMfMtBV4n3tPgivZgg/Q/2ecDb09rNNjomipYT2Irco07COoLXmp/8FixZp6DIS
         0gM8aUQhnRrYZsRfSqYOWc7cJ2zZy67c/qwIYUMfUy9heXNYjXcgUMCIJhoywVGoREh5
         0ZWepGP2zGv+PRhtg545SguvQegWvSy9RszQK58AbajSdF9TILjRJXJ3qtbp/qonXZ0z
         Jntpz3Cc1hF5A4/HvkzxfapMzG3mKJTu3ewdDZWWKNQCf+Wmdjrv3GZ3ZwubcGYA0Mn0
         P1UCowo1vt569spGmc6c6fLvGoJw+DDcDClH8J/VAYH7YR15J6sSTgkKhS+fdmz/n6DV
         TOJQ==
X-Forwarded-Encrypted: i=1; AL+hErE0u84fngZhWX3eyt/qs1Ap9KYoeyM4IPUY4AjHbxCj+aZc9f4tLPlbgE/S9wXLo9gFknff1ZFBKOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yU4Nma05EIoKB23JVsBQXuIserNQqG12nHWvuIdbMd3hq4/DK
	el0Z6FTuKf8xnEb73O80a45J1Xg6B50M3St1QTJt/M75LoMTNgpeZ4QDXeiAR7TgtI9BxaVN4lu
	brEudNtH1LzGsCqxqeN3G/msTWIKh7vkPmerifcf55APeBQHDeGolEG6yOvDlxIY=
X-Gm-Gg: AYBFou00YwhG0DVU6zXQx3E0RyJM2I+GApuYlgdGyUHjWYpkkZhDy44WbB3KjtjvrND
	PiX09lrBXWe26gGijophwAKJzFvNZkkhUfCKa3pMiayUjAwZzuoE12x4le4SwNigE7GkF2s6nEK
	p1CQCNDpKRXm4wLpypxYwpZSAZh/rJvfaOdrB5oqk8DVPvxcF1Z18ZA4s1AYV3p1ItYqtH2LX/i
	gKpEEbOMRRuHijNlhOBNn7NAkRsws9gGHxGEM93LFn1zfftamJDzW9mOFE47CU0YChNeY62b90v
	QlBZBgJ/y+vyujLIDSRri0iDUCEcor30zyRQvGg2lFv5cyCdnlVkdvswSn1ftreEL0iIrURyOzi
	13IXvHNP9DeuVLtHuaArE8l6fWy/Yu4izsR620Bn05+QOzpqV6uaNBxRIrUxMDau/MKwgmpOfWb
	xE/d+uZHMmp74JY7UQTW6xENJos95uRSsDbHiM0sHL
X-Received: by 2002:a05:622a:5c07:b0:55c:37c1:aef7 with SMTP id d75a77b69052e-55c37c1b4b8mr34089411cf.77.1794655792559;
        Sat, 14 Nov 2026 03:29:52 -0800 (PST)
X-Received: by 2002:a05:622a:5c07:b0:55c:37c1:aef7 with SMTP id d75a77b69052e-55c37c1b4b8mr34089191cf.77.1794655792088;
        Sat, 14 Nov 2026 03:29:52 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:29:51 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:18 +0800
Subject: [PATCH v7 01/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 SM8750 CSI2 PHY
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=1075;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=LFc6jx+MXDH94lWI3ZDmmoldzQASgCtkGLGfmGw+wwg=;
 b=qQbMkxieG7t3MHs39IJqk6/8ONMjTaPIKB7+zb7r390+yjZnta8SFA582Lw2EtjV9kt1MoFe7
 ZbB3RdBwSjZDb0AfWh6sGDhV1szHrA9qdW8cpbOGDDd8ztsmVi4NfG3
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX39k6rDLaV6mx
 Fz/Q99EGAyQH9S7c4WpBNk0MKBJvoXP34YdJgVYGfx6YOnNpiV1o6qSDmyJyNymkAMeMeo44mJ2
 QGEw/GVqgpkeK8/R1ijpE5qaMWalLBE/SGaoZMMymm5DUU118BpLq7YuHb+phxR9WSZuVIFsiXM
 flriABvG4A7XtCxyiZFrpjfkA++hi7AsugBaZpHyxWKapv7yGc8XYYp2BMF/XYVleu7Yeq0DGed
 WXHk8sVKaYj283j4Uj+rlJijQ6UePbZv1LMsNlqKUh1fYoezcLAi7Rq2BS2DOWryCl3rs9lsxnE
 eh6b2GqMRyPvRKm3AkwbYAXfxUZleaZVL0viCIrGKMeYaQCBKKSW47XjlEghe7odJwzYMrLMwi7
 oKj1uzOY2Ie/QO0mtnNywfr9piA44jhfHmm8B0lePq0fZL4ou22AmIYrgRh0nvZuFR/1PWB3Mrh
 JOxAlvjq/KT7KgnqxLw==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af84631 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CbQ82e2HgpuiUCsW3z0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 01lB1vwhCPKSD0Q6AKv50tyGw1Urvq_q
X-Proofpoint-ORIG-GUID: 01lB1vwhCPKSD0Q6AKv50tyGw1Urvq_q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfXyXZofGhYKl7J
 Y65jvvn8D4RVL7b8mJTPAuX2g/2sg1I8VFPinmz0Suj4owYcG4KwKuGclUowrMI5w99MA+QMABH
 jCnUlrxMNWmTWlh4H4nsG7xkUHdMfN0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

The SM8750 camera subsystem has six CSI2 D-PHY blocks. Describe them
with a standalone "qcom,sm8750-csi2-phy" compatible, so the CAMSS
binding can instantiate the CSIPHY nodes as separate phy devices.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
index 6e9eb8e265df93b631101ae13f31f6365b6239b6..8ff3df1d0d2787b2af0499c1e4106b86f56ff82c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,kaanapali-csi2-phy
+          - qcom,sm8750-csi2-phy
           - qcom,x1e80100-csi2-phy
       - items:
           - const: qcom,glymur-csi2-phy

-- 
2.34.1

