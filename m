Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756752;
	b=1DzmyZ0AuoSkiiAr9d6Oc1T+Na4tl5mi9G6Bhc3DJz5BHFPJtNCi++E7psPwPVM0ZlSd
	 oqMvQQrCBC/pRlEc8ZZeTJD9KgLptmjST/l7gR0mCMGhIA1BBLWA8qfIevTXDBkE0hvZ3
	 2+6av6kbFXzz5Ygdol0aLvthluMrjq9HWe3O6epuVCDbL3UVFMjzSD669jlrvVqa4DQ1O
	 ymJOZHyNzpgCha4jEifKTBctqUG8CPAKPnvuohnS57aHExG3B95RUAd7yERK6jc7dp2Xn
	 TSdgr/Hdo2/c3D43eAkE7RroCckDVbaVN2uDRnghvpwB6aM5sbnTpfNhy4sQpEZnDXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756752;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HihkSyB477snEx2qkjOAH7gF9pw6KdJj1K6P0VttmfQ=;
	b=2BNN7eh0kbIxwgisglTzXyUf6dWys/rRpUWQAinBT91mHqq1401jcmbXbfI/z8Y71Z3e
	 ydQ3IusOL6uhtZrrSHdtoeSV/EDwPZunMhOBeZEHRD1HiYyw5D1KkztX2TZTG/iO6Uv8q
	 IOsjhsb5gCkw+D1sZXozKPRa24AetBod9gyyAO8dtz3wEENAoINif7f+uK1ckOInZh1JQ
	 oAL1qPbG0buYVSQfRACZOi0rKHKpqy4h4UueeCIL6XQqcU0o+Xd2GoJO6OMv9M5P36EI5
	 gFgmtaS4F6Vg+mDIN03qUeCoYzHojgcVEN1IWilw1GdK+Yn6MqaP7fe5zvQpR62nBBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f2xnCnmY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxlOKORN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4D606A322
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A4D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f2xnCnmY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxlOKORN
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAU5N2164239
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HihkSyB477snEx2qkjOAH7gF9pw6KdJj1K6P0VttmfQ=; b=f2xnCnmYqrv7Vo6P
	hye01ZDbKV3YIjqnNXj7RYcKG1z5iln+NNIzYFdebVX/cQ+M5rAgCE3XrUDYR7bz
	sPRzX0Jt9kl1GssBZNX5CNxIKYv0eQF0OjoyXFWEwQf7GdQikPKkzdJBsyeEJo+b
	V5Y9ylZmy7hpzkQvGjkIWLXDWsMi8fWeyc+Se+1nP/00x4bTX1UqQCSvNgRsdTB2
	qZmWr5PbRVY7Y4oj76q6s8OHmj+GQIM+kQG4VarjaPCvKoaJlOmth2QU04ovqNHy
	vXNU9AgIGSRq+UAzeiDSN8HU30jpTHIvtLLH9/aOJC9JRU8sLfGi8covIgsWuwvM
	xyFU1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahuyxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so2635050eec.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792756749; x=1793361549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HihkSyB477snEx2qkjOAH7gF9pw6KdJj1K6P0VttmfQ=;
        b=LxlOKORNS4DIzhtg3vF71wL6K42RO/Nyim6reKytsZGiqsdhRKRKAEECAN/tBNHAFy
         2u/DaHGLRPm21cwk3WE91TyOLxJuCdZYIfBrlKksSlcoSmgrpBiyGGe77zc+rU5968wo
         f4f5cDhKY3+RaCnqhMARG8HuZ1jrKjhrxpGULkqurWWRu1BXp14+8EArKudANLVTCWaj
         o3q3J1w/6SrOzJgoy/1AoI9rGxU81XGsYVoZDTK/xQgY4Hh9477q5f6HaFGAFX8wpDCr
         hkLVUBlj0IzNvvBruSb5EBLGRq2oBa9K6BUdzV5ATDHha/AnXyRx9wkZ8ZzusYPRhsU4
         FGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756749; x=1793361549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HihkSyB477snEx2qkjOAH7gF9pw6KdJj1K6P0VttmfQ=;
        b=sn1gVok6EpIs30OcDalzYnIZABzvcrw5zG+WFkN9v303Dga+fv1wGW02HMwjXysIiI
         N3hqcZAOeCQp+CabocCOopDb9ilQYUXbQCg3Zxpx5lb48bQL22gjviiuEt6y0nJi9Nmy
         VB3IGbbumPWjS3casad/mJ53p5iUqu/geZndQIAU5eaUFD77IwT63RaH2kPMPgHtjjEn
         2HCNsQFJpr4wIuRrkaOt42sus/NaR1a+psj+1iNJHon8bdwYnRnxH9ZcyluQoBfDVbQO
         7u9yIOJ2b0NIh5uCmSp19oVn85ZOc2QZPYp6mQzIY+zV3715EF2QX4kdbtbed8IgQ3xj
         Czpw==
