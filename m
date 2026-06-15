Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945B3BB100
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507592; cv=none; b=cfE9CB1En3dJVMMhMLOpmfIJzZFEtRZ7r1TcO4lBAfEbNIOdKh1QvZIKDEzxGkA028Gcxa/9rHJcfjtcWS8FUS9ViP0yjL0oM/0h7HksFycoDVKqHdSH3T8S5UI0P5KKBguJDzUzbJOgVDjZyadSOfJpcZfGwBa8gopHd+opZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507592; c=relaxed/simple;
	bh=QUAOHVDW4Udars0Jbe5wX7sJIZNINY1ZT2YyhfvvXAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0O8djCMx1bG/m0ZgKX3KHMJJpmgaPdjQJvlOyKz2/m2IfBLD01I2w09LK5M5+o3iYq4KDEpJWHO6I4ODvnz7qFH6DF5w0baKlS6jLSWFs7D1QQfM0OSo+X60Uv3Do+dIswbzaR8oPQK1kz0Iuon4Ybxj5K1qUi7kTejbs3+WcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mpaDXtKR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hc0QPxNf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mpaDXtKR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hc0QPxNf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6L2oZ3828244
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	au/dR6Wd3jTT560wWLDqtcWcjYZ7Z3B9jdL0VywUhbM=; b=mpaDXtKRhMK7OYTP
	RwOaN5Doek4boMEUJmviyJ9rMmt7btz0zrYzJy8L9NEfcTj7E9l9UPe0iZx8W1Ph
	shR/llTRbdUUZfpzCWfdAmk5oOiKSHs/M2gXSJlA+CsoFydSx6jm+pm5eNkRpbmD
	hLDwhBXjIweJKIfRzLip2z6YmhHfnDvtl9oMva4yQLMCt7zkOSy01muoc1jWxhEY
	CwelikNIKaRIns3MqeYpmUFFcR5rtcR+XhHIDHr7juGcgTsf0bgM4W2Z/zJlwZ3E
	48S10s45ofrJGIEdWgMzylGutOXWqXA/KN4fZwet4mFxwtjMdNBKfL2M9K5bKtYB
	liJPGg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u64ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b54cf2so2312732a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 00:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781507589; x=1782112389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au/dR6Wd3jTT560wWLDqtcWcjYZ7Z3B9jdL0VywUhbM=;
        b=hc0QPxNfs2QQm3ze6jbxdrRYeSeCX2AOMIYZ7fTLR7wwQgIXhbtwzh1y5p93tq6hBm
         5pCvQc9qORadyhFaBrdc/1fkJEy3D+F19PGj2GdMCeECon26UTS28XO9TWMQ5fNfQLdM
         ZAVhyvXbyHdQYnlpuexCs7yICBfrP2WziE6bLI2biNeb2lxK+auANABUB9aPu+ngq3OC
         3JHC0uEEJRYzSNefttOSHpU/tWewEoKxqw7iux11EToqiNMODiOm3QGMCqG1r1YGb64l
         NnUXuZYNptNcdX/fzcdC8Rp8a2hxGxKJiCIFiX14csOO5cCUa+R7/42OSdiej7rZy/j0
         e7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507589; x=1782112389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=au/dR6Wd3jTT560wWLDqtcWcjYZ7Z3B9jdL0VywUhbM=;
        b=rh9Zyat1DCkGp/2ErZPSTT0/khgq7ZF9+TZ/nyREffBPAHOFujV9DJLyJ4+W67HLrw
         gFxbJfc1Gef/VuKK3M63i7vWvo21GZjVq0v0P5sOQT0kj4JpsY3kgt2YOUGpdb9SLW58
         b46d1aqH1kjJQ2MAqOkhGsKoLL1AmrkINhRmtOFlYUA+oWUaELWhaaCQKsaSfTs8LRsl
         /LXOjJnanN1bghDEBN4gc7Oku+lfU/qC8E1OmbB8dUqMYwkamO5eGFeUY86jutjsS5u5
         LLkSeaJNzUgkqDU0aNpLW2x8lITJ0zTL26AaUIjOE8+80n59w1OBfHhrEMEyoCCBSmDg
         NCyA==
X-Forwarded-Encrypted: i=1; AFNElJ8M26ado6EguFnW/7222eQfmGNB+A2QUo7+BIFcwIzdKYFBjSOFX58uK3jOmWjeUil0OmHMYCy98P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOb9s/6qzHK46SOhBLV2kDTuu6qNVCj/nDI/7aNN4ZovCpr91w
	JgbS2zjxItNMXSO4hnpkPPFnTiTeLHA35//znxTBqqwaYj3LjVd24t1vSelTpA+DkXKSBZBuUbE
	am25fxxaPimI3l4X5UX2ieJdvtLVZoG/umzrLs8PGdHXuYQTJwiBPW6rvwiUu/Sc=
