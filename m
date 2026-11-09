Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232992;
	b=FdwAFIxdjx8qZA2PuSIhsprGIFWiaILl6G+aR9hdVAMxHVCv0B4I7nef0nRlzQ5F2dCz
	 9RdGWKTjjsy/Pk0+df7F5tFuUJAli9xh3zbP1Q1BAPh11DeOV0zoXzxGezu9V4vqYM2N5
	 r5dCQZfib8WIzMLJDui0qYFWWAkeZCxowc0b64lKYFpD14+W2nhl3TTqWtZKsfleHcF0k
	 Zy3EYqGWECOMXyyC2H86HDKDxFGJuWkm1WccDkdnzyBshvGBLyEllV0BkZLn11/qAmDR2
	 bHTQGdW0NPrivDFClAkEAEQUVuJJ7ZJyLGAjoUBMYMdYNLGVSg1GhY6IhvkkxTlnsMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232992;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rMm4oZuo2z9W+nImaszEaAp1ADUmyI6URhH6NsR12iw=;
	b=uE0EIu2Xwv0F8vpBPVsXMjTcv1fX9zz6V3cxQ+Cm0ccWS6g49RAtIQ08zyOxKQiiOh9O
	 ATwywnWCk1UjCFGjkI9EdbO6830jFSH6Qg49xXUEUIdv7wbue5BlTVCf6bSoz+cRyZZ4w
	 WOtStYWJpTimmn7APyaLzSI4I2W4PvNNXC2ve0UBHkCacA+1VgcAwI3cs9C+tf/phEyIM
	 ranPrlCwOMAdM/d0Dz+x/h5hIU7rTpUvxOLuhg1k3sL74QqwsiZQWOvO6yl+tspPYFiUZ
	 uCBSwqwSdF+R+De8+SpdIS/p8aqMq5ZkEviPwDuhnuruaPRdSzY2dkKsyqO0GsuEVFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Nrl/FBq1";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g4dd3nam;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D910606A332
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 14:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D910606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nrl/FBq1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g4dd3nam
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEx882927788
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 14:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rMm4oZuo2z9W+nImaszEaAp1ADUmyI6URhH6NsR12iw=; b=Nrl/FBq1tchQeyEO
	usYUOiM6DNJ7kNmTpsZ/+DRm/R2l5HRmmarw2ynLWaToVnPHX2hAKzNnX84norvu
	S2zps9VRww7nd1KgkeE21hnbQwrqUhe/o2UerwID8HUk9WNUEpuzrAiQ+09Phcbn
	YKZRBd6K2FaLMtZTElGPsB3/PYU7IOH672Xeo1ib2oQceNXf0ppsl2jLuvtpTo0X
	ITrQZB10mI5e49KvdKI8XU7BlNBIcT4t00Nue9gpZFZTWbL2HqzurrDemWf1HEU2
	JRE4cl170BwjEdORL5zL5VEVJPdSjX2T/edDY2MQbJ22GptU6bde52z5bqAGPbZu
	ujkHsg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8ruv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 14:03:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ede72654f3so959203e0c.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794232991; x=1794837791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMm4oZuo2z9W+nImaszEaAp1ADUmyI6URhH6NsR12iw=;
        b=g4dd3nam1MCzoRnGGWYaCz4GPC9D/NGBggObDqLf+9ErWA2Zxfr+q28aV2M+za4nP/
         qkr7MrVJ1l0VTSkzTBJ5nvv3b6asbW+/3/rwYqmoeLokecthQs/Vq5aFa5cLAGCnOnu0
         wMmXyIdZfuARhZExk6Ot1f42VITsLgIhqXkgSAMpPgKdf11kMi3KdQYGrFlP//S2PqcT
         Wu3Ug6KqYO30a8kMD1SkpGUZhiFOP2KinMGaFTZenm6mbhUimPtar8yUEu4zX9d/GrNA
         YMNjgFoDE2r08e/UH/GxwM4tcBf0fXiXLCA0TI8KzbbRmL2JXmTIv37trgikEXxQfLog
         ZjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232991; x=1794837791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMm4oZuo2z9W+nImaszEaAp1ADUmyI6URhH6NsR12iw=;
        b=t4TQYCP+sCng9iVy0FGWFXpz6u3um0iW/DE5q4WoMYvq/dLVJswqNvxztQhDJxDdpQ
         h4erA/N2XISnECFg+GAmgS6bk2hybmimuN5SfntzG1kAePeTck8XoFxOirIETd907JrQ
         UEkSYpcCLUA8GugTYfm0W14JIyBq3e+IkySe51+YBkBu0/rdHWemXlMhFykbu55Pg/OI
         weC0qhyiNO9k5vfUw4BAzoAMWgelr/JWdc4AvU6AYy5Rwp9rE9Q/0GpNmgA5TjjBQkI/
         USD5MelYHmBA8J/A9ijwcFN4sVE2hp776051E7nN8pNKSKcF9gZITVpcFh+JpIpw8gSS
         /Uhg==
X-Gm-Message-State: APuU4Z9zzuzJrod/FCdYtGuB2eCX4kWwBW4s42LvGnv+LFzBj4MlaY9I
	CeC4e81i/IzacLxUvmB8J0kb2/C5Sdnk4IpFrbgrdSdk4GiyhkJk4+MpYfYzs8NGZBmokQOavr6
	ZoprzQl+K3x8Pc50syaB8bt2/izUa08v9WGZcgk4z74BbsecjusciaaBzE/9KQJ2syv2Sv+yTZw
	==
