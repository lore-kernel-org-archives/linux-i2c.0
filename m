Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877092;
	b=Ux1CRhnc9Xr8+brRIU1+1rEuXTEsNM6vQluhnNDBbjXXBbI0KwqE6rCArIIyqLNGrG1K
	 v0NngbPEkBHfGTcAu8M31aV77kCOtMGiNl9m1UvHV4dcZK98vsUIHKpdynAtSlk7/eeNR
	 MznQH5E5cQV0LE+F93fuJR066r7CJYKIojAmQTwA/yul+KjfC89hdk7HOiOazOScqBc0/
	 kYcqFmKRZ/k+MrHNYI4etcA/F8vdd7MGPtQstpV7gTz9VoMUXBZURVI/r2gZyw4HgBSge
	 VBQwkd/khzgw5mDrTqpJUhkRbrx64rqhpYhC5P9Rs7PZSZJfDd9fai2UNi60AY5NdHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877092;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Tx4N7P1fRkn5Ta3AZs9XVGYEyxqCt48WpsxBKXnWKvg=;
	b=4d1EW3vfpG2VVN84vI+TTtNwGsLGIJnLdLjxx7PTXntx/eShUGr1JvQX1CfZwf3KPZcS
	 MH4EmXnlDtX2esuOYgFYKaoFSjOOhOz3Z4R+ZPmkpQ/wLugCez6O1C+3A2Z+uyuFUHOql
	 BdBIrQHcMs05SZoH1t9qDM4q27tJpsPkj/CA4FSUoV5FjDE32DN3VpkFT4Sfs4/0TSbUR
	 9JydR1gztxxtZd++4Kc663/5G4+13QHu/OMehukZ0WHVr2u5dpphnHAyQVHkdG9QljeKD
	 VGdMzPhpsJ4Ej6ZySKUXC8jbs/wtHI2DyFPtWlW//PqA4nsFf2d+drMktXqvuxcaGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LYU1q7hb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Pu5/zBxq";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1C606D818
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 11:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E1C606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LYU1q7hb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pu5/zBxq
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AhxaI1582975
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 11:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tx4N7P1fRkn5Ta3AZs9XVGYEyxqCt48WpsxBKXnWKvg=; b=LYU1q7hbol6nweMa
	Ih+LCLM9IifmB1k2NsdvECh0fURO1VTVJjDP5AK+c/gK7HEJ4yiJTAaAPN/plh2P
	QrPOsRrcJe9COmdca/D1hIKYGd3Z079lJ3OiUY+cYfj959SoHzONhU5sVOh+0dJp
	xsoTXxAxUrNpj8vvidFcdztPuNz+WiG5spcfmI9ZAe3pHUhdcIsI56g+gYpaESUv
	26IkDz84sZKCTvDHBaq3Ew6rcr98fYIokAuI8QgRIKFZBN6n0XK/7GUpyT8b+lEr
	FTzDDb3UcuFNAz3kLe6t75xhBMM6LcX1tR5p5pu33AQkJx0EOtp/QjyYo+z0xOzr
	KT75GQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraar3b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 11:11:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f13c143c8so331761385a.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 03:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877090; x=1794481890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tx4N7P1fRkn5Ta3AZs9XVGYEyxqCt48WpsxBKXnWKvg=;
        b=Pu5/zBxqOnIOalaVvNSMdbrbDaydtUbiKphzoTewxLHsbhIHb8ad8e21d3sCVLWKk5
         1HUkaNYw3QARi9X3GJDRFLVLQrpWAmDlPc738RHVEG/2nHJDm7SdTpn971d9RG7GkpqQ
         iO9sIDCplNt1ZU1cTFdI5sOxamkJm83p2K6gm2RTDXqWrUuHHi9ZrEMaeIz+zbxpO6ZD
         OYDiPjT5zjp/+rkC0pqntOgwl8fsOfxg/Yl2ki9PBvO/wVOzBjEtaVefJXIWY8XxDrlf
         OHdv4lgZIRMe3kCmyVC3ZvRVokNlv79YTxscEtzKOvgL5f6dcMy84XXzqM9jvFaon6AQ
         NJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877090; x=1794481890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tx4N7P1fRkn5Ta3AZs9XVGYEyxqCt48WpsxBKXnWKvg=;
        b=WTOFYusqs3Eg2HQPIhFHXrJrRGn2AJYRSKrpRTBAClRjo1r27Ax47814bwcFrfp8Xm
         DnIgYHxL9UyO+6rShF6mRyhCToKrGG9KzZHCBlrawBsnE6I6tC3HwjBzj5IllKBooJVi
         XsU0DETk+yz6USl6Kq1Z6+JbBFSrkXGTvgAciLnTin5/eMVVP/EzLEsBIJIFoPIUzLMO
         fu3fbTQAANL+xYkDuexib9xZMGRlksHGnXKBeuiPpZ9RszDAB5yWmFjQevMRMy1Hno3J
         Un9uxAzFcls+22fPIQtIdQaES+bJ+LJw64QObwdizQqicKHf/UmWiNOmaZAyUqZSuJKF
         pd3w==
X-Forwarded-Encrypted: i=1; AKwUvBwaQ6/LqaKC/vpRQ8ZvvUKXMM6kJG2ZSNe/QEiyPGvylNaR1MkiQG9Kt4TsEufPAHyVtQ4ZzNMK7+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bKYbltMjK/dbfw7RyYICNaCYutwCJlEC4HdSy7z7KH2jOeNaF
	QtXetdEfUh/Aagpvh8MsFUExNGLwsUE9IBoZliyfMzXwUnuSYGIujglgkM/35DPelDujoNE5Xdn
	9OOMDqKw740gu2a8/yFNP1Z4ZOCKClyd57wHP4cKYSgtP16rwWmVZpB3598Fm4BI=
