Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC533BBA1A
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507584; cv=none; b=filbmjPA+KSLI1wml2NblA6HfqCFBqJV5UkQWf7aK54kDPewABF2TLDxqe89mG7U3wVCW6KL7YV5DVk/xFizK/Ed9Pjxfyv7qwySi3ycBwBjwJyoj/xb9ndB3HVP/LB+cdMRgWeSXIT+z++7ye8eoLJAQcYE8NdUNXgFOgU31Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507584; c=relaxed/simple;
	bh=dD0P2j8Nr28ZbmLTZrfr3Iys+tRkC7smVwGCVx5OZpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCWYPQjwo9SBLKPogdcYypBsEdbw+hhqkaj0wpR2iNdd9AK5oZe45Z1ORulUIDCVhP4M0t17pKyY+wLV+KdP4CrpIzQBKW2fC+efZT34jWLCDuSba635gllQRmO/ksBr9VevW7D3N91Kbnq8KeFMoO6eXPPg4yqBYNtqVQ1af/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gV3FlwnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GbGWaDm9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gV3FlwnS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GbGWaDm9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6Kmo53911473
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+V1+Dvn3cDeatOqG+XJiqlXl0JvB6Pajl2d8bHbdmnE=; b=gV3FlwnS+mMU1ZWv
	NefsMOoZi0YvbHjNcmXp1y00j8ErfHcA+NDQ/FbqApJ0LQpSJjVRzVh8e1HDPquL
	OZHwWJ9/E6J31dvmgifx76e2BDyOtAwm+C9AWjujwPNfpN5+bZqgGId7JDZFfQao
	VYg3bDcoktnId+//Lc6vusY6XTiIkAc/6LB+bzry3tClfHU5Rawmg99XCIDrrAP4
	Rn6Swe0so34bQzfsMMvuIQWGFi5H2ND2gkZAFmpR5aDkSetiw9lBlNf1PpcLc7oV
	a0PT1JAKz+3Rs/2lOBPmzN3XN/Pk+pAnJf7Vse+killgJ54VQpl8ikNMwtqoTVmH
	C2pTfg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryc6x5v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b934a336eso2458039a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781507581; x=1782112381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+V1+Dvn3cDeatOqG+XJiqlXl0JvB6Pajl2d8bHbdmnE=;
        b=GbGWaDm9eK7wcCd3hthjSm9fG2k/JKN1Pbgfq//QlGLQTJsHQvXIih8e1cuIzuF9+1
         /683BKgPtMZaPuBAcDhtt6zqtqOUvmAUoNKO7UQVKRK2lU4dbVLZHCOq/ekQUcohaVUR
         CZX+7gRxiLuArfKa3eLMHB5hpvd9eRcjmRgi+6BRcsA88h2c2J0mS0FXIdyxXlfm8uH6
         x/dkUOBHvgTnlZftPYWX6AF8pE8q+QLRacdDQ84Bpep0Nms+1xCWd9f/TAU/1eEqGw/D
         RKlzSYE2BRG6dAy3mvZLgEIWVrmsHeObw/TJTCUNFDmURzojCLfTve8xlu7qSdtvWXR0
         O+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507581; x=1782112381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+V1+Dvn3cDeatOqG+XJiqlXl0JvB6Pajl2d8bHbdmnE=;
        b=EHZLsv4WJeneEBPdv/W8jmbnHiv4IykGJ8P7XtiFfRy8+7KR2xuFT1jqenSM1OLr2j
         GATFfV5zGh86eXeMfJNFn/pOWeAI/VUisUaZWqSiibkUY/fdphfFY9RX53MTIygah2cg
         nf2kWImJFrQaYjHjGXtHbDnBF17wP2+RLkVTykCHn0McfMsDA5ZyiE3i1YeSA0CnxM8C
         IMtExUx/gYUfo6tKOIDNxXt+6d/vZ/qvj/mdcBvnFfTlag4vmiKbbWVlc6gJZxzub6ud
         y1ECTZKGMa3RzcBVthwpe2e0ZXdoW2HWH/AoUw+zX8y+UZa7jiCclzidwSPNFk4ahleo
         HoqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yOUcDk2h5sskMuCPQ4ovbozMPE/xBNHyUeP4ABmTzScepUMLmgSeH+UbYUzov3qUacSJ98N/rLVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+Av4sQM3QkTvWUWGvrvhCfwT4sBNDXj4xq+3oM6BsEuZEinu
	Gp1xVY122X/Ox7ycCHDiKb1pYXGpIT8twX9Mitbq+HgrLQuukyc21EgHxWOB+ol7tvS7ZsGDK0V
	6SJWavmv/JPTGA7BhKGSed2fIPWBizRwkQO9rD4CVG5DRP9FJdSwaLWRI9JMzmoo=
