Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676D497B65
	for <linux-i2c@vger.kernel.org>; Sun,  4 Oct 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141007; cv=none; b=oouEaBg2G6f+1+A7ejoWRgEjq2mkOTmcR4ViogkQW03w4CXEDUbmsKqQk0DqhTsfuAIfAm54AykzJ8EvQm3yMXoCnoT57bxHpercIrzRu5SzNIqIcmXmEDnFWSt7oJqvy+yhdGZuBA2sgF1x1QBqT3bGbLoTKUQkPlQSscvKPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141007; c=relaxed/simple;
	bh=+BFjDkLLGiM4Z4BilxjEIUHw5Q8uQiEcFlpgHQFk4iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/F1Lx2OqRGRKt3TkQArpp0EaXSf313lT6diRVE84etlIoQET+NzztqIGOiOJF2i67qB6W5meFbrxHKMBKPHsKpGdDy94I2lQM5J3xwxwY/bU34VAadC3Yzzq+PateltSaOukVuviISbVaX2hsOElNOQ/S2qM6u3+GcNVx6UUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpeB5qLj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMVM9wwQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpeB5qLj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WMVM9wwQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694IHn743673006
	for <linux-i2c@vger.kernel.org>; Sun, 4 Oct 2026 19:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J3rp9e5dLRcm3b9/yRcUca1yu8dnsEO/hPj3KPAyrCQ=; b=QpeB5qLj+BsZ0PG2
	h9rYqLXwrHtR+rZL51iB8LZ+gHAOHE3MzcDF7jQJDW65BKKeWoS2YvuJSqKgp+wh
	cxZbHbcnMx4aGXXlgxMKSZ2/NIn313OD9zcP8EaYsryi5IhZOq/PMPfswYRHZKAd
	IO944Nr+QA0ahhR/ltJUl3Co78AHD6thfVRH2Sa8aAhF7fCQi0iX2eoD6rRHhwpl
	W0bkpWbVEGmghoZ/jTPOZh+iPk4TrjPK5kxC/RzdP9poEprnivNmn6FRM3s42EVV
	/Xjs5NhoqmD32t2ouPi0Xk/Nf7bgUAJObGcpUx8FRH5F62YpjxeeWUX756b0SGs+
	wpr+FQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2t06ukw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 19:10:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337f26ee19so32048941cf.2
        for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791141003; x=1791745803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3rp9e5dLRcm3b9/yRcUca1yu8dnsEO/hPj3KPAyrCQ=;
        b=WMVM9wwQQUz9taHGJXysSlfN5CqcyKhsTGxO3Ya/FtDIiSgaWPxsawrplF0nmSQT6a
         E+D2WGdp2OekCOtPptsDZ4Nzz2ANuFnDTRgHF9SEr9i3VybCaRH+dPOpKkp2Qni22PUs
         SJK6C8DAXbF1v2iYfR40GcE2KsVCCEk97Yu4HvYkAGaC711nJJ6m4b1oWpr+0ncCFJcb
         SAwXHK2J9kx/TMsdXe1Zgh1b41Ykj6Biu3aBScLZMu6MXws6BsvQ2kve/QM5ZhyuPsxi
         VhvWfPEKjPR40HpzWbAKVSHoKRp6vLmsmKYw/2Jub0gUOTVYSremGjRCbu8K8dmEwllr
         lIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791141003; x=1791745803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3rp9e5dLRcm3b9/yRcUca1yu8dnsEO/hPj3KPAyrCQ=;
        b=1ZRndYyv7pQ4JBXvNVDi/GduwYkr4Z1qqvOMBWwNh3rLJaLLQZgpBuDMZu+4J+SP3J
         Ni0Qebq9TUUWa9utMkwPto7wOAhyJBMPC/0yDsoU3Y6WqN3/3NKvgNKfdEFz4371us/x
         0ttrRYAacQEhxRPMUe/jSwuq9OQDiLnVbHL4ZdEwP+xlZkweFe6NIjSi3IOFS0HtGMWE
         NZXH5nnckd47clOvPmVonHrtCqRx/ujsy3EfxAHFLUJNuf88b8daf5q3GS0R6UZLmueI
         sXexU4jDOROdbjk+PVBMVzRlqAOVh45eTbJIAleumxXU8uuHW5X+dWfCOGP5JHE0W1TW
         pzXg==
