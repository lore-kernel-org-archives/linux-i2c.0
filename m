Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F044734C0
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938001; cv=none; b=Me8hzOGSp6wK/emrNGH6lo6aVxjapG19cVLSKuL1BP/TFJN7cIzaqTYA9NixVaqHu8jcXWIawZpSiybaW8cWMTempy5Quy8wWAaFVjozqadSWhUuw3w9mqZYrwFIjmitl3/2fbpZ4nSy5BluVQBYNifrembrnu8Zfdms+/FXgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938001; c=relaxed/simple;
	bh=AQmvJX6Nuci3e5n5qvrcudWGnYySqxNcGkS/kJegtyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnGoe5xBUYA9MqUzgKJ8MLdElslW/p07wdBvhf2XWB5xXIzMh+l2Qde8ibxDeCzG48Z4wabDp8yUDGke3HAndZnUPvRW/LmfB2+qdfvLTrgUDHY7BRboaKkjiV9EojAQhJl/bLiPs14Tyq7MNiBelckg+gnN5Pl4mHr4VWsLLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6OQI39G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XwhpekJG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6OQI39G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XwhpekJG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Bvtum3124681
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 13:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WghKy2QgIFqNw57MRraz0/pbpdCWerjS4CjNHDDJT8Q=; b=D6OQI39Gs72VHY3B
	OUprlOdCdsBJPlPvLVqPnNxYfKGs68oaiT3NvSiusDpDVfBlzoC/hpQ7wcdeDbgQ
	sToq0pu/q2b5o+8xUNGYb4kdkw9A/J14b6xZnnfpUJu2XpWpAiVZrCra0wKWBuHl
	E3agT+ZrPgO7vRlUmqqkPaXFNG0SgRUAhlcKXVMgHfxXktrAjss0Pr/od8CVuD37
	gV+6JFRJsSb8zhkAkp12dvgHZJSBAf5sgiWhHp7kuJn9Y0kepoxjs20Sq7SwBXHC
	JRaYwuA+P5YGFJhLfs1+206qkhrnVkpvSMUvQ2wCaWu+sTZYUXPLu7Gn5mwx+lLk
	B0DRYw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14w9hnv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 13:53:18 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e6ae12b42so14159097b3.0
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785937998; x=1786542798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WghKy2QgIFqNw57MRraz0/pbpdCWerjS4CjNHDDJT8Q=;
        b=XwhpekJGNp3dKEySmKL6nZOhlcguE2oxpWwm/KyhVaPuhfuwQ862bkGKlkas6u37j9
         q4mVrEi/cHnnhJ+l4Qy9uk1hcLNUbFTAYsWZ/Z+iD6egUwMZJReBKxj3YxWvCLbQFQ1v
         t+Vle+j6+mVpwDpuHzAFie/e1Y7OnPycq5I/0cBa+rref27wKNBUR/vrZsMyvinaeMUi
         Oan4x9aUM0i38fk439zUCR8gI2nq5JbA8lStL3lzRKC+16CJVkHiXTa2VyZ1ngVgAEys
         kBQXqQJoAd/YZOuqyiVRc4EZo4BFwYtpLMm7j5ntXAPORc5HtgTGz9MrS9VPXUqRxrFE
         V1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785937998; x=1786542798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WghKy2QgIFqNw57MRraz0/pbpdCWerjS4CjNHDDJT8Q=;
        b=hfL099/+7snm6xf/U5VUBO8Og28NdjTVfKHImc9VX7S70tNVevGiePynpbys1Lrpsz
         YMjBnbbiQxdfVPClyoOzlWbWnOP43cRBG2HHuhD8NpU5VRqD7y1JlH/PVzZ+z+OARAe5
         mGh4NkUBgGqWns7jzaqALaoh4MbOCPaCOENXbDthvJHg+mXeu+YhqmKw7zG6cB3YOSFx
         aMHfIcloIcfFc+3wiAizjy4ZczjhTAAL+SmRkTCCr86dDel0a3fINn5FtykAieqTDUKp
         JjHB3+jzbVlihemZpP56vCeCQnX+BUm3jG+hKiw4RQCC9KAJWs0Vq7XnX97C9uHx6E4N
         d9XQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro927uViD2pVMDVbD8bal1T2LNtwrO8jtzdmvqxCtu3VmgzfR0JTANwFHv++7yAjJBnaOD7gF7GCqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAW1L1nG9I3045k75Rx2kCh+cyfwi0+5Wcv5gbogJshxw6TGRG
	U86GUPEW7KvznqMze+7e8XOlpwG4t2y/jmJZSEBBgEEqe9OnG14y6xsiJ5ohkM9gX+4vNIHii/S
	mNZF3P09V9RBEh/Q2rI9qAYXZLv2uR0MppFriFFB3H3crB4OAr2UemDczltxwePc=
