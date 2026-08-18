Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4123B7777
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029290; cv=none; b=p01mSRjpwmC4uf6qAGBbTh/TT8XPHUUM236zTj3fWo+IvCB57HnwZk26JFnhC04VzkTN0+LAl+o67QfFiARXm+Iy05nhH9AfuuixLj2A6vIY8Cjo2NJHoe2+Gr5VxGhVEKjD6yo2V+QhX/vDCOiPN7Y2ctaY9HCK2EeztKOSCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029290; c=relaxed/simple;
	bh=++4ueJUBuR+ALJL9F9Xv/e1NPCYzmBqxDWJrIW04iiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zkd3cPJPAOALWoIcP2ykJl19tgWBZRhAdyOaBQmBMOlPRrlSRIV/RG074IlzXAJzO/I54CKRcdAO5wFidFjDb7Nn5s0KTzVjUk6py9cqSwleR+lr1ZMuO3+Ganm1rzyjHTnM+rChJyAFemJkCHWO5hopCkrVvrek3QH9Gi4X8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYszM8VN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b0Nlam6j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYszM8VN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b0Nlam6j"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I3r0VY477797
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HDLr6tMxOU8X4ZoOR5cvkxyRwp+J3THXTF2vqA6irL0=; b=LYszM8VNilR7UCEq
	8rs3IknO2Kk5BMXlQ7Umj3xkKOEk1ZmaD7ZuiimV3YwJlhYOpLnQ+8ITes3v341g
	CD+OZJBdCxSraBXv+HZLmflAStqN+pDXfjBMf3Fu6ATMAb6oHXSQMjmRoOdEvypH
	YX54KxXW9LAXMn3IQcTfWknILTo9/dyo6E+GYo4M7PINOuiF38K1Yi00xjsbMxnS
	LClETud7vGPUwuyUL6YCupKSSc/EBcI42PrmH2rthE8yKPTAUK2+rslIYxmGkGxl
	O+MZZRad4cJkKeIqQT/yU2gmDoNCsAqKidzUyTt2YH08TmW4lIIK2yZQEm//Vp8G
	Bmz/6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp089j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so4317038b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 22:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029286; x=1787634086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDLr6tMxOU8X4ZoOR5cvkxyRwp+J3THXTF2vqA6irL0=;
        b=b0Nlam6jb+52HleLm2f5jI2mfMTtC+cAN0xPo7UVsQdZ8nyB611EgyEsInwGafumjf
         jGl7octP/OHakF1LB+SGFn+HvdyzJ2VCCEh4YaMlxbhB6wvKBDEnlVVVO8RAmPfLydZb
         ZBABS8mt8iQs+bzoWzXjw+CH124OMDo1ci6BGOmQ9FQeIihDVDdLQOBNfwaH2Mr/2MTZ
         OHjiD63u5jkwNNVmaGYDdqYYxoB0n22z5TOxZO6LhFMYpwtQxCFnC0lshIPgg2VeG4kj
         UaOAUOiYkvbHG3HcM/qjdy4awmerSIGJtQpzrKEYk8m7t6p9TvZEWzR05JElXMB74Qaa
         EjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029286; x=1787634086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDLr6tMxOU8X4ZoOR5cvkxyRwp+J3THXTF2vqA6irL0=;
        b=QlvtrKRaavMShUZWAyQO8uoQMkWW2zHgkWKzWGs1Eog+Slz+uhx32oOc9NaYd4Y/it
         BCzqLoSLZqz9SA6NtKvrpgZrTkAar4lxYdvBypmtMKBN3po86lBY2ltkqm010P7mShmS
         yfVNiwfyJQOSY0TEc+cT92+16vNbAGH8uteZ7E7SQ0lzsgrbDItC8GtKUKpRlIvgIAh0
         5dNTdXgDxuAFVYvebjvXulYnKjorH9qCBGF9c1JERwBx1hXq01Pw3bZpqiDzycIjfd/+
         xAqLliRAHRn//B1Xex/wrIaICW3+DjqY7ZEkmbTtkqNr0WPrpGdb9X7on8PM6bSpZEMy
         UCmA==
