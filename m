Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5043597B
	for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970116; cv=none; b=Zzcapqg2r5drznfUsCPJ1lgRrM6gCHARP+uhx8wBWYcKZuMey0JXLO0HL10+6xCvu/uu71Zy0gOybWNuVKQ4MuU//RsSuJYQaCvWqLVVyF9mMLmr2kVmiPcsI7BmFYtAO5rIf8qbaWU1bNmCyeJc1sf0qjlkDfDhp8YwClItnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970116; c=relaxed/simple;
	bh=tDXx3wroFrRAKQmBzd2yLg/NaUx0j/jHpTibaqhT1TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niIbtNZ7ZSWy+9UUjBtbFEFwjJv2rjffGseCeNdgHA+ThYEdO5MK9vApvP9jptO0q+Xr3ZXXKqo6kmoesZZNIglmJ5zlWdia1QZ6s6MDkLWFXAA3E9M48qiCyIcD773kCeeCq3BNhQTz8WA/0v3l9c27Au1B2nXjYBXUdaTh9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+cwCQ8b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZInH4P9Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+cwCQ8b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZInH4P9Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65KDt1343642981
	for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 15:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XthznrMWipPHmPVuxKSsO8GKMIYUVQMvTuS
	e7mtIKDs=; b=T+cwCQ8bo9C9/22tifQWozfplrh1HZa40bkBsylXdbHJ3rDmGB9
	n92aqqP3lNl1Jt9xx9zmkFRv9DxkYBSw0mAaZ0ZCrXWfkA104e2MUShDlaWkLt4F
	TeHe5cLqPt+q9w3hckLZEHPqcmuaoTu0Ve5tuzozLcHaDvzZDeRH+8nZWvleQzJk
	cV1/Krtkzs3Xd79ciaQ8HHyD7/xG9WYBPP51xQk6/dNPIan1LbF46G2IEtbcGTKf
	8T0waeepjLEJb6wtfhCvWAf8uHlceMaNefRd2L6ygxZAlVz763Aok3QDJNthPr3b
	O/nDRRn90d9q9j1UPSf1tgrli4FqXUJFpew==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewj6h18jt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 15:41:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157db42dd8so631248585a.2
        for <linux-i2c@vger.kernel.org>; Sat, 20 Jun 2026 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781970112; x=1782574912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XthznrMWipPHmPVuxKSsO8GKMIYUVQMvTuSe7mtIKDs=;
        b=ZInH4P9QTfPLWipbAKNRccdizW4xHMcNq/nK96KO42vHja4KG6Ecyu+SlIp996oox4
         BmXz/gMNwcZXwua2fl5xkt5mukzvaQ2gL0N0U2X7oMwrCW4imaFurb9z80YNJiAaOn/K
         G2EMsYcGw6tnGxtI9kXLMGbyr6t8Gh/7GvL5yNj+mBqbWaTEUnwi9CsyqwUNDgvERcPz
         oyJVCnT1C6Iozp/z1QogprDP0JzrZo/E3yLDnRU+anBbnyZ2f0/7YY/RQbySaKBW6/1U
         PIy7Lq/51vLxchbarEVB6vS5s3sDG8In+i/7r6cEGhifvpEmZaNfuWU5IP6gmtuUtFpF
         GVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970112; x=1782574912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XthznrMWipPHmPVuxKSsO8GKMIYUVQMvTuSe7mtIKDs=;
        b=CgfE48xlE5hAxR7B7St6O3+MtwzYEPhomL5/NoqEyl98H2hhZy0deeAh5+/d2U7cYu
         QWGA7Ren7XvP0G32iTR0FWK3Oq/isbPsYOM2GpXyHfPaVT2fSQ6H9UySyhCubOSo1Rly
         O930dS192AK93A0gSPYxlnGWcR5ZpRmkmvsDUS7PEoaPG21cQiJykdsyST0362ZyD5Xv
         D3CkzW9vulq9plvf/PnbDQM5lclCVfB9PGiYMp2Oc8iu7T/cUdUNbhaqAHN507gzyJEE
         y/99dDAApY5cnIwYUhriUMIG+3GtiTK0COE3sQwd4jvkWrIhsEFRCOuckB+1dZB5vbBt
         iF3A==
X-Forwarded-Encrypted: i=1; AFNElJ/VVf7RH9TFMvafvVaYLuSqX0n2p5g1aR9VO9cA+KfzRXxjipnHZZ2tFpMkRnNowTzA+80T6u/NXvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+ZBcfQxLe2WPxN00L+utedMmoaIyakjQxO8datkI/PD1rzQR
	61gDB0OdeMFKB3CU90IFhUe7j/7hUjjIe3GEfGQjQQMGuxTIHYyjIjELH2FT/4aeGJgQ3ftyqkG
	cUPEqdiHZmv709/RIZ41OTXyWT3eGgi3UQrLQN8PuZgjGXpsWdsWEUzEvocPbMHs=