X-Forwarded-Encrypted: i=1; AKwUvBxbGCD7V81W9/CkArSNKKove8EPaB26GfBUB/Bme9hrGkJJdc+L2cpKWVStmMkSngOYdkY18wgh4TA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/rwWdP60vYFWOMm/v1IcIffV/sv/NAnKSVuZ4hUMLaHsWtWsh
	9F9/CVjUOO0gwldkNEhnCRkQROBtW+ZfdJDf8Vtfo/sjp1PabmMsszR2SlB12LpRrViJzDdghu5
	CeA7VVdYp6+7g2uED0mQ5PXQrulL9nDJSGRIz4D0ANbBMB3BjvPhUlexEIE9JibA=
X-Gm-Gg: AYBFou332xbvY+D+ZIi8okhVMYnM1nEYxh+W0bNNdyRqSzDR8SQSbssASzz8NfE7ETY
	IjGIZnQO8nXUojB9vxwRdtMkKJnd1NtiWgyitFxvm18izUDWplOvyevyRWwJ3TfPfiyKzvhy4rE
	4zw+sgizuYyw+JG9C2HV44/+5Fgy6Shp/BootkpQ+PE6jVnHDntigO/S7Gg8S7ZyhieisEuVAkL
	zGtO5bOnxz9sQRGN/DheLZOv/iJNUAWBREj4YMULGB0Xo6EFp2guFASXRxJomL52JrjIJgayYwe
	0dfqqchUgI+wS+wGeY9zyxghgmBOE2MXZLfFKgwXCLlEYTmyJs+zHr7fkyvxBDJAvnTAwPVILAj
	yiImg2bFQGXcMPbUO+3ZwzOMaH5gAKkW4hQ==
X-Received: by 2002:a05:693c:894b:20b0:369:9eea:cd25 with SMTP id 5a478bee46e88-369d971dbcamr2958365eec.7.1792756748424;
        Fri, 23 Oct 2026 04:59:08 -0700 (PDT)
X-Received: by 2002:a05:693c:894b:20b0:369:9eea:cd25 with SMTP id 5a478bee46e88-369d971dbcamr2958316eec.7.1792756747751;
        Fri, 23 Oct 2026 04:59:07 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5ea64sm8786134eec.5.2026.10.23.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:07 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:27:58 +0530