X-Gm-Gg: AYBFou2URgZNp6mQzykc69OCpgE7d2anSOiUERB7FTUHHdfzzssWnNLiX7KXj6UpHXS
	SZDd9M3pwa6AOIwDFPu6XP9kEHTwPvF5y0OmQeXy/gYpxM+1EBpyoKhKLewWQ6AuSKXSAJymJZs
	uwB8b3c7BE1zU8hQi+ToLToc8SNEW3224JK8IVfZufLylvzF/zNpeLLOmGAqzYNhrpLE9Sq65vm
	/pFuT8RvTz2UnldwjXwxGbZszYDDQC46qxtFl6vrM0BbFdu6h9X4bHYfgZqZG7KZed6Z19NiJwM
	XMTfRH9kogSArOwRSLA7PLKNnHSMXiU6zJ6HDJ5oOAytZslcsUNqG9bDHtTq2e926s4eIj+69ra
	6FCxFtul/x1LZGDMZQ9OlwoCVltG1/0bz161BckXPXTcuL7AJtw2t1cd0Zd+lEvm0UksRmiUN1Z
	Fnakd3P02kWmK8a1gUtXrpjVH4FAGUm6I2zBduhrYh
X-Received: by 2002:a05:620a:8806:b0:93e:4d74:68fd with SMTP id af79cd13be357-944217b2aeamr3041638985a.65.1793877090343;
        Thu, 05 Nov 2026 03:11:30 -0800 (PST)
X-Received: by 2002:a05:620a:8806:b0:93e:4d74:68fd with SMTP id af79cd13be357-944217b2aeamr3041633985a.65.1793877089727;
        Thu, 05 Nov 2026 03:11:29 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm438320685a.39.2026.11.05.03.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:11:26 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 19:10:59 +0800
Subject: [PATCH RFC 1/3] dt-bindings: mfd: syscon: Add Qualcomm Nord Titan
 CAM_TOP
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
Message-Id: <20261105-ccu-v1-1-3accc4b901de@oss.qualcomm.com>
References: <20261105-ccu-v1-0-3accc4b901de@oss.qualcomm.com>
In-Reply-To: <20261105-ccu-v1-0-3accc4b901de@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, vikram.sharma@oss.qualcomm.com,
        nihal.gupta@oss.qualcomm.com, vtumati@quicinc.com,
        bryan.odonoghue@linaro.org, Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877074; l=1095;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=Q3m2L70QHVhNFssz0d5iHd//KrXi34EuQb4Z/fjKNc0=;
 b=tJUyjpuxFIMXk3yVPv7pWbYsQQMLXi4d1roL6jwFr09gpB77pcSfkPDrM+jz0MMUgdXX+mAHI
 GAZHn2d/ZbYCRjZPtKEwPdztrnqtMsEyEjk98aw5f7HWCUbeyTDslPo
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX4fydrFZA4Xvu
 DU1rn/zkQXmb44PQpjFje9iLZrmZ/Guk1QBI3wEIgPe3qsA+8nVlJrdPfxFrMukqzrIbPK9pxAm
 2LXuool70ApOPicZuOSRiDbDajvzzqY=
X-Proofpoint-ORIG-GUID: _GRpRDO0Q4VueF4avohKnT7jOnp5MWjc
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aec6463 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eQjVoD_657R47FWD1NwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX1KtI54IysPbM
 jNGTyYON/ie3R6blN9JMUw61428pHYploss011wR8dRs1dCqtUVoKoYq1k/z+a3my2vY/W+usYf
 RjLSKpXiiiphctq0vRDRPXJuUPAoEXgDybgGty89s+NfbuqlUzq0/eNNvP/HqMXvChmJE6KaYCl
 qNus6cxn1Q2RF8CqpNsxyzVjnxeNHGJT2rvzMyFcA/Kk+hJ727LzRYToa84MKlzAIYxY2v5iJ/1
 5H3kA/JuAf5GeuMRujOWKuU0HUuxYGwx2qtcRltrpWMG5qynYrm2vKjJScaOWQoHKrIKr4cRgFK
 N/giANpMuVm3xA1kymZSUhgaNQK+H3vv5kYrTnp3RKRNjzmkUSQ2EWzfxnPWnAlzN7Q9/Um01bR
 QFbYMzTgMaDnSQr0mnXLtIoyrj4Ht8CgSsFYyrSkH9kLcIB8amjQClQcSP3PgM2kAnyjdQB9amF
 Nu3SckaANEEESRGusNw==
X-Proofpoint-GUID: _GRpRDO0Q4VueF4avohKnT7jOnp5MWjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050044

The CAM_TOP block in the Nord Titan camera subsystem contains
registers shared by several camera blocks, including the CCU output
mux used to route the CCI I2C ports.

The block is outside of the CCI and CAMSS register ranges, so describe
it as a syscon for its users to reference.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 80ff0e1caca224d8dc7d8a0243acc49c253cccea..077c4037fa0ce4f1b93927579c2c326e7bed73d4 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -109,6 +109,7 @@ properties:
               - qcom,apq8064-mmss-sfpb
               - qcom,apq8064-sps-sic
               - qcom,msm8960-sps-sic
+              - qcom,nord-titan-cam-top
               - rockchip,px30-qos
               - rockchip,rk3036-qos
               - rockchip,rk3066-qos

-- 
2.34.1

