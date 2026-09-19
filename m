Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6A391829
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846610; cv=none; b=eVUExGWPGnPQe9r4mgkBJ1BO/hF/GpBGUJKQdRuGAlMPJFB+MO9l0UcibogwGcfTNBHPqvYtJ+c9kc4aB8aW+9OdB9lGz+wiok8Xyk9Okk19tkk2lq860UrdvOiW8aoZA++Yd9Cg57yjxxHAeShp+VkNr75S50VoHyorsGu3Lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846610; c=relaxed/simple;
	bh=CntfZH5YpGD4rg4E0AvfvaxQfBqRMlH85OJ01FCAET4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyVs/lbYCFONjyX3EKqCDZudByapjd5/hszWEeu4YBAul8py4jiFzSyZWLBCA3LwzdafhRS43FLihTJKarjwryBuzSPvf/5EBmpyIiQtfBWylB2vLXBMmE+JvhLGsRENUEquJErgyVXaHIU1bJ30avPO1nLwTlBfeVEpzXFMEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K66Huoqn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ET6nLGkA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K66Huoqn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ET6nLGkA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JGK8HF412764
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 19:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lXyCZAnmc1IzA3rJMUzPME9X4zRA0aPBaKl
	ADkS4SxM=; b=K66HuoqnCo99DpCiHIaju6wOywdonVbZwdkUhVfkw3yertrAaGy
	ZBKrjm14oJxmn4qZNs0fOrAliqINjQ+mCMP0BIcpVuFRnm4+MYl5M+SLNzL5+0H/
	GHgq4VshG7nLA30P0p3SKUc74KU8VNIMqF0MHKOdg64uDm2wfgb5kmSfp8JedJUt
	dn9Gh5aPdhZffQDsAZO1m10pfWFlMEoI8wGFC6Ofp4SokZhq4CWezWlTEEeJuxZa
	opg8yLw7MjP5TdZo/oM+mPyZZMjzXkDYxMxO2bzgXShj2R6KWjO6gBvpAZmIDYSF
	48BpqMkR7CD5vIXAJm0Z07Hwl89fkC2yi6Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshd61nh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 19:36:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a1bffc2eeso566075385a.2
        for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789846605; x=1790451405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXyCZAnmc1IzA3rJMUzPME9X4zRA0aPBaKlADkS4SxM=;
        b=ET6nLGkA4ufqEcvtjFm21PmKK+YoHW2goJShm9feiGPP0wZtYVqBmqCie/vkuRXgHC
         XwSxth4QJ/ZZjGdYcBdxgdUuPiJWVdjjC97+bwjsof6nek/ZUouVEqcv1qehBLhP/pm0
         EXLVlNaCZEWnchtH6xZZBdiLeh9lNbfM39uQbSCtfQUV1isK4icexOhqf3nC3f0bL3Fe
         LZ5uZQAp6++dbF7kwZBRaO7wboph8It8F5XgowsKA0cVw5dO1nIa2rrHd+CqeCEPpNgd
         nwuPO6I9OK2ljFEDqrnoQ1snIunZL+Vt+qowJoq9K9QqRHe2sBXc9HpvOrQiCWCHX6vN
         hR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789846605; x=1790451405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXyCZAnmc1IzA3rJMUzPME9X4zRA0aPBaKlADkS4SxM=;
        b=GJbOt5m+I+o46D4iuR1q/NmiZNUHL8RaOO15E7Kkp3jABKeRqPAs/RRen/BvFmbiLa
         /8f3VawGOoL3s5e27GUrjxkZHzXMOQxPWDkyYxM9ILJP5lXYVZAG6onJq72BIPiKiwgk
         YJVQwh0gF36BDqoI2uxHCtjXB/s4TV/21O8HeqDvAocBZYyvvh5ZnrT1JAr5U0/XqXYl
         cRH979bHeKKxH/5q4w9/iqNDUIk9101QEMa4g6N25pfhBT1/bdWyNtLzUeQN7ZhrK+wP
         DPyc2ysb11R+UxthiEvU72ql5X0SL0xy8hMfsoZxs11SOqWScrETc41hGCAkx8RVKHDo
         oWZA==
X-Forwarded-Encrypted: i=1; AKwUvBxpQYriFtSBgHZ1V6sPxH3fcdgpH9SbE1j4n992ahdR2HcJg82GZkGpJbe1T7kHAYq+xA/Yje4rb6g=@vger.kernel.org
X-Gm-Message-State: AFuF++k5NYv08OPOQ2WLQ8u9305ivM5qBLQ6GoY0FUXLWR5ikZZtn4QU
	2UU+4OZXDWDsIrcT5GDK5gUg37svhGB8lT29F9EP8k5jo6xB6gHsZzRWuX4oXe7arTnMG57HTeO
	fFVDMkcvRdrnXTPXFDhKd7obWffcv949z+1jRjMIh3KTljfuSfSlrehnPSU/I2p4=