Subject: [PATCH v2 2/3] i2c: qcom-geni: Add bus recovery support for FIFO
 mode
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
Message-Id: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-2-93572b453d6f@oss.qualcomm.com>
References: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
In-Reply-To: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792756735; l=5941;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=rQC++aix1hZIuBxUGJVRZIONS5Ev4yVut66D1SWXROo=;
 b=KLxNM4ecIsw20dHO7vzuFUlgkcJKLn++hCLHgu0KgyxNZXrU4RVhfOBJrH+bCaqQwi6paJ3ZE
 HSCDxdlQf8SC0pNOk8ovQu4RMXPyXKfOFPgJDRU3LCvGvTlKCHd9AJ4
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfXwuUslWM+rcd/
 k7zOizxRo4+eC7NrChkrgrPrrAFryKqZQTuvvgjeqJNC94Ghib5FaST2kB60Js14BOu1Au6QbCX
 9REBJij9Lac5zjkCRCvHpkVf2g3hefE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfXxbr5HhbSffaF
 eT4aCSIMnRAVlNMjIieMJDrH4IbGboAG5WpCUwF22YnBa8JLAizAgjYzRzGQf7sl/c5TJ9Q71GE
 BM+9p8hOP/1XX0lE5MZ4IBrdK5JpDHgv3e0UD16p+F7iPyDed7hMpZaaNSvwfYKe4jCbCRVEb79
 zdvEqETsqtyQRDLKK5bq7Kr0lP6qXN4ouswTPBB1fNYIeBUQuj2jUWj35qNdK/yVczZUTe5UWC8
 rpfC1hXT42P1HK0Sl5T0Cx8NI/myPawQD5vozhPEJl76pBg4rR90fdQqN3WYJrxIZN3tPOzu3Q7
 BFPkHSMJTXGbvhbwvKEQBflTzqRSkdsX4fbHRTK4nhFbWNEZlK+IXhrohn68MGwNnipXLeOebc9
 JmjyJKKIYeka9zOXzyNXZ8xTYoDCvonHpyb4dqU9cVbLVWp6i6NVXqmy8YH9yskTYw82wZPaJlD
 Pk22PPHKT03TB6QZ6ew==
X-Proofpoint-GUID: yf9MqO9qlfE9xpmosZgejwGSI9_NOzpp
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb4c0d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ah_FiUNgRufG_lHBlQAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: yf9MqO9qlfE9xpmosZgejwGSI9_NOzpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230046

I2C transfers in FIFO mode can fail with -EPROTO, -ETIMEDOUT or
-EAGAIN when a target holds SDA low, leaving the bus stuck and
preventing subsequent transactions.

Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
hardware opcodes to restore the bus to an idle state. Check the SDA
line state through SE_GENI_IOS.RX_DATA_IN and skip recovery when the
bus is already free. Trigger recovery automatically from
geni_i2c_xfer() on -EPROTO, -ETIMEDOUT and -EAGAIN (arbitration-lost)
errors, and register the recovery callback through i2c_bus_recovery_info
to allow recovery via i2c_recover_bus().

This adds bus recovery support for FIFO mode only.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 119 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 60b6273f538c..065d7240de04 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -34,6 +34,7 @@
 #define I2C_READ		0x2
 #define I2C_WRITE_READ		0x3
 #define I2C_ADDR_ONLY		0x4
+#define I2C_BUS_FREE		(RX_DATA_IN | IO2_DATA_IN)
 /* M_CMD params for I2C */
 #define PRE_CMD_DELAY		BIT(0)
 #define TIMESTAMP_BEFORE	BIT(1)
@@ -145,6 +146,7 @@ struct geni_i2c_dev {
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
 	const struct geni_i2c_desc *dev_data;
+	struct i2c_bus_recovery_info rinfo;
 };
 
 struct geni_i2c_err_log {
@@ -316,7 +318,7 @@ static void geni_i2c_check_addr_data_nack(struct geni_i2c_dev *gi2c)
 {
 	if (!readl_relaxed(gi2c->se.base + SE_GENI_M_GP_LENGTH))
 		geni_i2c_err(gi2c, ADDR_NACK);
-	else if (!(gi2c->cur->flags & I2C_M_RD))
+	else if (gi2c->cur && !(gi2c->cur->flags & I2C_M_RD))
 		geni_i2c_err(gi2c, DATA_NACK);
 }
 
@@ -1013,6 +1015,107 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
 	return num;
 }
 
