Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232934;
	b=K0NPOSp3FCpm+MwKSdENswg8sFmsSUy59urHtectTa4XKhNREyK4xDzBnThtBRjTGXjG
	 pfEp76CRLNLpgapHeYP3/AJgsYjx6TxsHpjv09UpgF/AIEQSQG7QJ/KAVCNEHDTADjn3V
	 yCB9IbbI0Lysul5DH4fGLroF/9LJ356ZZQyshA2FLUonn8JSIBaoDQogK6cpEt8F3bb2l
	 6QTkJxkU6U7SQ2ysU2BfvSwpss93SFp5b7esImXwfeJ+4A9XfYi3OzA3PUe4g6Z8BnQrm
	 PVPAYHZB8hiK2NkZZjNUtnFrr+UkqsC3LEuo4BH6gck8khEdl2PH0w88PwMMR+uFgJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9cUE3n2XMFbQDb3izV4RNIRB1UH4e5dkhEIQq9VArGw=;
	b=W62B+9YWbQn9ToFueKlIP882/DYYV7J9WmniMK/xnEUhQXexcOPj1qmgEdTE1dvSuz/0
	 shZIba9fNx3rJGyyNhRMdE2TZKeXmdFxN+cOkWuWdrzAT6IvdZw56vd3hQju0GU/1NiZI
	 D5zOLbPILrMvR28PA9RENBQXPW02TpXYGSazeivqRBOK7EB/ZeO0G+IsH9sZ0YmMHauAt
	 ktjc9/1XYU+HwPEPI6kCHlsZdv0UJvkQ8UvALidKiUCzG0Wxhe5c3qTuSy8C2LyyrFPQA
	 sKLSaWyt7jxO0R2uYFZO+6UdWPgDiV4hE4GZqzATMgLsHvGhgpoKoTqPpHN8FRNGApA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kAP+gnZV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZaOLjiF7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA9606A31C
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kAP+gnZV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZaOLjiF7
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFMF4359447
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 14:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cUE3n2XMFbQDb3izV4RNIRB1UH4e5dkhEIQq9VArGw=; b=kAP+gnZVS15Be3hy
	M4aWI2V4HwkP9Kd3jMZd/AiZfS7Z1rsJZ6C7vXXjBqyb0pcQQ/cif2URj6jPTGN5
	Dic6FlcXyFbjzfZqY4rrg8q+iysEdS29fY5R/+ejNg1ZcwA6VfqtSf4dcsFZ2qfX
	cQHaF9BQL2kIz7AZQr+sAdldki8PoqgBXV8hCxxfqtq5ELTpkVW9OIvVdKXg0fDV
	VzGbjfUNnrBaXVxSy9qPkiW+bpocWN4mlj+CdFni/AgmrkNjBkrv45E1TC9Raj+8
	xBzkrgjZ/lBhli5+mS/Flt/j6OQe/+GQd6xr8MkRjkEEA6HiP/KCgWJRa2G4B4D6
	rSksMw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2hxay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 14:02:13 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ed100ed770so45784e0c.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794232933; x=1794837733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cUE3n2XMFbQDb3izV4RNIRB1UH4e5dkhEIQq9VArGw=;
        b=ZaOLjiF7VYRTjishTg+U2xqQfodPPZ8kIksNmeuh6ATbv3mWHJzbccf/w5YFm8NJcG
         JqZXkcvk+qgHDoubBQbdyzT/xtPB5yWC5wOjhdGrBJjbc8QeOuAe3mpvPqEXJTYWcd91
         prFungGtAAmzFhdNNq/8z2H3leaePvQzsmATxUOTKjcIAP95pb0VtCdg7skwqTo/yNg0
         Y4gE3Rhillh0prPIE4FkMlKUoGYJ30sH7FtoUsuCRJAmcFuSJOBOl8b/asXiK/1o/zYb
         +ChWoNK+HtnRNeJZ8vnPQyWVyYUjViPKwlQsAFJVKnaN++kS5Ui9VX2UBpLueCtjfo7p
         rrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232933; x=1794837733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cUE3n2XMFbQDb3izV4RNIRB1UH4e5dkhEIQq9VArGw=;
        b=lLPbKzfls8PmyC3pFAftdyKKqxohVZHvxycUxr7W1K6/gnw4GLraxwUXi33HkPBq6O
         dULvXaZGi+uU00Z6Ro4//sGkv/sNrMa0SgLsmX5inCy3XhKszQdh3c4dY8qu2Aa9+k8O
         rTv6GiN3zD46aBzpGW/75AmcfFL7qHxIF+ulTpbwqr2U9txIo3xJn+P641j1f7yYave0
         rxu60iyoE99io0hKg451oNFgDnDVs3VNlmK2c/rxW7A4ToQyRFbv7z/nh8r0EBEDL4yE
         QET0+6wt8CVcVDa7OSIxj8onZcPZTTwIOD92dDWcmkp1jAU8OtItPQmfczUdKSZPKLJv
         AvXg==
