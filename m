Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADED3AF65A
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782657568; cv=none; b=KjDLIRsM4oZj64vCsov96O+M3uqBRSvRLNxiqSmhpo7d4kQdZAjPRA83hoLNHkXyOpB1FGiBHUrZxiPmKVFlaJEMd65J5N1fr/A5dWksXPFu5+80pYw/dL/0DN01CG0IE25bdamx6OFEfYw6sbDXkGKN8Grxn0ZXmHBmU6wN+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782657568; c=relaxed/simple;
	bh=AZiHHq+x0W9FHol6e+Xjn43IEDJXWdNcQfLBaFTyIpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcOfQ2NiXab0VWlk/miLrMqm4Fg6Tiv1eAlrVVwn1fdtdEjfCv6AjiEKrRli9gKTN9k8x2mGTSUfIm7Xjj2uXL+rhtSKimMgfHVEWxGf4BN1BgYXiteGS7TBlZBhVIfYG+pdWh2PgyOCVQfdbWebchSKpD4eLSz+xK5CsjvCgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ml+yI9lv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZq6nf1M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ml+yI9lv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZq6nf1M"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SET44M012088
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 14:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9maitIXa8Sram4TCv+YQqEBCGgRKHZ283RLgVKVYdhE=; b=Ml+yI9lvBCbA6p82
	RzHlPJ3juFXHuXbvw5hvM+Xo3gfh5zMZmGOEhrLziwxFIpwiQQ8Gxq4ENSjbbYAE
	pxSg7opp87kqsQCD80PM6ePUrJQYb9U0EZd62Zn3ONWCYW/ZNsHbcqj0abjcN/yG
	AT+5VT1A+Cbtaf1kVJ0iyOSZxTLzNmgN8S7CdbeynBdO3OqmWZ8Q8cYj4MBMIYCZ
	mTMkpTrfVS4cKtEkHECZ6s58TgWZWcUc+AkQdIU0edL+QRstW0cBGJX47je+aOrN
	HMfORUvZOHehF4qqWue0cuAE2xSDOPIr7rs41uSX8Ccxju/69BvxxhRQfyhkL4uR
	Yi+0jw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6k2kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 14:39:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0a27ad86so5231253eec.0
        for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782657565; x=1783262365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9maitIXa8Sram4TCv+YQqEBCGgRKHZ283RLgVKVYdhE=;
        b=JZq6nf1MzVqfU2OtTyuoVhQXv88nRFQkp7q8WAWv84MwVR6EaUuI3bnM12JjeyU0bs
         133Gn94yp9qtYfejwyhwnIHEK2zp1PfeILjpChGleAcdCwI5oDmlnCZVz2PdT5525aJL
         elBZQHgvSXYSwY6jcQrPPsa+vIyz+nV9xeHlpeJ9nk2B4lCqmYXjZn6PYaa//yTt0EOu
         UoL2IzR+0Dvojd3F+MfvPaRX1cYpXeI03BGA7h0w7n2JcIPOcPq+66vUGmZZNKhKGsvy
         Ku5HRU0LVsiu7iPBtbenwXITqMS0qVvNmYs4xL+qmebliATnJZFslflHkt51MQO8/rox
         rpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782657565; x=1783262365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9maitIXa8Sram4TCv+YQqEBCGgRKHZ283RLgVKVYdhE=;
        b=FSpdSWurrok2yVmCoOJ3yg464ztcCCcnD86JswNA++mLbPrHjlS9f9HaEbnIfI4e34
         j9E64VHpToiq4OCMfEXijMUeD7HpLXIpKEueIGGy8tbOaO7jvokjnXSe575mKH5yQt1O
         9CkQH9qBMMzErKTnXYc0a9My2uBg3f7CWWd5R4O5jDM8ORgmP98LE7VQUJsgqUUE0ebW
         7NWynOXvuOee8Gj5pNIanJvKBflPpgT+zKdKvJgGozlw8BpUISCl5wHus7sJZVdJeODF
         rXSfB6GBVZkcmM/tG6DDbMJLFLo3VkSWHeIVCDCKlbfylAlOVTowQ8+/LyZTbaC9YBHy
         +bQA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6hu5sc782gvK198OpK1ehlHzeBU1xHRVwg75yZs2gTcKHF1oK00LaO0pkTJzlp5Smn0fFGLjilxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdX+p+lfkj71c9quNKh/I72ILlavQCHnOZOVQA6tHJLhhSxvG
	AXtJMNcK84N9PfAe0mh7X6Obb7BFdSp4hd7M035bEI8OqikC7RpEWhSiRCo8e8+zfxpPeiaqUAX
	0F381U+0eS+cPnms9HX//1dB3sxTXB1eybD+WUXWmKPT4ksRU1qwrU01i4IBCayk=
