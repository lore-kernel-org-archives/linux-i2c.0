Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655804;
	b=GSeK2K4HjvvBaRUaHsQL7ZBSu6lvF7nb8r71qVuVnSyJEDx3eTf5d8fII5ID1QcKffhu
	 stcS6rS3aDKxerVh6zShhb0hJboUgGZr9jcFg2uC3hma986lAZo2phf3xMmNsUeOnMfv6
	 SSPkRm2toezhVHVXmJGD4MUY48HHwos3IIrvbqxoy3tXGKH+5Tyc2isnOQCRIkFgmU4+L
	 r/Hml5u+4AoJ8BoRtbsDqQCA58xK0W2AbPviXnByDx7quxjwlcOeykhgsGnW21tIP1KOq
	 cqs8bs2D12IfiZKNc4omiZolMAPEnznBZe00LqGlQ7nbBq29VHTTMrHDlnMAd4JJUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655804;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=StjpzzgV3K5FMka2TqMOP7NLAIJFL8U/IFU/fNStwV0=;
	b=R0XntDN1rSp86Bk/8892PZ7SSK7J5aHO5h3NMPm6p1nt5XXc0xwiBBpJ5t4KUCV247C9
	 EiDRUO5GyNiatG6QIMQRuDkBgtbmv/VNmh+9y2vi3RgggKAaUUAkJAVv/bvCeUoW1QnKZ
	 V1XuRSenw3I0v5VgkmJucHTzWjkETBzBxJrqSzEPIunZati40STpya9RJv0H0sR/f+6YW
	 7boZJ5JsPc8boWk9OrgBNC0nQwl4ZoGPCsvTSJmIXh7LbcQTlpw2TamiRICXi7FnuNiHM
	 n1voFTJeyuGAOIWhj6KgWf1cASSKqLcwuE69LV5vRmVE1kURT+Cct/02NTIz2UCv6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l1PCjtMg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HlPXQI4n;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDBA606A333
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACDBA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l1PCjtMg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HlPXQI4n
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wXZq3650354
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	StjpzzgV3K5FMka2TqMOP7NLAIJFL8U/IFU/fNStwV0=; b=l1PCjtMgREQfKx4P
	zjv2l9uRq5lMe43qTPNoJN0Tgj6vGJILER7VcC32DvWY2sX+zSIKQ8OTrq0TE+7D
	fjcH2qGfoVzvYn2ZhyEwUs+cxRtx0qpm06b3raicfchLlLbpW3xk0c+yqaTz3Leu
	KcsIsdAzM50jijoUyYsiGhDnUZvQh4kxAi5XzHPDDTYPm1fCWtELPxbmkJTWJYth
	Eg4wv+nGokkQGHpPLq/dYUMk4XYdoglyVlZm4C7n3d0vf1gH5ZwOMcnwOJypuWdS
	wa6AlcnnAwH+RqnjbnCFpyWq28cE7AtGpE3wuwQCqeMOC0vinla7fOSW4FbYyx48
	LnlicQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjrn8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9496ff065bcso10504985a.3
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655802; x=1795260602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=StjpzzgV3K5FMka2TqMOP7NLAIJFL8U/IFU/fNStwV0=;
        b=HlPXQI4niU8Bqa7F/U7dK5jNUuMu97N4c2gTR2TPtnHdTLIhZwltTbaV/LO0nlZ+eH
         mF8gSveaMh6qdBvmwSyg2QzgzGoeTDall81uZkdR95RnAiJakyhS+Flb2e5Sz5bpicJY
         iaa0RWR3HZ4xvzQnCgDXNk7xHzISsy5egT8Jshu56vazE0PRBLAAB38k7FKlBkUfZFd0
         3sPZ4TqKiHdFdcPiHYnpn1Q1gSgHy9ApauNGlu9imhYQDYrpM5JYqYFbVqwRD1TSGusR
         ZqNXhMydRMJS/rCS4obLyQU1JWBkgHXYlu9Jh68js4FCJY7HZzjD61vkcskTcDHyscZh
         UXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655802; x=1795260602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=StjpzzgV3K5FMka2TqMOP7NLAIJFL8U/IFU/fNStwV0=;
        b=cLxSU+73WXlZkS53GZDVa+AZ0g3O5PHD2p8B4yMdtj29TmZxOILXaTczHSvhaULWbp
         qLwB8Al856xF9IHED8Z6UaBkb6Ju/sTwAHkIEzhF7a2CLvKazW+/UgLuCh4N7P+/uuOJ
         1HA0k8DFrce/CLqHKX/cueobcgm2ROBqJh3mIOD9YRFGpQuOoDC8yU93jqIoplFPL8T8
         rG3lKlylgEuOEVrBhEfXwne0hxWTUm3XIMQO5xlWF0XqTQ3CYEYKIlZJ3B0DmmZhzShV
         hmLnfvUJozx+qdr+gRkvBHh4PNP0QyCUKyw/YAgfrMS6VPfyGnLmQqW4QnAnyfVhDX3n
         Bcuw==
X-Forwarded-Encrypted: i=1; AL+hErHVH9UBJno7qrC7pihoKSUd+Z+U2HQWP+v5Dt9n4R95aELUg0CPAGjzitDDfZ6mK+sf5PYLPIq+hk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Fvi+f98+LJns/o/5TaimvpGE8RJ/AGHaD30YbjhQMdFM72gU6
	qRJKDR/uptGqEAlg+cfwaze7Eau7LiVz/V0BIsdeMYzMTT1dBmTYQY5cWLQo5RznomdFRicDWEs
	dT422OVay+I0pE3fbwtVa9cO6EpQ+mhKI+j2P4JgdZ+LTmXrniZQIfKqHNsbWPkI=
