Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655817;
	b=BbFjHnGa3SbW66eOsetTlhy4O/9mRYdSM9Gnwl7L2tD7n/p2bkQAWFz6tgOPLcMWH42G
	 4Xckg1yzFuF8xuNxbowsq9zlf4uDsSa1vy3Ukswnltb2RZyLJbtAvPTObczSrhucZiHbp
	 NBsBsiL2COjAVgt8YNOQnDTQn+naA/8wDbNbWls6qB7WpQp7q44N8t5pY2XekndeppdCh
	 bwCCf/z+0r1/Vm7I+/0DmRZXQlBJ8Tpn14/E88w6g7hQ71BUnbWVXtPaZ2oI5cSTr8B6v
	 zLjOvmc54Kpu2axv2NqiJAjnW4WrKgO2Q3qONw+9oJXIIPipm8wcPAVFH7QmGicEkfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655817;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hcdILR3xyf7f8ySp8tYpqHBnHrARzRGQO+9FgjgHBks=;
	b=3vmafQg/BQz4L9ulusPk3aGoj1aU7tqJXsAIqAPAzGtKvJCjHhG5vQjEMcT0itYzrS1/
	 Pyyr0j2E9l7FfJEVWQdBGIB3uUkn9bas7BVDY68vA+7lSfHKKTGahq76QGSwZh1yx6pYu
	 TaSMy3GsswR7FPnKVh66KHiQwTOOpwPHure4a7XIbMO9TB+FB4NtDdoJNfxxYmpoVaD2R
	 0pjeAyyg0Jz7UWhlggawHA1gHMsTZ7fN0+2VqiEV6VKy4yCzjU+Qa48z1alSVzcd1sUmG
	 FCFk5iyQHH+zTd49Mokxf4qHVxS7BHfYszzwGtJ/l23AhF29bAFQig+3PAuHhE1KsSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cTJ6s3aR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jPRuzcKR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04316606A89F
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04316606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cTJ6s3aR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jPRuzcKR
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9w9cN1750095
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcdILR3xyf7f8ySp8tYpqHBnHrARzRGQO+9FgjgHBks=; b=cTJ6s3aRh19wkTsF
	H/K6BHslxjC8hzN+VWNrLXaj/TZow405xJNfC1755wdMinzHsLKhUlI1DnxArzP2
	FSBf1emn0BZzXkenv+tjkmB4GKsUXW6FY92zxpIx0mInq4q1VXoJhjxFso99NJPU
	DZBhZLKuzyqgorDYFlJ0y+5/uo07UwrF46wG2VncCiYedWU23onVEbTl2aZgUjUe
	DwRWQgqFT32DB7hPyzaHMeS3xPVT2UyAizNoPXZZ0rHSPrbEpLqfurK8ZPVLUQqc
	Fj8tUW0Tvv4H+WFdxm7oiW6WyTivbJ/q1qrZTTT6DWKJ/8k5KmDOrmsjyfvRmeZF
	qOQE9g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj40mv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91ea39a2f8eso42484976d6.2
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655815; x=1795260615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hcdILR3xyf7f8ySp8tYpqHBnHrARzRGQO+9FgjgHBks=;
        b=jPRuzcKR8aujs137Pcq7QKpIy+cna4AWNKp7CgfVfIasFe9+YD21Ssp4KU/kH49K42
         SBEqyJL6rVVB2LRzBkK67bacDQTk/CfWRu9Os1sFoPsUZ+GELuuXwI/FP54l211lBrpF
         462glV4Yu/EGh+rxKOHSKz2xGrzzjsFIgxl51vPeOSDNY/TD10KqvKU2+PnUGcMwu3Nt
         QDQfeDLVNNdtb9kN1mUzY1H/KAHWqnHDWKlvKDr6MfQWIQDRfzzVDYshMKrRhxVZhqnN
         n7gNwf180B464qEY0vLJs9vm+GfEdDOxq+NIuZSGSZZ0XDF1n0Xug3YebtVQxHDvsKBR
         FbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655815; x=1795260615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcdILR3xyf7f8ySp8tYpqHBnHrARzRGQO+9FgjgHBks=;
        b=iW95VbFJMFxApBV/rPYYiZJXcKhYiYty/jqMuqokNVhDZ8r42460aYDN4gTLjaaZoI
         xek8LA3spfnO5GJsfsvdyjyIa7jwjLSqghzJ5/HElXZNef2e/GU6Yv6ALdTw+W5FjmvN
         8D1zBfiqfGJeGbGkGjWm1FH82kqcMRr48oysPUSjS8AHumdfPkYoqn7X+fgUPC6admZT
         axqjPx1sSKI3IIjfuheG9RtaI2PYROS3v5iojLff5B0Vxvww+6Gvqz8/Qe6lJT2daCKo
         NbK1G1HDtKb6N2HL032fqpNXmazBHcGaW7n6trY/eLEomJ5i/lAm+UTf+JTj+BM3esX/
         tjBQ==
