Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314D405872
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815587; cv=none; b=j6bNFzVx6lPmbuORQY/gRs0zixjXRiPLGiFXGjxfqWC5/MYFlBzfp3Qt1z3efa7ZlW7oA4bNacb8SwvD9EgWnW8D+wSL705NEjlgDz1i4Lh6bPnaf6B803fxM/hgcfAWNQ3Ig7e/x70FQODZc6mXIXyM50Rj+EKGcI2damfdrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815587; c=relaxed/simple;
	bh=dcopeyyySnOd9fL3v2swYiTB5ACAPgg1PSgm14bzBCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWNMtQ8Vrr5PEw+36LIduVA8O0ihteFH8KvM0BAZ/GwXNgK86uf778Bw75SWbiIi6vcUEkPIxOQ+7vmLoahollG5ak0loHu5LeByTSXTCa3H/meuDRMLLAAf1Us17STNzUEOk6l5MAXIdae5YTidufETZ99vn3msh/BzMVyah4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JPII2p9y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eg7Z6HOL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPII2p9y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eg7Z6HOL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH1cu73147033
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6gMLM31lPewnCBaPI066p1pgy4In0RFum6QqFLaJ934=; b=JPII2p9yDr0AgFhE
	gBA7YeCXlr5AHJCIhlRaxmhzdJnXkug+hm7a7F9h/Tf+lgA8VF/w3obLVxis9HGY
	0P4pbPDPFA/Tx8G6yojWiFBpoKeGvduw/2WyjQw1/NMjq9dQGReyssObJwHfpcyE
	a1CxhObFWf9SYjmpKamTyOaKdCSzz5a5XjHDz4Oiz7ftccM+SuKrVWOHRMpPJMNt
	iIkO9Mi9KVhGOlMPjsWnL0R9ByMb9m6zSJ7gRM3Wrt/RfIBReADm4HnKQdrnwq5B
	lMmxAc8hPgh0PXlJtN2I0OsrpQuQ0W0knSD5VbJ6Huw357w0GaGAUpLMd2KKUauO
	N6yvRA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5v3u41h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so15762348b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815584; x=1780420384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gMLM31lPewnCBaPI066p1pgy4In0RFum6QqFLaJ934=;
        b=eg7Z6HOL/ZnsnLocQDsUOwFDxh6IoYGNWBcOnOq3piu6jPnrmvXoabamfyL4olXagi
         7sEXIqObYpbFujC/UWpXRexFbG6GscHNk6t+ZjtrdSIgDg6MZTQfsl4NJ/YLE13IG9Ry
         HtfvrOsRXGyrosOxhJJqV8Hl0F0irr8QFAvQGBAsRkS2nqimzmCDiP9PRTsy/2upbnjn
         m3o1sjx5d5mU+ibwkf801p+6o+vl3olDu4rS2kHl2FTMx4z2kcDnfkVbZrur9C+H7e4/
         Vk70sVlLUNaWWpnaW88GPsgFH8aS+in7Fy3balf757PzaYzB+gAuhiPfNIyqEpNHsZ4U
         J+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815584; x=1780420384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6gMLM31lPewnCBaPI066p1pgy4In0RFum6QqFLaJ934=;
        b=F/94/CZ/D277OeqzwZ50e0zO6CSpRCGSZC68luUk4ArYGKXxKVlIUsTFd6AM4xksJK
         W/xmI0Ktqw8xso4Q4OrOB6qgSFbJYClodORRtGnsvetBVfbXudtQVUhbjI3OPF4wAfTc
         8UObApbX5KodaVHGY8Dv5z25YDK0Rb+zr51xx6Ff8nzf9pinda6D8mOVbMmTmuqwstZJ
         MlN8iD5+3CfMCtn6K7kDFqg75xRxud8FLp5RKMa5dAUHIzXYHbCY+93/tBQd8P+9H/P+
         8XJfhFGQVpP6d2hRVm9h0+Y3yy0c6QG2ZvXZPDGdI+M/k2jkwrvSm/8JfA67MDpsQiGN
         wAtA==
X-Forwarded-Encrypted: i=1; AFNElJ8B3Swl2TQnFm3b8Holydy0bDjVvDCfdXKCfMiZSK1TZM8eZEueTsdtPE5fJlOqXrLO0wt3JAGwDTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/3QUBUDDZAGGq498j1HKgfja54Jjmd5cdltvyDzOjjKYGACo
	xbFzyAr4BJGVABIC8v5ANUVXIT5HIuPBI4t1G8+x+86sUUE23jaaQkMPvnEoX8FnwYIelaVLAVo
	EWOgkzUEBEhsVIAU3olBXfp+Am/XG8QoZuyioFU80pd01AnfXCK8bE4BO/V1PD1s=
