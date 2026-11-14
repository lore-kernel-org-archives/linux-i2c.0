Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655994;
	b=i6Dgyrv69zJeTg15iNzYWV9eJkeJ638O/ZHYjptV5eWcQZkEj1YadKi7zgfB9Ab0s6z9
	 UFiRPXnsy7FAHJNLNO7uePfv7/bHPtDWzCnZXUGOre0H2I8CZWZ72tNTeUVQ0iNPQYfH9
	 a9F4gwTwhC0s5eI5F+PYiGPVmdjipS4jTo1ao3j4+Cq6A1zX02Sl4aHu/JAcW62RQOkYf
	 vRqJ7/jEX1NaaNQFP4FTrxxbzD8r1ikmL5PoAQBNkrEbHIbsuz8mZimG24JRSdnXGm0Vy
	 IJwYEzdIJnifRT07eLZi4Ck1f3yEL3JCkK2UE2UF8hTBQQPrmKRxJnj00mxEoE6vUgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655994;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=srBCbyMfwdy4wkpUlf47oeNrRB80fK5jRYSwk4ab/ls=;
	b=oR6TugYli0F3a/HoSzi+dNWBvLEJSRc+cUCbyFEapscu7dfhuX1yJUpErEeK/z+GDyD7
	 1liAuYXldbKSigKI4G38lgAJcWKY0J6H/oEnJD488kADNCeLQArD07vpbA3LRz+2nd8GI
	 OzP02V4ybc3j9r4+WzKxgVT5rRFhUeltCHvcmOrM8goOI168+jkcaZR3kqFr2lmj5B5ko
	 +j11rUHPzC24eOh0iaVP3H99n4XkndpaPDEdsV4p4+kFwaCOEqqnm9gi5SZuQjLpaHU5R
	 sydf+lUu1HkvPVhNk2sf9Sn/91tIUnD+6DJfVEXgmbuhdaNbq6IyCETfWNXOva0adzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gARnTJM9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NT4D7nqX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67F606A336
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED67F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gARnTJM9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NT4D7nqX
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wQNd3276429
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	srBCbyMfwdy4wkpUlf47oeNrRB80fK5jRYSwk4ab/ls=; b=gARnTJM9q9kebp/l
	YdsQQ1a4otBoicdDIRA4J/GJ4Bm7SQr+8r7n7wQhmrSwk9XI1pQ142zvK+XyRRqy
	/L4LV4XcFNGoMa246C8/mTrkbM/G62gIimf9PNd4RiSSoG8RbVjlsm9tmfcvR5oJ
	/HSM0IQ8pc4nEmaAVggoihA6g1HY1I1BoYGyhS8eisJgi9ULBR6Folq7UX46QkZM
	AGSVl+1cXW/+HlHjlixEVrdBNU61VWR3kltokJrNEsU/6MPZwJ5iOJ7em9petx8j
	ANNzCEksI26UeG0XUGKzgqizyMz+6uuT9c8orcg3LKf8gO0nJCBF4ZJPULKad9mZ
	ZYx6aQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqgrp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:33:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f0f4c70cdso7168606d6.3
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655992; x=1795260792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=srBCbyMfwdy4wkpUlf47oeNrRB80fK5jRYSwk4ab/ls=;
        b=NT4D7nqXH54JlNeDQ+evaoRlmZ/psehAKr93D5EmbuhEevb6Sw8HnCkBhA/vzBtSo3
         KdisdMAma2Ivhy7HgQKQ3MeZA5BYL2F5EVlPl3ufU5a5t9KYgrYyjMscuc5M4MiPHIiH
         Gmt2CgKJci1Q+yxTmFl9JFUHv3vdVfeC3zFM7jzVLKBr27RRA9FXz0rmO6ZNcS5aVHhB
         ckgITqKXEn/S68aKS7Z7D62zZkhXkELUSsM48q2SPMAMRNg5NIvZkselnYsOBNGM+/LF
         XbeGUrmt0U5cn4O8BXm54HeaJTpugbnjZsI2p4SHgcRJhg1GVKV+U3O6XG+T8ZbnCAtf
         599g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655992; x=1795260792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srBCbyMfwdy4wkpUlf47oeNrRB80fK5jRYSwk4ab/ls=;
        b=1oYIGuzu5uDni4Qi182Ovf7J199eDHzspUBSIQtHtuRBArktUXStC2hcInih9Samr0
         Qky6NOp3L5Kb4DIw4C8T4g4NzSHTD7Y+3Z8oZVFbRgH4LcXoDfCeHmZ+QzZKncWAN2Ep
         kOTRaqLuYOM5gGiCGoanoCCSSoArpEJaK6SbsxUjFClDXIpzW30IXETo63c7yVHsfyXH
         9PZsataNWb3H++2xdSM9VuWO4Zykg1ziO0TSncr0emGZwWN6xoh490PTm2QhENJN6nnB
         KFqkogXhnHGszEdgPl/+nm110EKfAo4yzLW6wI881meScKvFD6c3AJKdRxDEr9Ca+7H/
         rTQQ==
