Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779858;
	b=h0HQNdDtFcM14OIMYKTbLVF/eLqNH5HWZf8I2qmJm5vo3CYXuM8WuU9AUc18jUjGaJ9V
	 iK4qZFeGED3Lcq7+xItmZXmv7sCOLEo7t5SfaDgq+3RdMkZfZN3jD8pMtfoahT+Zitchs
	 AyVcjCBai4D3OZEBUY8i9ZQF2OOJCfz6125vRCMRBYSBQIVvxaSA99c6jqQPURSX62e2t
	 e5/h0kdI+1O7y632iMeZIustfLqu4wXUU+0QOBDcPWnbTWK+mDf4XDrkyv572xatYE9tu
	 PIabkejSzrVRSPNsqU5fcuRYHg8bjpdtSbG5E0cyLmKmfNW2c5plSdu2gtvt33nyRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779858;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=;
	b=tq4a/JHcH/E5yYmoxB+k52d3dsT8uiUBvwgxHLJ88zoLQXvtKTUSGJvgTPpfBtDBOf+s
	 yyQv9cH+ymVMTtFIaIxSDTZ5mOWS9woFNs2ko7V5h04qKos0kVdGvjiZar1glM9v24O6T
	 O4x6LLGLy3MoaUTwm+XpjjRsOCuzyAu0Icm0XF41H0RRtNjkHeBtFeIRAYJsT1koPvluE
	 QT2OyQXThOx2DFXrwPLPOnE/OZbnqDAG+gyLQzE01YaX1WrLySEtNa3sDd6pSNA9XX3vi
	 Gk+k2KL0lD+TtmkvKKBUx1oTRCJBQ0EzMmlkW3XijR3vCwr713k5PWHBhdGwQd9C+PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBJS62rl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PkAODmPX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B711606A31C
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B711606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dBJS62rl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PkAODmPX
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp0HN1961818
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=; b=dBJS62rlsuED/DG1
	i78emq4hKj8H6+mhm64WNWUuIK6yv3k5Q+ImF+Rg1xgdvNYWi0PqHeCvH4O8JZgJ
	wnyeneyFKDJkmMOgbK2Wa9jgyPbn7KZePKZxmdvaayGeKvMyzIjCXpIahCEOLfua
	X58GM2BzgRtxltYL88RxBMUY5LAs9FgqM/zD/DQmEl1ggiL4NEJOJKkFewPr+v6I
	iB5moLuw6cO6naPdIrzRUkBVW6DqK4+SMLJCR7jv5j7qbHbOxYOaVIISZvi9+fFU
	/2m+QM28yWN8Xk4Pe//kqe0Gh+yR2CD4rKMr3AGZApUsK0NnGXq4v85QhfizMRSv
	E0875g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hturn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 11:44:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b4232374d6so10733831a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 03:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779857; x=1796384657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=;
        b=PkAODmPXjF1/fRy6BgTKi93BYrgym+VcinhmQMsBJvJrh64GgnBnYrMFNP5q7xfgqN
         ZPpAcyff9quKRKLYKb6VyjKdtBScyPaggeWnP93xQ5mGqAknYUgVkR1aSFdn6MCcJXLy
         +LW40g2ZQZd79AtTrqjLtVRgPGmFmO5quMKnSONUMfmjLekPvFFuik4JT15qB5XAlrQ+
         uhTXJQMQ7Gt9SdMBkGNiC07NQieaZQuyxiR3pVdR5qJTUT6xLP2UK+ScxNYRL4Yo+5R8
         6FuhatIIltTUwQ8oPR0XarKtWy05rs1uMW/rkuhQJ1OqQsPNzx0FiL/kwGe1QqHqVbA0
         SSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779857; x=1796384657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmawXRSR283Ucc1PSnIiqX8eAjPfNtrwEJ7cQLdMyUA=;
        b=fsHo5E0EMExybs03whh2FtIP5pg/JWn7OKirSmGVB+1lxKG8yn9IP94cLSJzh24rnH
         6FNT0Qt3nMFxh5aS+VLUovAUc0F/VRkzyvgZMpYPM7Kri/pyRVRvZ0ySjgf4s1PDa529
         jebsyIE8Iu0ZganxBoj+JgIDyJluTlfNIkrlwzdw8IJTqh6IJvu2Q7XmSW/3TOcAz01C
         6bljSau6zuoXc9auuAPO4GZUPw3ggOSFxs3HPhgozElthD9SCIswu/DI1ZxPYxvFrv8U
         VEP70DgkmjDRs/KMzoU+sfb43/M6tAsiQUsU9hPXBVcnnrYgHmfLjmIlVDGNS7TwBybA
         nddQ==
X-Forwarded-Encrypted: i=1; AL+hErGq8iCENcbOhesa8cu/1lvWkpQBeksk9aZWFpf1cNHCqFoWDzY9hd5kTAVUZCRDBRnJ1XohtPUVTz0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x0cBp35IW6M6/OyEtZ2EdAdN5e54TP6axoe49Vf3p+v5LR4Fg
	MGqVDIsS/fYWCv1MGZ+6MmddTpw239hPoiTVF7k9EGMuJZeVdVP/TzthrxHZgk1KrLZw5BlQWXI
	czrq0hLSDavgQwctXXWipQiUsk34DpWUAc+YYubjAO6Nn9JLV/woiBQJnE3RUha+gu35aPoM=
