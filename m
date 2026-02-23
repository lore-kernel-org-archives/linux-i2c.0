Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8E34EF06
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837224; cv=none; b=uja727PpOpHm8Al7kK3n8ERUxfBZmVED7UdCdoA1AH7EAzy8eTJTLLh8W2MnulExwGeCrziCCjVUlMKhPPJM0ajHP2aFue2yHg2tjm3nyxMK8OwBndO6lpKjtIY3IEc7l3XXNHfKd0M9cPqAfRJYuZeeXMtd1imMi9NTs1rLRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837224; c=relaxed/simple;
	bh=JlJZdIjQAEdOPapDxkG0d9x6lJ7pOOWi8wm3ojrJ0As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flB0IgDqaaQYFg201qQpbtWk8w9KlyGL2bWV4bbkDLzQ9wZHNoRqZ5Z9G3vY4sUGjioY7HFkpLwHJD5frWyvGZlXpRR2F7+LldxXvlOvIeh4WgvaeFi1La/rgqmh3X5YP1aqGlq319iPOChwRLFTbmtcoLCvDygwRzaqcOLTo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8P4JGSI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KGNZfWnJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8P4JGSI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KGNZfWnJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLJVZw2608680
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bi9pJMMcFRf/NBCA4ID44huyo8rl64qSPRxoYMM2oCo=; b=B8P4JGSIDrvN+8Jf
	xosfPkLtE7i66HGsksi8i3rb4IoYal8nCD07AV0JIUJ7UYFilU4fnKJdTZ/XXvgP
	Yt0kpGJOD3DjC0Jc5lQlS5EmifiL3MyyyroOKqUpDnxFp0IYqGCDDKVgRSsTILjB
	OINQ8MueFNEm5d+ebfaRWcG/ML2/xqE3I+Jaz3xHOeb3t/K3+DZfMOSPNTKP7vXT
	isDhdmjEKXg2LTvFYEFAIhCHVh/g+WLIg4FkzctEU+ZVZiJdEj+kfB0VBs6DLlhi
	QJQ7d0bBSzmogpol2zT02hM9JUuq1HNs9Az1Ztud+z+7oqompZmB2PwOAG1eOlCh
	6cbQ4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgv2m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c71304beb4so3086448785a.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837221; x=1772442021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi9pJMMcFRf/NBCA4ID44huyo8rl64qSPRxoYMM2oCo=;
        b=KGNZfWnJWGPb8jTcFbsaSrty+U9+q1V3nLROInltKd6jX6Md8ZfX8xAo7lcI3/WyWA
         heceY2qjUSYwsm1KWpF6o1H/XrMcgmtTc19pyCRsw9W9zdSCeUsosDT94jxrEX/GCr8W
         dMgxW10YNwX6pmbYRVzuoaNiDdLNshXtb2A9cNES+UH6/L+yIRxjiJ/BTGNo0OeY6LC5
         Rhtbt6xHoPuEqQcr57aEyAn142Koh1eaYJVACnSfsrkw5GJouwEPHt4hRXQujGIjn9bC
         BFwFhQMnFl1at4MlM2dUfwUCpenNtSrDIfijq/Rx0mt6nHuMRN/5faS/6mU0lpNN4g8x
         lvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837221; x=1772442021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bi9pJMMcFRf/NBCA4ID44huyo8rl64qSPRxoYMM2oCo=;
        b=wMIk0ZCNPDwiJ8+EUQZjAIXF8gnv5DhwUuJVPoZrFyjdMa3ZyQlY9DPMOLjhj7N1Kv
         OB/bPuWX9V/tsLsF/J2UH22uo357UeuHKfkOVIwcrZyKvMwxpmhhcydCvBWrQ9RD1M8T
         KWUZSH1WOzLgfrytnIw56IxOrI9tBn360yx4z3LDUERSPwQKGfvVNOQOYFcBZ61/eUPb
         TikelzCyRlDztt8SGKiYgOycesuNa5JkF52buG7h/kiz3n2RdmlQ8Vyl/r8N2HD9tVjZ
         4NJ06poO7UM1RRgL2E7ECZuh0twzTkWZMrupT4QWktBFlZolb7ry/19pWOMiRfgGTzKm
         MgxQ==