X-Gm-Gg: Acq92OGPVvLTaHN0yRgNJVgBZHkSI7KGUnKWIGWfd2ClmV6BCxPqDKkrQTASkmD7Lfq
	Zw2kiwevMtXkQOd2eXit2oE2Lruli4myKdqGsEQ1D9X7tGusbg1hGxSuRpRFlHtbL4gOe71nY2d
	UobMlH5Thd3L5zYn+2YBp4f4emnmvgjdrrdrk0oS/ZaUwbDcFlS49GG7Kh3BaWtSA704yzhM5sE
	wi2WOOcf0n8O8xDibu878KGR5fSpx+DMxMhbHz/+EdwH3PRxiNK5SH/0QsY55S9E/xKQ+GZwLl9
	TJmjYuKM3dNrCnoMZHXBs1xmT5t/vyHZ8TqDHmeHQMT5wzqKT06CVddlj3/TAsatRUE+Lv7Rzey
	zUpWfrwG73Xl3z1rhFY2uzro2xqxQW/UG9pCiBrrCEfNAdhGbL5JK
X-Received: by 2002:a05:6a00:3010:b0:82f:355a:857e with SMTP id d2e1a72fcca58-8415f68c23bmr19307747b3a.47.1779815583688;
        Tue, 26 May 2026 10:13:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:3010:b0:82f:355a:857e with SMTP id d2e1a72fcca58-8415f68c23bmr19307714b3a.47.1779815583182;
        Tue, 26 May 2026 10:13:03 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:13:02 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 26 May 2026 22:42:45 +0530
Subject: [PATCH 1/8] dt-bindings: media: qcom: Add Shikra CAMSS compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra-camss-review-v1-1-645d2c8c75a7@qti.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
In-Reply-To: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfXz5T0N2fG6mWP
 L86gFOFRXkZfgbTlqc+sg3bY2dGWKDdUIoMhZzf81AfSiQlaSqIl3zGv7oFGkAQ1ysR928HEDRM
 2BafMUuUsVWtdLPDr/FoGQss2UzdRMHQ9bL8BrK4P5ra9xWWAb9vaK4E4E3TWDkxWR2meDd7dpK
 4s9BUwGadhy/PzvaNFWzbW7ttsQ8ONgWCCbR/AV/w2HFPwH2cIvOiDJapgwhh9dDgHkvP7l2/57
 zXUKcIG0hTGl22+Bixe9nxi7IdFzZ6fgY2Cdn2G4Vd8jHTjoZaoUn1yWXEe5+PsJuRa+DDKfYH1
 qEOY3ve8cXplatjeuZnpoAD7IfMIYuuzEIjcyFAK22maApDMtzAOE9Uhyhnoq2eIkayJ48SbNkE
 CEmVfkpPO3hSpJpcYnh1CFnLycs39F7Cqij1wHOG+D2SUM6vMECNvJ562fuRbwNv92oteDYpkON
 zkM0Jk7wvyZh5Uy1CTQ==
X-Authority-Analysis: v=2.4 cv=Zc4t8MVA c=1 sm=1 tr=0 ts=6a15d4a0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=TW5Qit177qQvJ9gbTQAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ladbt6jS--_vHTFYrMx2l4S8F4kjbyGk
X-Proofpoint-GUID: ladbt6jS--_vHTFYrMx2l4S8F4kjbyGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260149

Shikra uses the same CAMSS IP as QCM2290. Extend the existing
qcom,qcm2290-camss binding to add the qcom,shikra-camss compatible
string.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
index 391d0f6f67ef5fdfea31dd3683477561516b1556..7b1469d6a1601413a1a32dc452d7d1fc85aa9eb8 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
@@ -8,13 +8,16 @@ title: Qualcomm QCM2290 Camera Subsystem (CAMSS)
 
 maintainers:
   - Loic Poulain <loic.poulain@oss.qualcomm.com>
+  - Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
 
 description:
   The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss
+    enum:
+      - qcom,qcm2290-camss
+      - qcom,shikra-camss
 
   reg:
     maxItems: 9
@@ -76,6 +79,7 @@ properties:
       - const: sf_mnoc
 
   iommus:
+    minItems: 1
     maxItems: 4
 
   power-domains:

-- 
2.34.1