X-Forwarded-Encrypted: i=1; AHgh+RoA+0ZaAKzJcNdmNCwokhIIZqYYztKogYxFjOAz+BOrA0d8fuxpc6ubOBYAeefg07KPhitAiMRSAvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVa6+0EvRa+NLJ2/ViLUEu9vE35K4Tqo5Jgi6/LbRNZzOJ3MLF
	8y67poNUEzpwqOtB1blR7hTXQWlCL/m7QaBeP6u3VSp3YJgn58uPayPIiF+B21q4TX778EMsTz2
	YFMuh3pPkbZ1fRIXRFrUeW4UG2wYAI1/grXmSLFT3sWHVqCdsbFsq9PjBJfc34hs=
X-Gm-Gg: AR+sD12BWtS3fQ0l8vZ1pUW+mH7HDdGTNTzvaicjCupMefrpNxm3H4S/0CsJC0ulcRY
	pC40vV8O7lKhzhUAypz1lIdPtce4+PrGRwdsS3yRhWy1MRYjhNcatXADCXz4PR+bizDV6noLjmm
	fwOQSmb9EvM+mAaw6zgWjIoMcvJvcxuWWJqWpbvS/tqCErhDlvkewnAq8aHgHhBM0oHIz9NRmlM
	ndu7nlG3kH5fayO8dtHp9Fp/A1EzrE+HjeAmyvVzzJyzsSNE17r95VwqlY0BbuLKRDt/LmmKn1z
	NU/qxwrm/jMXAfR0idTE0dg3ze53VpS+Ea+52YtHTMILAUFi0NVfKbNNliZKMNh/eYXr/xSFj4H
	KAcedKcKi8EofNeYJDtH1pza0rnqj0XqhFg==
X-Received: by 2002:a05:6a00:408b:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-84fde3651cemr31654350b3a.1.1787029285999;
        Mon, 17 Aug 2026 22:01:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:408b:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-84fde3651cemr31654223b3a.1.1787029285376;
        Mon, 17 Aug 2026 22:01:25 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0158sm1028876b3a.40.2026.08.17.22.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:01:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:31:17 +0530
Subject: [PATCH 1/2] i2c: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-1-9f31b5fae5f6@oss.qualcomm.com>
References: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029278; l=3344;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=++4ueJUBuR+ALJL9F9Xv/e1NPCYzmBqxDWJrIW04iiM=;
 b=qoh/kF/CdZGmjzzp8V0TC/GMZvud3T2lPhY+DJ9aa965phrFGeje7GZcT1wurx2VhlD8NUqPH
 2i0bb1278TYAZdZ8/aYXpPh1NAQ8XcW7rlbkx0AlNf9/C0QYWwwqjLa
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: H6_8Stusm3-I4eA-UU8IAmm--V2cdtiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNCBTYWx0ZWRfX3a8DF30FOHc+
 HUOoKAh3d9Idm4ck0L0Vn3TuGvE8u5B6IloHt7lBbL8mjsHxOZQQAf5h3zslBGavJv4fadU+MTa
 xXCyhHaosOkW+7BomGf+rr0a5J1pnvuZlwHJm5u7Qb82szUeR9LKYa0sYaJuqKEH9RiXE8nkZDz
 awMxtRksoQd1vMn1tTOius4Qpj5AyM2Gx/v80Ysed4EM+K8Y55dk7H941SEDzHKPevUJcKo2r7J
 PddpsILlnNT8tnfKa02mw8AFkbQG9JihKzNLMHJdRW7u2w/eIOmNmpJ8Jd36XfEcS2cNmrxVa+9
 /PgUIicXuSK/Scnnvx51N8/2fQl0FUHN5R9rxcvYS7wBAutVST1NJXJbcKytrKb8flr7pwGOPAx
 geEg8Dn/OoG7rhLR+pTl1/Bbmu8RAQvGTmjvilBsi1UL/A0w/YSJCu7FJnIfbqYV8yY9ezE3Z+y
 mIVWj6qP0bx5aLIZBtA==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a83e727 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jy3MxQloX0jDNi3JzIsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNCBTYWx0ZWRfX9FGzmGN1ZDvM
 JsVTXz/uNKyHJPvoC/EiCgofg0EcyJs6HSZz66zGaXCzDZGZk3oCTCgOfKNgAOT+XCZjLpCBHxD
 5HDeOGmbgnhDkEzrdseIc13QBjqye3k=
