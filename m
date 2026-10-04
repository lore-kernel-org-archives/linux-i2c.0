Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234B497B60
	for <linux-i2c@vger.kernel.org>; Sun,  4 Oct 2026 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141006; cv=none; b=r5+P8CXVZ7P0siH+xvENqfuFKY808j5KGVSLCUW3ncM1ErdAHgZbAIG9IplfutMdJCyAmv05hJRJmUZT/3eyGDma8tw8iteHaWvoVduLtAufIrnX4aBUczqUVtMnYVE+kjMdtXNHJbgAPiiMpOlPF/OHhsL0kfuwV7yhzfL+Ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141006; c=relaxed/simple;
	bh=cFeblvwPftksG2AVCzV/tkFe9/LaOzyZoKiDxNG3L8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e399JVFjDU0vGo+1MmDfn8rCxXy88xAfgl/a47uFsQ3TilIQJtfyFPL+h9Cc1eEBcALoR+7wrLzDamioKHOo1Xw3p5LTauxCbYUHid5YHiMVLWN4QtJDmY99xuDvtIRNiX7TwVStSt7w/BBsL/OFtBGHPEVC60nk/xBa4wi/UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMvvBnmd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfmd9uZx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMvvBnmd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfmd9uZx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694IHeIV3253406
	for <linux-i2c@vger.kernel.org>; Sun, 4 Oct 2026 19:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DxsrjknzXZqK4ShoWL6zLdXOirQvks0hlKrZuyPXacM=; b=GMvvBnmd1YE+QLYs
	aa8mxne/fCGQgm8w7ehn0qW9NW8ObmV1Gh7/xQDcF6M9wPWW7nBg+fXTXm9MOazg
	XAKkEYdaFMk8TQMjRl+Rf5Op7uFHMkgWA+tSBzAoKyXCW03c9VYA4A5c+mWl3AA5
	SHg2XMRNZxG+3s22Enu23JtCx/XK/79GgByca4adkOTd/t8NpOSrx0X1E+5TdDNv
	Bl00F6OtaABnkJDHqtZaHvjH2SDh71ITfTmQFZBW+XVIREjHIaqH7MdTQ6xm6P5u
	UxvJIejGMLM3zYkylCj+o5ULWVeCgrvcA+PA2CCPbnA/AIp/Cft+FEIpqbnMt4Jn
	Tjm7lQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tfdbhmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 19:10:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9123be39eeaso32811436d6.2
        for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791141000; x=1791745800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DxsrjknzXZqK4ShoWL6zLdXOirQvks0hlKrZuyPXacM=;
        b=dfmd9uZxlc0DxHcIkMUtFRiF0vYmhpkuwkYp6NKMP7EHNrUWiyx2VIn+n6cKbdVQSl
         982h5S1VR8LjmEgHBt1aykdRfx4dzsKegp1RXvgKutun4hyAqCThArZyPCDFQ2IVz3cc
         V63PGku/5o4JE57UYZLygdSfT6Wna4+FjxPz0Mc/4jA/Z7y4ryKAq4CL4eJT4PAuDW07
         lhHkzw+NG6qGox1Pblh3kMV1poHegkjs80jQ5ccSfwNResXZJJ2KGeI27PpM646ujyJT
         tSavnJW35UQcxqWUrSalogFrLgQlDwfgDO336BqPHi+UuzSJMTCwGNApsX14MS9qbQuU
         MMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791141000; x=1791745800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxsrjknzXZqK4ShoWL6zLdXOirQvks0hlKrZuyPXacM=;
        b=aDW3SC7XnUHX1OOBhAfeW48zsQ/+N5A2w8zbVGon4a8ddGLWXR70xwwuAT69ZjIYUe
         YAtmcoHoHKqPisnn6t7KZhLVIK21aszJT7UNV4hHevDsIr5tTnROgjhZGUnl/pWOWytt
         X3XxhWMoPcRnYJHdD+x52MNIy/Qd/iknb1TQBH5I7XvicG5SwDnLE4ka4D1Ux34pKivI
         906ICACTBGTACOHy8rs1TkdOXxlc0ylplKBWBcaxuHMPj0I2jdvqXpiv5cu8uJg4iBZf
         ulFyKPESa5ugvmcmgWeD5l2Do2GRbFbwx9bXtbO5Tqmb7WqMAVE/iWMiqH4to6vm6o0w
         zUrA==
X-Gm-Message-State: AFuF++lFiIHKoiEQppgmsR13on7Cimi7zBHI7dkFqrHXN40N53sEpAVy
	FunBk7Te50ecLMoSXaOSqYjZD1oDqIEg9tyxyQjkeqMPZV/FwUc4jA5YblRDv12sH4NMzMfPBJs
	H5Qcm6Qb+i5kJgCmOIUTl4fqCn1aFWPqjrpPtdRoHa2g29jFGBkOofEl6ou+Zn0c=
