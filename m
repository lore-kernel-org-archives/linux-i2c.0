Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97F3C942B
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615057; cv=none; b=A3C8xdM3J85yUoAWQt3Qat5GvFQatAbK4tR77RFMsJ1EXxc+qg7IX+RWEKK1qPLoJbWkC8Rfgdo87+eapaZNO8xRPoXuW4lh3z1yAsxglJnSJETKZr78Ef5aqyEH08T4wMR2cKIoPmvynNYsaIVGOa747JTxBc7MUQZPVRhHDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615057; c=relaxed/simple;
	bh=+aNMaCFajVHZevzqhvBUxV3A4RHGDEwQsfVeD6cIr00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4KBg5P1CTQhMxiC7M/C1vD1tSoUlGRTATCUtcDAO+Wca2OonCjYlLqRjs0TcBN0SwjsR2oVOZydRocm6XGQBewO8O1CYp1GtDatWupWPR6KwLmt3G+LwO9nM4QvgvjGj4A/aJex7Tuo8HdLbNydxYE5s7UZLAqmUAjLyXRa5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=br0TjjGO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=auCa9N2f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="br0TjjGO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="auCa9N2f"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J0Vul4015460
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 20:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	APSHC1pcT6h1M0mEivj1xdJzv1oxGETs2NGnJFu+bB8=; b=br0TjjGOj+MNqfnE
	vHGSHlqIkgoKeAAF5cNq7914o1S74gyT4ze4QlnqmIg3hnw00j9F3Kw76EZJjvK3
	a3VwWqMzDLS1eZpiqXJ3B8APKEqqzYgf6gvu37k/7aYARCulHkHPi9HXPPPLbDpl
	bUifAms8qWtQUDWICslYT39j994SLIua2Opq3zeEiSyKEtug4WYTtqKFdvUKeddH
	DOQeZ8iNVe8xxGPCEyAbjd4nZfSLUHp1y4F7+RaTENc0aNt75SQLWxjBhIGkNTsI
	riC7IiL6mNNKSglnDT+0FtkbKUj/dt+eHT932SLkf+CJwrLC9UV2dWEL2OOKrYcu
	yEzCVw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx1n2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 20:10:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e8004d60eso455280685a.1
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785615053; x=1786219853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APSHC1pcT6h1M0mEivj1xdJzv1oxGETs2NGnJFu+bB8=;
        b=auCa9N2fxqxOPJHyUj7NzGz1kkLK6hQ54cCmnHQmz09BW3Li6GuzUJNlJU8fInzQBZ
         Cv+dE1EmkkM8XwgagSkaSmYf74GKkf0vceVuFMtfjiD9yjXiGzN1n/gnExZX/N/Yrl3x
         w8ADxP5W9jYfMAZpJo+nXcz5s2ks1cSiHt72sycCNqrrsmxJdzNp00j25gmjLulOnUAl
         0FiEKLsu5Lgmz9c1uO6UfdtoQolQNOSTSXyPsayG0aT2kUKkS7TBrYzw2hqBuyJH4amN
         raOHf5DAsEl2EMbUpAdrTIbGEqmSrSB9Z/iPrSwf1xcnxcp5h0f9fME7N2hdxqZ2Y90h
         4sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615053; x=1786219853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APSHC1pcT6h1M0mEivj1xdJzv1oxGETs2NGnJFu+bB8=;
        b=NMH4Siunu+MhZ54kdGmqv8kfRTSgxECkglaCDcx5Fs1guK+TVW5swN1hNvY9evLB+Q
         wApORbrPtXxtDwfyCQaM0P3kLYN9xBO4bTWJnFoz2iIMNDwRdrbnzxpmLvAvGp9D3ogR
         wtiSKNmZN2CfWuL/l539+uRdO26vePx6mUhZkyFQ3yLr4BpDPiYe919a4/IZaA9r0wKD
         BJs+TbB22livz4QTcfANBQ5hQ6SMCdJNbH0H9TJEFEuomTpdwkJRnuJuZ4zVd7MaOlBU
         GRZuzEqgRB7jHXGexDmw5QyzhfIxx3P7+FYG2QagkVOjQAQxDX592wpJdBY2fiebcMhj
         xaqQ==
X-Gm-Message-State: AOJu0YySaZf8nQTkc8pKmB1ZEuP5gJGLFVWTLMuGen6wFtlofNu4ypsg
	eEa1isJ0GdAkQkziOgjPpgzBVo5+vkfvXUjIqsz2XGYCvc3qVc0YrwI0Yj4HOmG1fQ1TDMPvobD
	Pp+6pHJhYNbxQcPbcAbCYS77zUqWJtdb/VXIbvXqZv9PHqYkhMnf0nItnWWE0e7A=
X-Gm-Gg: AR+sD12/RsNLZk+FLcMhxsc7l72OEaF/YdUaEHoU3WIjYDTxcsQDHEAIgbWG9sPID/s
	rDjazfvkcDCNq7zWQBIyjiDpdZqJNB760fVUrk33A6gtxA13MX0q6SQZbQc3S+KSgCzhIhxfESy
	BSsqYTmHjjCt9hdP0YbsK1tSFTyWBv4PS3yqcam5GaiTGk1kT/veE4h49ZXLTLn0Zv0CwTYRSru
	jVKS27TKjNIU6zAZ5ZR6KDPC+aWU7gSoEufx6S615UnqNSQ8omz72HEIxNC7qnih7Mggqq3OGxG
	Q2CLc3OlJ5rwt9MbmwCy6yuj68rBMp97teteGaqpBKNDVkwgXHYmqQJZ1tIITdj6lNux4SWLHLb
	XWr7BSC046/FY2loS6hS6M4i4kK1VyUHvD3UyaLbBsjpdfWq+KJ4h89Jpo8LsCAgxgx2UbMu012
	VvKNz6jIHkDSZTTzUldJcslAQmDLave/ROVpCqgr5HSIQ/qc5qctbN
