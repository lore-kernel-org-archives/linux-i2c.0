Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1A405C2A
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815622; cv=none; b=bEDDSo5FZjkzFxDNJ/iisYA1wrZBkMAMLuTyeXPSWsdLbo35pwP5P+8t6Ffaqa/Ljwmira+RQhb2fx0RBbwBK87boMzgEx7wyyR/DbLwPCiEngihNQy6Nx+MJgHUL1/MtWk1jPBSsGBsT16VHBcenyJX7nncwssL73xQwBHcdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815622; c=relaxed/simple;
	bh=sB1CH5fqfkvydQKUGQkQAAWvvAtcksY1vgaxmjxAO3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7LJpU2useiN6kB6W0U+epL+OnTMflRHtdnRkLyDDrj9Fj5938HAEaSIyokhwgrOQaJeGCv8n3KKDWaWmxEU+NMrvS9fMWi5qIA4tt1rzM9/31+evMx2uiw6UUI7qcUsVAwDO05C22vmKzAwCTT9zhwjaOvUNvLdBI9iH+WOCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ie5Ycloo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eG+ZT9H6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ie5Ycloo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eG+ZT9H6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH0x9D2022481
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXVCch3h5O4NtbeND/2vo6i4hR0XUpgBJAmZ8skfrzA=; b=Ie5YclooSa+2jjm+
	azDNWrWUux0GlIlJQMFIR2ueQrGqWRhIVaTDWjADBXdx99tdFq7EK5gZlUDT0BJd
	kehYR9JUwXNRi3S79lpV9uG06MSYShkJDdW789uCs4ew8ltvPxf+CK/H47GWR/UD
	gybrQBqbJVJtCGnLlUvA2muzqFi1nzrGAY4zuSrM40cXmqQ1EgkbIrd1y7s0b6a1
	6AkIIq3G+JjnpCT3TD4WEt93mNQsHvzDw5bjovGiAOaBdXvT9rtBFexVWCSXUyKZ
	gg0M+HnEDegjbsDorfS3H1ieWPWjyV7woA45JLja91RCii46p1L5j4JOw2J/vm1z
	8ePCrA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edefugf87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-841d02525b5so381042b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815614; x=1780420414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXVCch3h5O4NtbeND/2vo6i4hR0XUpgBJAmZ8skfrzA=;
        b=eG+ZT9H6PrJ/jpp+8xV9jSdefK4vBY2YBFsUlZ7Gz0q3YyIsCPVEByEljBbIMbT81o
         KRSjHTig14YLtWGQzC9BNLStVc4TL3RCoMOIxtqqp48cB8evcaJykxnBGhmGzr7MHQCc
         vCoQnHanUYc+p2mkA+BqH4I0WlAU34SYBaVhzTVRtiaXtl32JHOjzW5lhzOENZncJ+R9
         fQNVc79FDj1bMDC+B/AbtyOz+WxlXfOx0W6aTD2L8P7ZiU74qH2+/GMIfgSoPEjQAZWz
         Zc+b/ydjX7hOwIdJNv2SAZ9vao1kl0h/P7aw3z016DeUIFs4B+7CSZl2RcT+VuxKhU4w
         2+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815614; x=1780420414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXVCch3h5O4NtbeND/2vo6i4hR0XUpgBJAmZ8skfrzA=;
        b=BbZpdjMRNkrP+gjZRlDrRDXWWz3yA6p3k6WPd0zjkHnA1msWYmPHUiSNj6WWaDKIEl
         10UexvtW3mTJVq8ohWHbH2olz9goOjZ1icR5zSzlRRaFBaVwJM55CsuSh3X+Kty9hNNy
         c7xzlS1N9748ddFQW7fFWIqxwj5ldcjQk7j209G3R5UZAiufNvlirtqiJ9psw2bpMuWm
         6taIP2CnN8A3iWNmmNXecaefrh+Zw04p2KuYNEoozep21ygidfqdMPBJdywapUjdOxi0
         JQVTEp1WpzvnvNkdJ+//uKdUcTwQs+jCg99ViRNQIxK6tn0QJE6C88KZRQs8Zs2BezHt
         8SIA==
X-Forwarded-Encrypted: i=1; AFNElJ+/+xbWV/VAjEkyR8XV4txNy1SF234Z3+9rJBDqZQmxit+7W5GGIT9M/uaYe4427gyAEsHqUpZDF2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPt3/MCEluKqEBWSL2KRQ1x+trdTFo7mEm79fFx8adwLzc7msK
	40xLgx1+LDiukSlHN4HFc0Am7I/9LhS/BIr9Z+ZNHaXooYgVHY7tHaiuM3xTfajrKeYVke0oYJe
	HoSJ6H7jcvFXX3HH/ahUCZ13nu1QnppfQEY/QmylyLxNQPu87iB5bhDtULCAFiZw=
