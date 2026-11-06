Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947868;
	b=iZk2grun3ToptwaTTrNMZy1Mx3aEZ0qJpMv0v0Xklbf7jriMgAAGxSPEXqBoRdVyhdML
	 qdNzbXadASgIgicJ9ndIUB21DMLBIRJWYySIgHrYtNHJbYDK5GV4NXKTH5HED6Cx2zZTU
	 BLQ3BlFCbO0Yy3NvrvJ7gUuzK386AEjTE2uCbx+yDsADUHBdX6q3Sj8R4kxa3bWjunygo
	 670XXwFIRVnB62cTLNsf0C0qvk6gtYdChFW8mp5q+cb3bl4BlqYLD8CXLTPOiU+dxn3xE
	 Dv80C4vWyZ41saaVFCG8QNSQJKqto+iS47OmnHnrumc/+i/m3oZZ+vftr0OPqyr7roA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947868;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=;
	b=uAZ/x+77M2L7+2OCxc4dLjO3uGEDmZct1PmFYlIYHFJvm68qRtvytKsDQ85g48Js8pY9
	 HN/N4jt4321Q/4ttZp7d8uNlQ9c/1py1/Afl087QBHqUjXm/IYPbFax/fZ8aFG+OdUw+E
	 EQu23tX8edlRzjofC5Auje7SF+ZJKVGeDzacDRPMII63zmd3VrEvyT1nEW0D5vFNJVh/v
	 mVnfNkuo6D5nzI2TrKophTdty+WyN53G/pej5oJ+LwChysZW7xFT2gpWXS5nNvWW3EusM
	 i5facf5Y4VaNWH4pG/UH3EnPLKs3TwqJM+/s5Q2sKJRuLFbVE18q8vRtNWP/plqCBqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pllk6hPC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=frBOfoIq;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84C606A332
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 06:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B84C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pllk6hPC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=frBOfoIq
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A640UUo1220191
	for <linux-i2c@vger.kernel.org>; Fri, 6 Nov 2026 06:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=; b=Pllk6hPCzbgjTS4L
	Lb3qhY1U4RExnpmitgxHB4Acq9kf+EW1lSTEYMFPkm31u77F7GgpkWshZJnUDL4k
	DrfKbBkj4uoVQBY+6JissiFCgAxJjdLtIVEmPaH5+HUZ5mUOp/upOiN+sPHLxmt9
	EPdf+bdPg0zUfYMc383hHEps9/5lZnYvXzXi6MpIPs0CwAVv3kjr6ckwM0nK5NtA
	SaQ9pdftVfLPd+oKZCPdCuhW7oCVdL3k3UxNvhaHy4W7ERyyaiX8uz1/ZUcXQUOn
	JgDs/sVMpkjF3dhVG2WjiyXW4eik8Mugx7LpxdceZQ6kUH7vdhbFd4Mx6uZuvjXt
	mvlm3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pc9e3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 06:51:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so334980a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 22:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793947867; x=1794552667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=;
        b=frBOfoIqLFhb0tr5lzaLQSMpMDYTPUe+Fxakj37QjglurscRcrbnyVG/77gjVpkCIa
         DgeQMpGpQn0EtQRA9ALXPKvgVy+Bj+BGF7zdPECukaIj/yLzgJZnqOq0IBuJh8CLBHc1
         lnaHH+IROQgwCnBzPh8qsc3J1iRFFTKeHTBWrPLGdWi+8/ZMqfPKpPFNgSW3DPe/yG1R
         vC5qUeuNQda8SKbVyKptd92TvfvRuRc6OiiY3s1i+5V+J+OIGgpsyk6ibbuN6br61FmT
         p/X7mVl8b2IxRiZk0+SeiyDlR5HnaAdMwEz8jWx5f48AmuLI4ToxEq9i+8qSZav0WhJP
         heJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793947867; x=1794552667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQZcWnzFgAmmFYA/sHLwHEakiYPJA+ODTFEZ0NO5CyE=;
        b=OaETZ8QPFkrhdVPbxCPl3kjsuhVlHFP1pZpQSqJtx4A3SDJv8yBMMi9ExsyHeOckT9
         v1NGZ70/WpytmdyWNnaCYcYR6cKNek9BB9akYqgXoRtUbAKtKywmS108k16NYMoaJLD6
         K1D+mQc7w0XkSFQHG+Y3P4h9AZnuZssquoh/bip3bnTVtBtuVgekV8RCVF8YuYv92j2e
         YStI+T7BXqp93MBLbT2bC8duQ7awVBe/yxRl5sIjDUl0qFtWKkdK8X2Ow5x0XovbgsnI
         D3+OJS65iqSChJSkDWkh/7beAr0mWJB631vN+FGAlRXBRtkS8dn77TcvGO/O2erW4oTA
         CCBg==
X-Forwarded-Encrypted: i=1; AL+hErFLrtqhO4K2/4lhwuw5+vjAiHoCNxlPEdkJOb3zY4gV8JzrsU7sMYXg3unL8SKAUg9pR7kVpVqIbyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8UjZQbR3MbcqURwvoQlEuTooCY0TN95Yxw1xZ104MUkcqQWnb
	6vj0Hx8pXOl2vqDcfNTD8Ro6uB5tgJcSibF2LhfzO1amnWuYWCLy0Q3KJQ7Ho1tJzvJ9awv5Vm6
	WOmuAi2tOBpSxGvmOVVgiBmwknL1ewWGhTz/HIXaLd3INWJ4i/Yd4gpGpig4Svkc=
