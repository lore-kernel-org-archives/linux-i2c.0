Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832768;
	b=qFtJf8p5y+T8DmzUl9C4S4QaSKVYJKVvRaGwXO/BIu9+g/u0snVcJL81gygL+mUY2Xba
	 mxDKOJOSEBioXf83M2IaO3X9MrD9QqD9GUeowUTmNMrHYWWQcWbKh7FeuQlKupAa9zCkz
	 90PazVsUWcaF7CrY2bDjrVnnxge1/s+eK1Sp7okrCuWPY1Z/TsqEvHAwn9K1HTrKIrW7a
	 trjWeaopshWHQBPbj3+jqcxEQ27JQQkneP2e965oT32xjTOCgvdz98/W24geMS83gjO6F
	 JBYG/M6mef7EK63fQ2glGTaAmGwkOSlGlA2HbB1Si60074f+lKZVudH82tIFF2bNwew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832768;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hSew5h3Dgo5T8HgB9FB6r1I7t6XZHsLAl/DRFJMr0Jw=;
	b=ZdlTt6wvG6NvVRBkVLlJb5nzSiYs2iCbTpy/UAfrz/gtEoFYrdcOMLr5AX29VgNIj3NN
	 ZDuhHm7YrjAJvUMuEPr7MUtAyL/Ryx4GgmyYukUcrssIiHfjLXJ6OU0e5yn9Wk4c2wTMu
	 tGGIO93X1YJP4eovIpTjfSnF245JFtUlqV+A2M36iavYY+vUapZyV8uZpTwMUc4Fzqlue
	 LFtryrtNr9+KNlM51F9HoYK/dSMyysXEIES2nVY444Wq03dG0+1AdZ0Dts5qFm1jAWb93
	 JLrNs9N8anvITZ6mJQvf/87sIxuQfFic/T1DLK6ZuAN6l/EzkzyBFr/5b3amb1CY7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=apchB3fd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IQmKgGEK;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33596606A32A
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33596606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=apchB3fd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IQmKgGEK
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC1Y4F3117460
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hSew5h3Dgo5T8HgB9FB6r1I7t6XZHsLAl/D
	RFJMr0Jw=; b=apchB3fdLb7InMeu+MwRH6njOSqpcMhxD5A41EE4UgHCtC+K3aM
	X++6Bz8Tl+4W4xLXr90JpO4hJuM6UCighPBQhDFw0xWY6oonB8m3X7My/EOR9wu8
	CpYtc2fTcs5MLN6z+10XH2zIgFTxMkHIfEmgcBL7C61edy/WI5NjF0rUC5oG8Y0c
	VKkqsCnDnmjxZa8ZyJxWwGM/qILHFURzSCKyYC2Vx+U/4rLdrm19VEtnZOf1brIp
	McNeDJjVBbgPCbuahxuYCLSBLJ+f7StoGqf6ramzu7H9219LR3dIABlp5fVWebA5
	tLpdJ4D+2//gx4c2EB2sv+WmIOZP7hSdRkQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f8046r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:39:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f0938c499so50056136d6.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 04:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794832766; x=1795437566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hSew5h3Dgo5T8HgB9FB6r1I7t6XZHsLAl/DRFJMr0Jw=;
        b=IQmKgGEKZkK5rd0ZXEFblrlLUIFHLQ9NAZSpMbqFDpLlFw2i1AMmFkrUpMPNxz24xf
         D5BoXLSBhge7cT4EDMOuccKONgvQJF/YgGT5b4b1xgM0V2ajuNLfKBj9PTGX9PeXuRTE
         swFX0wuM4fiHajCxp02Ylk3x+TSi0tGFDUHN5YCzEbwkZ3XgzUcN+HkwEn+fvFL3CMNz
         iK6r+5E7AjYN64UStfkjyU9hQo4fOAMO9QIqMXO1PDU9OHrMYSE+powZE9E+3F6dpI1/
         QH+VeIXp/zTPofpe6Qw8s3MVEaVtpKYFRkqfWXBtln3b6WwRaDLHgdlaSIdhgIR9NkvD
         Xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794832766; x=1795437566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hSew5h3Dgo5T8HgB9FB6r1I7t6XZHsLAl/DRFJMr0Jw=;
        b=sO+cnvcqByheeFUCXSinwx8S5b0U4zphdp6fcrqZMC6ua4RbPrqdJavuOtkfa/fTfr
         TnTCyN80M2S39amERNgyEz1k8rVeyKq9LaAG6/MLkVDNukFDsp+NIFVcS+ZP7abT111/
         SGJ1zEQTRJazaf0tczdOmN7nPiYDXSRe8HDnq+OEaqqiadjvkcOZ6bfEHapfY9bcZKjq
         M0GwzwXSHBQeNJ0aUUug14HdihdyAKe2d+nmB/IidDAtz5LeKcfMmKeNMso5a+VKe2dB
         4xZzZKGXGBSVyyvPYWPhPk3KmK7fpm9ZKgBJ5fpDwqpoB9KUafSmMboaq/M+L0/mz4PR
         Cjew==