X-Gm-Gg: AYBFou34BrFxg4FU8jmra9S4UAw2V0gJWJjszE3Aynj3JOGkvkHMT+W9KNGe448dq9/
	xpA+iM9vy6SX/lmRv8fa43B0xNxFupkTv69fxaRBYYacdg4J/LM99wBCSPEF5SoeSIpoxRWpn8/
	Wt0265l+pbIKGkLhY4/fJ6dISLCQYrOw8lWDE3r8+3dJm65Vg+h3EoqNHj3/J66Bon0MpnhThKE
	5x++jR11jfIpM4hl4f4bXPGyEeCnKqgHE1n7RAs8c1icKhNdpq8axWGKmMwzj/7hftUbE0gfDDp
	ylaynnT8hXRolJzM5VcE0FrnEakkTQQw7/JDBqzlPNfpHMFozoqIiUqsMi2Kx1dRijtrQ8wi/TK
	95WFFh7mY9u6H3NEz5IihRtpu67H591dSS4rO16zBhNBYleNQdiF22Z4QvUc+RR+J2s0za5a78O
	RvTAQkdx47IIP3sg==
X-Received: by 2002:a05:620a:2682:b0:939:fc74:b6b5 with SMTP id af79cd13be357-93bf571dd8fmr312325285a.43.1789846605571;
        Sat, 19 Sep 2026 12:36:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:fc74:b6b5 with SMTP id af79cd13be357-93bf571dd8fmr312322885a.43.1789846605173;
        Sat, 19 Sep 2026 12:36:45 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dafe8csm1623947a12.13.2026.09.19.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:36:44 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] i2c: acpi: Use I2C_M_DMA_SAFE in acpi_gsb_i2c_[read|write]_bytes()
Date: Sat, 19 Sep 2026 21:36:41 +0200
Message-ID: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX1swbzD+mfeYr
 YIR0P8kI86bshWd4Wz3UscGMI3DZJyiAFtxFG9VK8zMIhLwbxH8rN/AyHtnQ6Eo77WKmoN5fB08
 PQvcDavgakZk5xz8U7DYH00gLbNk6GxlsWh4+poWkQi81sandBLi8B0ipqIJ1UROd3AQJMu+5g+
 qgMIyiEE00GW/1ZsRLG0fdDmjRetQ+Ts16hKjw0ebN68RNuRduro1uUcSP4jX4XzVsFWTgDyFBS
 FgSQTxMTG9kYnqIvjK/h+WK2ZQoi9sIFuxaqJAkUqw+tieRCoIYSa8zOczsyCHUYoELLvU7u4H3
 ClO47bPiLM0AJ498zGqRSuygXels3EK6zGv8w/kiHZN3CVOsabxpzmBGYJbwo5ZyeFNAfG6ICxN
 vwI2zvQmorDEO0kOfh33PjKuWbVVAKMsHUBK1Z+DMMRoOTexbG/HlFC6BQ+KY8xuWlcODpIviF3
 cKguMD0F8fa7p7THDJw==
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aaee44e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=xtLyfKWn26C9IafwWvYA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: TuqfRPoS2x6Vxe5Ditx53VNthO1MnUE8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX6rkmxtP/6SuW
 4Vnbv5JDB/AFf5WdwWru4/EcjUS5AfLTaM2qkwTfj1CMQyr5tyuyOwHzvYlTLlMpg0QBtae0m6K
 5MSWtV8K2af8udVJ7ooyly29K59Wj3o=
X-Proofpoint-GUID: TuqfRPoS2x6Vxe5Ditx53VNthO1MnUE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190287

The main read / write "buffer" is kzalloc()ed and as such is safe to
directly use for DMA (unlike stack mem). Add the I2C_M_DMA_SAFE flag
to the transfers using these buffers.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd50186e..583d89c626e3 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -607,7 +607,7 @@ static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
 	msgs[0].buf = &cmd;
 
 	msgs[1].addr = client->addr;
-	msgs[1].flags = client->flags | I2C_M_RD;
+	msgs[1].flags = client->flags | I2C_M_RD | I2C_M_DMA_SAFE;
 	msgs[1].len = data_len;
 	msgs[1].buf = buffer;
 
@@ -648,7 +648,7 @@ static int acpi_gsb_i2c_write_bytes(struct i2c_client *client,
 	memcpy(buffer + 1, data, data_len);
 
 	msgs[0].addr = client->addr;
-	msgs[0].flags = client->flags;
+	msgs[0].flags = client->flags | I2C_M_DMA_SAFE;
 	msgs[0].len = data_len + 1;
 	msgs[0].buf = buffer;
 
-- 
2.55.0

