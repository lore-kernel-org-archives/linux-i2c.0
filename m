Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48E3D091E
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512479; cv=none; b=UAJS0Z/gSAhb32/4b47XPuQ9PH+WKnqkbDrbT75FNEhfiHz4Mw/q+n27ErwvmTvAETLnRmqIagVcjWU+eK8LMunH4TpZ/7hNYRYgm/OP1GFzOaWofjygsxEOKdyQ9EsD4hACNEtwJFBYZH+pM29KtD8vq/Bf0o9t5y8hMiGavEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512479; c=relaxed/simple;
	bh=dD0P2j8Nr28ZbmLTZrfr3Iys+tRkC7smVwGCVx5OZpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTX8nVqPNYRSl+6dUSt6jHdT7kTO/YnhzepmH4ng9xZds+pne0fTE9YjWH68er9EAG7Zol/kXNBzou7yZYQoQUnt3c2Ogc3eb5rbqqImgWurmIFXzwdsOx32/gX5L65Sb9hyfEb5aoxMvbs7akgFa8yvBp6kw5sM2HbTPTEzEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lv4pIcee; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Isv74LUR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lv4pIcee";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Isv74LUR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6L2343828244
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+V1+Dvn3cDeatOqG+XJiqlXl0JvB6Pajl2d8bHbdmnE=; b=lv4pIceeNxd5cu48
	UH8gJsf0WLoHM/FTmuj3jRY6xgDwa5DBOTmyukYf3a+eEBOMxwOePZsLFP/suSht
	jSSbgUKDZ8W77L3wahFrUb5CN0bJ/Ws4+cu8CIvvbJTwrIMqn2AOn42x/AEm5+Xr
	RcQmsxVHUy3iI87JvBlCvksPeJBFrcnnEwLpYmRFF+tE+2dJVuf2RyPu/18GjuFS
	XYJpkvcQW8Kv6Jq6dagOiPxAGBMw2gHLNtIhuHG65YfLoR9rCkKzIFvyc3DdprW9
	peGfGV45/U9qJM0oOIABgggJ2lhhBlYaXkRSPwVOaSSRS6onX4YZxeJyclubHUlZ
	TTZCNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6dvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso83960655ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781512470; x=1782117270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+V1+Dvn3cDeatOqG+XJiqlXl0JvB6Pajl2d8bHbdmnE=;
        b=Isv74LURe8/YRGzEijRXBTk57EEuPOZrxwyfWSUlWuxdrnkeN+/5aa6a7QFiBTEGPN
         wxAw5qa9MT2fsIE0/J+oT+oT5m6wNigWodh+L5iuPaHybOc5HWe/iOOIv4PfSlxnGquF
         WeAUHFpBB6sP2w+BITzvc4jp3zC/GgPgu5IcTz39zs5Ls/YUtJezHjgkeyjW0YA22+RQ
         jGB4rvr0FYgFGQpyDe/icwx2posIV+45tOhAbj9PN+qMTnIU0onUtnXcojZH2XSDB2Zf
         TpxkPHJOkBSJEzuqbYmK6i0VP4UqNBB9/5WMv13nAHogK0xglH27Q5CSGt1WFKVtRyZP
         s6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512470; x=1782117270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+V1+Dvn3cDeatOqG+XJiqlXl0JvB6Pajl2d8bHbdmnE=;
        b=s7kpJ6MzJvTz1n3SgU3DEEpQ/rEV//+1HcUpcWRN/l1pq8+rJJ+Yq2BGrlBB/ewMLi
         HrpzRkzSqx4gkGiCfKIwi66QKfkQY796pJ6HLjSlouDvPPQYpt7zKJdFoLEOTao7YkRB
         9tZxyfLa/bY7m+uyR+f0Bn+bIUCuJrRvbNvqykbYZx4yeyBlm4RX5RR18xJDgofv62dl
         YPQFG2z7/qnWbpgKkdm6JgVwY+1KPYQD5QLlBAQoE2PMiLDayL7QS7zzTSedpH0EIn4d
         bZ98MTkmsGry8yFSwDf0k6DjRNFvE/QesFRQGQKrQq5Nc0898jL7//ygu+ZfHLLJpEM9
         Vt7A==