X-Forwarded-Encrypted: i=1; AL+hErGbFgNZrLTm2nUOE3u/N6/MGwi9NbK4d2sjDvYMWhYXeFGvkx5ZILardLglgCIos3UxAHxqnlH6Dp8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gbaqIZjliiWklS8qIno7xkqkJ991TCOHX8wMsE+4nmNeRdsXV
	mar0YkSL7mdvhveNPrQ3OSsiseeCEtd0MzZ3YHqlx3BjaPsgnqGz1SfZ33j0z5A8Cm5PSfajYsu
	eZBx9u9gNPspAQWTOSpVqeNp1988AWmoK0SVDqfrAdA+f/e5gxjP+jBZnPAECFJk=
X-Gm-Gg: AYBFou3DVxF9cNFW/y7Q8dHdbF75jD4mUwGCTLmEKszyajnP/ahER73wvynd6jHgxJK
	mL2iu0RNAaLGtE7N3Z73qwQH1QdeJHSUc2x4hl+VpJ/nctyyU975fyi/8DkCmrACTzFhQlxLkao
	GdiWudkuEYJwH5n/TlPEIAL7ABj1taUFfJVmszB22PInIXnqNxs4k5SpOOAUiTw+VdK2gmKZj5l
	YYba2BpkpVuvqRCIp5Qn0qydSIvflnVFFjhaTEweXCto1uQtO9lySeHUmFL0wHemtX3bjdAL4vS
	r0v+6gCCm2D5zrT69jCjr7jpHoVnxgNhRTueeDNJPqfQYuz0QEduuWkZipR1jMfUQPsfw5gt//y
	+v4EtW47DTnBhNyRmkAx9ZVY6DVGXn64uNzJDeSTAqt+cP4aXghO9ZLmoEkMigIQrSokydDbrjH
	VNmvXA5azEh8bGw+KqhSCtZMhaHMNwF4rXGbMsYgut
X-Received: by 2002:a05:6214:5684:b0:917:8a83:a15c with SMTP id 6a1803df08f44-91f2417a770mr75225816d6.34.1794655811330;
        Sat, 14 Nov 2026 03:30:11 -0800 (PST)
X-Received: by 2002:a05:6214:5684:b0:917:8a83:a15c with SMTP id 6a1803df08f44-91f2417a770mr75224976d6.34.1794655810708;
        Sat, 14 Nov 2026 03:30:10 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:09 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:20 +0800
Subject: [PATCH v7 03/23] dt-bindings: media: qcom,sm8750-camss: Add SM8750
 CAMSS
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-3-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=10729;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=6ECCq5dmZrMTJAeaCZmdGOCSRUKo5+lFZTMMouXNrMo=;
 b=AwznNgiH+vGHgSPLrz35eVn+WtJVtKV9Spl8X36JFZNJ77cwosaGCGCx+x7/W5AGQZ7fCKz6J
 /0epyZXXeTkAfInlIKkLYtdNMWRUmV9CqIwUNnEviBzQnkYtKkEKd4M
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX4tYDWsHAObFv
 M+fVWFse2uX0GsuBU9Snuu8MVS3AL43SZnoiOlJwfd/Js3GiokyB3epjQ4uKk8zi1fvxKj3s2IR
 Qf7gPBqiRT7Y7pnxitLUWOJ5KlD9sTKHU0y9RBw59xTtjDpeQJ+i7zKr5H8VeOsySzDBpqlVfAN
 ZreFcneiLRvizxQkBbpJJcnYQcId8V0mQm9vp6xYyFOtC7+Tg2yUnGkSO16zmFigzAdZ7VdXESW
 2MtPD8mROJzjUN62m7dxSyMIbmgwXNPJP3jksF9Y4pQfuwRQ4xBjV2sxi/ZptoSLcALjejwblNI
 naC1K5eD2S7pSZICRJaG0skBTZC/kDDVI45Vfz7sMPWjlA+hhVPnOM9VHJKnIeM+XS1ootxC/Q2
 WhfD9rPrVPxskt+pJJQo18K7Gtn8eAgewDluJNaNC2jhE2rDaWvoEgwhGxYWxFGIwwZ07oxRUrW
 xdEUGR5uxRR8B/Q++0g==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af84647 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=yzr0uxE_ijXmPgLYsrIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: D7EJpODwQ9oM-ktj6dwGaz8gTtyjQkq2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX/Xl206i5GhX0
 uPShtEe5ZgSQiCZANZlTzwp7LiHPVGf4UyYu4oOldec2FWjVNO0Pd4Ro6cT8FOWrfA01ap1L78m
 4L5Olf7E9eQPamtKTld0GoACF5KsOYg=
