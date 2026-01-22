Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C2426684
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078503; cv=none; b=smyQmVQ+OQ8eJfdl3bXnUvsLFt45qwbtis6nvRkvkdrF0ZsgvN9mLhB6EwZ7GxrsZO5bPOg1IqePyzI/v4IA+dton4kNpOGQjxJ2FeILaHOwtJld0Fw5UpmTXHOIlRsmLxNV9b/t7UX6vFOx2S7NTiaxGw99GQZfXwm8RD11YzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078503; c=relaxed/simple;
	bh=urisQog5JZfbdirBxu5tGAO+ASUUaW9dPoY/c9Nj33A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJRGrP4cGR6eoD4MCkS2fZa3nAT6iLigRBvc5d5f6dgNwSsZlTRDL8TwoieR8DXZoX/8KlOVzaYZI5ZtKAUBeFxkzChy/Gk1202xxjxZmUScbe8RKvhtohgNpeenY3bbrXov1MkmAgY2JDKvBXPJIxdcq6BVfbgRkYQI4mN2RN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jX01lWX3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSlQgOKB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jX01lWX3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSlQgOKB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7iMDi107373
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oYe3a+X8RQV757haNblqDrC0UCkSImr/La6BxbOeCBI=; b=jX01lWX3yFK3QBsd
	L11wmoR0sLo16up3YONxLEHLJk2fQa8+O3fwOBkgB+dmzXIWC4E1F/EnEjOf6Pyk
	OwOSeGz3EvSWgknLzrr+rG9KJo4HIvZloVqTT6wDcqTQHGbUDTsgHJopNddxjtzU
	faOtMzyWbz5okd4Ra+b/IFTL2RXtUPduPNsANfSOHjVAoZf3bKDHODF1haHbpmuG
	6Rm3fMF3SGo9IIUJUCb7QDejdTHI3KBUfZzwNIehxvs4hLLHji9AcKfCM9WyFus/
	Ac7IWRkCfS4o45LxpNfVFPA3oEDdHuK2XrLeiwzsasYQMhtxZOEt/pNGNGg89CmY
	Bi61pw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6pgt490-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b4058909so205989385a.3
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078496; x=1769683296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYe3a+X8RQV757haNblqDrC0UCkSImr/La6BxbOeCBI=;
        b=KSlQgOKB1ReCIV6JrVt56GVhm4w5KqkhhN9wAC0VuuXSz3Jwz1ir7xmJfvCKRLKCKC
         n54owv/sUR9lwvTGZeclWHhus7JugkSSx3IaFazMW8kXIgZwgintOLx6a7L+d+vHQZx6
         WBQxKa1LlIKF56LAx0hB3lO1V5zK7f+YfMX8ocnc2QkAOxqLEvhMpccPj7+810E2iftP
         kHTPtiqgb7a3VSv+9evaOM2+TbDWr13q2W9QHoGsXplTwoVFoqhugEk5kvJyyk7g+Afs
         /D/2feS2xpICl1CG+OAufy/Ss3oRR/1fLXf9DCb5GTClmgw3kHGdFHDtcet6/6sHfZ/F
         Q87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078496; x=1769683296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYe3a+X8RQV757haNblqDrC0UCkSImr/La6BxbOeCBI=;
        b=ICbZapHUNC0dlIsmfWude0GYs9zAezAcB1NtWyuCSZz/5gzP6GJqnCQvZGpQ2h3bK9
         aV+8KciiRy7LY3igGrSvtRCvtN15xR95Hk4D7l4KHx9aQFRtBMO9MQ1PkqmR+AOGpC6z
         Ia5MPqGnHp5Db5T6UeZVsiUBmi+n+C7PlItRvNn5Kuz2TkFs3T8OkUEI3dsKx+DpI42T
         +VG5wacY/vzoL0h23tB6mTC0Jg4G8Np0VCEKqpOzol1zy5RNNoC+UXox/mEWPx3RTyWn
         qWNT+1hl962wT3XRlnTgPtJKyagtr7NAJlSO+bIeh7Am3vyhBMUx9y9eKkFh8j1+SZWF
         Ficw==
X-Gm-Message-State: AOJu0YzoJGZLJGOCOeNtrmUOW/ExaVk4OJFulrbo7oaJ4keQnIDj8xyi
	fDGCvbfM38EVOZnnvDCjvHnm4P7UbPI9nAWDeejszvj4Trxh7CB+l7DLmNoxCPpEm2U6nlmFdkq
	Wq2aAmi+gn9f6Qbv1y1WzCeJci20OKpeBebqWA0AfsDUnrLLopd+jwk4zbMUvKNo=
