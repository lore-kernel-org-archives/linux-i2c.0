Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779042123B
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161511; cv=none; b=YaXp5HHmgQDg6GXI3xmV5sj4Dyn1mPgiRaWpUy7R17bZJIGiIlSMp9Fu0dmZcZpGYiPZwdcc24uA0Eq8eIOx509v2cgYeEgdy5u0hChqw54Nyq4BdEbmBBszfuiihF1U0dDUbfIX2I4AL/trZfg/+zwxxlmGLju/1D+xpyRVSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161511; c=relaxed/simple;
	bh=npxXC/2A3nQUucjpT0p08dcGaxkVim326juc3Mpe3ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcOoHM4hPwTk9XuRCldTrROcnaB7p7qoknM588hTL0ESr5Gg0eocOcU77mVcAaKoJABxarD62odrOFj8uX2UyNnhMJ1Bd4pxvP5idMuZFTmpQgq0sI1Khwq4ONknDx3KZbcHTi2245C4gIovgEJY0bKWJ9SZBIVGOgFK2G8zdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4VripW4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z9reFQUX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4VripW4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z9reFQUX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2xPZ3409964
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dD+VmVixjFFrk3iHvh8FDxDS/komPYN3IGSBgS08bOY=; b=G4VripW4A6ljkhaC
	4C3PuwSs9z0k4I1GrfAA5khZt0Z8cjP2xuFP6AYGbrk1W6dTS3OBqnRyQ1uPzEgs
	3Hyi5ZFyxnGDj7GLPGNsjGZ2cWa6ehRpkOC3ut/DzLJBQjY/GmilDAf1goEdEV7r
	iIoracOj+DmuecE9F5H+tkQVR7qrEV+/S9vYGYiS3wA5VW1j8mtXbnM+OgOb3lBN
	ns/QlVouxNZkLmLftsEbnkb9klwMSBWDVYi9t/yO6Rl1dpLWCWwnX2aEDZtgMQsI
	831Aeso47xmUCQEwHaFFM0YtCbqsJWuXFaCHwiMIZZ4rMd7FjtSzA6bmkT3Dxs91
	pUSVXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux864186-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-331b2ec616fso2937622eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161502; x=1790766302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dD+VmVixjFFrk3iHvh8FDxDS/komPYN3IGSBgS08bOY=;
        b=Z9reFQUX6KrYwIwTvlZLa8Kf1P5PNZCWMTQptQ1T/zMwrYjyALxwInDYMqMhDw7Q06
         HP3PZSNoZvJfqHK1dXvFQY6OXOvJn1X741noQhFwopwjqmz0jr44UrS0pQnT/JSfWoP1
         Bg8LADLI8BvdczxisoaFoi5b/N/yvR7ByRfYT4KA6XcV7cP/C2LFb4U5gm5T7hzEh6yB
         MLyVFrUZUFn2FUlO5riRJFBeNcDE8nf/VvIz5bZDj+zm75hjuEvbddFhLSY8Q6vvO95a
         AlEwLyJTpYIeTnawcoFMuwgGNgEcRPQS9Mp8SKG2ts42XK7ZfZ2d18IWTvUYdPdiPpxn
         JP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161502; x=1790766302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dD+VmVixjFFrk3iHvh8FDxDS/komPYN3IGSBgS08bOY=;
        b=j3RK1XdJFrn+03SJyQzRPFNs/SZgNg2LPkdDvybwQy1CUwrw3jV/V07HtHgCBw3GlR
         nKZDMBP0mu/Stu1cqt9a7796/+zvKQO8sYD2t9dDcXoJy/xbBTOQm0ssDv/PopPalqgT
         UDDEFC37NiYGHIidNNNGzXt4J+R6tFRjxftBJp7iU2C4sjTiaKnkU1hnIlDg6KYMyYCP
         fK04Ratq1b8l7aNBYS13si7vqgr+HqwxAan08Pt97zkJktZOzFE+demHlcqj/W2SzDb9
         cY70MXDD0NF9oo6P4RXXkKqIAZuvlsqwP5vZSDwAA/qiuc+KPQgStvqxnCo7V5OmOLzj
         qnew==
X-Forwarded-Encrypted: i=1; AKwUvBwwyOggQsV5kC8XvfbJ9CfuNlV3sK3VtVnQnq/AyR4SSAvNcZjdNxHUmZ6rd4V3kNIxt3utyl3dSFM=@vger.kernel.org
X-Gm-Message-State: AFuF++nPL5KD8inB8RLQFxZx5H/F4ZQQqe2Bi9h+Qw17bXitwRAxz6DI
	6wFxHX3EKEpWqhmYMiCd74l1BCrZhx6xPaqHqsr63IrJ8XCzSSztjptBQj+kGAO8KIRswc6Acaw
	qvak2RjDA63I3o0KoyC6jhW1iBC5bidyqczh8uMtKZAT3K55ZYZfBfzDEy1fDjFM=