X-Gm-Gg: AYBFou0sNDEQRJzh84siGRz+MBmP02mD+gYt5VVbWvITQ5YUgBfQ/1chjW4TcAvU4lb
	uRzLZo2eibODWzavtzcYsJzfzmhi9KArd0XgRDFklDhyupmUWaro5dGTUxrnZaTE1DzNSYC9AYs
	QdONTakTR6ID5wX2431pZE+DN2jie0trmz6ABvPMo6G0C4KefXqQEg8BOrZRCUqbGzhlvEcRBH1
	K+jiqv9ox6Z4mHXCsUIYkUP0bC4fj7cc/qc4JNvwmgDEJyM7Ngs62HPznbRL/dxSQzDz5AOrk23
	h+R/EXrJKxykHjgY7p2hLAr6/H3OR+enhWnouFUsM2SmOQxYvJGzy/upRd6mH06P6tgHAVq9JYW
	E9xSngG6RNHcehH1vW5oxvDTqMbbiWtnWWxbm5knYOZ21BaxTjGFQBMUzOlE9qAGHIEsQROMfBK
	rVZ5ZZ
X-Received: by 2002:a17:90b:4c4d:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3b0db6ee69fmr1388250a91.20.1793947866831;
        Thu, 05 Nov 2026 22:51:06 -0800 (PST)
X-Received: by 2002:a17:90b:4c4d:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3b0db6ee69fmr1388239a91.20.1793947866358;
        Thu, 05 Nov 2026 22:51:06 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm6597274a91.1.2026.11.05.22.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:51:06 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 12:20:43 +0530
Subject: [PATCH v4 2/6] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi
 and Maili compatibles
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
Message-Id: <20261106-hawi-maili-camss-v4-2-d528c7a797b4@oss.qualcomm.com>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
In-Reply-To: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793947844; l=1461;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=O6JOHgjWCf6k0+eXloLMxj3S4Nm7SEUIMrYIjwRLIus=;
 b=0J78F37O0f9bKC6fbPmKMswzabA2px9rj+Plc3qcxMWcxeMS/pTc9HKNtYs+5MrbeLGZVuuNx
 8WyPRjLiTw9D3UZX5eeVL7ax7VaLBS58JgE1DW4/yo7qd9ebMIaIoQ6
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: jjjh2aexvvlIO5BCNeqoJPlY-8P3U2m7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX2o/cOrMPQyHq
 tXjje1hE8pmvUGyfORILOZTa4oxyBTksIASxOovj0I7+s6LRVvD41+rkpaORy5jT/W5kTfaHjtV
 UQtmMs4uRHauTKxBowZkudaxN15xQVqgsWqnig+8XMOOzIR04aS6MiJBUzc728qvf4PnRnaTxYt
 OEmXzGWjgmYC6lTN3H2H6b4hjpitKGkmaSSPoRifDgIGqN56hxWTb3qtucMx4/FVeBMbHqSNWZN
 lMfnRRuOBC4/bE9EAU6LcL7Zr2xqifLCL6rnDEJd2DygSJhXe/tjE2ZAsggLAfptUF+/jg6cPgA
 bwU0TvpM78+LS+Jlj3a6inOpmDgdrugAlqf81p76IWJx4xwQlWpZM162cQMKYPp9TKy+KTDjn82
 D1EyxXZzQDlr7mC7UyC5ETMqzXJDg+stGburrLbnN3Ay/roIWFiFNysGXCQ06nIvEIv1ZSxPOT2
 IxTcUoT5xlp8PTU/TMQ==
X-Proofpoint-GUID: jjjh2aexvvlIO5BCNeqoJPlY-8P3U2m7
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aed78db cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Qbo-v1IXpRF52dvEqNcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX8qUm4V94XHMf
 +yt/843rSp89Dh7URTjxhwO2pPLiTQ/HwaYjHtJcxwIYUQezMz2GuWSQwREvi1ol+zGagrkzbLL
 tPYtsaubLBDwnXB2mzgBF8qT2+TaEAY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060027

Hawi and Maili integrate the same CSIPHY IP as Kaanapali with an
identical register interface. Add qcom,hawi-csi2-phy and
qcom,maili-csi2-phy falling back to qcom,hawi-csi2-phy.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Co-developed-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
index 6e9eb8e265df93b631101ae13f31f6365b6239b6..627aebc7cd9b7ca313457d3f70f72796e9671e8a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
@@ -18,11 +18,16 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,hawi-csi2-phy
           - qcom,kaanapali-csi2-phy
           - qcom,x1e80100-csi2-phy
       - items:
           - const: qcom,glymur-csi2-phy
           - const: qcom,x1e80100-csi2-phy
+      - items:
+          - enum:
+              - qcom,maili-csi2-phy
+          - const: qcom,hawi-csi2-phy
 
   reg:
     maxItems: 1

-- 
2.34.1