+static int geni_i2c_fifo_bus_cmd(struct geni_i2c_dev *gi2c, u32 cmd)
+{
+	unsigned long time_left;
+	unsigned long flags;
+
+	/*
+	 * Clear cur so the IRQ handler does not attempt FIFO watermark
+	 * filling or draining while the recovery opcode is in flight.
+	 * cur and err are shared with geni_i2c_irq(), which reads cur and
+	 * writes err under gi2c->lock, so take the lock around this reset.
+	 */
+	spin_lock_irqsave(&gi2c->lock, flags);
+	gi2c->cur = NULL;
+	gi2c->err = 0;
+	spin_unlock_irqrestore(&gi2c->lock, flags);
+	geni_se_select_mode(&gi2c->se, GENI_SE_FIFO);
+	reinit_completion(&gi2c->done);
+
+	geni_se_setup_m_cmd(&gi2c->se, cmd, 0);
+	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	if (!time_left) {
+		dev_err(gi2c->se.dev, "timeout waiting for bus cmd %u\n", cmd);
+		geni_i2c_abort_xfer(gi2c);
+
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * ARB_LOST and BUS_PROTO interrupts may be reported while the bus
+	 * transitions from stuck to idle during the recovery sequence.
+	 * The opcode completed successfully so treat these as success.
+	 */
+	if (gi2c->err == -EAGAIN || gi2c->err == -EPROTO)
+		return 0;
+
+	return gi2c->err;
+}
+
+static bool geni_i2c_bus_is_free(struct geni_i2c_dev *gi2c)
+{
+	return (readl_relaxed(gi2c->se.base + SE_GENI_IOS) & I2C_BUS_FREE) ==
+	       I2C_BUS_FREE;
+}
+
+static bool geni_i2c_needs_bus_recovery(struct geni_i2c_dev *gi2c, int ret)
+{
+	/*
+	 * -EPROTO and -ETIMEDOUT indicate bus errors where the target may be
+	 * holding a bus line low. ARB_LOST (-EAGAIN) on a single-controller
+	 * bus indicates a stuck target, not a real arbitration loss.
+	 * GPI DMA mode extends this trigger separately.
+	 */
+	return !gi2c->gpi_mode &&
+	       (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN) &&
+	       !geni_i2c_bus_is_free(gi2c);
+}
+
+static int geni_i2c_recover_bus(struct i2c_adapter *adap)
+{
+	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
+	u32 ios;
+	int ret;
+
+	ret = pm_runtime_get_sync(gi2c->se.dev);
+	if (ret < 0) {
+		dev_err(gi2c->se.dev, "bus recovery failed, error turning SE resources:%d\n", ret);
+		pm_runtime_put_noidle(gi2c->se.dev);
+		return ret;
+	}
+
+	if (geni_i2c_bus_is_free(gi2c)) {
+		pm_runtime_put_autosuspend(gi2c->se.dev);
+		return 0;
+	}
+
+	/* Bus clear cannot recover a target holding SCL low. */
+	ios = readl_relaxed(gi2c->se.base + SE_GENI_IOS);
+	if (!(ios & IO2_DATA_IN)) {
+		pm_runtime_put_autosuspend(gi2c->se.dev);
+		return -EBUSY;
+	}
+
+	ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
+	if (!ret)
+		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+
+	/*
+	 * Recovery succeeds only once both bus lines are released. The bus
+	 * state is the authority, while a clean opcode status with either
+	 * line low is a failed recovery.
+	 */
+	if (geni_i2c_bus_is_free(gi2c))
+		ret = 0;
+	else if (!ret)
+		ret = -EBUSY;
+
+	pm_runtime_put_autosuspend(gi2c->se.dev);
+
+	return ret;
+}
+
 static int geni_i2c_xfer(struct i2c_adapter *adap,
 			 struct i2c_msg msgs[],
 			 int num)
@@ -1037,6 +1140,15 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 	else
 		ret = geni_i2c_fifo_xfer(gi2c, msgs, num);
 
+	if (geni_i2c_needs_bus_recovery(gi2c, ret)) {
+		int recovery_ret = i2c_recover_bus(adap);
+
+		if (recovery_ret)
+			dev_err(gi2c->se.dev,
+				"bus recovery failed: %d (xfer error: %d)\n",
+				recovery_ret, ret);
+	}
+
 out_pm:
 	pm_runtime_put_autosuspend(gi2c->se.dev);
 	gi2c->cur = NULL;
@@ -1239,6 +1351,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (!gi2c->gpi_mode) {
+		gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
+		gi2c->adap.bus_recovery_info = &gi2c->rinfo;
+	}
+
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret) {
 		release_gpi_dma(gi2c);

-- 
2.34.1