X-Gm-Gg: AZuq6aIP8cPr1eXJJHmqzfbPp46jx+yScB5UIzv/yeR6i5ekl86qVgDB0IsvWtsgVdz
	jkNPvMUvFb6RRRjyaQr8XPf0BEwDrLjzAYKSf5TdBhjYGdlYOFXGKhwUDNAYlTf7EzpfGt9Xrla
	GPQqyinfi+VCDy7+Nxzcw/gw5hSvfO/E1VQqngnguOrREK5qUK7hAAGLJPoGBdV7uor/LP+9aFf
	wkUIqvDO4seY0kqHb21uVH02IrBA783g+Mg7lnTrLRCxA9aghvjEzB1bZk2BR3+O+1CJcSncsQh
	fcY7SRpVu0sn4IWTo/UfJIcitOyas3BL23Pgdn6X8IPQ+oHQpg8RwS12nxKsPyqrjPF2bipzitl
	tPim1O5AuIo5HGq4/M3PdTNUNgQOs5KOEJ00o2JPnPY/N6hXnzK23bKpCxaPndncCvHg1Nyygfs
	b/
X-Received: by 2002:a05:620a:288b:b0:8b5:1b5:cafc with SMTP id af79cd13be357-8c6a6709b67mr3080298485a.36.1769078495766;
        Thu, 22 Jan 2026 02:41:35 -0800 (PST)
X-Received: by 2002:a05:620a:288b:b0:8b5:1b5:cafc with SMTP id af79cd13be357-8c6a6709b67mr3080294885a.36.1769078495346;
        Thu, 22 Jan 2026 02:41:35 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7260229sm1387868685a.42.2026.01.22.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:41:34 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:40:49 +0800
Subject: [PATCH v4 4/5] arm64: dts: qcom: talos: Add camera MCLK pinctrl
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v4-4-a908d49892e7@oss.qualcomm.com>
References: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078453; l=1538;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=urisQog5JZfbdirBxu5tGAO+ASUUaW9dPoY/c9Nj33A=;
 b=I7z9k27YrP0G4lQE7jSsHQaqMCmfAdS0JW5oaDyYtJTvk5+UcdXrfI7CMFvOcIoB4Bt41Vodq
 tUrvYBEyWVUDgr/FFrVxfAuANQayW2RNkejOcM6nSJ3Mw1e+f1Ux8fA
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NiBTYWx0ZWRfXy95HBRPhmfYx
 4cuJfih1Z/uJazV1H8Hr55pwQLH0vwMmDC95EiJIdc6Sxi6VcIPx1mCa3fQBphcjKEedwqgRbGX
 xBKblcBeWyZQIXX4nOytlHxP5cxNOSAJ/lsGlQnHj5pQPXo/JGj0xMZL7gNlI2ubCL4PZCZWYwi
 E/stJG/1SSPEk16poeziuMdxgFUymZRbIamSj3oqHY8G3Fm6/Zh35jVOLj2teCZhgbRvBC71B4+
 WePC89d2HMzYYFblmIFWujyV8BuDHYqgg21FGJtrmNUpnhPyCGSs91fJpa3G3j8FV95AOrJyG4Q
 oRu2f9MVASp0oJ5GhKY4/TXSEsaeHiuDumPWpfl7N9+c85/VYo2hCFuy2XmJdvMKpJzrUptKRUs
 6N7DK7CLq2QuankZPgfpbXV7O/vls6vr132dSYzP0M9eBbx3KddH5n+Xo5awBoK/PSGjKordEBh
 xWVpD0a5c4qOaR81l0w==
X-Authority-Analysis: v=2.4 cv=OZGVzxTY c=1 sm=1 tr=0 ts=6971fee1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=butnsgrUGOw-u3YEFNkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: leq07_q4pWFdLraUyXuS1J-A0R3fDtQM
X-Proofpoint-GUID: leq07_q4pWFdLraUyXuS1J-A0R3fDtQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220076

Define pinctrl definitions to enable camera master clocks on Talos.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 6d28096e50546855bd762e479b66ed6214ec5d65..33897994d0ca8a193acfbc94a932551a09c712ce 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1553,6 +1553,34 @@ tlmm: pinctrl@3100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
+			cam0_default: cam0-default-state {
+				pins = "gpio28";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam1_default: cam1-default-state {
+				pins = "gpio29";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam2_default: cam2-default-state {
+				pins = "gpio30";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam3_default: cam3-default-state {
+				pins = "gpio31";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			cci_i2c0_default: cci-i2c0-default-state {
 				/* SDA, SCL */
 				pins = "gpio32", "gpio33";

-- 
2.34.1

