Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696220;
	b=pxzt7J0pA3j1l89BDLt9r/RMUzqciVHtcfg+N53qa561rLXI+P5VoVazR2+8Hd94afmG
	 L2f7ZExPAfPhZMvEi17CuhE7jOrYD6gJrzJOET08ILy73H+Wgbrm4kIsiRe/eUzqTdiii
	 /oC88wcNsyd9Gp3ktut1woKg/dFcGUJQRVCWxLPv32Wm53h0RwGuwNcetpgCcPNxiLOgL
	 sBehU7ErbDuKbl+4z8zp69hnxeTkOoHWqufWI8g8GWXPQ1SO/0fC/vwhx9X6jTYbgijTk
	 njqNai+seGzEj0pyoE093DA8IEeWDNP5Tclp9GqVDEVgragP5GdZKR1+xGf5vDtUStQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696220;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dZ7RChXsBE4e2NQjMFi9+emvoDPdpsRGyTqHgg2FmS0=;
	b=4eBhlLLgbCc3NHMcDfYu1MoBd2EtfU5suUOgnj8GfHBnz1SH2xGn6C4io5E0i0gHPSfn
	 evtn8gH18O5lnayRixVffTK2Si57YltxZ8JqZj+4VMcczeEWoQ54z7ovmndN37u/vedw/
	 YAGT4877J69DqNEOj8pBm9IPuSqLYtCBMP8hmyY3jYxLz6iLrlpfnOLkYJq4vp1oJCihc
	 k4nlfL/75tqjerbEWqxUUPUjdrEGHWJc7n7VV0DHP2xZdAzbzMQ8YI8A66P5NTQQQPFwL
	 YmaV5E+g6NTKAkvO8K/DpwQf8R/RNqFoB0Di2+sKZ/rKbJ6lnFmSkfHelDPtAjROtHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SXwmlaMz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mcclxg5V;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6F606D818
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 08:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C6F606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SXwmlaMz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mcclxg5V
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A34h9Uu750949
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 08:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dZ7RChXsBE4e2NQjMFi9+emvoDPdpsRGyTqHgg2FmS0=; b=SXwmlaMzvHwEqdoi
	ub910vcWjvuzmpW9MzUn6trvKdaNNE/c3sLQSROhNqe6IpTSOIKoi9pe4bWQNEkC
	6LS94Uoe/9Rquwj25P/rR7C9QiNe2q5P9myC08Cq9evvThMHD2ZAwhPtD5x+tuVf
	GZWNsAODvQ3M9bdlCvn+HUlYiPA8Hrqfe+7isn5PpLh/VDcfifBJ280prZRc797m
	j3ftLKfWlVAUCdPksy4gS4CfnV4S0jXiXepYT5BvInQ9ybYcaYvMJ5J32cKKFCWd
	rMBsoel/ojywATkMwxVfTlm2fG3o0uWFRIHLM0u4yAtG70blzN+ssS2OX0+drxzf
	ZzEToQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5gx2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 08:56:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso4893796b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 00:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793696217; x=1794301017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZ7RChXsBE4e2NQjMFi9+emvoDPdpsRGyTqHgg2FmS0=;
        b=Mcclxg5VoCniZlI7efGSa/tuudec1i3K9q2X1ekkMJHqAaEbaGa/1iG5xOGtumRZfC
         j2OQHxwO1ydsC5dKTGTDEC9lcf84W0l2IoLANyPybhyozry9hwOdfM9HChoNBxbX6l1e
         KfqniGT3DJpkmATGLFTJubn4PjqN6XZUkEOlZ7/17uYIbj3GK2yCD4zJghkVGgRmGwAW
         3v5vP8Jcfi4KE2N29sRf0L8pWKT9nNVSn3dSf+j3uOvml0v/BaG46t2z8blxBt5zjWs6
         t93q7uWBBEljuQGyCIalVne7Q7WMse7ai7tNX8PDkGs4nN+iPAqt0KDHHWc5KjFisCMU
         6vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696217; x=1794301017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZ7RChXsBE4e2NQjMFi9+emvoDPdpsRGyTqHgg2FmS0=;
        b=e4T8KI3+f6qlIBxWjEZ4BgIODp+CEfm3hgVr8qcnSFITDMSOq0P7BwhLNkqQmBj6kd
         FDeLBx0Mj5juTyh7wQvTf6t9HISVIELl7FtSpBZiPT9NX+0A+mIYHX3hjFSfDBH7uBs6
         OMpOMC5hC4A7tB0aHzd2VxTi/A3WWqQqhRnpDGXDIQ3zDhpEQHyRztL+rXzQ5ueGU/AX
         34v+jixeuVloXkOdV25K7Onn27YOAuZKGO9/mGi6u3XM/OSFVcDBNblMYhPdSjAq4Xq8
         EK6Zcjj2SkYpHGctS/IGHmGonKnKCA8trsYG20zdJbeNnV9GRZ9vMLLYog8mxo0pCeqR
         mOMw==
X-Forwarded-Encrypted: i=1; AKwUvBwickaWk6LGLG72yMfDzJXAb+hQsO/kdaxFUtx+GI65MTeuAx2YSFx0o95G5Q1kOLfmxb8aJfQWDB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mtm9MFBmDWIP1SkAzpJjYuwjwMEQB0GptEOd5tpvDS0S/nApW
	TDRCgvKyyy+n8c4W8vTMEIn/zOLG1fVAuxBNQowhb8OrYkbjeUsCc1w5AnSm+hqjpov+hvQYyyc
	f3kivdj6sYUfJR1df330bUr2Ek1z26E4UD/D2ko+7t8igLajQa4b9KagAOWvaa3E=
