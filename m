Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233006;
	b=lM38MclNDGU3/Rg17hTDoN8iUeBOQoh/dK6hvxHd3lThByaY4HeAR98PK7BUFhr1Det4
	 w9Sqx78aAX75ErnTumkrfg4ksxqWrabXqcIfW4LBNx8Qf0DHAqTl1/Eltgrg6Th3a7sTQ
	 27AOY05PnTnhOO9yLxWL05/CVIEJEgW2UztE2QpoI8afg/f2GOY8WX2zkdhhyqkGBGCuP
	 LZu+E3itzYSXmC2cVZk1fIiCdLaBEPqma/3RjxTssyUn395a4Q3EgV9yHjSIoVZsaVNoc
	 TatEBzNMt2q51kOBbZhtsdTUSXmX8ZyMwCrYJlfSrdI5F6130y4UCbzBKLcN3UZT0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233006;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PrVp+K/tFEuf9iJ99Gnzsx1IjRK1SVHkagaubIClMPo=;
	b=r54j0L6hgt+5k5hp9+7GgkBpuKEqQvaV+TGrEJTAg7PKrYrtgMobKy1ljhQhsosc0Y6y
	 ULNnoklx0Tc1neV22+uo+nZmF74+ddY1chxIY7kaRebxuoY/0/EceWaa7lYNTOVexI+Pi
	 g+GTicddTOqymXNAwuDHLJUKHmOS7htNW1FF/h+Ggn7rltoiEwe1Cd26gxywxXQxtZasY
	 dru70y1d+6WucnyKKYNXVOvGVIek2xcijz7XEFp0mywYukqpYsI3jAm9AGKTaObEUeJ2H
	 o1bZ18NvMNX45RxWRy1wMNirEumx135IDu2y45IVM7ZNSBwUNgkiMO98qVb+nP/6dBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RIWR7qCD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rh9mAhg2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED33606D813
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 14:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED33606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RIWR7qCD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rh9mAhg2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DF6RG3461055
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 14:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PrVp+K/tFEuf9iJ99Gnzsx1IjRK1SVHkagaubIClMPo=; b=RIWR7qCD4J9UKU+I
	wgZvTOb4k8q16s19UJUTI0trJrDKVyB+uksWSr3uUAcV2LY39KbYK0dl1CvtVHZT
	BpluA8mj3Qp5BuNncxXXiNti9gPyNXGU6Zdpu8g8ejxDgsZJdEwBt8jzIrHl2APk
	3Yhth2OUgcjoAF2SBxQfd314V46OS8aL836RIkoJQnXFfXaIuUzJRKOb/LMmvaKn
	9q9+sK2+hNaNhu6X/gSPrVZJJIUPxgnVz2jNXOQzsOo3j6sSZvyh9UAQ7fQajaeU
	qU8RU9JOidOdSy++U7isH1osvvbWLVW/K8lIx5klcC8SHfl67Wu6LmRViH/n4tOO
	mI8oPw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0rrc58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 14:03:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5337ed1ba44so19865021cf.3
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794233004; x=1794837804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrVp+K/tFEuf9iJ99Gnzsx1IjRK1SVHkagaubIClMPo=;
        b=Rh9mAhg29SHC0MFnD5logYEVRaJBc4cpf7E0RMM83iYaf4noX2h9HPpvSlQ9k7w6Bs
         6tESq3yGt/t0AAzYQbzCwPqsl1BRZCwMuLwd/8H8oYZNYm/3CI9jJJfK+QpYpBfyLxtE
         MP9PnZN18eXwWKVXLShiiEbmtdUV/n4TDd6P0Jl/Dp5+UIIJZkGDSbWVfflUJfy/dDCP
         KM7Xh0fdAz1M9q3iY6bLCAfqb50GS/Q1xPcAxN+W2IKwHUtOqQlSbi2vKdHTMegBjI41
         87GDkV1IXkSVsHoHj0xsvnnIdhFsPdsDrzeoJnCQBiMcQVDqwlZyTZbMuk2L6u9jfjRU
         AACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233004; x=1794837804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrVp+K/tFEuf9iJ99Gnzsx1IjRK1SVHkagaubIClMPo=;
        b=TF0WxpVEkDVvJ7sPA7yfEZyS65iXNEmSHHTIKYJZC//zLvn3bbl9Qvk2t+EPBrubLt
         gOAkPqEIN12rsQu9fMnTfnygISpOggpXtii8uP9xkSXXxv/HgMs1nuyCW9SeUF5EQjXb
         0ph292sFRRzH5Cxxm2vuGWTSSOzUyYWRmz+ATt+CsSyRwwhr7JlV8fWZ7Ii6mC9EjMEz
         iCfyzaRf7yvJjwfwksIAN9MgLCmFJbiPjTyRqSxn3h5USYq594empXLBiGt+7siK02cb
         HE26Fv7zW8PLtKuKDedkcNW5cAiRYfKATBhh1JpxJ4W+TX6hCpvJQrFSdDnIhqSG+rgo
         vEaA==
X-Gm-Message-State: APuU4Z/gGMtp6eOspRDzEQsWltbz5MBrs0b/QEXARCey2nVqQGBKFsL8
	ktsj7QEPoQj1cac4h/pzDJyNGSBMHWHz29ZPwtKU9QF0d7HsSaPSnXfaOmF6I9R04ygdoirWRpe
	pIN+uEPsIn1xLARsOfQRyXxnqQMHTyhAKNzeTWt7WZEav0vuUshoJ5UPM/SZkIUyTXp5REpkxjw
	==