X-Received: by 2002:ac8:7fc1:0:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-52b566aa6c8mr90783551cf.11.1785615053198;
        Sat, 01 Aug 2026 13:10:53 -0700 (PDT)
X-Received: by 2002:ac8:7fc1:0:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-52b566aa6c8mr90783291cf.11.1785615052863;
        Sat, 01 Aug 2026 13:10:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm358499066b.54.2026.08.01.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:10:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 22:10:43 +0200
Subject: [PATCH v4 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-cci-clk-fix-v4-1-e1d80da54e01@oss.qualcomm.com>
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfX8OCMmXvJp7nX
 2jYbprekQvqL8k+c2G1l6WaaZjxEJ1sT1Pqo6PWknl+6Ytp2JJkDwWHuRf3YmwG2g1p3Eo3p3IP
 VXl0/IxWcGmf1mOuUiCA2mBc5Nf+ozLiIiAuFPNAHn339Ewurj+U1YtIQLwi44zEiqG7KPyXKh4
 bE+s9qXUItUqNowzTAnMNbrK0sWALYJwmuXN3bIH+z8ckl13jmRAID73/gWJ4zFYlxxpnJ6KQgC
 SN5e8rcwtSB36RzOPzQJ67y7GAhtKAVRy0ch55w9EwCvW6x03NH6BAx2Mcl7e1yDBn6JGrUAHdg
 m0/pMFQKO8GTS+S9U2nTclmwew/M3nqIULpDz7X4LHtY9JzuKo/uHf6A6WMSHtAf0z7pguUtywz
 Q9yqZ6Bc/t99Ru1fL7IN0TjtR/UWLz/rXPKRByerpSktBuo5i6NwJH5w62bHkRrOzoq9yxcg38b
 ngI7/iuEn13+n28MuOw==
X-Proofpoint-GUID: k8nxC0xDDXJJN-xMONrW-Iw6ONS7Dlha
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6e52cd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Y4CGMd7wAM7EkgizcVsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfXxh5lWp2+AI1h
 AwJfJo9o10/TOV5AzzEkHJMDT+dNu/0+yL6A3O02ujmfA4CMohbC3O8r//aOaud7i+iowepBLKD
 ZaPFBgxqYHwa7Ydakydppsr33y3eGsw=
X-Proofpoint-ORIG-GUID: k8nxC0xDDXJJN-xMONrW-Iw6ONS7Dlha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010162

The msm8953 CCI timing table is internally inconsistent. Its Standard
and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
clock, but its Fast+ timings are essentially the v2 values, which are
calibrated for 37.5 MHz. Since all masters share a single CCI clock,
no single rate can satisfy all three modes with the current table, and
the DT assigns 19.2 MHz, so Fast+ timings are wrong.

The msm8953 CCI is the same hardware version as msm8996/sdm630, which
already use the cci_v2_data config (37.5 MHz). 37.5 MHz is supported by
the msm8953 CCI RCG, so reuse cci_v2_data for msm8953 as well and drop
the redundant, inconsistent standalone table. This makes all three I2C
modes self-consistent under a single clock rate.

Note this requires the CCI clock to run at 37.5 MHz, the driver selects
and enforces the proper rate in following patches.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 47 +--------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c4814b5cdb463734b8361da7fffa879..0a216c4d08114f267c8441925e8811ca64f1a909 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -756,54 +756,9 @@ static const struct cci_data cci_v2_data = {
 	},
 };
 
-static const struct cci_data cci_msm8953_data = {
-	.num_masters = 2,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 11,
-		.max_read_len = 12,
-	},
-	.params[I2C_MODE_STANDARD] = {
-		.thigh = 78,
-		.tlow = 114,
-		.tsu_sto = 28,
-		.tsu_sta = 28,
-		.thd_dat = 10,
-		.thd_sta = 77,
-		.tbuf = 118,
-		.scl_stretch_en = 0,
-		.trdhld = 6,
-		.tsp = 1
-	},
-	.params[I2C_MODE_FAST] = {
-		.thigh = 20,
-		.tlow = 28,
-		.tsu_sto = 21,
-		.tsu_sta = 21,
-		.thd_dat = 13,
-		.thd_sta = 18,
-		.tbuf = 32,
-		.scl_stretch_en = 0,
-		.trdhld = 6,
-		.tsp = 3
-	},
-	.params[I2C_MODE_FAST_PLUS] = {
-		.thigh = 16,
-		.tlow = 22,
-		.tsu_sto = 17,
-		.tsu_sta = 18,
-		.thd_dat = 16,
-		.thd_sta = 15,
-		.tbuf = 19,
-		.scl_stretch_en = 1,
-		.trdhld = 3,
-		.tsp = 3
-	},
-};
-
 static const struct of_device_id cci_dt_match[] = {
 	{ .compatible = "qcom,msm8226-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,msm8953-cci", .data = &cci_msm8953_data},
+	{ .compatible = "qcom,msm8953-cci", .data = &cci_v2_data},
 	{ .compatible = "qcom,msm8974-cci", .data = &cci_v1_5_data},
 	{ .compatible = "qcom,msm8996-cci", .data = &cci_v2_data},
 

-- 
2.34.1

