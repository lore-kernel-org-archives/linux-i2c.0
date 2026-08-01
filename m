Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA33CAA53
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615061; cv=none; b=iodJyQwA8aEDHoiCvweVkmb4ofq6NMJMEszgbdcbs2Vk3cYasUwm+wV1qArRID8gEDK+tHQ9dZ4WNVS4qA6LR2SUs61wIvbN03bIXY/QZPswrCZK6ZwFjOodHYeThcrO7zlarNUCt95UbiRVzPdK8dCqpDpJZvJAMhyDlsirh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615061; c=relaxed/simple;
	bh=36LpDClwiTtPG8m5erGqKrgPdPeIbwObzYjdSOKiybw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAv4OVaYBrRs3IRslIXWUa408PvvIsGIoHn3ymYVM7dCmVfWH8N8bTqi5YtcGMRKAAaM5MENnS3zSJYkt/ugY+jYszNe70Yp7mHMTTMc1bx6818q7sNlXyEfi7fC5RzIx98HJZct/b6sypvL/9+kz43jjB4RfCSo08z6dAj+UGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+qm5VHo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MVgmg7Te; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+qm5VHo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVgmg7Te"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J02SF3847696
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 20:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wX4I5JxQWCnspspAzybMeYWAjg+gkSGEg/d2+h94uWA=; b=g+qm5VHooWAezGok
	0PNG38F9QxcihFaTFa+IMv3GZ/fLtTSnPFaSBtL+MAGdS/vAshgeOCvKgS8ReUKK
	ugDVlH0u+pPQhBOdxxBVisC+rtGr2IEAFcsF1pHOep4MXkHPdpqvoPduOMkYhE7P
	Op0nvZGkGHdDbuYJMuHK5RKYm1jU6vgbX9/rhZFdgHO6iaSXBks/0v6Lj755J/qJ
	K6oU63eJslxo2Hy3g6xx23mKvYixMBYWsAL8jinpy5TFGHVDiI+ROzN1L/VXGZY5
	7txF94SvqKGSUp+QKXxVOibmy86UMe+qOKH22orUTQQnFDw+Z0p5D+1JXrXYghHO
	GsyYCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8vt9pc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 20:10:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ea24a2db9so209659385a.0
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785615058; x=1786219858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wX4I5JxQWCnspspAzybMeYWAjg+gkSGEg/d2+h94uWA=;
        b=MVgmg7Teb80eEGVBXpbSjO47myNZ2u3zZKOA7CBdRJ63QIuF7bSvW+l0pGHajttft0
         KxeD51TAg8b0eDQ4vCWdtBp+tneu8rotXEPWRYlHkB/HiWu0zQCDpuWCTp84zgitRVYu
         GLFnZSpq5ml4n2v69cOoA1oAAVWtHhSsyzCTDypqyZ5rcE1hzLPmtx46skLC7Z1EKe0m
         4F9SyKES2qq7/GtMz21JsjomXUOOf1+YKNM/sIECIGCnsjUZlOw/tk9LNqxNQ+dQcByX
         LoCE2ONc2NdSOJ3SM4N0WOQJc+TLM6gDNlYdZlrVJsz8ryAqB6PxCVsNOIT7J/EQe2rW
         6TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615058; x=1786219858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wX4I5JxQWCnspspAzybMeYWAjg+gkSGEg/d2+h94uWA=;
        b=R7rtiuvDlxd5qz8v3uAwNHjDECNn9co9A0hNyFak2DC5AjsniqRELHhJnB8wEH/zM5
         x8zMPRW4s0M4DRn5x6I9dqXgMnvv+iCZjpDWvJH/jGNjQjekcS7sYQxCyEg1/8vI+AHJ
         feep+wWSgow1gkLfDMsM2/OHyRr1ZNX2ZbdA8xrEnrQbxOb8IkKA5Y3SVvPxgIOluTg3
         58oibFaVSsLLfepJpwgSrQFdxhZ6YecSd8Bd6QXXDxngaswmyfYlJePwPX1vEDiugnB+
         8FRDVOAqftlL2/BxZ0DAlKnJSkLO0ctAunMZKF6EidLhaifwXWVKroPG7Ooc33QMdMOJ
         9jHA==
X-Gm-Message-State: AOJu0YxByMW8p1EPHxE+sxYTD5keUPrf2+0LdsTzioIT5XYuFvks6Yr8
	zFXm0lj1hRAeZo2/ptG0NI0LkUrHS7/mGLejFHP+tNDMJY/UkEwfpfkZIGmFf40hc2E1RSsTyfE
	ZHMr2gqEqt+0ha8H9O6VX2Kgy6yA7wfYZL9eyc/MDzdpSX2VZ/cIUni+qS/MTUgj2Eb6pvyk=