X-Forwarded-Encrypted: i=1; AL+hErGH8ACuZCcK1u9nGgICmiEpLGA9tQ0kG2PFkO/V1Dz/G7Jz/YYuSoUYHN9YI2nKyg/wqtTwZt38790=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cqwXbMVmOnRW38EfLIyw8q+C11NsgS7/3CFtGsqddvzxJc87R
	NBInBcNeXl/jvUPX8m7vgRs64TrhrmF+56xqLVmV9t0ScVqiVlqkC5eXMzZIDYrVcwRnUX3FK3t
	lWXDunjtnUAlZ5sCjMJ3ik1tjZlKZk10lXLd8fB0vtGyrtAx9K3EgIYYty35DhLg=
X-Gm-Gg: AYBFou0OtbqDkrdsEIlC++kX8fz/kPQnaGxmRPr4NfLjQHKDU2zH4MQ0zYcX0hoP9Op
	u9yXM/IwSV1MITjLuTpZxDcuj2BwXMzZbJbRw3BnXlcMvtak2Raq2jfEuJCRKc+MnHIV1kfmvxL
	9IORHldMHoKim8pBLesBJW4z3veuHhyWRVvAkmapbBZpLpnTGF8zcpJOWgDziAhF9EhKCKuOqW0
	8D/aKjgSa2PizSViCNymnRswx69DOp6Cm2sKFEGAOzSpPrWilIjHsnKv65/bYmF14gMcSWwGT+8
	fvny7AQnOiKyahQg+hZgZYEXs5v4XnFJ+XHbDZkmb2l5blR5fpNNH0CAWfo6pyfExDcBjd9HZdH
	kfP7o4jIF0otxPlIixSkQ6i4CQDFYuNh60ZNC7ZiOJIqXt7fHhLdNQzWTqcNS2CSlRJ1YLOvXMz
	z6+jKwRM5rIBwrFstFptJp/XTkzcWmh0U40TOdH80n
X-Received: by 2002:a0c:e01c:0:b0:91f:2b32:d8b0 with SMTP id 6a1803df08f44-91f2b32d922mr47536086d6.48.1794655992361;
        Sat, 14 Nov 2026 03:33:12 -0800 (PST)
X-Received: by 2002:a0c:e01c:0:b0:91f:2b32:d8b0 with SMTP id 6a1803df08f44-91f2b32d922mr47535756d6.48.1794655991922;
        Sat, 14 Nov 2026 03:33:11 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:33:11 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:40 +0800