X-Gm-Gg: Acq92OFHJlwo9hmd0vZY8AXxkd7CziB6u79iezFM/zJor09ljAQFkcIJgA5A8JX1M+p
	JoVXTystT0Im4IhHXyz5OFwxIZHsk3TMKlmdZhXnHrJFJdZ2QhupK7SpRsp5k0gkniIcNA6ZEK0
	ZBp8w5mQPZx9eoiBJGIMrp5Db8Vth4HBjPaopDyfrZ0nIUd3hOiEnRvDmP3dLr4RGNCVtSOCgFQ
	YDutqsSdNEqaVYcvIkLIa39gRoKd/A+y+Iw2z3do7aRN+4fA6+ewSx3uRHf4M6O18lT+Cvu+Lpf
	tXUWl0MnpXmLDnvzp8Qy2KV9EfFDxjZHoBaxHImjDgQNRAvRZ49zi8jYl1Wthu+666sgpfkl/RE
	CZa/sM9yT8pUVzBeLIU0eFS4ABHPjvBELuCIbIOc8c6VjfzoICMJ+
X-Received: by 2002:a17:90b:3fcd:b0:36b:91a3:6af3 with SMTP id 98e67ed59e1d1-37c2bc6534fmr9768849a91.7.1781507581226;
        Mon, 15 Jun 2026 00:13:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcd:b0:36b:91a3:6af3 with SMTP id 98e67ed59e1d1-37c2bc6534fmr9768837a91.7.1781507580798;
        Mon, 15 Jun 2026 00:13:00 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm14867474a91.16.2026.06.15.00.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:13:00 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:42:14 +0530
Subject: [PATCH v3 3/6] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v3-3-8183481f48d0@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781507551; l=2667;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=dD0P2j8Nr28ZbmLTZrfr3Iys+tRkC7smVwGCVx5OZpM=;
 b=MiksEv4dAsytiqn9yWeQj/J3Y6aswxj9dbZTN7SqEhZdVeiE76C0aTVUL4+2Glq3iaO6ojOUy
 YlvQyqQKU1MD6aGx2ZSjsRezHKfmluPRHuZvZS53PBxBi78BTr66Oqw
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX6m6IfGU6qk0m
 38790F5FBahvJqn6Rz6FpbQgueOIPgAGsFTzq8vwHtbdUMWRuS6rDQTMesoo8jD9C6uphU0pweH
 UEmsf0ndmkBVoQpCf6pyKyODZktlqlU=
X-Authority-Analysis: v=2.4 cv=Oop/DS/t c=1 sm=1 tr=0 ts=6a2fa5fe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=s9wsCz4ZXjtKvCKk99UA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GkFgtptYvJ32siMclKONLIbz6uaqhPia
X-Proofpoint-ORIG-GUID: GkFgtptYvJ32siMclKONLIbz6uaqhPia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX7Gyh0DkCAFua
 SzVYodAThu023gv7Quhe3MCo87TcteSr5q+Nzs1gppJ7BoZAwCwTkY3bEva8LsuBxeEqNW/UWa7
 +pKouC5JRz5LjNlmQbsrpN7vCpuXl5oJleHuwGrL+/TFSmrVDCQJ33mWNEkjk6Afmsfbl8Zm+lS
 WvnoJ4cgsrUUKmeem5UtQ919BG/GiEFWijMIXU4hfTjsQqQ8nDek5Y0f9Ugc5H822hIxigFV8ex
 29F3gLrKiSQSbwVIPDvEjY/0tkMgdCVJVzHse1KEz1qddVzPJS1jxuTde8mUxDrllAkvLxilL+x
 +Uy7jKLSNuav4iuGgNUfXr/GKVRK+z0Cn6Er5pKJ/gDxRQmQYrV13kjRmfEjjoYUCFksNlnR0tK
 OTEQJembe3G7Hp0AbjY28iPX7ROyAqSTP3g3mY44iIA5IQREtp6++nVIw/ot3hSOOSthonTHNxE
 OWk4Br0bP/1iupm9Cew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150073

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