X-Proofpoint-ORIG-GUID: D7EJpODwQ9oM-ktj6dwGaz8gTtyjQkq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add bindings for Camera Subsystem (CAMSS) on the Qualcomm SM8750 platform.

The SM8750 platform provides:
- 6 x CSIPHY (CSI Physical Layer)
- 3 x TPG (Test Pattern Generator)
- 3 x CSID (CSI Decoder)
- 2 x CSID Lite
- 3 x VFE (Video Front End), 5 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE Lite

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 .../bindings/media/qcom,sm8750-camss.yaml          | 297 +++++++++++++++++++++
 1 file changed, 297 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8750-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8750-camss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e7ab61d71ffbdf653f8a3b92b26035a2b29093df
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8750-camss.yaml
@@ -0,0 +1,297 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,sm8750-camss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8750 Camera Subsystem (CAMSS)
+
+maintainers:
+  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
+
+description:
+  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
+
+properties:
+  compatible:
+    const: qcom,sm8750-camss
+
+  reg:
+    maxItems: 14
+
+  reg-names:
+    items:
+      - const: top
+      - const: csid0
+      - const: csid1
+      - const: csid2
+      - const: csid_lite0
+      - const: csid_lite1
+      - const: tpg0
+      - const: tpg1
+      - const: tpg2
+      - const: vfe0
+      - const: vfe1
+      - const: vfe2
+      - const: vfe_lite0
+      - const: vfe_lite1
+
+  clocks:
+    maxItems: 21
+
+  clock-names:
+    items:
+      - const: camnoc_rt_axi
+      - const: cpas_ahb
+      - const: cpas_fast_ahb
+      - const: cpas_vfe0
+      - const: cpas_vfe1
+      - const: cpas_vfe2
+      - const: cpas_vfe_lite
+      - const: csid
+      - const: csiphy_rx
+      - const: gcc_axi_hf
+      - const: vfe0
+      - const: vfe0_fast_ahb
+      - const: vfe1
+      - const: vfe1_fast_ahb
+      - const: vfe2
+      - const: vfe2_fast_ahb
+      - const: vfe_lite
+      - const: vfe_lite_ahb
+      - const: vfe_lite_cphy_rx
+      - const: vfe_lite_csid
+      - const: qdss_debug_xo
+
+  interrupts:
+    maxItems: 10
+
+  interrupt-names:
+    items:
+      - const: csid0
+      - const: csid1
+      - const: csid2
+      - const: csid_lite0
+      - const: csid_lite1
+      - const: vfe0
+      - const: vfe1
+      - const: vfe2
+      - const: vfe_lite0
+      - const: vfe_lite1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: ahb
+      - const: hf_mnoc
+
+  iommus:
+    items:
+      - description: S1 HLOS IFE and IFE_LITE non-protected stream
+
+  power-domains:
+    items:
+      - description: IFE0 GDSC - Global Distributed Switch Controller for IFE0.
+      - description: IFE1 GDSC - Global Distributed Switch Controller for IFE1.
+      - description: IFE2 GDSC - Global Distributed Switch Controller for IFE2.
+      - description: Titan GDSC - Global Distributed Switch Controller for the entire camss.
+
+  power-domain-names:
+    items:
+      - const: ife0
+      - const: ife1
+      - const: ife2
+      - const: top
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    description:
+      CSI input ports.
+
+    patternProperties:
+      "^port@[0-5]$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input ports for receiving CSI data on CSIPHY 0-5.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - interconnects
+  - interconnect-names
+  - iommus
+  - power-domains
+  - power-domain-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8750-gcc.h>
+    #include <dt-bindings/clock/qcom,sm8750-camcc.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        isp@ac04000 {
+            compatible = "qcom,sm8750-camss";
+
+            reg = <0x0 0x0ac04000 0x0 0x1000>,
+                  <0x0 0x0ad27000 0x0 0x2b00>,
+                  <0x0 0x0ad2a000 0x0 0x2b00>,
+                  <0x0 0x0ad2d000 0x0 0x2b00>,
+                  <0x0 0x0ad6d000 0x0 0xa00>,
+                  <0x0 0x0ad72000 0x0 0xa00>,
+                  <0x0 0x0ad8b000 0x0 0x400>,
+                  <0x0 0x0ad8c000 0x0 0x400>,
+                  <0x0 0x0ad8d000 0x0 0x400>,
+                  <0x0 0x0ac86000 0x0 0x10000>,
+                  <0x0 0x0ac96000 0x0 0x10000>,
+                  <0x0 0x0aca6000 0x0 0x10000>,
+                  <0x0 0x0ad6e000 0x0 0x3000>,
+                  <0x0 0x0ad73000 0x0 0x3000>;
+            reg-names = "top",
+                        "csid0",
+                        "csid1",
+                        "csid2",
+                        "csid_lite0",
+                        "csid_lite1",
+                        "tpg0",
+                        "tpg1",
+                        "tpg2",
+                        "vfe0",
+                        "vfe1",
+                        "vfe2",
+                        "vfe_lite0",
+                        "vfe_lite1";
+
+            clocks = <&camcc CAM_CC_CAMNOC_RT_AXI_CLK>,
+                     <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+                     <&camcc CAM_CC_CAM_TOP_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_0_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_1_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_2_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_IFE_LITE_CLK>,
+                     <&camcc CAM_CC_CSID_CLK>,
+                     <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
+                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
+                     <&camcc CAM_CC_TFE_0_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_0_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TFE_1_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_1_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TFE_2_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_2_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CSID_CLK>,
+                     <&camcc CAM_CC_QDSS_DEBUG_XO_CLK>;
+            clock-names = "camnoc_rt_axi",
+                          "cpas_ahb",
+                          "cpas_fast_ahb",
+                          "cpas_vfe0",
+                          "cpas_vfe1",
+                          "cpas_vfe2",
+                          "cpas_vfe_lite",
+                          "csid",
+                          "csiphy_rx",
+                          "gcc_axi_hf",
+                          "vfe0",
+                          "vfe0_fast_ahb",
+                          "vfe1",
+                          "vfe1_fast_ahb",
+                          "vfe2",
+                          "vfe2_fast_ahb",
+                          "vfe_lite",
+                          "vfe_lite_ahb",
+                          "vfe_lite_cphy_rx",
+                          "vfe_lite_csid",
+                          "qdss_debug_xo";
+
+            interrupts = <GIC_SPI 601 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 603 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 605 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 376 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 606 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 377 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "csid0",
+                              "csid1",
+                              "csid2",
+                              "csid_lite0",
+                              "csid_lite1",
+                              "vfe0",
+                              "vfe1",
+                              "vfe2",
+                              "vfe_lite0",
+                              "vfe_lite1";
+
+            interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+                            <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+            interconnect-names = "ahb",
+                                 "hf_mnoc";
+
+            iommus = <&apps_smmu 0x1c00 0x00>;
+
+            power-domains = <&camcc CAM_CC_TFE_0_GDSC>,
+                            <&camcc CAM_CC_TFE_1_GDSC>,
+                            <&camcc CAM_CC_TFE_2_GDSC>,
+                            <&camcc CAM_CC_TITAN_TOP_GDSC>;
+            power-domain-names = "ife0",
+                                 "ife1",
+                                 "ife2",
+                                 "top";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    camss_csiphy0_ep: endpoint {
+                        data-lanes = <0 1 2 3>;
+                        remote-endpoint = <&csiphy0_out>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.34.1