X-Proofpoint-GUID: H6_8Stusm3-I4eA-UU8IAmm--V2cdtiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180034

During system reboot, an active I2C transfer can leave the GENI Serial
Engine in an indeterminate state. On VM-based platforms, if a DMA
transfer is in progress when the VM is shut down, the SMMU can raise
context faults as the DMA engine continues to access IOVAs that have
already been invalidated during VM teardown.

Add a geni_i2c_quiesce() helper that cancels/aborts any in-progress
GENI or GPI DMA transfer and resets the TX/RX FSMs, and call it from a
new shutdown callback before the system resets. This prevents both
hardware state corruption on reboot and SMMU faults during VM
shutdown. dmaengine_terminate_async() is used unconditionally so the
helper is also safe to call from atomic contexts such as a panic
notifier.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 51 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..10c6a4b0b825 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -1034,6 +1035,53 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
+static void geni_i2c_quiesce(struct geni_i2c_dev *gi2c)
+{
+	void __iomem *base = gi2c->se.base;
+	u32 val;
+
+	/* Make client i2c transfers start failing */
+	i2c_mark_adapter_suspended(&gi2c->adap);
+
+	if (!pm_runtime_active(gi2c->se.dev))
+		return;
+
+	if (gi2c->gpi_mode) {
+		dmaengine_terminate_async(gi2c->tx_c);
+		dmaengine_terminate_async(gi2c->rx_c);
+		return;
+	}
+
+	if (!(readl_relaxed(base + SE_GENI_STATUS) & M_GENI_CMD_ACTIVE))
+		return;
+
+	geni_se_cancel_m_cmd(&gi2c->se);
+
+	if (!readl_poll_timeout_atomic(base + SE_GENI_M_IRQ_STATUS, val,
+				       val & M_CMD_CANCEL_EN, 10, 200000)) {
+		writel_relaxed(M_CMD_CANCEL_EN, base + SE_GENI_M_IRQ_CLEAR);
+		return;
+	}
+
+	geni_se_abort_m_cmd(&gi2c->se);
+
+	if (!readl_poll_timeout_atomic(base + SE_GENI_M_IRQ_STATUS, val,
+				       val & M_CMD_ABORT_EN, 10, 200000))
+		writel_relaxed(M_CMD_ABORT_EN, base + SE_GENI_M_IRQ_CLEAR);
+
+	if (readl_relaxed(base + SE_GENI_DMA_MODE_EN)) {
+		writel_relaxed(1, base + SE_DMA_TX_FSM_RST);
+		readl_poll_timeout_atomic(base + SE_DMA_TX_IRQ_STAT, val,
+					  val & TX_RESET_DONE, 10, 50000);
+		writel_relaxed(val, base + SE_DMA_TX_IRQ_CLR);
+
+		writel_relaxed(1, base + SE_DMA_RX_FSM_RST);
+		readl_poll_timeout_atomic(base + SE_DMA_RX_IRQ_STAT, val,
+					  val & RX_RESET_DONE, 10, 50000);
+		writel_relaxed(val, base + SE_DMA_RX_IRQ_CLR);
+	}
+}
+
 static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 {
 	u32 proto, tx_depth;
@@ -1209,8 +1257,7 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c = platform_get_drvdata(pdev);
 
-	/* Make client i2c transfers start failing */
-	i2c_mark_adapter_suspended(&gi2c->adap);
+	geni_i2c_quiesce(gi2c);
 }
 
 static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)

-- 
2.34.1

