Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB23E2AC9
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934961; cv=none; b=StbQMM92/9rcstR4xr8ZkSFl/3LgEQkVCXCshr71lSlzLk51PDmfehrCYfCgYMFFmgNPA1ZErNtC0EocMtA5Et7qBSj2wqBZdbNK3SfxYRe3HRdTCYfVb2y0+/kixZDKIVwysI0mJRY8WRw7b+weLC0njqVAicDxwisWDlwtTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934961; c=relaxed/simple;
	bh=T/77rBwVVX1NnOpvQiwPTXRSL9axwN7LYY783rOf818=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDm5QsJRJ29DIkq+vuOErnklkJhKqrCBnh4jpFks9rqRHHrjjCTSOQXylEK7A88RsSB3KIiKhSbFtTfSu8krJBSj5P4xLdt9HEcUZTjAZXfH1lcSr+ZGaIMDKkICd0VeLRHvUk3qafoVH7P3799bTkM3oNHlPnG/KAA2yNgYCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QA4wMyOX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b+36EkpQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QA4wMyOX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b+36EkpQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7YlGZ794258
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UPqYujuhCNHw+HoasKyvOKVVzVHElhECYsLHzz2QeUw=; b=QA4wMyOXTHlPrPYY
	fmbDcsl12WcIp0j/1fnBKt9ju0ZslspQRbo7j+ChnOaGWHuurGRLbrQJrfNb9y+j
	E2hxYcJ0AJ/17yxnEYP2OhC36TKbFa17kjypEy0oCjol5/WiIUkW7N55axO3ta1i
	/jo30J60RtwFBaXfU7HWOx/jEeBY4z14TJvTb1jvCtgpdCN3y1t+Z9c+zGcQIdJK
	8Yp7GIFgqag4gvFZnzI11Oox+fOoZa3hBhbIlduyzm4dVn27r7vWN1AYx9VfiqwW
	g8x6XPJY9z4+w/yaRiYhZZMS4APJlJ4bOJZ60DG+uId5lG+AcxU/pjB8bA4NST0/
	kuhLKQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn0dk2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so2311752a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934958; x=1784539758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPqYujuhCNHw+HoasKyvOKVVzVHElhECYsLHzz2QeUw=;
        b=b+36EkpQ6GFQvXG2t8UDGnA0uIJd15rSFVSBCX6o6GrJdhiSfRSp0N8oFRGB1bJCpL
         qzrb14OBtgqsfjKjTl6/EdfUjfHiOmyK1pWNRrzUONyuLgy7tUT+mjM0VqFiSnhxCj1e
         zlAb03n2f0HrqA9EssDRII832RIMfxpxW9W+y5TX8a1mELPv+YriEqdiMYTgNcR9I3P2
         d0I/wAgxziezLCfUexyo28XD6U+wYt4QU/VYuAwoFzewY6KIxI0kc1XmEOmb5VJXGmL+
         eoo8989FGs5O/pYyEjFZvk9/UfuSaE/S0BMyJVtUApESlPbWnecI54mhlBukXjLf58wi
         b31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934958; x=1784539758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPqYujuhCNHw+HoasKyvOKVVzVHElhECYsLHzz2QeUw=;
        b=dblf3xHrGHr5JWDYdNRWIFjm2i9zxsky/SZru2sUcVgu7ChkBq86bmKtEVuGMgndUN
         bi40+KHZ9IL+d9N24AB0rq/oG2Uit19h5mCB1qrAUdGgr6rarFIWoDX2LZKLVKKyAy8f
         NPhJcXAIVpr2H9CKWDMqgqjSe71pYpnU69gvAgQqnc9L6VROwatzd5E6CX3eu5CW906H
         3mHkR1XwpSPuZU8XnU8qC+jzvve8ajxQGgK8mzS4OH8+1ejarJRJhG8nrNtGli/21kkC
         H7xvfuWQ2gZ0IaIqDC3B7EmRSxpNK0DO+kQHh1mFk6r8NAtgt77egTZRe/DdyTRSNqMl
         ImRA==
X-Forwarded-Encrypted: i=1; AHgh+RovIb8rZxwBGk96qu2EZi8NieKc63Z82ON0TkYN6AB4I1VBIOX2WbgPmznf70eJw5t8xn9AXkPk6gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnyeiDaabqoS8Xav9oQKOpXb8O2428kCgHWaAHvTz7xHdUqJY
	9ctHrYqLQvgzDWcoerVU/NKbDmzFdL/hASgMniHk8RHSadZKgBAgZyZxSKA8hBh8w5B3MufA8mr
	dJKadBLeu4zlpOn2/7sT25Xho70BKSW/gXIZdICHtiT2QHE+QV1DQWwFBDwPSfhU=