X-Gm-Gg: AZFdTZdlQpVEVgOGwZOI69VskIGHAlczMyUV4kE+LKKmEUtVy29Jcbx/WAQCMffVylS
	b9Jdq3O1DavnMtxLtE+cR7G66RkcIy2EduP0G3g056NzqMETVbjiLI20SB9qdGNdxE9LAT/6rYf
	96xCx8iBM2V4yykcFaEZqB99RGpBtZtOSZf70vNzR4fku2lEJZSQ5vOsbX/8ilmSHidut+w/f9x
	9XvCt1tA3klrS5pBMqaHNTReTRV7xab6eBQkh8xKVme6nr3ubm0fLna6xCQ6k3ack7O2pXPg300
	YHk4IzpHbdtpRvVBD0O22gFZL3oVY0uSuCeAjPhvLp1P0cglWc5zyu+iYruS54LRZrgVtvSNmjh
	QicVouzG8USbCQjRWTqXzQkCzRiz8scZMeYDT69wekCEEHaSLX1Hvu1eiRt3ysq9gG0aLD3VXi6
	EsANwx
X-Received: by 2002:a17:90b:2d8a:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3b41c95b7femr23643535a91.53.1795779856728;
        Fri, 27 Nov 2026 03:44:16 -0800 (PST)
X-Received: by 2002:a17:90b:2d8a:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3b41c95b7femr23643480a91.53.1795779856250;
        Fri, 27 Nov 2026 03:44:16 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm40480933a91.16.2026.11.27.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:44:15 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 17:14:01 +0530
Subject: [PATCH v6 1/3] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
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
Message-Id: <20261127-hawi-maili-camss-v6-1-0f4844eb63b3@oss.qualcomm.com>
References: <20261127-hawi-maili-camss-v6-0-0f4844eb63b3@oss.qualcomm.com>
In-Reply-To: <20261127-hawi-maili-camss-v6-0-0f4844eb63b3@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795779843; l=1476;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=BTDhy4Hj9RCXelLYOtQYezLS7KR1Rsj0YchhEiP5678=;
 b=rZ37/Dykad1gUgWkePEK4ua5jVhBcm3T2Lx5wifTU22AKkzobNwh7SmlpOFwcEJqJsLvINRXJ
 qiDvisd2FMKD3dK8zMLrc/vaoMNTITRU+1dVBsO61/rl+XrMfL5girf
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXx8jWprnAYXMq
 8AhP+FVju/sw9g/PWEiHGUIBCRMgiJLsrtJ6c43cJ2weHPGReEGOV5X4Oi/E97TAb+OOSgArPrd
 o1R/cnNBONNesZ/qqgXNbWQJLdPifq4=
X-Proofpoint-GUID: 9qDuQ1NJYObj4wlod1shEgOnUsl2pKsb
X-Proofpoint-ORIG-GUID: 9qDuQ1NJYObj4wlod1shEgOnUsl2pKsb
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b096d11 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=LDBv8-xUAAAA:8 a=AartCDbB9JJyHY4DVtoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX4sN3nrrhWoIO
 TtHoudUUVjT9WXXS/i5FJHAo8aLMWwpqfPyb4OTCOGCjyT4byhXznRflRfl7BkLyxDptwBjlXmU
 hssVC0cpiW1kbHIh+my4BAwbmxiCZYV7hNuIgcYcU7X85SqHcgZgKXvaRKn6a0JNVkl5oUPC8qe
 4ylRS3EiGaoSRq4v16MM40qLn3OYqwBep4T7NFRyLdSeqcCkNh4xgMg0T13TwYrNDCKkv6STtwS
 WxBRelB+9qF/KhFMyki1lC5BRgExAtv5jlA6jnIGVS2NvopPUtOKCrtGvUTE3Hrme/Ue0QX3Uyy
 xdKr2/XZWmmoAvTtSMhtcMpS/JxxeXOdqXPfbv2hx3hpTKLtLpA5g2YWyM7YEBUZ1SVMJj0GtBd
 q0crBW66dSb0kxDgsqmIp3wvs5tz1W9RPINZKY5xA8euI/6VO8uLfUI4JZ73ediuuJ/v/3LCip1
 vB81xny6e5HHB3GJY6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Document the Camera Control Interface (CCI) compatible for the Qualcomm
Hawi platform. Like other recent platforms it requires two clocks, so
add it to the corresponding clocks constraint as well.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0ec1ef6b34859709d10a2a36fe36f5..b2b4d4bcf780792515ec153c873bace1764fb3e3 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-cci
+              - qcom,hawi-cci
               - qcom,kaanapali-cci
               - qcom,milos-cci
               - qcom,qcm2290-cci
@@ -137,6 +138,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-cci
+              - qcom,hawi-cci
               - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,qcs8300-cci

-- 
2.34.1