X-Forwarded-Encrypted: i=1; AL+hErH2sgV/aKRTx3hE9QTatLGoip1pLxQP/+pSrmzUf1VWg8w5OHlGToVXDVeJpHVKZeSJWAcFtOSiwiw=@vger.kernel.org
X-Gm-Message-State: APuU4Z93j2u9Kiv9ZjhErD/ptiWksuyyIbtC9nL6KF2DPp2foONs1gdM
	SoGkV6kjYtlphqcIVB83RIdM5MT8nB+/ehyjR7ZWIEImVTBXb66/xCs5GvY5+LACdH3avAmxsYt
	v/jwZfq40LhkH5/KJUMwBOCfArVF9lNCsUOGCnjqimCfyC5L5NDjeuqkVPET9sos=
X-Gm-Gg: AYBFou3lO+F/r4AWdiUUr25APsx72e88NvIsxFdNSzPI+Ze5gu6sMCn16MvPgYgvuzH
	R3nDZgbUYZGc5aArZ1af2K5BRRq0VW+87M+yS6+WFp7raLsMVOwvpJe6mwWq54v8nDifthq90bp
	8mi15eJqxvtJ1skWoKVvr4puS7PBNbb3+9H0SDbA1Tn3BbRFB+3ESccox27F3Gh2Bzj3NLOhsaX
	KHt8sHwtM06VfalW2mLd7rg0AaMgvB6vWelK55MvUjfbkzmKyOG8Ml2DjFuxTXjxeXtJio7HL65
	cBJ6FBEVBRHLBHDBWoc/ym/sX89xYoTmy2LRkHQh+fVugr1vIf+ZclRWG+0WClGFMrqpjuQeV5s
	hutRvKGpvkfKspdCz899OVk2Sm8+z1lkHBLwVpDahQY03YnedEvXYJldWw0iRf4ZG0RgvEIBwyU
	8U0bqS+/ufLVBlIF4sI2VRHg==
X-Received: by 2002:a05:620a:1786:b0:949:76ca:ff3a with SMTP id af79cd13be357-94976cb0460mr532932785a.38.1794832766196;
        Mon, 16 Nov 2026 04:39:26 -0800 (PST)
X-Received: by 2002:a05:620a:1786:b0:949:76ca:ff3a with SMTP id af79cd13be357-94976cb0460mr532929685a.38.1794832765791;
        Mon, 16 Nov 2026 04:39:25 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223b21sm24532521f8f.2.2026.11.16.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:39:25 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] i2c: qcom-geni: Fall back to i2c_acpi_find_bus_speed()
Date: Mon, 16 Nov 2026 13:39:15 +0100
Message-ID: <20261116123915.10182-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MCBTYWx0ZWRfX8Tx/46/psMnF
 QsNEnwBpR01wumWCfm4WYXCmr/8k/A5xrkujXRLGIzUKmPRDNScbiub1n3eCWXQtnzQ7DjX/fXO
 1WJGXaWtbZO8MLaARnKZ4yMXpp0moIO3bC06obETFyVeQTS7NBa72EVYVPHUDx8bjvxT+bN4el+
 kcp2U1tDZM24GUK/FfphGW5LOARFUg+Nhf2j5pQ76bpOPvu/6o+Y6gYxJ/lTrDvz88KcaTmoufw
 JeDnnxIYfPLzjpjwjN68Du45gncka8d24iofw9ssEyhhgvjNBMukU0Qlj+KFYpUjvc9zY/GxmgL
 RM6cCwEevciTrhds2REoSjPlyGKm8PLwPhdVVrWgAtnKTqXRW2crAB9SJ0EUTAC12veAOpyt4hg
 KpDMS52HgBrkcp/Bo8/FWvYm23jgCNGlxASyf8Sbj+awRamFLzXZD8XBEGcLqh8Qg6bAR+yRKJu
 j2WKTdCu+11sKZkDuNw==
X-Proofpoint-GUID: b4ZiwLYpTMCZ8W0AQ5F7XNKRry53ndcl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MCBTYWx0ZWRfX9KKdBKvd4+RT
 Vy91O/v1+Go3J6/nhSr+7XC30QyMkiwj3blwgL97anmAwFEhW3/IfgsQIHT9XKz7d6DSbx4Dhsl
 o3aZRBfMlk1wnO3nzljO92QIWjsDR1Q=
X-Proofpoint-ORIG-GUID: b4ZiwLYpTMCZ8W0AQ5F7XNKRry53ndcl
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afaf97f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ebSNtY053JYnNN3LUkkA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160050

The qcom-geni driver supports qcom-geni I2C controllers being enumerated
by ACPI, in which case there will likely be no "clock-frequency" property.

Fall back to i2c_acpi_find_bus_speed() to get the bus-frequency if there
is no "clock-frequency" property to get the bus-frequency from ACPI if
available there.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ef48ab3e8b94..cfa334e9e81e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1200,8 +1200,14 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	ret = device_property_read_u32(dev, "clock-frequency",
 				       &gi2c->clk_freq_out);
 	if (ret) {
-		dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
-		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
+		ret = i2c_acpi_find_bus_speed(dev);
+		if (ret) {
+			dev_info(dev, "Using ACPI Bus frequency: %d\n", ret);
+			gi2c->clk_freq_out = ret;
+		} else {
+			dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
+			gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
+		}
 	}
 
 	gi2c->irq = platform_get_irq(pdev, 0);
-- 
2.56.0