X-Gm-Message-State: AOJu0YyLWyZ0L+bU383jc2jNvdaRkzA1xYUN68O8xxMvimbEk/GG6KyW
	v5ti8HJo8fNyJe+YaDX15NGmrhn9Ykik3HrftzP4Qkeezu2gNMOMQgfLnaw9ElsDOsRDzBoPGR3
	8w/Jp+zeZIDl83j7p+44m0hkDMi8f8XIMYYsnBr3jlGwPRJaUtOkgieh/PqSvQME=
X-Gm-Gg: AZuq6aJwq3ry1+NEOI+OrjwXJROUC2JqYbsywdaugRKo9sgl0+wodeEtQPRcT0xij25
	4UHJyMOyVE2DX2uqYzTENWUO8foiNF/Xw2Xjqbli0bC930luMvOtgWCgmxGfQXL+AXcj0/lXVi6
	LC/V1XZfagCsCiAKuq+vLJ4qa9MfmgOGWeDL0Z9uIYkCoCSBPkwQXDCttRjn9fUvfhIVI9MZjf4
	5ocY8Yr2L9AkkvSU3YrvWILDgE/CZaYrOoONTggPv7vYiGmVB/kvvoHQ7/pzcHQVrABB9QjU4Cl
	HK+BLz4u4GxNUS8fx/QJzOIV26gZ3hO0jbc24OvdZLwIQu5hfFJNE4XPhY2v3hoeE4QTuBywoKI
	aU6SEjLBdnCbIrAJX7W4YkW5NFgn8zhaoZMNqea7sa1GpvzAAuiC1
X-Received: by 2002:a05:620a:19a5:b0:8c7:17f3:e98b with SMTP id af79cd13be357-8cb8c9cbfd9mr853276985a.15.1771837220597;
        Mon, 23 Feb 2026 01:00:20 -0800 (PST)
X-Received: by 2002:a05:620a:19a5:b0:8c7:17f3:e98b with SMTP id af79cd13be357-8cb8c9cbfd9mr853249385a.15.1771837218557;
        Mon, 23 Feb 2026 01:00:18 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:40 +0100
Subject: [PATCH v2 11/13] i2c: nforce2: use i2c_adapter-specific printk
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-11-13b2a97762af@oss.qualcomm.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Khalil Blaiech <kblaiech@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
        Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JlJZdIjQAEdOPapDxkG0d9x6lJ7pOOWi8wm3ojrJ0As=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcGnrmRWnN9R49qmQ75B8odbY5Rxd6lE9PAH
 XFL9QpoS0aJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXBgAKCRAFnS7L/zaE
 wwFtD/9FJmnPrfZtvTNhoH2BGjowqofWNEMiGJ3SSV3vlnqu/q2ovI+NYYSRdIULepLZoRsQxXE
 dYz/t4W3uSTPGMl2Q0VE9oxrPjoDiZdXLZLpisL0TqW1vlOdxuQz00/LXAR4vuC3n4YKAbvvFq2
 /ntNiOJXkZdUhYZsG64K8LoiFOCQSPdjNXCdv09FLCYyup0lxByxltsokWwKsknPY2x1CpUBtNW
 32HN0YKAtXVelAJ2hsDfbDuj5hz1OjOmV0KhV4Ak2jDGogejpUXI7c6hdH4dEqEhIqkuvW4ME8Z
 ZjyUdhdqMKExq9WCyw4NwOJiIxRaJ1Oq9Enf9lkeb2KCh7FwSc3LRcbtfpeIM/c84DWaeCZR8Mm
 oC+mBUGCUE5rvE4tns+2odmLcCcbNscGLHoo58Vi1XxsuSk87nDVohD8VIDy82aXWF3Q5wKFZyM
 KKxXUyjmF3qFSMTwsLCtfcl7vwd/zaSH9BtmzO2dI05Uoz9igDSE2HinYcKfhLeKCDzNtUhWByw
 ZIStk3TbmoyPoX9qMs9WWAQd5ZvxMdFo4QZsHfu+gNUk3DConvZqTV5Dq8qhxPwjmRTSvytFziV
 3bkagq02Zl5WGTJF8d4ftS1nmlSMYLgPaJu8r4j/uJdJVhzdpZg9sXLW8Nmt36NOlHeA/FFrMyq
 OxDgMK/k1/05RRg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX3jgang5jZge8
 vVPFOlZ14ptYsSbgvb8Ym6eCglDL7KOjZflHbkwhniAMZM2cG0iKKHSZasnonWFnLlIFrz6d7tq
 5bxiH7CcW5awvrQWbikKkust3xAmIFWGcsBtiFmO/a+MZUUyh/Epk4KMmnoxGbCsM0WpYIWAeUA
 hUAAuAC6jDzeZVC1BHzoQ0A2Ejr/h1qlEbnNrspiH206PzLKQO3bFfzse5VTCtOnhQhYcKoLgYo
 SFCiMCr0jC+HYMATKzHrY0ZWUfi3l5fylQvjpFfmsTFVp8VLv5Fs1X++DqylSP92sEhEI9c9qUy
 /ird1Mh9Jtluh6PudmfqRvu9ANP8mriz2sOSPkxGfLNV8PWL+ZNQTSOzDDH0a38LND7yaA5YTU7
 ToTXmOWMHBtpDCuem3DgCxG8+qubUzxAKFOp/jRtR1XKNSe/clYD7mJcXSR1i1bcDS1Bz80xu7M
 QzWZ3VVesc6EC8uf4PA==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c1725 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ULAvDvZivfA9C-ZB8fsA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: tERKtPzfOS_xl8QhQZGZ_iQB8uvjIeNV