X-Gm-Gg: AfdE7clHJ7IDpI/2E30bGjymxzLSzpBdgfST1/kvMxyccgbwf8dg8Pq9w5Crh61NZdt
	x6TGj7+rrUW4Fdh676hqnrk0FknVoxv/wAyEGc8oXNbd5jnBFKCfYzYKOkZjyZM63ES0LlhDUmF
	e7LUsNBtMlaF+mKgMZmmgguIr/380sEti9bc+moFC6dBfKk27BAAiuXp3dFYzSh05r/yCYGakGA
	Qahq6PjW26Lbbtq5rEe+htXE1pa0zqM4SP3DPjKie3DKuLaTADID2BT0hY36M+SFWC1Ut11SzSj
	V9GNzCD/KdmYg4V58Xx0rF6LZFcAsM5XeRNqGhtW9gEVF7v4VRyv+seidfiBLsP0auoqbtJfRTK
	y8SKu60r7BPPd6CYcdV+1c5j6f8ddlV6ASKHCTPcMQA==
X-Received: by 2002:a17:90b:3807:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-38d15364aefmr13934326a91.12.1783934957766;
        Mon, 13 Jul 2026 02:29:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3807:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-38d15364aefmr13934278a91.12.1783934957232;
        Mon, 13 Jul 2026 02:29:17 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm47495569eec.24.2026.07.13.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:29:16 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:58:35 +0530
Subject: [PATCH v5 4/6] arm64: dts: qcom: shikra: Add pin configuration for
 mclks
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-shikra-camss-review-v5-4-db53be15dc4f@oss.qualcomm.com>
References: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
In-Reply-To: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783934917; l=1547;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=T/77rBwVVX1NnOpvQiwPTXRSL9axwN7LYY783rOf818=;
 b=U6/UJ0ZuhTgT42D+LrPdvk+x0l9xbREy7lCdtIpjjzj7ojVC+DQMTPnJ75Fvh3wtLcFCoWcKC
 sDZmCvEJtCLBbWwZWcb9u5o5dodmN2XL/mIv5EVEys8KgJyKuveg38c
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: o1_AzJ6grJwHaV_CRfNOVj-O2scW3d_d
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54afee cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PMLJDkNcKfHmOO-cHakA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfXzhyFXH19dRv0
 dxJDXhbxsxdEnl6YeuR/rERC8TLgh9kzK55ejLChgUXrv1yMX1JFU5w0UvSeOOTKTFFG4DjlfwL
 KxnwfHl2af/06mFX9w6YspljVjvg8k8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfXw+TefQacaEQh
 c2C0D5DLzBrX55gyVShgt/5y9ThlrBLQR4rnHt/IyslC6DEP9Ckp5i6S/4CDuB0KlwgCwZMdH6E
 laUfs6u9azYauvD16wRLWCnfVSvtAAYY8B5gwJWkBTP8EJWic6Nlf0D5qAlhw7QUPCda1TaAH8b
 Fmp3ReLRupogN+kY8V//adm/lioBzFB+x1B1+wzng9qoa8T30cf8ePcGxYUsgHk7LEgJbXtvAWx
 IGXz3xJ2SALYNW9oANjuG00UNtkkKGYx4/9eSGlMYA9d2iLSAxS9ws69l9oSvoW3Qw35hmCZDjq
 N1WO/dcccT1rRg4+dVmXYq6YE/50B3RpZ2AuEdO294zwUBPxaOcR/I9JXi6XDqBdYQbtBaCreRa
 h7JWgxfhZjsGR9c9bQhm0HyG+j3aMQWIiVV9oRywbEYrqBjW7V2IbPvH8j5iblK+6xJpgxwYRSM
 m+lbJUZEVKllZHGDfmA==
X-Proofpoint-GUID: o1_AzJ6grJwHaV_CRfNOVj-O2scW3d_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130098

Add pinctrl configuration for the four available camera master clocks.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 18da1380e52acdd8813625eaceac796e342efd16..d87a87b3a23cc869d35cbb9c2f802d425c9eb94d 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -387,6 +387,34 @@ cci_i2c1_sleep: cci-i2c1-sleep-state {
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
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";

-- 
2.34.1