X-Gm-Gg: AYBFou2cbhYd05Ye+PhYpJ0xNrmoLmY95cagFh6GWved14iV16C5PQEij51XcFZYrBc
	OzAHHSHOakkd1WQZYNanK6BjorVADoUHp7PyOb2brpeUrfRgcdU1ivOYgkYlHiw2ZCvGUdfuDxa
	KCayblPmgn4vgc8uefOWAtmKyfQeDDag80hIzKwUIDxBrKtUco1LYyDGatY+DT2Sqs5AhCFHoco
	ZuFMPlVFCvMmVzFalHN1ps6dBEF2kIND3q5vF3azCCJ4ZzR06MDlTFDqHfKYc0aeZDVdCTWm//b
	vg3PiLWJ/pSrtNYay4twBTET9vmYBmsRUZdswHgAS6U2ELNdsnWq88R5Q3X0gr5nvPXh07K3n/e
	kR8i5AJbgNrB/zyTmX2kJLfyAtBY3152S+armkN96
X-Received: by 2002:a05:7301:5414:b0:33b:de43:4aa with SMTP id 5a478bee46e88-33e8c442e35mr2309691eec.12.1790161501962;
        Wed, 23 Sep 2026 04:05:01 -0700 (PDT)
X-Received: by 2002:a05:7301:5414:b0:33b:de43:4aa with SMTP id 5a478bee46e88-33e8c442e35mr2309638eec.12.1790161500470;
        Wed, 23 Sep 2026 04:05:00 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:05:00 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:44 +0530
Subject: [PATCH RFC 13/15] arm64: dts: qcom: maili: Add camera MCLK pinctrl
 for Maili
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-13-cbbb42e534ef@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=1581;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=npxXC/2A3nQUucjpT0p08dcGaxkVim326juc3Mpe3ls=;
 b=YsYtcU86DYgWmwtIhOPKFQ62Yj6nln8+PucIgx2mqT1gc9z47yTmOl7/J0PAAk8yQROqGKfV5
 +iJtYg1/j+QBMO/CAZX3SWdow7ORIcqZnKmRkF67Le+COWyQv1Ltlc1
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: kYLkmXzm07zkqRz6cbT_HKc82-szpZIu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX/utWxEEe5gYD
 qh0HGnVo4onrM3SGDKDLTLrEpVlkKafngy+3giLz3mw1OL17Qa4PO4Nx9e8cCDrp59rbGUPRERK
 wbz3vzSCA9OdTDo6mIzwulUdR+vPmRg=
X-Proofpoint-ORIG-GUID: kYLkmXzm07zkqRz6cbT_HKc82-szpZIu
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab3b25e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-5ruBYKNFaXfuGS5u4wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX1/5oe+VyCxjh
 gmvFLRp2NwqL9HF/fZ9qa1QSHfGOa13vZfSEwmOmXabI7eWcWxVJutlnM/GSJ8pOzvNw1Gan9GE
 tVX9KRmtFj2pOfPPQzicONuilcGOKzZyxqWi36pBxvX2uBFoP8iIVlbk4fexYpm/anOSYk7hA3z
 X216Bye8ELuby5BloSoZ4/BF+yaWeO35goePja7T6gaFIad2Y/zPBU9mpaFoU3lKFpYT4VJlh19
 F2ZtYXHmhQj6AFbgxcKgzU7k5gzJz/H+3XDRuSxUF33iv6wTnODybhsK+U4iSVR0lgyyNiNcjrO
 nA4XbcYMS9PKGmGNhR0oKs5QcjJ4dNvBpovxT9M7ZB6pDnYzh+vi8jCtWK4sTSrKoYJuQ+FDiWE
 t1Fo/qKiOIjCgAxiH76IgScPqahRs9knRxnHA6IWFE11KLbU/kplFWsr7i3EImWre5AbmbgL6Ao
 fTR1XrbXlUEt0oV8gdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044

Define pinctrl definitions to enable camera master clocks on Maili.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/maili.dtsi | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/maili.dtsi b/arch/arm64/boot/dts/qcom/maili.dtsi
index 8d5d64a23642cbde51ecb6c7377a5eed355f0d65..a73e0548f9ae32f64b3429c05187f9529bead616 100644
--- a/arch/arm64/boot/dts/qcom/maili.dtsi
+++ b/arch/arm64/boot/dts/qcom/maili.dtsi
@@ -5748,6 +5748,48 @@ qup_spi0_cs: qup-spi0-cs-state {
 				bias-disable;
 			};
 
+			mclk0_default: mclk0-default-state {
+				pins = "gpio95";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			mclk1_default: mclk1-default-state {
+				pins = "gpio90";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			mclk2_default: mclk2-default-state {
+				pins = "gpio91";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			mclk3_default: mclk3-default-state {
+				pins = "gpio92";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			mclk4_default: mclk4-default-state {
+				pins = "gpio93";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			mclk5_default: mclk5-default-state {
+				pins = "gpio94";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 		};
 
 		sram@14680000 {

-- 
2.34.1