X-Gm-Gg: AYBFou1QKiA4QNvTiWxVHFl/oY1qE28E5/2XbK6oDBPuuChjCfdMeIbX2+YnrEG5QJC
	fMOetOJ72q0QX+trbrVHx79PpR+5TZaaFg+eNHosrSVWXXSDB1z8KrOjEmjhMHnJj4LEqTeyI4W
	OFAzPX9/1IS3Sxh3QSRHdulapO/gkF1YnsvOHLisZCLdGznZ40V8nwns70XJa2z/EQV9Km0QTpH
	jEuHpy2uAUiUnQEB/UAM83Y9wOM6zFvi13y5zQtS4PqtWMIffqYP3YWnehFJR4onea6tYtdUw/k
	2/87dw5srFw6bHEl5frMOFgMjsk1Y+d97kDwWoPEb2hJbFjOnKRPrX+5WWZ/5wakKPZG8Yo27j5
	X/iNM8wOd5mO2pmwoqO6rvWs5oKfxIsaZ1ZnX//752CTl7Qs2Ky/ceYbLqmI2fGi+4Ul6VhGSJI
	LAOyefzdI=
X-Received: by 2002:a05:6a00:b48:b0:8a0:1889:9685 with SMTP id d2e1a72fcca58-8a9be681f7emr10562559b3a.28.1793696217429;
        Tue, 03 Nov 2026 00:56:57 -0800 (PST)
X-Received: by 2002:a05:6a00:b48:b0:8a0:1889:9685 with SMTP id d2e1a72fcca58-8a9be681f7emr10562542b3a.28.1793696216891;
        Tue, 03 Nov 2026 00:56:56 -0800 (PST)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963cfe7sm3017471b3a.19.2026.11.03.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:56:56 -0800 (PST)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 14:26:41 +0530
Subject: [PATCH v4 2/3] i2c: qcom-geni: Add bus recovery support for FIFO
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
Message-Id: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-2-59b3ce96dc4b@oss.qualcomm.com>
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
In-Reply-To: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793696204; l=6282;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=JXZdYXeEm5Hz86I39VFbba/pmrAnLFDlRH2tGQYtGfY=;
 b=+fK/A5cV3UJOyGvZlLXqUWWive3KXGBnZEiBM9abnRWbgZVNpzqprVKSP98e9lam4ECVmjvyH
 wIMKMAz20X5AVQqWiNcU06ZRP7yCQ+Ne50hy1iF0m8wI/I9D6HhIH8X
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-GUID: zYZ5jpaXSmNf92RfmYBQDWjt7toW_AK1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX8nJ2H4T5+lkL
 F+knTLlhTOKAx9JTwp8YAsqm5qj+oSZZB0Trzm2L+hfjWit1X/GB6IYv4NFsBvBpaU8D+G8mMTy
 q1jkt3SPRFehcaZ8+6b236zSf8kcvds=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae9a1da cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=c5Wb_hjG3JCSEPZH9V0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: zYZ5jpaXSmNf92RfmYBQDWjt7toW_AK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXwWUgV2QTwEiN
 7XMgO7bednI0AWH30k2JBM4t59sJNDWZsHzwMhzTIj7GRnig44V17s1a19lGqaveEjRUO0pZvfK
 a54i2zjVFinQlW06t+uf+CUy8zzHRTBS35HgNs5lu6CY4oKuROF5D4hM3Y+Fis8VDEcyObIEOn7
 Yj5BQ/bVjRrJ/nOPay/KIAGz0tc1Cg+EFDq2KayuEtzbvYCi5t3UFls+QpU78KuIsRGM6a6Hc2v
 WLddEW8SMze/6zOa1ILq8P4IVTQ46Fq0zgikd1IIeYz77hSej4o2lH44HkikFm5mrxluNj6q9Xa
 BEdwQbg9UrQBXUsES1A8KoSmfitBETEcI6SXvDCMu0i/Hp2iXCu9bPP2Sdst4wE5JfcWY2EgzKp
 3AB7VOHhIlUSZ/5d2ZJz+4EhcXO0jbechzWC9yEMslHwEC9rF/KkLQMqeApd+j9kEsbxWkZq6yR
 lfwgxHw4j9h0JSRsHAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030035

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

Use the adapter timeout for recovery commands. Configure the serial clock
and bus timing after runtime resume so direct calls to i2c_recover_bus()
do not depend on an earlier transfer having configured them.

This adds bus recovery support for FIFO mode only.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 124 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 60b6273f538c..b08353616adc 100644
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
 
@@ -1013,6 +1015,112 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
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
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
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
+	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	if (ret) {
+		dev_err(gi2c->se.dev, "bus recovery failed, error setting clock rate: %d\n",
+			ret);
+		goto out_pm;
+	}
+
+	if (geni_i2c_bus_is_free(gi2c)) {
+		ret = 0;
+		goto out_pm;
+	}
+
+	/* Bus clear cannot recover a target holding SCL low. */
+	ios = readl_relaxed(gi2c->se.base + SE_GENI_IOS);
+	if (!(ios & IO2_DATA_IN)) {
+		ret = -EBUSY;
+		goto out_pm;
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
+	ret = geni_i2c_bus_is_free(gi2c) ? 0 : (ret ?: -EBUSY);
+
+out_pm:
+	pm_runtime_put_autosuspend(gi2c->se.dev);
+
+	return ret;
+}
+
 static int geni_i2c_xfer(struct i2c_adapter *adap,
 			 struct i2c_msg msgs[],
 			 int num)
@@ -1037,6 +1145,15 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
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
@@ -1239,6 +1356,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
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