X-Gm-Message-State: AFuF++kxd9M27raZTsgJdEKUe/VSYjpqty48BQK6ngycL0yFOTFvBXWF
	OogWNSQeH7IU0On0O0TWGXp4XKT2kUBhbVxiqbbEjnfq5HUuV22puJKzSo4FRaF+y+ucHiQ+mmv
	vFh03dVEUvedt5Y9NDI8fra4l5eR7mMscnHQiDUMEP37cSIqV/KKLSAom1ga7yZI=
X-Gm-Gg: AYBFou33ugnGuyBn/+DEe8/IcwTNTi6QOemJ/LMjjzShDzVbbrbcs5DwOFA10FNV2WE
	XM7pYIg84ejejVn38h3eQ31S556llovtM2xzJiMVTOYcJcHIVVhXFqcnhroVxcV8y380eaiL/zv
	swo43HYTPbima4f4+YJYxZzEb21Fw31R00LKez+hAKJavTuuSSDW4Ggz3DC4MIsQCNRU99zQhI6
	BuXJic7wPKVAWehJTsVdcPXTfu6tuNGUfVz5hvHk4E6yoBulfxEHXIqE8QVfxVT6XPza5AS4uEg
	rhwtDSjH+BtCdbruCYnngt8zaZLG20L1jTmGedreO2GWt/XOLFS47g+t8NUkhKeYWyIiXCrv9hu
	i3pwbeTPBhhH/ycatFdmT9fCJoc8pS0HSsL2zr/Nhd7fhNsqmhTsfoLG++eOC4RuGg3tcLXeoZz
	czUhZyQNMAXQdEpYh9wtNiy5QFFCLI5NqE4QkwDvLcHTsdNPcITw==
X-Received: by 2002:ac8:598d:0:b0:535:2568:c7b7 with SMTP id d75a77b69052e-5352568ce3fmr40815121cf.9.1791141002855;
        Sun, 04 Oct 2026 12:10:02 -0700 (PDT)
