Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F743B3CE
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137625; cv=none; b=HLUoMnGZgQma6q9FO3c4nwbHUsFFadZPMcUDInoExldwnmOl6yQfYcE+r3pDNxHhcRJSCm55og+7WwPz0sYso2Aqls4DBSZIygG5I/ZzeMMkjbAVHiJOARQGMWpZ0pc/R7Kd1w9m1Pf3aUZbJ+8m6qz4ki+Hrzix2TrrhlRT7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137625; c=relaxed/simple;
	bh=s4Xv7K4OvAD0uBwBVLJBBqdtGCwPrigiXOi+IUrvax0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnAlZ6ZTl5wg4DYGsWo8gcCprWe3rfe4psHPRv4aGGaMw1c2CD5wgJPqkKVRty34/x4SFXi5BIDsYOMH/uw24gkfOZch8+EEUb87oL0HAAvRpjTYpNvjEu5fZxGe5vSlp3vk0FcdWCF7kATK8bUlQaPUtxlHS8HZn1IZqh5V71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofe7O7M6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hO3Jd4aG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofe7O7M6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hO3Jd4aG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G6W6hs2678060
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NM/U8a44rlIT9UeEhwV9SbSD3GlJLAGz8cAmI6y5EAo=; b=ofe7O7M6GTGQTGg0
	dL1vLLvH9QtF3MIF1wwDevvJKELK//Hipsab5yjYEr0kl/Nu74wFeaayShL1fJ1X
	UH2bJiW8zv+CeAwOLhXyhlwIOWbZ7Bw0uzMucRACC6/DrXQR5Cl4vxE2f6gADr2m
	guiJESHVzy7m3S0QKO1N2SJlXYIg+L75mFJ9DhwCIHVWYfO+QMipZy54NQEg3FKc
	7fm955ov5VcjDr4qhM4RiZJ98jbtoUTBOMKpoLkKadjW1CjOo6m5nYvD6dRkT96I
	S/T5ZAXdk5DlAldhTX72qPOpxJeuFoSfTeCzOyr1B5Xbvor+cWXYfM0XyT36DvRa
	OE6M+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19tberj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 08:00:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a3f673221so1845272885a.0
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792137621; x=1792742421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NM/U8a44rlIT9UeEhwV9SbSD3GlJLAGz8cAmI6y5EAo=;
        b=hO3Jd4aGPG94Xj1uM/f8euZ23kelrWhQEW1HSNnMNG1wrylj72TmmEjShIR5vtvuE1
         5JcPrlAiViQa5RZ3ZcvoGgOM6hNONrI53Iy5M/mFCzEIU6sBGGxoF2eAlW3drgyW6Naa
         LJGj72p3zjYFsMZHpqgmXhmjwrbCQUnmg5rDJmk2r4+JCVd8PLTKl0rJmhcozn1helf6
         rnPKSfSvzP4/4tRemRksk0a4TwM7kLEzE+T637zY5JnokCACj5+rETX2DK6CZsHWtWPq
         62KWMWQB2HgYXShnmj8kcBKVLsytaQeTi4vUif03j9OPTvAxKO9ROeYm5edFT6p2qx0q
         HGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137621; x=1792742421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NM/U8a44rlIT9UeEhwV9SbSD3GlJLAGz8cAmI6y5EAo=;
        b=LOnno9q7c1GBojs3X5q3Y1WXW2bKUTY2X8kRAfV8AJQY0WGIusSsrk7hN3cIcEFdDA
         ++CV5ktxzMbe1N62OUzamVk2BnUljDGK9+PxPJ38Z2EPYKW53eVyH8STprkfGiOoqPfI
         ohqs7+l/cN8auZGsTmN/eX0KUKFRr0lZgWGqOjyLfC2g2nVj3nfNHSTG8u0dxeFyO8+g
         /zER96ptHJ8gLR4gNt3dzIRhrNAcu7Ln4lXUW3H8gznMSGlmYbem7V55KDaGhZXAdA/u
         TDKbRDGmgVMtVTgS0OJnSltGHmnwp6Kfg1bbZg1D3d10chuMSA6K8dL3PMFYq4tYG5wc
         juMg==
X-Gm-Message-State: AFq9FYJNXtM2mNrFXpbDCkVqVqmQh0oxMWT+AOMqZJSkm60/Bu+0mtKo
	RLav8KtsdY0PU/BzMo+zC7qvP8wHggtHv3yqxvDzhFkzFUY2b7RXnbr0SQ2k3zETj45UMt9v8/h
	XhaeyLvxC/c8RCQq/ntrTIzqtHQ4Kp+RWpiAh/j/SEDFh4r6Zbk8cmiNcQye2MXw=
X-Gm-Gg: AYBFou1jD+wK2ssORZvDtl5WC0U3MioLGsA+aLiDaClleI6SPxaaqQ6MMsGa5dcfcs7
	YhtYqow2p2/TP/RQ2OeuynBH6HXI6Sxy/E5xETabwkMO4X7i44sEG5Ad70DG/FHW7vIIZXGspkl
	HjBZuN8KLWib86i+t56b7RXSz3Mi0obtrVJLIARjp0yjK6P7t2J87TcHdd9YED/+Qd2NH9hldSi
	fj6V25rp6HBwTWaUbZeofmcBqvwZBIgwNhA/9n0khwJfx13GEQ9RxyobRBLCjGgEbLN01tfZ186
	k8WBRwT3c1GpaYivU5N6MTp92z0jNDFpDHum6B8jJ2h4eo7voYEq/h7SqUsszq5PFP+lk9fqi+D
	3fJPIAJubZGrYno8ixQ3xHhIXzDWCKE/36Wl9Gc0+rHiZGzobI1DIqQtLPk4dxnBtxc+KPqbkIW
	tTZ9pBapoJWeTntNIUhWni0VWNXXfVRW40tDUecbB/6TbXwWtrOVg=
