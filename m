Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDA47276C
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016640; cv=none; b=f+AprVpndZNCB1EayAtHyOMFAxF0ENLtRc064xE6x735KplBk6lO/Zs0BCw/zHWEyNvOGAWnGrwum6EqwUUizCJc51YWDWcL35r7OqDExNQBwNx7NoGvDEG8261DXHlNBO8xI9ipKhi0eZM1xHpoo/BfCfosQ6FSM5Naj4Qx5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016640; c=relaxed/simple;
	bh=t1GOytGlrjx46BpmKSPUCNe+9RXHzC4jFU/9ZCxL4vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1X7pU7F3NTvrNbOKTW8fKjKwOqt8etLOueWRJz/1etpGisov6dV5KZOfi26BgGKYVCDN9vB3HqgPMJlJ1uZLBePGB6XAe8n6W/TlA23+/RbHTn2cNXP/H/oWTvYl4hbAgj9kLS2MRli/8vkoK2G8nALYZuvhqIzOib9GeDjjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EYhwgQa3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z5ewfbet; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYhwgQa3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z5ewfbet"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nsNg1876736
	for <linux-i2c@vger.kernel.org>; Thu, 6 Aug 2026 11:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1XBnMsGWKjNGQOFIdwFdqcIu0m+wHOCKXu4Zohj4qGU=; b=EYhwgQa3fefpSj30
	QJkcSd8c8fPjPfHp58opoMiN1ydp+V/Bcu/bZOFcsbv8kLRzXZzVAmJj1uD8mv/4
	e8TeWtAaQP71Xpo0ssqmAmAnW3sAMrrMS0mZrXDK11+tlulPOpb6lSHdMRWHXoLF
	FwEmO8JoY5kq0bMLedoCfkeO+wl4S7dmB2EyctJKicfyqCI78mke+FZyf/4BL2ra
	2HOv6O2XWmm6JoP3zh81TWaCEC1XEkmZxfVfXf0zI5MC12Om4zwS80QSgqPwbUD8
	TtXowvkEUDCKEZe9x927nnBMdZXU05L60fLE3JO0TIruXudMLaDTsVju/vfoKO+5
	FwSIIA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuchwbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 11:43:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so2244956a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786016636; x=1786621436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XBnMsGWKjNGQOFIdwFdqcIu0m+wHOCKXu4Zohj4qGU=;
        b=Z5ewfbetYLUNy4VDT+AQkcTQk33S2NTXltHd/LEpbsAQKKoCGncYeZnNF1nzFnrnlP
         Xw5cg5bhppOXp77Fu8h7u+m32zCZps7YfUkVyZ7y1Xhsr56fyL6ou8Vtd3rN3M9vZvpZ
         t4Ra+x/YSAxp0cxhauyCmsZma4DaZJ729uI6Q0GRrDCN+ICtJB2qJ+Uedo6xq8gKO0bB
         zafigPxbSD0uHHciaa99SXhgfGbA0xatVIC5E7hR49Q5uYYp30QPdVCjaKPwXJ9Omyln
         WRYC8lor2VAPDe1KatHC1s2+/cUODXa1YwBwgB0wsusZ4T0e+hQqenCom+7B1DEerViB
         WwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786016636; x=1786621436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1XBnMsGWKjNGQOFIdwFdqcIu0m+wHOCKXu4Zohj4qGU=;
        b=T5IwnSzy2Sv+HlN5oVGrHcYSp5N9H4Gp0VYepE5MknCpHo98uAVgTrphAlGoYWOlHn
         388WbHuNxXGh6N5u9LrO7AW6mT5YQBHz7RIjuaX9hiz4kdO8k5mUussKm5c3USkInfaQ
         BwyxXLmYS4PlRZ68m98exO2WMaHj5l5N8zvDIY4+eYCtYlAVFKyp6B7UPomj5gDL1RFI
         XpCxuwjcs72YKzUEJMwcukWk+gdz9hDaZKadAtT64fcJlGCwnvTyYwbKZcH918COfGKa
         k+qjf3e2aTL9FbO2P7njDmF8QTdQhdrJY/Xh60fJ+nmxiA9ofzlUt/byXiPVdOB62yKe
         4R/w==
X-Forwarded-Encrypted: i=1; AHgh+RoIAEsFes92dgy/VEz/FpoMJtLBVy4+qY/ybWByvOB9baw9dahYHVIm1g4fnJvB0pyYlwTuPpkRLlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qO/ggn/Z2E0KqtIUDg13dV6wDn6aNolp72Tt4NtCOEYJhEhU
	0kyykA/VahMNMHPSpCFeeR1tNj443IwsIkU+K6oLwQDcIDpCi51T3KhKFCJhGIcC9S0A1WN0unU
	QzZ9QgI+4+Q4USICodl5x+H7WFL0MAv5R5LBd5FN4IgjwSjOt7JI2wqdeICLCgFZiocQRmrc=
