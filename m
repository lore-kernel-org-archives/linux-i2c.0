Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0C34E779
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837390; cv=none; b=A1sSfSXh6AdjEnLf3bmFdYu23+6gXV+pkd7t5Beoh4SsvvAZL4uW5Hve2PoC1AzrtwIIHmHs5apuuJfgwuxXjPEJDN8fVVi9wPqxk5AXKdXh4UAdqjVqJZO2/N/A9xzo0L3dpzpatIduvGU7zCL4/kcwd2U/l9aNGeQnwwvK2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837390; c=relaxed/simple;
	bh=7TxdzRCSiPh0U0D4bTEwGW9tm6C1QduulA71FuX7yKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egUMufouJs75D+JUNMwo7VVaHhOFPmrwv3B0Y69qyUFxt+cG7X2iZyyr05xlBHW7RRsWodz3RSz/HRAEjklmnL5Xf9us3c7uJvbDGnK+8zdXJQkmwUMDW5s+SaO8dCc1fVTZiGr2ODIBM2VDV4XvOvWUev/wbLYWOu3b7dSpqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcRGExkp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaUnq7Br; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcRGExkp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaUnq7Br"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N7Jegc1423380
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJear8utHwNpB9Vva/K1yh9yUJ+AKqEYbzU/V/WrvrA=; b=XcRGExkpDrlmhRh7
	EHzgHvo5naLO3FGwhtfrFA95MljEQTatbgHcr0Y+KdQGDFhcpsLLmblBQ8sysMVU
	dwbtKsV1CQTcdXmiNYv/B4Ct2iscAC7toYXMcLtfxZ1reDZGTR7aVGEpJ9jwmfGO
	iezGczslhJr5eayWUjK+v8X0njcc232vnamXGVZcbq+xEHdj0GO6Ii7PR7G3rXGD
	7OUTmmkFc5WowkcZpgjTP7n7td5yU5yRu3QflS7lJy1YCz4weZP2BSC5xiZNzpZ/
	x3VaZoOEAQRCzDHHXrUIJ6Pcypwj3+B3HBd6j2TnfruwZauNJ7ktDr0vU+gcWZ7s
	av7Qug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgv31j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3a2eb984so1166332885a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837387; x=1772442187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJear8utHwNpB9Vva/K1yh9yUJ+AKqEYbzU/V/WrvrA=;
        b=QaUnq7Br4ZAcNREsAiP1dtoOr4vHyOS3vxnV65U0/hRbznBQ5k+uJ1c3m/gnfzAvmb
         E+nPNyavDeE6YFvnKi8oHiM3vuhAr1k2S0n4228an5fEOGOKQJ2KOb/GBQ7BlVVbm+Jl
         75Z4Suc1UlXsh0+l7icH9EQTSmpWd6DZ1cxZC/2zxtYiyqjojmA5xUNcEQPKD7BqJ4Me
         JbtjwLuylp9F/BUlA4o7jqosKBwynpbaNzQ4jE+L3gQ4Dxjr4WEg3zb53gxm5xzm2F21
         LjVnWf0lkYG78WHk5mANAok8WWt03GI+HadzMGW/di+gyL246u8LLx7ThkykPu/bn8F9
         ny6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837387; x=1772442187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qJear8utHwNpB9Vva/K1yh9yUJ+AKqEYbzU/V/WrvrA=;
        b=Y5Gfkg7hvAfKh/USanLwxLwxqE+CZp1q9jMoLJdmcLTNYeC3k0ugKc6D+ZaFnb/CgZ
         Tbccw3Q/sGVHp2rOqFivE3FsAjB8VK2b/wmUsSzTivIASYBCRZBT1RdsVrlIDB6/8psU
         GaQFpIxZ9fHc6nh1scNWOI4dLRGrfFkCtdQAeTKDaIIh0zgpqqvN9RYf1uOh1fxa8NSr
         V2KzOzWEkMe3/WrBACfsKvQ1RHmpOwh4ojwrD45Yzk0aML6yhsjyJeFwF//AYuG9X58W
         lUyj/UKn7MQyab4sKMpLnFBF7EKA89jcCgbZ32S6njTL+w0CHrVJINebi0M+3eHFcq6p
         +AZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF5PGFmYNBY76wGJoBOwXbTyq7NglC+SVdSfqJ1KdFeyaAn/LA6n5SfTNiOvKRTWwdwEkKFFySN9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpwqW9Be1Ip80J2H2HagKYQPXlc7sbJfIFGn9M8rhcEdwzlrtB
	iH45UAXosChYLoqYTxj9lKvDO9oIkFaoOnLRsA4bXTHgl3FYfT+TR/k2zlWNiV1Q+C3uAKdrqiw
	CUE5msObuXkw17jSg1Zyhv51Tn/qT74LL2dslgJFZZ8zH3R80/JdjqP9VslUiduY=
X-Gm-Gg: AZuq6aJ1rYBSVgnC20k/lz+aPISQizaXj+QjoUHCqmdLd+WsLyYXMjnoen441ZhWgxz
	A+KRBYEzC1Yr7v1LP2akUzpXbETYGwboiztoQLojTme28UY+8VEzJypwiTQkOQfTa1KENcdcmJZ
	uRObi0FvfrAz0rkjkA53N/WwY5ZKte5BJZObDJgvNcjq7pkjdeIKK1qEepo46FjbuXrRT7tecpg
	dODmyIQzV64Th68pql5DuYBxD3fSsSdIh72SVD18PPNLzCB7nCREc9SfJeQCzB9WOLDVUr41ODg
	zM6Mkbpy72EmhZpxlahH/VgVspyUHRKMMINMFx3rSGQg7YNznbUiJgzWcNAbLZkaY0vyS+mdmpQ
	0ldy6Hj7hqsi030E/2l6fkPqhn5L1Vzc+DZ0dz01h7QQNG1XJF4o=