X-Received: by 2002:a05:620a:2626:b0:93c:61ec:d17d with SMTP id af79cd13be357-93ebd224f79mr3279619985a.14.1792137620361;
        Fri, 16 Oct 2026 01:00:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2626:b0:93c:61ec:d17d with SMTP id af79cd13be357-93ebd224f79mr3279615185a.14.1792137619741;
        Fri, 16 Oct 2026 01:00:19 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm5471446f8f.16.2026.10.16.01.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:00:18 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:00:13 +0200
Subject: [PATCH v3 5/7] i2c: qcom-cci: Extend i2c read limits based on CCI
 revision
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-cci-imp-v3-5-5ee7ec1ea1a1@oss.qualcomm.com>
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 4SNnoRok82tql2HTOUfz5i8zTBDwYaA9
X-Proofpoint-ORIG-GUID: 4SNnoRok82tql2HTOUfz5i8zTBDwYaA9
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1d995 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Q-BVT9UuQ3EDAlpGIL8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzMSBTYWx0ZWRfXylp3/aVPsjXi
 q7/hr7IOHgG/V4ZlwnhY8Ztx37gBkljcbK4wtAg8TL63lFUdxYFaUq0cfWyQQWqoSGvRc0tlqlN
 k5Yih/FF3PPLsDd1TaUEnwIw8OBoAYItUeDw8OszNtf2OtdDBhqU+S65CD46plSFakzQPZsJYjk
 Orv45sa4ziTQXvkjI5SDpmPorJrsB+lAPGgR0mxiI6CSw8cCz/vXa6HcvZgZ/tf2caFOJ4GbfGW
 CX1OfAb0iPxVd76LVq5MVrSbHV/tQ3NWnuT9N9TZx1u2E56s1YAS75Jrd0R8B0SpcR7joDGknlc
 J1HynL6/y0fgNsZMS1Asc3qa3EON79rDtxryzX6OAAjLS3HKoT2xgZxdk2ZWsdgPKDngmDdkjFE
 6t2J9CgqTTWrnFMC+85Dyrm0q5g4dFE8+w9NhjNK/bmEUOvdNB1y87TPW266FcOhlDbMtJCs32T
 G9gJXahS3algX4LEMTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzMSBTYWx0ZWRfX4QajUSOVYkV4
 snzKuW7NM0ZWF7iOVcJ/CHGr0wMF8OWsQymgpa2tak6Vph+DPEUetUXFhxSl9wD2yr0aWSoga+E
 sn7WpYeghET9a5DLbh3pD7ChRIO8SqM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160031

max_read_len was hardcoded to 12 bytes for all CCI revisions, but
this does not reflect the actual hardware limits. Depending on the
CCI version, the maximum read size is either 14 bytes (16 - 2) or
254 bytes (256 - 2), corresponding to FIFO_SIZE - 2. Two FIFO
bytes are reserved by the hardware, with the first and last bytes
used for metadata such as slave ID/address reporting.

Add CCI_I2C_READ_MAX_LEN macro to derive max_read_len from each
revision's FIFO size instead of hardcoding it and adjust the
values according the hardware revisions.

Improve the FIFO read procedure, read the first word, discard
its ID-echo byte, then drain the remaining words in a plain loop.
Switch to readl_relaxed() for the FIFO reads, since the preceding
wait_for_completion_timeout() already orders them against the
hardware's completion interrupt.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bc4aa3c6431f385e07a74c67323674c183a31f97..18cfe03439e204691a9ea873f67faeaa119b45ff 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -105,6 +105,9 @@
 	(((qsize) - CCI_I2C_BURST_OVERHEAD) / CCI_I2C_WRITE_WC *	\
 	 CCI_I2C_WRITE_MAX_LEN)
 
+/* The first and last bytes are reserved - not payload */
+#define CCI_I2C_READ_MAX_LEN(fsize) ((fsize) - 2)
+
 enum {
 	I2C_MODE_STANDARD,
 	I2C_MODE_FAST,
@@ -484,7 +487,6 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	u32 val, words_read, words_exp;
 	u8 queue = QUEUE_1;
 	int i, index = 0, ret;
-	bool first = true;
 
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
@@ -512,21 +514,16 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 		return -EIO;
 	}
 
-	do {
-		val = readl(cci->base + CCI_I2C_Mm_READ_DATA(master));
-
-		for (i = 0; i < 4 && index < len; i++) {
-			if (first) {
-				/* The LS byte of this register represents the
-				 * first byte read from the slave during a read
-				 * access.
-				 */
-				first = false;
-				continue;
-			}
+	/* The first byte of the read is the slave ID echo, not payload */
+	val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
+	for (i = 1; i < 4 && index < len; i++)
+		buf[index++] = (val >> (i * 8)) & 0xff;
+
+	while (--words_read) {
+		val = readl_relaxed(cci->base + CCI_I2C_Mm_READ_DATA(master));
+		for (i = 0; i < 4 && index < len; i++)
 			buf[index++] = (val >> (i * 8)) & 0xff;
-		}
-	} while (--words_read);
+	}
 
 	return 0;
 }
@@ -731,7 +728,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 64, 16 },
 		.quirks = {
 			.max_write_len = 10,
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(16),
 		},
 	},
 	{
@@ -740,7 +737,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 64, 16 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(64),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(16),
 		},
 	},
 	{
@@ -749,7 +746,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 128, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(16),
 		},
 	},
 	{
@@ -758,7 +755,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 128, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
 		},
 	},
 	{
@@ -767,7 +764,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 1024, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(1024),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
 		},
 	},
 };

-- 
2.34.1