X-Gm-Gg: AR+sD10qztDjo6JpFMHl1OnSAfUMmNgpXO8DVp7qkmitDjz9NGHGZ0hWzjSS1IiZfnu
	LSn7sXKTX8QO58B/Fm6Q3wRK3YiLMwyTdsxwTBfcbmrx/ttpQMFJ+bbEFpL7VdN9fzOkfkm3OFJ
	/94BKW7PGPlcnZkJOHdK4rOJVv8GN55rmp7SVW2mrq/XKPGYgSQuP+SCRWdM8YdEznkS7F9Q8cm
	SBTf2teBs/140gan4ete8oVqt2lh/EKr2K+rdTzr5t3MElFAs6xJMnEr84Fpw0Fze6orrwJwEjT
	Xj4e0j2LtosKryUsBu/5u+VfZRj/4QPfxNdmsuI8ND5rh3Iip21Y+KlWuyvDZzwtjB0cjflQ5yx
	ELa37pLd0zwgZ7lSqkvMjmYKePUbFE2FwUsl6h+La4snwdJradynSI6WHeZ+4ZSAIEbH9ZVpuyi
	impsg26oGVA/QrDLG7KOVA2lBu0ogrmlrtJxQXNw1/dWDy3/3QM9Kl
X-Received: by 2002:a05:620a:4711:b0:930:adac:1e99 with SMTP id af79cd13be357-934a0a86e04mr886694285a.38.1785615058531;
        Sat, 01 Aug 2026 13:10:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4711:b0:930:adac:1e99 with SMTP id af79cd13be357-934a0a86e04mr886692685a.38.1785615058147;
        Sat, 01 Aug 2026 13:10:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm358499066b.54.2026.08.01.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:10:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 22:10:45 +0200
Subject: [PATCH v4 3/5] i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-cci-clk-fix-v4-3-e1d80da54e01@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfXzifJTP7HYxl+
 mmb9rrR+t3neLptQUmcRqNlR3wNobfY5zthhpohjNFLno0kOETmG/0bz+wWWwhwtbqmH5WX3Zak
 skQEh1JIzBHapqTc/ObYgcAywIAmEGg=
X-Proofpoint-ORIG-GUID: FY13-QyFuii411UIVl4MfuuJNb5dg97g
X-Proofpoint-GUID: FY13-QyFuii411UIVl4MfuuJNb5dg97g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfXzQB6lei4F2wB
 6oB6x7PCaYSSaelVnfaM/RYyfcCM9naFUScs8CEfDgxNhQVvC/hN2fuzKpQnhuFkKy54Ou3zvRr
 pEY5hIUe05U7Dvg4skACb2Zt2WZiT8v2fglE+YpUgRN8iPnn6E4KYUgzFycFuJ+ezowKrAbrfP4
 LFn3Asb1lFomzP1SeWYoJKeoNxUIuhvN337fUwx3s5MsqY/WGw1YuWoeBaNJIT8En+ekf/XijN7
 9ADh8d0JbuUyDsCH9oMVvQPHlkyMUdHFmsBG/szGpZHMx7+TJNZj4f0HCGf/fv7ElTd9P5r6tbN
 HrHa4QmiIVvROTjvjpfKqWtKmzsyb0h0QbbdP0K+69D9JipwtcYzosN/vOxq9OUHO8xH+Kq+567
 lK2NYf1MA/i2Gr6yjHr5+HY6n0l1Garz7AyolOf++75ggj+Iz9ONjW9Vd2GedIBSXfGstwUjqFD
 vfu1ElxYFkb2BtGEzUg==
X-Authority-Analysis: v=2.4 cv=fKMJG5ae c=1 sm=1 tr=0 ts=6a6e52d3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fiHgs4EJ_qdzu2AaPLEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010162

The v2 CCI (msm8996/sdm630/msm8953/...) is normally clocked at 37.5 MHz,
but its CCI clock can also be configured and run at 19.2 MHz. Add the
Standard and Fast timing sets calibrated for 19.2 MHz so that a v2
controller left at that rate still has valid timings for those modes
(Fast+ requires 37.5 MHz).

The values mirror the v1/v1.5 19.2 MHz Standard/Fast timings, which
share the same CCI clock rate.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 1092ce0371429ef64c7cc44cc23a42ba4c135af5..b6fa37a306758ec33ede6fcc39ce4412b86d9a84 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -762,6 +762,30 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
+		.thigh = 78,
+		.tlow = 114,
+		.tsu_sto = 28,
+		.tsu_sta = 28,
+		.thd_dat = 10,
+		.thd_sta = 77,
+		.tbuf = 118,
+		.scl_stretch_en = 0,
+		.trdhld = 6,
+		.tsp = 1
+	},
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
+		.thigh = 20,
+		.tlow = 28,
+		.tsu_sto = 21,
+		.tsu_sta = 21,
+		.thd_dat = 13,
+		.thd_sta = 18,
+		.tbuf = 32,
+		.scl_stretch_en = 0,
+		.trdhld = 6,
+		.tsp = 3
+	},
 	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,

-- 
2.34.1