X-Gm-Gg: AYBFou09wfxQDIzOzVv8dNwdvyf1KpXxnAzkP1+KAvrY+UsUgGiBwHUWb+nQXFDgyhD
	u+x/vHZZfQLqzwnYQ/d9bflRu62u93xF5Ya15oFNJn81eO5kvVPykIv2CeMEHarVWK9MnhnSuAN
	lIvqnvaL/xRweKwL9a+3lLlyzmndDk4bpPE9vB1SRw1k0Q6jUJa2/cpBhDMERpEU3Y3Efzu0n3M
	sBv3kEQvjtyumdgcy/AfS80fyzTfra3x4fhiQB8CMlTkEYlax3JEPbEWh1YIgyFkogDNsgTSwDi
	CpkwgbujWYY/OO4hl93YK2z4fe4uJ+edmfsPvyweU6xQgPQmsAUqtBO44HsmBP0jpSeuTkEoyMH
	F967K9INimMgDu3DDOiLmu4talXigffFhGqiuo8qkjRkmcPyzNyL5PV7bZ407Q/Zc2VreCfn6+Q
	R+yTxmRA1KdAHupG1P+MoUZ14uGv6PHNe6TJe31JYLA5SENMvtY+J50GbkPOHkQo4ns7qZOgp3I
	mv3smBvxgUyRdjhI059VFJilYn4
X-Received: by 2002:a05:622a:447:b0:54f:4fcc:10c8 with SMTP id d75a77b69052e-552a5b7245fmr55045581cf.75.1794233003901;
        Mon, 09 Nov 2026 06:03:23 -0800 (PST)
X-Received: by 2002:a05:6122:e266:b0:5ea:e7aa:acb9 with SMTP id 71dfb90a1353d-5ece720b077mr1148155e0c.6.1794232965445;
        Mon, 09 Nov 2026 06:02:45 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f9b5:154f:6aa3:35d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm161515845e9.4.2026.11.09.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:02:44 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 15:01:57 +0100
Subject: [PATCH v4 4/7] i2c: qcom-cci: Add burst write support
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
Message-Id: <20261109-cci-imp-v4-4-4dc4095dd052@oss.qualcomm.com>
References: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
In-Reply-To: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Q5DNL6iw-evS_IPMaGBJP5Bbd4qS_v3-
X-Authority-Analysis: v=2.4 cv=MpfHeGae c=1 sm=1 tr=0 ts=6af1d2ac cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Yp3SuMTfTe4RQKdpiVsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX8kTugOJBsAxB
 3Bsk1YZmm1JnNj+f79zfyamoyt7c98tKoUxJLLh8n4vPi7OCut9xeX5cVRPyO9xoxjTaQk9ete9
 pLoXopvKZ7pEN41JCis+sdzfKhU2kL6tdEbEDS0Tf4BoXYSOCRaKVazTzwpW9FedLCow8sG4CUK
 017PpYxZH+NIW900xT9OzfXoOVGmduVl68ESWOHpLCdU8qdhpy8T/R85gC+kUa8dOM8hao90W2Z
 pZoeLot4sxH+3Fh+nNVs3DpWqx3vIPI8ciUrUD6NeTTAKzJHZtjtaH2gpG78EUOjGi3KvGXGEl+
 mvvQhnhokE+ZpWKSKenDfoVA6e06RDOZHeBlTjg1F4nBBoqj24FPgTiEytOBT1Ot/AbCXFq/nK+
 sJnJ4OhiQ95y3j1tXNJ0si/BxpdNL15gzfP/+DdinFVxoADrT4wr+4Vwpac7X/B94hqVQthYP4B
 JaDVvcJRYNOilB4NA4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX8tcbAKa6H0Lf
 x5BMP8VAR7RlKI9gjCCed+kjZUjlJiLzryu4m1RXioyDAcXmOhWLrrQhM7SjW1VQUD1NK2aF5TP
 2lB7atB8jTGrJPnejEO1G1ddAsnAMO8=
X-Proofpoint-ORIG-GUID: Q5DNL6iw-evS_IPMaGBJP5Bbd4qS_v3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090055

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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 48dabd923b690864eccc29d232847c80f3c3b46c..a698130f4712492847336e401c0789b1a64dd02e 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -87,14 +87,24 @@
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
@@ -516,11 +526,11 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	return 0;
 }
 
-static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
+static void cci_i2c_load_write(void __iomem *loadq, u8 *buf, u16 len, bool burst)
 {
 	u32 cmd[CCI_I2C_WRITE_WC] = { };
 
-	cmd[0] = CCI_I2C_WRITE | len << 4;
+	cmd[0] = CCI_I2C_WRITE | (burst ? CCI_I2C_WRITE_BURST : len) << 4;
 	memcpy((u8 *)cmd + 1, buf, len);
 	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
 }
@@ -529,6 +539,7 @@ static int cci_i2c_write(struct cci *cci, u16 master,
 			 u16 addr, u8 *buf, u16 len)
 {
 	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
+	bool burst = len > CCI_I2C_WRITE_MAX_LEN;
 	int ret;
 	u32 val;
 
@@ -546,10 +557,22 @@ static int cci_i2c_write(struct cci *cci, u16 master,
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
@@ -719,7 +742,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 64, 16 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(64),
 			.max_read_len = 12,
 		},
 	},
@@ -728,7 +751,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -737,7 +760,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.max_mode = I2C_MODE_FAST_PLUS,
 		.queue_size = { 128, 32 },
 		.quirks = {
-			.max_write_len = 11,
+			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
 			.max_read_len = 12,
 		},
 	},
@@ -746,7 +769,7 @@ static const struct cci_data cci_hw_catalog[] = {
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