X-Received: by 2002:ac8:598d:0:b0:535:2568:c7b7 with SMTP id d75a77b69052e-5352568ce3fmr40814881cf.9.1791141002482;
        Sun, 04 Oct 2026 12:10:02 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([37.169.59.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394ca0f0sm176318385e9.1.2026.10.04.12.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 12:10:01 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 04 Oct 2026 21:09:50 +0200
Subject: [PATCH 4/5] i2c: qcom-cci: Add burst write support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-cci-imp-v1-4-227d12cb4829@oss.qualcomm.com>
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
In-Reply-To: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=cf5HPXDM c=1 sm=1 tr=0 ts=6ac2a48b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=1Gfya9YG+27Uq/30OuQ23A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IknTBVmojEPKtAEnxLoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: vUf0YGXuz6oF5KUj2Ddo-QuNM7nYVMMt
X-Proofpoint-GUID: vUf0YGXuz6oF5KUj2Ddo-QuNM7nYVMMt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX8kS0TYlXAWZr
 aSlTf0n2m6uhoA6jjLVgKRx+TouT1AqyEp7/Sm6e5NZttDDX+O78ORf4CoCm3tuJTiaPXZkejPL
 ffXPNQ0tzj/UEo0pTOO0WQYbXm05sNPx3cwGrI8NgglkD3msH1ZFzxUeOHN0WYTaOn9XLUjySWW
 4bMlCtZdjBjAbTGGsrt59FiiX0GOuh8d4WRyK0yuNs7PpvX7/vilqEOSxZPiPb/drw4Z2RlzYBD
 4OL6kKXRb214k3RFAyZUfzkFDpNbkg9IgtwjP97o1z2d2tHJpkRNSmTX0Xbeq/2N5J8cL7r3cMw
 db9ymU5EWypo0l4wusr3h6Vf7Mz0JKMhQDUgs19QCBFzut9T3XdAkx+RNAfUbahhNFzbwxeHN8k
 7rpg/ebc7ZuSj3/nEpM6FoTZwkFXB+wIGeCOza/Fy0Pk3usFOU1Wd+l7G6KO13BRCfV9neozxh5
 L/BbOkyJQIYIj8dYSYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX2IapAFRuPLup
 /eWwMyHJmg0q0Wa7eLYmSUzs2q/yIjS3f/9n7GkqCBKtNhTY6I2YELCxNEHSJigRnl9zW2rYaHQ
 tTTHDfFJWzysU69EOPpEXzGJApACxAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040076

A single CCI_I2C_WRITE command can only carry up to 11 bytes,
so every i2c write was capped at that size via i2c max_write
quirk.

CCI v1.2 introduces burst mode support, where consecutive
write commands (marked as burst) run back-to-back as a single
transfer.

Use this in cci_i2c_write() to allow longer writes across the
whole queue instead of a single command's payload, and raise
max_write_len accordingly for every CCI revision that supports
burst mode.

unlock/lock commands are required to ensure the commands for
a given transfer are executed atomically.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 44 +++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index c0b39d419e296454a083d38ce302940875b8ad2b..9554d42e6b976ef33f6421a98209c2fb837e9698 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -85,14 +85,24 @@
 #define NUM_QUEUES	2
 
 #define CCI_I2C_SET_PARAM	1
+#define CCI_I2C_LOCK		6
+#define CCI_I2C_UNLOCK		7
 #define CCI_I2C_REPORT		8
 #define CCI_I2C_WRITE		9
 #define CCI_I2C_READ		10
 
+#define CCI_I2C_REPORT_IRQ_EN	BIT(8)
+
 #define CCI_I2C_WRITE_WC	3
+#define CCI_I2C_WRITE_MAX_LEN	(CCI_I2C_WRITE_WC * sizeof(u32) - 1)
 #define CCI_I2C_WRITE_NWORDS(len) DIV_ROUND_UP((len) + 1, sizeof(u32))
+#define CCI_I2C_WRITE_BURST	0xf
+#define CCI_I2C_BURST_OVERHEAD	4 /* LOCK + SET_PARAM + UNLOCK + REPORT */
 
-#define CCI_I2C_REPORT_IRQ_EN	BIT(8)
+/* Largest write that can be bursted through a queue of @qsize words */
+#define CCI_I2C_BURST_MAX_LEN(qsize)					\
+	(((qsize) - CCI_I2C_BURST_OVERHEAD) / CCI_I2C_WRITE_WC *	\
+	 CCI_I2C_WRITE_MAX_LEN)
 
 enum {
 	I2C_MODE_STANDARD,
@@ -520,14 +530,15 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	return 0;
 }
 
-static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
+static void cci_i2c_load_write(void __iomem *loadq, u8 *buf, u16 len, bool burst)
 {
 	u32 cmd[CCI_I2C_WRITE_WC] = { };
 
-	if (WARN_ON(len >= CCI_I2C_WRITE_WC * sizeof(u32)))
+	if (WARN_ON(len > CCI_I2C_WRITE_MAX_LEN ||
+		    (burst && len != CCI_I2C_WRITE_MAX_LEN)))
 		return;
 
-	cmd[0] = CCI_I2C_WRITE | len << 4;
+	cmd[0] = CCI_I2C_WRITE | (burst ? CCI_I2C_WRITE_BURST : len) << 4;
 	memcpy((u8 *)cmd + 1, buf, len);
 	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
 }
@@ -536,9 +547,12 @@ static int cci_i2c_write(struct cci *cci, u16 master,
 			 u16 addr, u8 *buf, u16 len)
 {
 	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
+	bool burst = len > CCI_I2C_WRITE_MAX_LEN;
 	int ret;
 	u32 val;
 
+	dev_dbg(cci->dev, "master %d write: len=%u\n", master, len);
+
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
 	 * This is to avoid overflow / underflow of queue.
@@ -547,10 +561,22 @@ static int cci_i2c_write(struct cci *cci, u16 master,
 	if (ret < 0)
 		return ret;
 
+	if (burst)
+		writel(CCI_I2C_LOCK, loadq);
+
 	val = CCI_I2C_SET_PARAM | (addr & 0x7f) << 4;
 	writel(val, loadq);
 
-	cci_i2c_load_write(buf, len, loadq);
+	do {
+		u16 to_write = min_t(u16, len, CCI_I2C_WRITE_MAX_LEN);
+
+		len -= to_write;
+		cci_i2c_load_write(loadq, buf, to_write, len > 0);
+		buf += to_write;
+	} while (len);
+
+	if (burst)
+		writel(CCI_I2C_UNLOCK, loadq);
 
 	val = CCI_I2C_REPORT | CCI_I2C_REPORT_IRQ_EN;
 	writel(val, loadq);
@@ -712,7 +738,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 64, 16 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(64),
 			.max_read_len = 12,
 		},
 	},
@@ -721,7 +747,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -730,7 +756,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -739,7 +765,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 1024, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(1024),
 			.max_read_len = 12,
 		},
 	},

-- 
2.34.1