X-Gm-Gg: AfdE7ckk6ZbG6St+IzYbRkCgvsLycX3AZ75HqD8Apm2BXtP+5ce1S6QlkS6YiuGme0e
	58oEuc5lqPBaDo+Gy0ckML8Ino5R8S7nS4czT2kZCZ8mfCjWWoLCKSdMuKvEkdFXqvAsIc7oFLo
	sIo5CCy6J2k9TSRrMvO53Cr/qw0XSXa3GyKgFgSi0nTjv09+Z+UXgShG/53V+kjCBNrgajSpUAm
	C+QtIAeRbgfxRzY6NNCK4uerk+vB6wvu7VwXKVY7+aMQzJyXj8BSS3lx+ZsTA+55i72hdw6FHVg
	n6nsRmtoO6j2r1gVS9pQkNBvtQJnm9gQM0WfHUi2/G1DbisEWcIxkwj3DWK8YIefHFDE5rxDcO0
	Riebs9mNLapwsJzhjP1KEMsHexZNrgCqS2+gp3Ze3RXteUPugdJXWfZjm1CFudL86M1t4GfdHY9
	zSdgF0uZq5EhSsJh354mXY4KRwlg==
X-Received: by 2002:a05:620a:a511:b0:920:fa37:f249 with SMTP id af79cd13be357-920fa37f4c2mr904533285a.22.1781970112078;
        Sat, 20 Jun 2026 08:41:52 -0700 (PDT)
X-Received: by 2002:a05:620a:a511:b0:920:fa37:f249 with SMTP id af79cd13be357-920fa37f4c2mr904530485a.22.1781970111671;
        Sat, 20 Jun 2026 08:41:51 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c6161595csm115159766b.62.2026.06.20.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:41:49 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] i2c: qcom-geni: Use device_set_node() helper
Date: Sat, 20 Jun 2026 17:41:47 +0200
Message-ID: <20260620154147.80919-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE1NyBTYWx0ZWRfX87gcl8ahOZce
 /bkdlySyEqC029K1SixITIndeox375vWwlJfcaHWRxP+Td5bEGk1LCJojVnwpJJMVEAtU3F7Xwb
 3twlOA1LqktiHRrmmhllikvTaDRFl6Tkvh5hoAmIbDvoYotnLsRPOpy9NcPf1XS7cbU9boDmzmk
 h7sL4kHwjsIBL4+YvXrH9ZgcE4A7r8Dt5kqIsfe8pvLdhNfhV84aGhRZDmmw+KLgKp87KcCNm9s
 is3lpk6Imt4MRy4XxAmfoRd44ERBQkOQ27gwN3V7+tZy5L4tZik9/jGklccGdU7WvTtWrAYKx6Y
 HxGrwndM4XfdrHVfCdEwqakdORIBdVk5h6r0Lpbcjmjy/5TLmwZaKX9O3JX7PiXBmrgwL+JZFQL
 CWmEkowtoNiy7IfN1g0hKYTDARNakZ4WHIVRDTm1YAi9BIcFrNDYDsWWI3LTsX36Kw5c2qj3uim
 ubS4lCdIIEiDmdCvgAw==
X-Proofpoint-ORIG-GUID: Cd2OiPN8UdV7s3PwXC2vj4O_UDtEt8rk
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a36b4c0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=2VF4tGTWRqxSFCeSHQ8A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE1NyBTYWx0ZWRfX0eAF28ypVDUH
 4NUyxtjPlcPpZK+Kir912FTq5KFYpNV8C1YCUQBAkf8XRQbdryb14h8lD+iF3D25FduMcI4bc1W
 X/J2KCS8TYEoVsI1vKr4Gonjq3M8WxU=
X-Proofpoint-GUID: Cd2OiPN8UdV7s3PwXC2vj4O_UDtEt8rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606200157

Use the device_set_node() helper instead of manually setting
adap.dev.of_node, this:

1. Ensures that if the parent has an of_node then adap.dev.fwnode also
gets set to point to the parent of_node, rather then leaving it NULL.

2. Removes the need the specially handle the parent having an ACPI
fwnode, since the generic helpers take care of this too.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a482a4c60744..2138fcffdaf3 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1028,9 +1028,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
-	if (has_acpi_companion(dev))
-		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
-
 	gi2c->irq = platform_get_irq(pdev, 0);
 	if (gi2c->irq < 0)
 		return gi2c->irq;
@@ -1054,7 +1051,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(&gi2c->adap, gi2c);
 	gi2c->adap.dev.parent = dev;
-	gi2c->adap.dev.of_node = dev->of_node;
+	device_set_node(&gi2c->adap.dev, dev_fwnode(dev));
 	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
 
 	ret = geni_icc_get(&gi2c->se, desc ? desc->icc_ddr : "qup-memory");
-- 
2.54.0