Subject: [PATCH v7 23/23] arm64: dts: qcom: eliza-evk-imx577-camera: Add DT
 overlay
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-23-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=3593;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=R7REMZKBzgoQAsBHnV/bfBXJwjhaDjD5eJBKNy2F1R4=;
 b=wDLImcnj8scTBdHanFpRiYbT1nq0rOCtfd5wIaavK+DM05XCEbDUOimJA/y2e1T9jgIjSGGwW
 MVQN6NYMfBxC211qy67EYM1C3tWaDMOlZTKPWA7+c03nr3dMUSjja8l
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6af846f8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mAyPl-DPwURhq-uS1GcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX4R3GOz5RqUZL
 o1iLZNMu9HIVMtdHwPS8XvvBDMQYvgw5rtVe5u2mhBnjI7RAiW5NGJ2fBvmfiztBFRPwSNTnZJi
 mMB8twIMDKbJkiB8g3mfRgjz//Na0bg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfXyP2aw2NzOdoG
 3rrGGDShznjtg4AjD2ASsxSviAmrnirtUI/ZNbvwUZaEMN0nQj3+3sWx1a2yIDQq0zoVH9utIhO
 6cVo7tp55g8zMzbVeLo8oAbq52bDolY3fEW+DcsCSkAH9kueyZ8zCcNn8OlhJKHZuBvMSlmKztx
 cK87ZpHQ6txUtLfNQ/AuqyR2PT9Ps2tUBuFFsjQ7h1PR9wGbs+0AVM1aQB3SNFYrbgEiIk//raW
 ZcI5YflueCxUGMHbk1VMjSaR3PBhOwXoGFksCJCY9BL71QbERrXDeoqR2rSZ+aE+CU2IYqXyI/q
 q1r6bb9cQgBH1cdAENlNpieInAcB6B+lWU2WIC3bWQ96f66HMdheQU0LkGIoRlPuXsBi6whM6cY
 bBoMBJXKEep+vi3ckm0jJSiZXszcFz64f13f4sQtB6A8KX0ERDqliG76ZW3nmCrXNmzPWHo4RUv
 OBr/8kuByOf4Hg2QKUQ==
X-Proofpoint-GUID: 6qQBM_ge3zZa3WbdCw2OXVueqiEOBlC_
X-Proofpoint-ORIG-GUID: 6qQBM_ge3zZa3WbdCw2OXVueqiEOBlC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

Add an overlay for optional IMX577 integration on the Eliza CQS EVK,
shared by the eMMC and UFS variants. The sensor is on CCI0 I2C bus 0,
uses MCLK0 with its reset on GPIO8 and connects to CSIPHY0 over CSI-2.
The overlay enables CAMSS, CSIPHY0 and CCI0.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  4 +
 .../boot/dts/qcom/eliza-evk-imx577-camera.dtso     | 85 ++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 64d2cfdb89c89f1c6eb0085e2bf5877ff980dbc4..a9374c54dd514f53b7aa97f5581c99cb6e75697d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -16,6 +16,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096sg-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-emmc.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-ufs.dtb
+eliza-cqs-evk-emmc-imx577-camera-dtbs := eliza-cqs-evk-emmc.dtb eliza-evk-imx577-camera.dtbo
+eliza-cqs-evk-ufs-imx577-camera-dtbs := eliza-cqs-evk-ufs.dtb eliza-evk-imx577-camera.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-emmc-imx577-camera.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= eliza-cqs-evk-ufs-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= eliza-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= glymur-asus-zenbook-a14-ux3407na.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= glymur-asus-zenbook-a16-ux3607oa.dtb
diff --git a/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso b/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..08f2e3c62dbdaf23a2f6ca69a5c392054cb1c225
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/qcom,eliza-cambistmclkcc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/media/video-interfaces.h>
+
+&camss {
+	status = "okay";
+};
+
+&camss_csiphy0_in_port {
+	camss_csiphy0_inep: endpoint {
+		data-lanes = <1 2 3 4>;
+		remote-endpoint = <&csiphy0_out_ep>;
+	};
+};
+
+&cci0 {
+	status = "okay";
+};
+
+&cci0_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	camera@1a {
+		compatible = "sony,imx577";
+		reg = <0x1a>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cam_mclk0_default &cam0_reset_default>;
+		pinctrl-names = "default";
+
+		clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK0_CLK>;
+		assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK0_CLK>;
+		assigned-clock-rates = <24000000>;
+
+		dovdd-supply = <&vreg_l7b>;
+
+		port {
+			imx577_out_ep: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <600000000>;
+				remote-endpoint = <&csiphy0_in_ep>;
+			};
+		};
+	};
+};
+
+&csiphy0 {
+	vdda-0p9-supply = <&vreg_l2b>;
+	vdda-1p2-supply = <&vreg_l4b>;
+
+	status = "okay";
+};
+
+&csiphy0_in_port {
+	csiphy0_in_ep: endpoint {
+		bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+		clock-lanes = <0>;
+		data-lanes = <1 2 3 4>;
+		remote-endpoint = <&imx577_out_ep>;
+	};
+};
+
+&csiphy0_out_port {
+	csiphy0_out_ep: endpoint {
+		remote-endpoint = <&camss_csiphy0_inep>;
+	};
+};
+
+&tlmm {
+	cam0_reset_default: cam0-reset-default-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};

-- 
2.34.1