X-Gm-Gg: AYBFou1ZpvcsBPKpdbuExccmACruqjQO5yYW99T/n10qCYdbo3hQAuDuYLVjH2TASmf
	RIiCc5Hf/vv4VsljQq8fs0kpure07L6vd6E01AkeHxhrZLVKUUDH5m+Gn6+MwOqG/a2E14hCctd
	rtPcc3jHvzs1ScT5qYPC/yw15fgG07jNql70i2NScwaJlHAsalqtwfJDC2Npqhxhj9yzTIdW7YJ
	8wD7WJvcgo0vpAd8cM7mVA1Majn+UVQsR9LTkQ25CZwu7RKltzOpLNAxrYSlTLX/nHAnALcJW20
	Q8KFgqDh3T+Pn3T5hLGHGwTZ6XW7m6WnlhKN0NhKv1rjkYtJk4k2j03iYcK08Ol2+xhpAHn3wvf
	8Bc0Z1WQrGh0k6/6rHW0wd0fZ5OUrhGCL+rzxGovUm+2q+YjmnSW94MNc3VHPe5WM2cTqdRxLzw
	UsdT11DI1qaF9ibVwl3nKiDo2IIKELmK2h9Kf/MVr3yMIW2BBI89OSppgXsP24MQ2BpT5udR84m
	h6A7k61JqZoFO2IX24OLZ8KU/Zv
X-Received: by 2002:ac5:c001:0:20b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ecd1fb88aemr1103807e0c.15.1794232990394;
        Mon, 09 Nov 2026 06:03:10 -0800 (PST)
X-Received: by 2002:ac5:c001:0:20b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ecd1fb88aemr1103759e0c.15.1794232989817;
        Mon, 09 Nov 2026 06:03:09 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f9b5:154f:6aa3:35d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm161515845e9.4.2026.11.09.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:03:08 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 15:01:58 +0100
Subject: [PATCH v4 5/7] i2c: qcom-cci: Extend i2c read limits based on CCI
 revision
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
Message-Id: <20261109-cci-imp-v4-5-4dc4095dd052@oss.qualcomm.com>
References: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
In-Reply-To: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX+W8US1uMM4Xa
 JijJI4v87F8uAlaIX5NYNUvuMTNi/JbjSNEvSb0ut32/VWLw4LmvNoGocWWUg5xx0xl8sn/JtQi
 CYHoi8oqgX/MqESmaKjqaK3N3XeiB1eapxDtfRe5jl+vpRJggWydWrLQohlfRsLZ5UMCsEOvQl0
 8Kwow/TIf1bUDTfGA/5T9oVpA7yEj+3HtgP5oTQUw+OGypQSurWlnbHs0CTEsAkdk7kQvO3IMD8
 X6OL1p5Qz5CHtta4WcsyzMsYAkMNeamklxf8Gy02rHa/Ft1uijZS5Wg4pEBgETO5U9vc3Gwvdbj
 BcpyqAfWi//ZWdFJHFn0wbmr/pW8sSBfJEmcK7Sq+R7eLrOkMIq9MrQFl4vJr8C2NMLNIs+0fb4
 n0S02dRWfD07mNbk2coeLki7h1lwZSExfeta1dECAOrSQ2Im2SpQjhlS/B/q4ir64J4S3YK31WB
 32sYIo3KmyMHMNFlZzg==
X-Proofpoint-GUID: nGd40xw5iuqzzOn4iFNNlm3C3fhibei2
X-Proofpoint-ORIG-GUID: nGd40xw5iuqzzOn4iFNNlm3C3fhibei2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX9F24MQUEytzR
 GSq8/jSAFPziqo+2DjkUT7JK4a+i3O8DfnSqBnhQz052cQDICj8ad1upa5YpjzCBJ0qgLwfADGV
 CcYCrQun4dwajdDnju5u20R1Dp3Z1eo=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1d29f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Q-BVT9UuQ3EDAlpGIL8A:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090055

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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index a698130f4712492847336e401c0789b1a64dd02e..2e10e9775cffe57f291c48176ceda4ec14411db3 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -106,6 +106,9 @@
 	(((qsize) - CCI_I2C_BURST_OVERHEAD) / CCI_I2C_WRITE_WC *	\
 	 CCI_I2C_WRITE_MAX_LEN)
 
+/* The first and last bytes are reserved - not payload */
+#define CCI_I2C_READ_MAX_LEN(fsize) ((fsize) - 2)
+
 enum {
 	I2C_MODE_STANDARD,
 	I2C_MODE_FAST,
@@ -479,7 +482,6 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	u32 val, words_read, words_exp;
 	u8 queue = QUEUE_1;
 	int i, index = 0, ret;
-	bool first = true;
 
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
@@ -507,21 +509,16 @@ static int cci_i2c_read(struct cci *cci, u16 master,
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
@@ -734,7 +731,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 64, 16 },
 		.quirks = {
 			.max_write_len = 10,
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(16),
 		},
 	},
 	{
@@ -743,7 +740,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 64, 16 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(64),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(16),
 		},
 	},
 	{
@@ -752,7 +749,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 128, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(16),
 		},
 	},
 	{
@@ -761,7 +758,7 @@ static const struct cci_data cci_hw_catalog[] = {
 		.queue_size = { 128, 32 },
 		.quirks = {
 			.max_write_len = CCI_I2C_BURST_MAX_LEN(128),
-			.max_read_len = 12,
+			.max_read_len = CCI_I2C_READ_MAX_LEN(256),
 		},
 	},
 	{
@@ -770,7 +767,7 @@ static const struct cci_data cci_hw_catalog[] = {
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