X-Gm-Message-State: APuU4Z9oJaoixNjCf0/h01aXbU8kR4vmB+Mb3QtItyxFWFVF6qq2k4jw
	C2qqZjcnOeTKFZ5BQPaL7Y+hVG/xHKfu+KVLCgp/WxziKn4Grd5yZ8mnUawHCFwLwiGv6/XPO5b
	IE9eAXkmY7HZKWdwjuwYJCNJjxPpVZ84QQgq1SUPPgXRpfbEwAWgPPl1rOp0v4WE=
X-Gm-Gg: AYBFou05L2vCvmrjJCawlvHPTR9Fk1/zuK++wTLeRKTD+QsIZbiDgThEieAX8u0DJPs
	xcfnK5ENSUEKrSOkzSEwwNWfUcII1vlKF3JqLdKQJVND88aixfhLYJPyFlx4HRATdnLaTmoBNmA
	cOh+a861fDZRw3Wa5pCG3MAptMCiVMyobxrKhQ0Q+lk02h/VS3jkABUoyqwwJKhDpgf4fYXAF8A
	qolT+F9FcDcf+Re9wwTs9oBUP9R17fRrmvXXr4lTBPmbChYfetlvDQBjnL/Zp/m4WBd7NMg/vvF
	BG7ZFJ0U+DbFS13WN3DtKZ97GrwYmqOY+k5wsRMKxRaaFGpKAChx8bdvYcVufzBCtNCzrHJe6EX
	SrH4AiifkSjElWgPT0iQFxqoKJkuS8w7Yqkx6qjsOUPgVV/2F+UIEF/vufAuB0vBkl6DihAYvo2
	70npsHSXhwoCppSnBJ9r2LZysBqC2MNczMUtpTdGWGnPXhDxGJJjjbYPkhl6UFVjWS5l/wU5nsd
	wynTBPJbYbnfKPw3xlG99qySdR1
X-Received: by 2002:a05:6122:179b:b0:5d4:a734:fb80 with SMTP id 71dfb90a1353d-5ece713201fmr1021586e0c.3.1794232929997;
        Mon, 09 Nov 2026 06:02:09 -0800 (PST)
X-Received: by 2002:a05:6122:179b:b0:5d4:a734:fb80 with SMTP id 71dfb90a1353d-5ece713201fmr1020992e0c.3.1794232924706;
        Mon, 09 Nov 2026 06:02:04 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f9b5:154f:6aa3:35d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm161515845e9.4.2026.11.09.06.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:02:03 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 15:01:55 +0100
Subject: [PATCH v4 2/7] i2c: qcom-cci: Handle and report queue
 overflow/underflow interrupts
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
Message-Id: <20261109-cci-imp-v4-2-4dc4095dd052@oss.qualcomm.com>
References: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
In-Reply-To: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1d265 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=L19FZshse16xndK5FkAA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfXxP4pmOld6WN2
 nUS5L5H7sHwGOPREYxIN0YtGpaZV0Yg83PXJrC515AZQDgyVbcceK6gQrvKS2+Lr3qKCR3oJ1oh
 GwonhDycHRcn9Rz7R3L/w28Nt93joo2KNH56OO07WQ4iJ12ohTTCgC2yVHOBRE8mpALn7FrHlZS
 RVwxn0KvCyfur/Nu4NdfUJQnxFzkQDIyQKn/hyhgEZe+sduv+rcc0RK9i7hYewGATgEDkxgOQ89
 2m/v5dEtfF149mOB2Aspk971eF2Hw68mf6IHdMh7g1cLCJG6uEKBoPCGq7STK/GPDhTzsF3+e7O
 gLtzcmRyFPofS4r+ga6i5T27PEq7uXoroyEiyohT7K96b6oBxl4eHfh6qa5nf6psdaHv1wRqnwT
 EjiopZv8gLRQ19qdyj3oMnYU2dC3Oum04mx5FGHXNw+KgKuGr7CXmoNQo09qqOjSUirnKCUz8A5
 tpshw8OXK6BQ3RxJH5A==