X-Proofpoint-ORIG-GUID: tERKtPzfOS_xl8QhQZGZ_iQB8uvjIeNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-nforce2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 7064fab81eacd416756906cc2ff0567ac44a3465..0cc2cfe8f3c788d84374d40ae8b43cabc467fdd4 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -123,7 +123,7 @@ static void nforce2_abort(struct i2c_adapter *adap)
 	int timeout = 0;
 	unsigned char temp;
 
-	dev_dbg(&adap->dev, "Aborting current transaction\n");
+	i2c_dbg(adap, "Aborting current transaction\n");
 
 	outb_p(NVIDIA_SMB_CTRL_ABORT, NVIDIA_SMB_CTRL);
 	do {
@@ -132,7 +132,7 @@ static void nforce2_abort(struct i2c_adapter *adap)
 	} while (!(temp & NVIDIA_SMB_STATUS_ABRT_STS) &&
 			(timeout++ < MAX_TIMEOUT));
 	if (!(temp & NVIDIA_SMB_STATUS_ABRT_STS))
-		dev_err(&adap->dev, "Can't reset the smbus\n");
+		i2c_err(adap, "Can't reset the smbus\n");
 	outb_p(NVIDIA_SMB_STATUS_ABRT_STS, NVIDIA_SMB_STATUS_ABRT);
 }
 
@@ -148,13 +148,13 @@ static int nforce2_check_status(struct i2c_adapter *adap)
 	} while ((!temp) && (timeout++ < MAX_TIMEOUT));
 
 	if (timeout > MAX_TIMEOUT) {
-		dev_dbg(&adap->dev, "SMBus Timeout!\n");
+		i2c_dbg(adap, "SMBus Timeout!\n");
 		if (smbus->can_abort)
 			nforce2_abort(adap);
 		return -ETIMEDOUT;
 	}
 	if (!(temp & NVIDIA_SMB_STS_DONE) || (temp & NVIDIA_SMB_STS_STATUS)) {
-		dev_dbg(&adap->dev, "Transaction failed (0x%02x)!\n", temp);
+		i2c_dbg(adap, "Transaction failed (0x%02x)!\n", temp);
 		return -EIO;
 	}
 	return 0;
@@ -207,7 +207,7 @@ static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 		if (read_write == I2C_SMBUS_WRITE) {
 			len = data->block[0];
 			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
-				dev_err(&adap->dev,
+				i2c_err(adap,
 					"Transaction failed (requested block size: %d)\n",
 					len);
 				return -EINVAL;
@@ -221,7 +221,7 @@ static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 		break;
 
 	default:
-		dev_err(&adap->dev, "Unsupported transaction %d\n", size);
+		i2c_err(adap, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
@@ -249,7 +249,7 @@ static s32 nforce2_access(struct i2c_adapter *adap, u16 addr,
 	case I2C_SMBUS_BLOCK_DATA:
 		len = inb_p(NVIDIA_SMB_BCNT);
 		if ((len <= 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
-			dev_err(&adap->dev,
+			i2c_err(adap,
 				"Transaction failed (received block size: 0x%02x)\n",
 				len);
 			return -EPROTO;

-- 
2.47.3