X-Gm-Gg: Acq92OFmwdnXKFBPbkbo8d0XpahHx96vSbzG0dB8sUhk+VglJ9n+CjKzONcBrV33pUR
	O0JuR8hTOkWG8l1EqEHbVcVyIHyNYwu+Wok1lXAKpEdufGJ5z6SQGBezJ8/NLfeNb1C8mFG7xM0
	O7liV00UBEH4NiCAUwPtAcPvJRweF5j4Ck59LQ9gvPnuRm5LI5wQTo1pRtmdywZFEGVBZ5iVGHd
	I2ISD27NKHGc56npSfX0Wjdoo56txyNhNKGFL6NtoxaFWtwDvgQKIIQSi076a2kD5Ju/7Kc0L3L
	1hKvmTF0svmraUBgaSkFudshYPwfuJlo8E43GXcG5CGNn7FiDgTmr/CnGAdI1gMhePT0wDurbYu
	RSLvUR3n/o8nZ7X6KP6sVHk6dFbHjJ+LQznToi4q5MEpFUvbHcvxU
X-Received: by 2002:a05:6a00:ac8a:b0:82f:280a:d888 with SMTP id d2e1a72fcca58-8415f158babmr19801932b3a.12.1779815614352;
        Tue, 26 May 2026 10:13:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac8a:b0:82f:280a:d888 with SMTP id d2e1a72fcca58-8415f158babmr19801887b3a.12.1779815613876;
        Tue, 26 May 2026 10:13:33 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:13:33 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 26 May 2026 22:42:49 +0530
Subject: [PATCH 5/8] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra-camss-review-v1-5-645d2c8c75a7@qti.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfX4+KfBi+BUlFg
 TJGdRWGP40k9msAlgOoYV2lrnFkXjtUsJjKO2sCffWAaWxWNbLNzBIosYMnoxbafn2eYhTS7HZJ
 hFmCy8Yuo4ztqSML3sQYXXCdkgVJqAGo/XhlZMJwdK1hDQnz+54H5H3vcd1lAyERlBqeRVmWWq2
 OuL4ElglDFkDl2JCABu3MBrZYi8WtpxFkknaG3/dVDIL0R7zyG4RL9Gg5hqKQ4Nu0xDhkMAYraL
 TaUtTAD1ew/V/KIMYY/lJ0Ui9LbZfqnTcKUoRCzUFRaJc4SNVTrqAfaEZ08fLSxYnattl3ZxP5J
 vqPZo68LvNcEcLjxL1dD12LvNbsB87VtN6NOtXCKe4XgP5AU0ZCTxRgTYGfnaARZsXaikApA3WC
 r+KnDX+PPmtif40dzJ6NCGE1noCd+pmQMBr+2k1SSRRE2y8TH+J+9B5GFpo0Hm4XhKlXJbxydzm
 8Y+aXybuirs5RwLFYjA==
X-Proofpoint-GUID: 1JQXtOlBKUEzss1eA3CLFSNbATYbtQtK
X-Proofpoint-ORIG-GUID: 1JQXtOlBKUEzss1eA3CLFSNbATYbtQtK
X-Authority-Analysis: v=2.4 cv=cPnQdFeN c=1 sm=1 tr=0 ts=6a15d4bf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XuEftVTFR-VjiOTT8WQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260149

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 6c47cf2a7ef26b4bb7d7f642a240b435cf5208d8..46de35971f629ded990827ebd76134e652758ce3 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -348,6 +348,38 @@ tlmm: pinctrl@500000 {
 			gpio-ranges = <&tlmm 0 0 165>;
 			wakeup-parent = <&mpm>;
 
+			cci_i2c0_default: cci-i2c0-default-state {
+				/* SDA, SCL */
+				pins = "gpio36", "gpio37";
+				function = "cci_i2c0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci_i2c0_sleep: cci-i2c0-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio36", "gpio37";
+				function = "cci_i2c0";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cci_i2c1_default: cci-i2c1-default-state {
+				/* SDA, SCL */
+				pins = "gpio41", "gpio42";
+				function = "cci_i2c1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci_i2c1_sleep: cci-i2c1-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio41", "gpio42";
+				function = "cci_i2c1";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup0_se0";
@@ -701,6 +733,44 @@ port@1 {
 					reg = <1>;
 				};
 			};
+
+		};
+
+		cci: cci@5c1b000 {
+			compatible = "qcom,shikra-cci", "qcom,msm8996-cci";
+			reg = <0x0 0x05c1b000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 206 IRQ_TYPE_EDGE_RISING 0>;
+
+			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
+				 <&gcc GCC_CAMSS_CCI_0_CLK>;
+			clock-names = "ahb",
+				      "cci";
+
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;
+
+			pinctrl-0 = <&cci_i2c0_default &cci_i2c1_default>;
+			pinctrl-1 = <&cci_i2c0_sleep &cci_i2c1_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		qupv3_0: geniqup@4ac0000 {

-- 
2.34.1