X-Proofpoint-GUID: SUnHN3q9hiv-MSLjUlqwGG0Vi_gKpy_e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX+YfeSqFK8Iun
 KruCEa03cVC9hVBRiXUA2ohhKsq6VRQxxLDDxpcn7twL+YCfmcmEUkg141AjOl8blbcYn2so5GI
 rLN6b4Rx9SxPtLsX0AX1bP8HBnKtyDc=
X-Proofpoint-ORIG-GUID: SUnHN3q9hiv-MSLjUlqwGG0Vi_gKpy_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090055

CCI_IRQ_STATUS_0_I2C_Mx_ERROR aggregates the per-queue overflow and
underflow bits together with NACK_ERR, and all of them were
handled the same way: report -EIO and halt the queue. There was no
way to tell a NACK apart from a FIFO overflow/underflow in the logs.

Decode the individual overflow/underflow bits for each queue and
report them with dev_warn_ratelimited() as such errors are not
expected in normal operation.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index e7e2650a05ab125c2ac619c90cb61152cd787165..3ccb5cc90f62b0996acde0b1df568ad4e022907b 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -55,10 +55,18 @@
 #define CCI_IRQ_STATUS_0			0xc0c
 #define CCI_IRQ_STATUS_0_I2C_M0_RD_DONE		BIT(0)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0_REPORT	BIT(4)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q0_UNDERFLOW	BIT(5)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q0_OVERFLOW	BIT(6)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q1_REPORT	BIT(8)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q1_UNDERFLOW	BIT(9)
+#define CCI_IRQ_STATUS_0_I2C_M0_Q1_OVERFLOW	BIT(10)
 #define CCI_IRQ_STATUS_0_I2C_M1_RD_DONE		BIT(12)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0_REPORT	BIT(16)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q0_UNDERFLOW	BIT(17)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q0_OVERFLOW	BIT(18)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q1_REPORT	BIT(20)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q1_UNDERFLOW	BIT(21)
+#define CCI_IRQ_STATUS_0_I2C_M1_Q1_OVERFLOW	BIT(22)
 #define CCI_IRQ_STATUS_0_RST_DONE_ACK		BIT(24)
 #define CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK	BIT(25)
 #define CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK	BIT(26)
@@ -190,22 +198,40 @@ static irqreturn_t cci_isr(int irq, void *dev)
 		writel(reset, cci->base + CCI_RESET_CMD);
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_ERROR)) {
+		cci->master[0].status = -EIO;
+
 		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q0_NACK_ERR ||
 			val & CCI_IRQ_STATUS_0_I2C_M0_Q1_NACK_ERR)
 			cci->master[0].status = -ENXIO;
-		else
-			cci->master[0].status = -EIO;
+
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q0_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 0 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q0_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 0 underflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q1_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 1 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M0_Q1_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 0 queue 1 underflow\n");
 
 		writel(CCI_HALT_REQ_I2C_M0_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_ERROR)) {
+		cci->master[1].status = -EIO;
+
 		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_NACK_ERR ||
 			val & CCI_IRQ_STATUS_0_I2C_M1_Q1_NACK_ERR)
 			cci->master[1].status = -ENXIO;
-		else
-			cci->master[1].status = -EIO;
+
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 0 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 0 underflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q1_OVERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 1 overflow\n");
+		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q1_UNDERFLOW)
+			dev_warn_ratelimited(cci->dev, "master 1 queue 1 underflow\n");
 
 		writel(CCI_HALT_REQ_I2C_M1_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;

-- 
2.34.1