X-Gm-Gg: AfdE7cnTUbhuTsf/OTc6KoKEv0/562IVQ4YW2Nd4gXlhSbOhfgTb4gqK9RTVmsVBUd8
	pxna7y5nE1q2ek1qV5QAABWxnBATX2Y2YP/WadZyPz1UWeTiIZMfTy7ba1GNpiSK2scyCyhqc0z
	wKqNhxzqUc+wNr6xsOMLmVaZV34DFI2k3qrkKm8CK0AJM7zXDQ2WzKX/sGD9bZV5w5InwPbEe/3
	w0sw/bshmnIJisafqK6vYmj3wVWZSuO6PwGjCujFXd3ST2PxSicU18UnREqFkXh0vZC3QC/dsEX
	83TsPJUV09SuTfx508wyxSeaQTbxyYlJiA3NE7z6MCzIvr717Q3+bQHAV8YdcySNJ7LbpCnNyVL
	rXHC/4M0adYInLsfVK1TWWuHY4m84pkl5X+pAHp38muji+38=
X-Received: by 2002:a05:7300:538c:b0:304:e865:f7d1 with SMTP id 5a478bee46e88-30c8500d8f5mr13533546eec.25.1782657564965;
        Sun, 28 Jun 2026 07:39:24 -0700 (PDT)
X-Received: by 2002:a05:7300:538c:b0:304:e865:f7d1 with SMTP id 5a478bee46e88-30c8500d8f5mr13533527eec.25.1782657564472;
        Sun, 28 Jun 2026 07:39:24 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm39300591eec.4.2026.06.28.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:39:24 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 20:09:06 +0530
Subject: [PATCH v1 3/3] MAINTAINERS: Add entry for Qualcomm I2C slave
 controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-i2c-qcom-slave-v1-3-8b0a5c01f9f6@oss.qualcomm.com>
References: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
In-Reply-To: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782657549; l=1075;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=AZiHHq+x0W9FHol6e+Xjn43IEDJXWdNcQfLBaFTyIpY=;
 b=U27u8RfTIriLBtUO4FkPELhA7v4mOnfzw+CfAkZqQHGrWLNASvvYHcj3ZEd07+OvOqcOhlGSg
 0QavU+5J/mdAEbN++LZMFV+eYcQpEdqqa34AvSX7MMgMUCU7gI1i369
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: eTH7q97IEk_8EIMSBSQBoaI1z6nYN_8y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDEzMCBTYWx0ZWRfX6603JzdesvgC
 agWzSpAA9feYlq3lcN0oUgR7u7vgARgVYobUY0PbFxJk/QHZiALAJjpZJMLxNMlrYw8TZ2QU1ti
 OllOroF0e6HQdE4DP9yYl7PB0x5x/ZY=
X-Proofpoint-GUID: eTH7q97IEk_8EIMSBSQBoaI1z6nYN_8y
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a41321d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=fuCEp469c-Jm1kTzFMAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDEzMCBTYWx0ZWRfX7jmDl/pOhAqe
 3MxVEY8Kcj8YwxJe328F3sJP6c8czcN/ttPhPK1UbopLRUZibOkwdW6TCd43ihVuW8WymKuvUI+
 jA6XVuhbhLfn8lIZeV3d2doQXuGHRHL+4bjtsX0vuYYEYvKSJyOyObkaRhjpzCBTE3O31PCrTPi
 0Jd8fRlRZLJg2gax3SRrfazJHEaGmU7Kcb9LwfnBx42aqpxoT8AB7j+KRG0QP0k1UpLJ8gw99Zv
 qLYNg/nOxnNi39wcz0FPPVACx/rADLOFPCNkSY7RcixR2opatZ1iI/avKmmfCXnZ9mTNNIont2P
 VRwH9qra2VS8B2IcXjDqo9LlezTEC1l3gyrD1Qlx4EpLmYNshEA08Qd2vaq6MOvGj3EnLY47/R/
 L/UrhjgYD5DFaKJMsgJ81Z6E6yDHkb6oBa3p/1Uj1ckuFuErFzZnYSImnnpOxr5TYcEKXV/Pdhu
 shDJC1jv7FDH7AdAnOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280130

Add a MAINTAINERS entry for the Qualcomm I2C slave controller driver
introduced in the previous patch. The entry covers the driver source
file and the associated Device Tree binding document.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1705eb823dd0..645bef228593 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22231,6 +22231,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 
+QUALCOMM I2C SLAVE CONTROLLER DRIVER
+M:	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
+M:	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/qcom,i2c-slave.yaml
+F:	drivers/i2c/busses/i2c-qcom-slave.c
+
 QUALCOMM I2C CCI DRIVER
 M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 M:	Robert Foss <rfoss@kernel.org>

-- 
2.34.1