X-Received: by 2002:a05:620a:28cb:b0:8ca:2cfa:822e with SMTP id af79cd13be357-8cb8ca8550bmr1023306885a.70.1771837387490;
        Mon, 23 Feb 2026 01:03:07 -0800 (PST)
X-Received: by 2002:a05:620a:28cb:b0:8ca:2cfa:822e with SMTP id af79cd13be357-8cb8ca8550bmr1023286085a.70.1771837383676;
        Mon, 23 Feb 2026 01:03:03 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm19657169f8f.7.2026.02.23.01.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:03:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:02:51 +0100
Subject: [PATCH v2 3/4] i2c: amd-asf-plat: use i2c_adapter_dev()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adapter-dev-wrapper-v2-3-d02946569773@oss.qualcomm.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7TxdzRCSiPh0U0D4bTEwGW9tm6C1QduulA71FuX7yKM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBe/P+jGaF1N9KsTXIGrNz8yYZXkept31EzU+
 +aX6UscteOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXvwAKCRAFnS7L/zaE
 w8PHD/9OaEcCxymUBRclYRUz7SdpQ4PkdMffCRatGkD35peke2jFSvNpDtqyKbjPoJiWP1Gacy1
 Xl/ZzZ8HXnMT5F5y56IPzlw8k3tG9KjW0VS6bMpezcFzM+MylXQT5TP83FQMLk/1J/Dt4m4xqQr
 vVALEa9TBg/E+NfRgqYLEhLs+iggntJGFcET8jsTbsEOMYzm3vFneC8Nf4EkBSrlSgK3tgE6t8Y
 1pTHBPF26gSL5vmbhdaw8s90/efvyF/3JxYRzoui9nJZvrmKc8jUp9DWB/8u95mLry4EnnlTjib
 GVl+QDErRbM0Wux9LFIR6P4iQjb6hGJc42rlGd5uc3WicM5CoTegHz0BpzSIepxcznNEfq/F4Ja
 PrGS8BLjdGjjeS3oHbwgOTKa6iGNGd1jiX31lTD1H2HOGFK0CZm1ICH0a47uWZMaqC0zxmKueo/
 3DE2lSHeX88X7XBVE2khAcCxj7/RU4jKnoxc6CP6M2rgLy7ZuJrW94O/dA5F5W32wNXWBmHnOPl
 xOd5ABtPPLDKMtgO/EgUDciBVwT2P/GmDLjEZL0lFkGmYvwS77qAi4zs/HDLH2CfbagnaOwg+DZ
 lWAUsShNA6jKoZ5e9Uqxddz1oBStL1PRz/+KpIap8eTn1mLrdAa4rkFEQ2xx2FJzHdxk4UXScQ3
 DUCpCNdUGgoCwCQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX04GGzg7q1OgI
 zlLh/uUNnZO/RR2ev1EHgqvyhgxulvXsn9+ZdLau5HaPeShNYZ4gvpyiOQYR8dIQ1MdCbxeI2e5
 YWUG+lZv/yQGiF7gIQN7AmOUPo4c6lw9uC2MjiI7qtjKkEXVfYmFc2CMZcUTH2jaz68+/1PRSBx
 RS4nOxTyhTAxRqS38FbiS2+zLO5Ny5iCzVXZliO0ASnthO9enW6fg5ntqthT5/ghv2kltSf0gF7
 jbsMQCN2D/fz93a8GesTX9NiAY53V1JYYnYU6wSklxw9UiGo9RgE/kCFIPamyyGCAi6nBVObtWm
 TpOwQzmxPXwkKe/pcU3dtL4noNtWa3qHhaVgwVwJ0/Ty0l1QAUZc32WEaBlSeu7001MuKGuI1OF
 wZaLPnQfA7HqJguw8VW6q8geUJvOqrxlHwMpQ5GaG6Ly8tdQl8rDeWDQIvhhj4p3ioPPaQUPm0P
 EdbkawkXT808GlNyqAQ==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c17cc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=qEvBVMLt1E1eEMTY2asA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: KSmcV-B8w0iF76GtECxPJCiD0XKmoqGo
X-Proofpoint-ORIG-GUID: KSmcV-B8w0iF76GtECxPJCiD0XKmoqGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Use i2c_adapter_dev() where applicable in order to avoid direct
dereferencing of struct device embedded within struct i2c_adapter.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-amd-asf-plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
index ca45f0f233210a3b03a16c4a240012bd524fefb0..271b1b24417d06cc87733268c3191aea16fa1d83 100644
--- a/drivers/i2c/busses/i2c-amd-asf-plat.c
+++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
@@ -209,7 +209,7 @@ static int amd_asf_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	asf_data[0] = dev_msgs->len;
 	memcpy(asf_data + 1, dev_msgs[0].buf, dev_msgs->len);
 
-	ret = piix4_sb800_region_request(&adap->dev, &dev->mmio_cfg);
+	ret = piix4_sb800_region_request(i2c_adapter_dev(adap), &dev->mmio_cfg);
 	if (ret)
 		return ret;
 
@@ -224,7 +224,7 @@ static int amd_asf_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	ret = amd_asf_access(adap, msgs->addr, msgs[0].buf[0], asf_data);
 	piix4_sb800_port_sel(prev_port, &dev->mmio_cfg);
 	amd_asf_setup_target(dev);
-	piix4_sb800_region_release(&adap->dev, &dev->mmio_cfg);
+	piix4_sb800_region_release(i2c_adapter_dev(adap), &dev->mmio_cfg);
 	return ret;
 }
 

-- 
2.47.3