X-Gm-Gg: AR+sD11aaPnZndJw0bVyLG/g2Z/Nu27GSIRoz0Qecj1WoU4Tyh37jmzaGiIlA2M2tpi
	Y4ZvkuLcivEq3LwXH5AXAmyeF+9pFXYhHm3REjKAbWjc4WbdIQWovDFKPVLzbJR7F9Ss7VfAp7O
	SmFNW3KuPCqH6XdAu7rKJ5RDZ8TuHQDH8rA51KV7EHFOTc8M/ZHBIt8oxdWa2zn3GQJiVO1Jr4g
	lCOV4wwjLq5JUyJXXjSczD1rlwYOGtq0v2TpgeQ+ayW+15QygzX5eE5hb1FMig7uHq4uIMapHyh
	2rj/hBhA125FDtvqzTmKI/O4C+3vGuK9zC2QKQFGJiWMlQ5+z4yemtBPaBmEkB4Hcah7XWIZVUW
	UIHjD7VkeAEx7eTlwxyvvWp2B3oMSQ8U=
X-Received: by 2002:a05:6a00:3d54:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84f2e014151mr15403732b3a.3.1786016636267;
        Thu, 06 Aug 2026 04:43:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d54:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84f2e014151mr15403666b3a.3.1786016635829;
        Thu, 06 Aug 2026 04:43:55 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f456b75dcsm1234756b3a.34.2026.08.06.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:43:55 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 17:13:27 +0530
Subject: [PATCH v7 2/5] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-shikra-camss-review-v7-2-c7360fd6a5ac@oss.qualcomm.com>
References: <20260806-shikra-camss-review-v7-0-c7360fd6a5ac@oss.qualcomm.com>
In-Reply-To: <20260806-shikra-camss-review-v7-0-c7360fd6a5ac@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786016613; l=2744;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=t1GOytGlrjx46BpmKSPUCNe+9RXHzC4jFU/9ZCxL4vA=;
 b=e8CnOHS8QWYKfDGWYu/qcr4Wz+fMXb2gqJFFkrVdOi69ttdNf9MJhz2poqVYwooeMrsnRHH25
 rAI74hXEW4aBEtX+Q7ad0s5uv7WzLklzwRuftad3bNpYSLlF1920qbL
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MiBTYWx0ZWRfX0SGrftHp4Ei9
 QR6YTQtV5NqFV+glX/U8oBlaV5AJZwqb8ogHk1Go6dxZ7MhxpvceMpIikxqeh8KNizg/1Tfpy1E
 O6VwLAGRQvnlQAew62gCkPDd8gdspf4=
X-Proofpoint-GUID: nNci-HKIM8tMs4p25qgR8gpzWy_GZ4XD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MiBTYWx0ZWRfX+g9gARZTIFyE
 jHmvqMIvGd2Iz/h83zKjc2kKA1NkScLiYUCAX38RgQci7IJM4eemso2ToIo9qxzB92Ygl4wtQ1G
 j5UZaoi1DoWk9l4gBHXPlDihCDNziSGkjnLB9i/mDzg2D8b0IcQDyRjwchIJdHaIjvkyGtZ0Yg/
 uzcnLgifBDwz/dteERMW0UatlVVzFXgC3AHcVDw/X3tSm/OkDbEm4NIXVfNRksEBcdER1wy+TKf
 yB5G33ZmvfAICC6zH4WLanPWwLMuN5UjQrW1ywjUXWkPZe+Q5pl5Qs8PBIdWEOY7oliThfy6VDZ
 H8ghuDqSy7WonB0oeZnVhuS368GUh/aQIzCzzkYNp8fDKu3+9ntFAp24t6OXmBED82TSegfFOnB
 GY7dv3UHLwpG9gMjXiOUh60KJ6t9qOcxlupBmP7pxVoo/Rzv9SIhODo6xYlxEdc4zWMA5SWag1i
 /V1McVpzL2uf2X59bGQ==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a74737d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZbC1Des45MQyGPwI-hwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nNci-HKIM8tMs4p25qgR8gpzWy_GZ4XD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060092

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 44e1a333e97f1c88a672c77579fbe987d4285693..ce5887b9b1d4a186fe967779b9615ab4e4727ff8 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -795,6 +795,38 @@ qup_uart9_default: qup-uart9-default-state {
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
@@ -1928,6 +1960,43 @@ port@1 {
 			};
 		};
 
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
+		};
+
 		remoteproc_mpss: remoteproc@6080000 {
 			compatible = "qcom,shikra-mpss-pas";
 			reg = <0x0 0x06080000 0x0 0x100>;

-- 
2.34.1