X-Forwarded-Encrypted: i=1; AFNElJ+S9lMYRU5hQMjrE2tiuyr3Y5bkSsEaE1usVY+3zoYSFfMaEpMdBhF92hnaoCZOvidmktvBSLaH2uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvATf/0mKCOnJDJ8Z6h28bYsUfGLexyfpDTx/eD+OnUkFfdSl
	qGJlWjy2I0WG/t25w1C6Z5jIhuqgMxnzJJMS7cv917kHIwynwjL4ciT7hRbxHkDQ0Mert4M97he
	zeV19ksBvBt7fIs4EeHkgxA9B7eU+TSGSscrhD6VeXpMEK/IsqFQ8TqbkrDV/KoI=
X-Gm-Gg: Acq92OGpw83nVZ/haA/gFgeHkHGeMo6TWah9Ar2+klT12uYA5ikH7QBYqdxJ48tfxMd
	1worquGpgvUTVHK5QbXk1UctrhgpYr9wejmvFgb1jOgYXgkE2btQIa/d0GUz18kTcg9CdGQaaZF
	DegUtIBBSqKuR5tyXAZA9R9KjgiSQ+MTNqXHH5ZAazLVU1XZRJH4AF9CU0yPP3Z62YQXmkrJYY0
	sLEsrSf4wii8yK0kzNltdMgFtp1BSCJQbaQplYiRSuM3FsSwhJHHFknhks09iKRWN64qRnVEqlB
	ccYuKj0AX0dtfRW2lYGQV1I1PwmnYjYP+qAGtsIKoCSSb/vPEHcGVNf24wWZDBDlAlelcasGP0n
	tkWdfi5WNWgnPFpMh21oPOg9vADbIlxSpNEB1VPzQrOSvECrelHAO
X-Received: by 2002:a17:902:cf0b:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c4109ed1b4mr154920875ad.5.1781512469866;
        Mon, 15 Jun 2026 01:34:29 -0700 (PDT)
X-Received: by 2002:a17:902:cf0b:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c4109ed1b4mr154920495ad.5.1781512469458;
        Mon, 15 Jun 2026 01:34:29 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm122789235ad.25.2026.06.15.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:34:29 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:03:56 +0530
Subject: [PATCH v4 3/6] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v4-3-bcb51081735b@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781512439; l=2667;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=dD0P2j8Nr28ZbmLTZrfr3Iys+tRkC7smVwGCVx5OZpM=;
 b=Cniw94I/IeuLlJ+GNuZeIQ0xTcT3NSx88I3wNJU/KukWnT79nHfA3XKcm0P6UDN9oZD8m0CuH
 UxBW8/qf050ANTXNPa8VDLV6JEP4odbMobSTjgfvNB8SJRoaZWqpIQ2
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fb916 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=s9wsCz4ZXjtKvCKk99UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uORUQYwoY0EGV46k2EnmFWfu7J75L3dN
X-Proofpoint-ORIG-GUID: uORUQYwoY0EGV46k2EnmFWfu7J75L3dN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX1vcA+tSCS5sR
 /ab/icVq7+MIOmHbJxGwg0KVIq1k3lrASBwtYGydduQa3lCaMp+E5nmBspA9cwhCbLvM6B52GBn
 RcvdqK/7SMy04ExW6AUQQYaBFWtAmvQdPLZIT8hXBBhxx1ZD/1Mp8ntyWKhpHzyiZIXB0mw/NGw
 16qeIGzPqHDMBAYOCA+/mNIkw+G0Zbsu3V5LDDzZfs8ADCa70vU9IqVxYwWf+4hXfmKCfTM/Sb/
 Dt8k5cdIkzJrh0ING5nVCCIpQf96eg8KasWM/cfb7se/pnGo+Exe/aicuLSVxWO9VYDBf/ujwS6
 DEGsitn8xBqFotYnZefJFS3slXCA4GdFjKQ/hjDU1ZFhk8A9fRo4mosfzODih8S11R4615buQLA
 rKzbKQy/wtLVMr/CVya4OMqMrZHuYSa7/hNYZE1zXs5N4vrr8Ipi9ounyc0JLWQyCwUruvO8fwp
 fbScO+grDANAcO28nmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX6rCH5h/dCmyp
 3Gi48NRSYcMOl81lWlujleNzlYEXd0iENizawqMwObOLdMR8QtqHxwqpk8BV0hnhWoQIntzw/rl
 hMFmhsHfnnX+56motxikVqV5hbIaIzA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150089

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f0e827996609dab2c09834857a1bffd9560155a6..57732804a6c6a114a407a4a541a1cc7af7635ea2 100644
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
@@ -702,6 +734,44 @@ port@1 {
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