X-Gm-Gg: AYBFou34N431/EnFXG47z0fAxT0VVdq6ck3n/JctAgsF/r0MuSiqAJFoUt2P7cLwmDB
	54Hv8Jzpa7JZYc45s34G6qmSDQQC1m82xfwKSynD+jBZmNFpMGDTBlYU12B9EfS3furYfif6fso
	dMORIGmeLxmAjtT6y86YYnxflpNXOgmRC6rwlVZoUZDrEQANRXk3ONVesYU2pUvpmVBnVsBIPiF
	8SZywyzWztGABFd46CM/eFcyywIfGNXK/q38QEe8R4gct/68sYWLMz038ioCOcjy4COybs24Gwv
	AWjMg322GqlndevvSANFcBzyh79gNzFKzo9zdwuyq+WHp3HJfSm1L2ev+f1KrYr654eCsY9EOj9
	RCr3Vk2sp5ZDXTrZ64m2zAx+lbGWP0WCLV6tZ8I53uaw5t5pgejRIAbX+Pti04YoB/mooCw0VaB
	T+FRtsuuLNeT3HVV/kLkou0CJAe/HvdB38tT4YiI92
X-Received: by 2002:a05:620a:2b96:b0:93e:5fbf:a41c with SMTP id af79cd13be357-9494bbb7e8dmr822387085a.16.1794655801378;
        Sat, 14 Nov 2026 03:30:01 -0800 (PST)
X-Received: by 2002:a05:620a:2b96:b0:93e:5fbf:a41c with SMTP id af79cd13be357-9494bbb7e8dmr822385185a.16.1794655800997;
        Sat, 14 Nov 2026 03:30:00 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:00 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:19 +0800
Subject: [PATCH v7 02/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 Eliza CSI2 PHY
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-2-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=1564;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=QtLaeWAMwSvDdk5BkCV2zOXsDrkSYOKz3w000Imr2GU=;
 b=ayq0vPZ8usswe3DyeKH5IP05zg0wiuLc2SqaQYyKdo7ap2j6Eu99cswy46uQjGiABqtEkkTgk
 NJnxyDfwEYnBqhIjRcSBPIsviU6LYc8w5T8W63QcoOphFlwacdYlmcP
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX1SmE8A0lsseh
 kM+AN+gA/CKoW7wKQ+CSBwP0wvuB9wXmRCzbqApIDtia9hRDTCvKEtEkIqxFVNBAowFhdflIw7i
 S8kK3+VS8WhAt5orlif8OzNBER3FIjwj8/D9esIXLt6/BfqK3+S3MxJRlA7IUlFr3MNvk4zmKis
 YpNzl3FrTd61r8HYEJ5zUAfEyGB5E77POcrbwajp2wg9GWk+yJNBgj+Mj3E8LnL+CBB2q2WYwHd
 D75Rf9cpwtHc6jYEDdkzA3ts4Rqc+aE6UGwh3D35WQSv9eyyZ6gJwNkeCE38DoVJ+KMQFImf5Ps
 OKLEzEBb+9jpr8rjpfrlJpNrBR/2bqqBFWliDxihfjj9zlsXuQUY3BWqUzdZ/KNDQtJnkFgNbh1
 QPZPK7S8yhKPxTUBEDpMFEndUMqvVA4rOLCz+zUFWm2tVEjaKGBEtaxt240z4AiQ2JkETyxq9Rj
 pyYqx/oj5z0qDWrtkMg==
X-Proofpoint-ORIG-GUID: ob9XHJTzTXrao_-LVt8n5v9ZW0viuYHY
X-Proofpoint-GUID: ob9XHJTzTXrao_-LVt8n5v9ZW0viuYHY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX247B5wNPDs/E
 gkcXPjjMXpaELEAA49uo54PVKDy2nOBIbVLYS/JHDswM4x6MXuct6sTIhBCEGZEwFuQtsEJybRq
 I+w851ibmLIO5HgYTbdvdw2y+8KHtFQ=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af8463b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Cn39VxbTSVwEGcu4l40A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

Add "qcom,eliza-csi2-phy" falling back to "qcom,x1e80100-csi2-phy", as
Eliza integrates the same CSI2 PHY IP.

Eliza has no MMCX and MXC rails: CX feeds the existing "mmcx" input and
MX the "mx" input, so only the power-domain descriptions need updating.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
index 8ff3df1d0d2787b2af0499c1e4106b86f56ff82c..884984f6f6b9e595df9bb3b0027c0bcf285b8058 100644
--- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
@@ -22,7 +22,9 @@ properties:
           - qcom,sm8750-csi2-phy
           - qcom,x1e80100-csi2-phy
       - items:
-          - const: qcom,glymur-csi2-phy
+          - enum:
+              - qcom,eliza-csi2-phy
+              - qcom,glymur-csi2-phy
           - const: qcom,x1e80100-csi2-phy
 
   reg:
@@ -48,8 +50,8 @@ properties:
   power-domains:
     items:
       - description: Titan Top GDSC - Titan ISP Block, Global Distributed Switch Controller.
-      - description: MMCX voltage rail
-      - description: MXC or MXA voltage rail
+      - description: MMCX or CX voltage rail
+      - description: MXC, MXA or MX voltage rail
 
   power-domain-names:
     items:

-- 
2.34.1

