Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655831;
	b=lJ5IEVhfVnZLpcE4UeyjC2sNgseWC1pD+y61bBA4EZZQl7SbKWYiSW6+zLXYTxOy9MoN
	 Dn91R97+ca8YTKqa2lyznGISZ7x6rz6CjjRl7zhkKnyULn4w4Cb8TcAu57x7Ia05dHGZ6
	 GlizsuwQ0TbEx70J4kkBZFW2Hv6w0zvLqpDaK98bnxz7i4ZmBEOKMtztz+4X7kZ4kdl+5
	 lR3EB5MzrnsvSSMvBQ0E4K/YlfBKukHuCWNrT/nIQDiRSAKmZiTHR7DdU1E47XWWqXKk8
	 d+KkOl8VCzxzFETBf/N/sJFWAJscl5jCAiks+v0tKmPH5N9DgsW+QolDkYbeC5BXB+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gTSf169frfMjFZsMxW4csMunjCZN1T8v74xtvKaojKc=;
	b=gOq1MDsiXKNSD1UzGK7IFgxjJvtJntmObLwPn8ueIhNLqCUh3zJhmTbBDgXH7m9eiuvb
	 s6StDHd0bkC3wSHxsg9z3IRFK7bSYhp5pImtlwSLnjuJWxwwlSAJtCc00dm+vielodyY9
	 OwkcixjuGvASpwxUMW35cPASAyfVrXsAraIzRuqLASuDJbDxSNgnuJtGB3t6zo97T4F5x
	 RL2TQvYD7w0IgOfiEvkTObkl8oK71m4HliqqyyLecJOIjzg1BdOUE/sffeJPfbIZRHD5x
	 Y2hGeMAhMeUtk4xOd2A+Vj0ptjX8jse/pXDGC9Pqnz12OmNULWYSreKMJG58Md6dYlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UMfat2ax;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAWRbO2X;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E6606A337
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70E6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UMfat2ax;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAWRbO2X
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wdNY1089381
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTSf169frfMjFZsMxW4csMunjCZN1T8v74xtvKaojKc=; b=UMfat2ax+68EdAj/
	tN3OQH3rgy2YMQ7HZ3iUEIoolyUOFJyB9OYDkFHOJnY//GU0Sm5DsAPtFFtfFTmK
	yJABxKn4Xg07JqPfLUxDivHhVzddOr59fr+zdO0x11qOER0GaMcpI1YjU1W25wRi
	v84PQwwfWXgZyCr7yVP3GPZURGj/2H2kHmHATgOqN7iPXoQGnLdbE3zRitsZ1Uek
	2ar2e8nRTbxfbO9nYdXuZ7lSDraPgL4UK/7JbVWf0JJ3m9bOjc2gon+LtUNY8IqC
	XgZmR41ifzSDtkKWKcuoHsjf0yQvsHYyexFpQCe1JDVIZke8XaVWZ8BS0oS3Lq5S
	8SFPnw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8rkvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f03ea17f4so42161526d6.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655829; x=1795260629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTSf169frfMjFZsMxW4csMunjCZN1T8v74xtvKaojKc=;
        b=YAWRbO2XjwrEofSNKRgJ+tdVY94h2WEcUXl2+DrXlLWHmWmLTm7aXB66nqV9XQgYKU
         EVZ8DdA+TG6F8hUQ1Ox012hue13MF30WnNsmPNQDVnv3tqxclPU5fum6dNLcH42c5HLe
         UaX6S2Afyb2HvqfEQkA0LIoVBdgO5hUwo1XWIu2NnXeGIaAC/ipeFNffa2EYdC/c/jqe
         WaW3CSGUPc/056L6WYpyF3c0uXV0PhUHv4vwmjOGNR1TPWH6R6FN0Cocn0ONq3U584Cn
         7l3mzsFG6Hzhhxf+kO8paHNgVRPGkDPGgx5KUNu26QGg11QhnayfamenAnN0M1gyAq8b
         CR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655829; x=1795260629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTSf169frfMjFZsMxW4csMunjCZN1T8v74xtvKaojKc=;
        b=bwNBMk7xGnTMvgXs8yTnjuQw4kxYaHLnN9r8Ye/JNlmSRI2E7rGfotMzq9HglMA+oV
         sCXRGLP/o84rXBmXNAtvdh16Q1hkDedj2fBJfjIugcMtmmJQqRh2nUqdJK7yT9/GBKDi
         +eOTdMfGuOo7JNYIRUaz1vzukXd6wlUFA5bdDGetPMWF7tvdXVuXET84JuAX4G62TiYJ
         lo7uH90tIvFxrYdOZFYh0bR64eU74BRq8UeWdjjti984+BFjpsVmMXBgHocwjB23pNru
         C9fAIzFhwsusf7ztVtcwLinbMBvdIvUbQT/030nRegnLE+NM9nIV0clKMgbnYIaPbfWO
         wTdw==