X-Gm-Gg: Acq92OHy8h8K3qU62hf7UjgicnA7HN4mi/vDFgtWMhkydmxhFTTgpNTQPYtAuulVRZt
	YA2z4S4Qo6DnAKpvTe9ZleGyILuvuRlK9IulUPOMv/aDLbCZdLJulMV/otrEe2ATyhktLviWmRB
	P+skF0XFgQ31G54/D+BNEpqbqNb8mA00jqzhFuv2dgL3gGcmuYC6tNcO+Zz10oPJvUJ8eNeAfY4
	HCAHv2W9towUxWthf+D2iacU2q/VLfpwvqjg4KxtkkZFh3v+57S1Lm53UpeDv6JKvf2Ww1YqOib
	trzDJCteJdvCMtADFTG6HJbt0AYDnrBMH++rrgc748iLgQGDzMgZ6xnXzx3pI/pD/IHtmcYzVAR
	34C6qmdTVHcxv9FQLNnh2MILJXF8Ay/qtCHaqMH4CFtXc93tKMaMt
X-Received: by 2002:a17:90b:3fcd:b0:36b:b06c:30a1 with SMTP id 98e67ed59e1d1-37c2bc42814mr9470963a91.1.1781507589233;
        Mon, 15 Jun 2026 00:13:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcd:b0:36b:b06c:30a1 with SMTP id 98e67ed59e1d1-37c2bc42814mr9470940a91.1.1781507588775;
        Mon, 15 Jun 2026 00:13:08 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm14867474a91.16.2026.06.15.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:13:07 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:42:15 +0530
Subject: [PATCH v3 4/6] arm64: dts: qcom: shikra: Add pin configuration for
 mclks
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v3-4-8183481f48d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781507551; l=1517;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=QUAOHVDW4Udars0Jbe5wX7sJIZNINY1ZT2YyhfvvXAY=;
 b=BUXma6q9Gyn2swW58JKf5dAcZV8fecETY7r8PGWQEBejEnOm6JzM24v7xnDk/1CRwSH5xQIw8
 Kyn9H8F/NuJA3m0GP83IuA5KK6byXRSK8tcHmhsiOsKBH1ngD0WjUAW
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fa606 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hvkXKTiNP6R-ltmIA9UA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YHPrUbkbgHER_YYafXUcte_1_OFuThaL
X-Proofpoint-ORIG-GUID: YHPrUbkbgHER_YYafXUcte_1_OFuThaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX4rzZavcyeuj1
 iGFhf9wOBdPOP/Bbt9JPfCQHp/wg2d8HburFQvuSIKVtm+DP5820kivmusBNBn6DcHVkmUJyqYs
 nusTt5B0LZRmp1SpqMBw4y+ebnjJMlavzc3TKeqcqanNlb32sFcNICF4dsxg+pIoCEYpho6uVjk
 XUi1da6WscQ1dS4lZpE6FuHztC51gqFS2KbHDfKKW1tC/KXAzITnwjqU+GJczj31j+ysmKRD6u3
 orb96HJN8FVIp0YRe3CuVvhpfAAC/LuRlXynO5jD/MHp2oOkUS5KxjhqSyn9w2+pSUgFeFNdWuZ
 3rA3kc0J6MTKInUB+Sfs4nPMPemzGjA0mwK6fRSdp9uYDTEwTKyR5i6z2gGAgPZoaVIA/vvH47o
 7JULSQHuO42rAkYfFtDV/y91hAPSCqJXukosdjsiKpMnsayB3q2S9vmLmm1fcYB2Pbls6fgLTp5
 SrQSh0EDZKuElrlL7/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfXw6CpWIgxLxSE
 dBAS9gg05roQYGONLYg6EssgMNUR0VihZALcNdSfYVTipPIz1MSAXeBHHBWa+1E5fDEhesaR2qR
 lmmDN+j8v/nGuy7DZl6B7IBaB8D0gpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150073

Add pinctrl configuration for the four available camera master clocks.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 57732804a6c6a114a407a4a541a1cc7af7635ea2..16b547131e8b14541abc68ff7cda126ba777ad80 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -380,6 +380,34 @@ cci_i2c1_sleep: cci-i2c1-sleep-state {
 				bias-pull-down;
 			};
 
+			cam_mclk0_default: cam-mclk0-default-state {
+				pins = "gpio34";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk1_default: cam-mclk1-default-state {
+				pins = "gpio35";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk2_default: cam-mclk2-default-state {
+				pins = "gpio96";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk3_default: cam-mclk3-default-state {
+				pins = "gpio98";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup0_se0";

-- 
2.34.1