X-Gm-Gg: AYBFou3FvVMCf2DPFJ783b/i5XfZxKjcw3e2WRloHDfVjkp0jpFhFqhOJwn28dmFPrj
	G2jkXP3gUCYmHkaM983XE2QqDATN4o49rzBo1VRycBmeoA2Vq3q1G4liTXQxdVs8wujjCMaDyne
	6Z+IqbAo7l83wanUDHDjZ1elhLXhShzyj/t/50kd14uAIxhx7GOdzWdxrftgYq2YgZCWdDP1AW4
	CBRiivDJBCoAdC5caiMbXECuq+/lqoeJD4NHVjFCBKJPjdI0QAKYNYi3b3HGFPVF7wNpsqxSiV4
	KI/NsLLOwrPNCLoXMUNivy2Xbmgnlw349jfswV6Rg8eWKY0hG+TAVUnKolYk6ydWWrzQW4Rv3y0
	/Q626STBbcgdG0IIRH1pEITb+oHUAAZjME0+RhzFzlnt6B2vXBvT9+xumSmpM9QvMYsPy8UD0VA
	zYKrgk8G5Fu50P01tGjFdHMzFXty/8+JQtJCG7X3o0O5INd9Oecg==
X-Received: by 2002:a05:620a:2626:b0:93c:6fa0:9813 with SMTP id af79cd13be357-93cf19d9244mr1564864785a.43.1791140999860;
        Sun, 04 Oct 2026 12:09:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2626:b0:93c:6fa0:9813 with SMTP id af79cd13be357-93cf19d9244mr1564861385a.43.1791140999409;
        Sun, 04 Oct 2026 12:09:59 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([37.169.59.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394ca0f0sm176318385e9.1.2026.10.04.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 12:09:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 04 Oct 2026 21:09:48 +0200
Subject: [PATCH 2/5] i2c: qcom-cci: Handle and report queue
 overflow/underflow interrupts
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-cci-imp-v1-2-227d12cb4829@oss.qualcomm.com>
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
In-Reply-To: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=LroHWXdc c=1 sm=1 tr=0 ts=6ac2a489 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=1Gfya9YG+27Uq/30OuQ23A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Dn-INlxkzmUqY9OSjTIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: Y9ogYHPdtIpc6q_XEsdgfTlD-2DmF6YH
X-Proofpoint-ORIG-GUID: Y9ogYHPdtIpc6q_XEsdgfTlD-2DmF6YH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX/qLerMIso6jx
 B5H6/UtwDhhOYUBDVtdzmHm1/eYGZzWnoS8J3kksvBzGHgU6PREQHLDSVRgBFv9PjYYKT1nKPmD
 HHJ9V3AB0I3svr87RMER3oIMgmtRX6Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX3u2r8C7OnHE4
 bnjypKdlRCy23xQ29pAi1jH68OZ9U3bHp1V1iqCydcv8tGaRpe26mE0hNqbGJ5I7hxFepdMqwXW
 FgpAb885IBOigAHFTwxR7P2hvuXZ+Adlcod69Qoxnajl/p22X3y7uUDyh1qhm3UYizr/PF7eoUY
 HdLoGXopYd1f77lDSMIJupoDfrbc7LFiK7mtcIuuI+Ku1TmIwERekdivgFyFVW8qeP6qs/DE5Xa
 NhIDaPMQD2tVfcTTlZhMTkqVI8AqzWTCYYBOPTh2zHvlKHCUFELjdOPmX/BnYhkbLaIdZF1PM5s
 BUhU9TkGBwvf3tbXsVuVzc4Nnu1dxKwqZN4ar5GizcRBt/CZ8t4W9LOcaxOhKaRAibWab3TLTQg
 SEUezrT4JxQkRYG8+/DfBKhtn2qSuigKKZ6n9HAjzXDWfZpE+j/fJnjUtG6DVbeoO7leTe2bXUv
 FTN2raWuZDpVafGQaDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610040076

CCI_IRQ_STATUS_0_I2C_Mx_ERROR aggregates the per-queue overflow and
underflow bits together with NACK_ERR, and all of them were
handled the same way: report -EIO and halt the queue. There was no
way to tell a NACK apart from a FIFO overflow/underflow in the logs.

Decode the individual overflow/underflow bits for each queue and
report them with dev_warn_ratelimited() as such errors are not
expected in normal operation.

While at it, change the HALT_ACK branches to OR into 'reset' instead
of overwriting it, so a halt request for one master isn't dropped
when the other master's HALT_ACK is handled in the same interrupt.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index c4bb97868c54de636be756328ca7ee4e46e6b400..099da0069251681cc52e351fb656bd73e78a96c9 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -54,10 +54,18 @@
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
@@ -177,12 +185,12 @@ static irqreturn_t cci_isr(int irq, void *dev)
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK)) {
-		reset = CCI_RESET_CMD_M0_MASK;
+		reset |= CCI_RESET_CMD_M0_MASK;
 		ret = IRQ_HANDLED;
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK)) {
-		reset = CCI_RESET_CMD_M1_MASK;
+		reset |= CCI_RESET_CMD_M1_MASK;
 		ret = IRQ_HANDLED;
 	}
 
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