X-Forwarded-Encrypted: i=1; AL+hErHQJJiYt7wqBSPAVp+CruIG2noYr3XbwvaAPVwohtjzNH5Ly0ZDBMSkLvBQGUWPn+h6297n9Wk4kOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2Z/KNt009FL5BImJvFNLBnfYBAW7dSmUKJlxxZxSTBGq9RdmY
	Ma0BMsmySYFhrW6qPEgodJcgLkHjzSd0KO6Jjh9ySf8GQKtIk9ZPoZJCLSxRqeE1fJBWk/PUay8
	YHVC5vyDrh/KMphf/dc8zr79m/hUb2uSdPqrkgHaAsjJUFawTUsOaa6P8bnLaS6I=
X-Gm-Gg: AYBFou3qZozuOYjGInd4nNc2Ww8jkAPDtAi9yAd1sNhlPKM8Qx8CaLZ5nthhNq1LnRi
	0dmRlr6cuBkDH9rDy/daEHdIuN1ncVoG6mOMrPPm68OS4qFoQu/0OytzztecgvRteXY7Vbuk7m7
	pjHQdz4L4GICKidi5PCudDeBe1BAebomZDR6Ei3kkTBoksd7U7CrVzWKbx20hAoa7Pir2+/dCwt
	fQcVRDHGyG0t6Kv0+lXUNpA9MRlQVQ9dXa8Lo9cT50MXxyAD0h0Ii1toihabdjnvjU4kD5ap/ws
	gCJgEBIr/GIOgdz2oHa0yYitWT4kQsUWoOtRI3UnpxSDlRYPe7+3SCWcde3aUNSrOEFCO0vbGnE
	eQpv3bxin4CcDEzBFAk7YzJ62KfCUa+Lr9NzR1bOOHwHVmnjkcVGGaO1d474A7zStLw0PaEyUqg
	crYG4vIMBruKy4Tspe6JFut2/SPrMPlisH8y+DE5MY
X-Received: by 2002:a05:6214:4a88:b0:91e:7d3b:4dc7 with SMTP id 6a1803df08f44-91f24294007mr84960676d6.58.1794655828896;
        Sat, 14 Nov 2026 03:30:28 -0800 (PST)
X-Received: by 2002:a05:6214:4a88:b0:91e:7d3b:4dc7 with SMTP id 6a1803df08f44-91f24294007mr84960156d6.58.1794655828431;
        Sat, 14 Nov 2026 03:30:28 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:27 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:22 +0800
Subject: [PATCH v7 05/23] dt-bindings: i2c: qcom-cci: Document Eliza
 compatible
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-5-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=1069;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=61yDOYkYSQzcaMNW502STOCKhR8JM0wrwP3tqxLNiqY=;
 b=ZmGzJUN2j2tTw0MqwLjAcolX1NvdlwsYsUMfPFvO3fQNEEChYTiWO3sjeHeQOIt4y2OG5zUEe
 CeqCoKP/0ZpDr+LXQ7U4OzMgWHKzuzFtWvMJMaE+uaKoldTk+I1xiVq
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af84655 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=phzA4CzYhpZqrDFsW3YA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX/Elj5QWDEmxr
 qfVoJHA44FzCTpNA4F936kxgdeOiwQKctF975Gm1YKJx15/kxq4VhjoBHjYxRsJGQXySV1ZX7DC
 qSQvRlOKN5DVRmzvaxvpt1oTUlroBAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfXyIV/kCc5Zmin
 3qxscwesua9GTruQq/eUPwSgjyWUmg7I9BjDuA2w7zBMMS8pSlcGAOXIGMC1aCIpslFNgW5xiA+
 ZrXMYrkQLz28gZp1pzlDiQjF7WqYIkcS5c01Ly0ql9nceu1vZxRxfy5/DDnzPR238M+r1txKLoR
 ZDfuULpmJTSGjLoha9jlsWIiuWWlA9dB7oJDGGy2VEOw00uUVJpHFs2FZTRfF5Zql+sqsrPS65a
 38CDhaoe/a6/C487PurV0yS1eQaLEeY8efyyqPG3dqLECXG7ZqCtmL9WbUEO3OzXzArgnpzEEhw
 ViK4u14WXpbztM0E4mjM8SOSV4i/MsRaYFDVgcD9T5jIkGO/7IUDCpjJkeGhmcMqVvzozd98Lpz
 imHpagNrLD+ImXcqCd0gd9EnBUlfTAVNRXJuO6IEXLDpdFufkt3iRSHQHziJpU2ubNGTBrbYtuF
 WC+ex/9mawb86SxndgQ==
X-Proofpoint-ORIG-GUID: usoShGOUpDwk8bGtn0Hj4Fxh0M-JxkXe
X-Proofpoint-GUID: usoShGOUpDwk8bGtn0Hj4Fxh0M-JxkXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611140045

Add Eliza compatible consistent with CAMSS CCI interfaces, falling back
to "qcom,msm8996-cci".

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0ec1ef6b34859709d10a2a36fe36f5..f16298d94177f906790c18831bfbcc5557a5accf 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,eliza-cci
               - qcom,glymur-cci
               - qcom,kaanapali-cci
               - qcom,milos-cci
@@ -136,6 +137,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,eliza-cci
               - qcom,glymur-cci
               - qcom,kaanapali-cci
               - qcom,qcm2290-cci

-- 
2.34.1