X-Gm-Gg: AR+sD10oeBUGV1Fy7z7dhTB/Afo+3u5mZMFX+kpWrI9EEwN39uEcI5iMuuTxgKNhTNq
	KVhSO05DmXGpGGHPlosBesFuE7DxcaNgErbv0pB7JmK68JgocN2yyXB35uvLSmLAVTW9aGJTEcW
	/lLN6a1zAXH8GF/Nt0m9kpcCmCzRGjZ/VktmnHnCgFx5pH00hd91RYVprXmFKj722lqlq+/fTdy
	DWCgHBu/mSFZzsPXTr+CqQE8vsWQZ7eqTdNyIOmDX4sRN01neZxQQl2VE+mO/osq1F85KfKPsIB
	ZELRwYAdpXgOR3i+p3rYPVZ5wbQMKwLaQS43VFrTY351cObGAHN3z6CwocolrE6WVMzXWbUO3iv
	m2l1l8j/D6vpLbKLMvQTet1p0jTZZZlU=
X-Received: by 2002:a05:690c:23c1:b0:81f:b410:b214 with SMTP id 00721157ae682-820224e0f36mr36672337b3.27.1785937997895;
        Wed, 05 Aug 2026 06:53:17 -0700 (PDT)
X-Received: by 2002:a05:690c:23c1:b0:81f:b410:b214 with SMTP id 00721157ae682-820224e0f36mr36671977b3.27.1785937997363;
        Wed, 05 Aug 2026 06:53:17 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201320ec71sm20892517b3.12.2026.08.05.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:53:17 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 19:22:47 +0530
Subject: [PATCH RESEND v6 2/5] arm64: dts: qcom: shikra: Add CCI
 definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-shikra-camss-review-v6-2-a8dbc66f0d87@oss.qualcomm.com>
References: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
In-Reply-To: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785937970; l=2668;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=AQmvJX6Nuci3e5n5qvrcudWGnYySqxNcGkS/kJegtyo=;
 b=a/wikjRFPxGG3nl4SJTiUqzc0Ku7M1qEAnrloJHSLS5eLVpA+ur2kXi9sKevQB5LgmLo3IcQk
 IEKoapUU/R+Cwo/07PwujCGvGWLTLFulI1t2tV2DnYjF7zRfvsilRUD
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX+wPjA5iY1afS
 CfKHSdMeU9ZNHSPXrzY9H8fXtjsBgBdCpG5O7cQvXPT1mVcDQK+koJwoNE+izoONnBwEfIRWZgy
 xfmnTnleFSTHXIVPy1h/nOXxV+sPjyk=
X-Proofpoint-ORIG-GUID: 0mXYMJHzKyHBmB9gWgrnwl7hhNzIOpyO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX6EVTrXwCnaF/
 1X2SNbtBePHKd2Md7rTzniu8JFP4E4yrp/EgA6xm1F55YPQbux7H5mdki32JYdljNQWRXJCpdJC
 ivDOSap/bLu2cXTVQD5CWZTBJo4/exkfmsUmlQ5cFUgdQItdwr7bRKkAnkD/b5HJvvU7sgzWSzv
 e7zRAty4IPkJrLd4uqwrpAd9mGWF7jsJIvYmpXSOMpfBq+fuEX3bTj2Gxl3zg3wG/mJzVm+n5vb
 /lfF+G0Hm9PuekWk0tZLBDepyusjwADi1f13YmbbRbfvePJaNcfyRM2shTG8ql1Q7wvMS0Kob4V
 ufNR6oTR3E56WeUidHg53+egfGmhRZcEab02Tmxqqi+E9/MpLTPDycVgjhasT/OZw38lGXnIygj
 aal43EMzHHxjfqVXyXocekVeQVIVLLxJaO+zrLqzL2QxkBy8LavsKKuLwq+okfEmGkXSKoCUcMs
 BE61NE43CJoy80yIG3w==
X-Proofpoint-GUID: 0mXYMJHzKyHBmB9gWgrnwl7hhNzIOpyO
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a73404e cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZbC1Des45MQyGPwI-hwA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050112

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2e5976861253f4402c75509f52301c21e3864d1e..ddfcfb137bb29439ce20ba6ebf3a76693792b56c 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -355,6 +355,38 @@ qup_uart0_default: qup-uart0-default-state {
 				bias-disable;
 			};
 
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
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -738,6 +770,44 @@ port@1 {
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
 
 		sram@c11e000 {

-- 
2.34.1

