Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122B35A933
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837729; cv=none; b=kBlI80bZbQD7j1p5I/ssJci4/aJFpDXEL9R3f5gNcg2QJ/dLLxt1YvGkm31YCI9TlxqKeoiQ6MIToUCj7QZCdQwj9Cu5WP9ucV0+KSopOTino2o+TXoNe30PKmS+OZS7wIlXmn+TYe8xT1Y/k1zvqTIKoe3pegnmeoolSvB9m+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837729; c=relaxed/simple;
	bh=CmIFvWiWgpCQ79cxYV/h0Rf+mkxgiPi/0lLFWuQX+5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcC0uknk42e1b6cnCUMpxO+ESnd1guPERvI5yW5Ux1pgHasehCsCq79YBZleulGWOcsa/igVegunYmjyWyYPPW8yb6jFlMgHTkarzFCaiqTh3WYxQKbUB8oc488idEA/zg82PTyA0ViXFpik8b4bZMjr6BGSBL6evNsiK1FbkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R89mKYtN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HRwuYSru; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R89mKYtN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HRwuYSru"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLUJe21335780
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p7jtvfcc2J2d2gjxl6lV1fr/Y4Rp1PRR3tE4w6l6Cyk=; b=R89mKYtNXde7fsSM
	3BePiuaif2lMqRtT04IydxlUP1OMLKEv7f6NLKwR7QWzGzHcwGDJexHP2cPkO6Kc
	UgII5Btx2JrebdaKNF8HEZGY1Zxw63bhFGluJJGTzBJahqmb28P3dgFLB3TckIW9
	xUmFIuev+SVuc6T5oTAtBaQLzA9UkdS5wPipf6UpW8Cr+Z05hMhL6SvOkc68sp9M
	XPxFejNJz2wO6PbfOh/KhtvxcTQ5+5CHZUwZ/Ydra7Fc+98pMqeIdLfEwWinEG0m
	Md89eJJ/tL+jr9JEwswO+HvAKcjNOsspD9LjVdJLF2ie7V3oH/9GYObjYCUiPNs3
	FzxOYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5x7v436-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ca3ef536ddso5090326885a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837727; x=1772442527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7jtvfcc2J2d2gjxl6lV1fr/Y4Rp1PRR3tE4w6l6Cyk=;
        b=HRwuYSruFH0JreL8O1uRsToTmqelXKFICY9flEeFUb78A5nTlc6LtrXvLo4CwfV+mS
         5ESeiQbbDGky4sn4eU8LtpLz5U5lLU+COlujLIdagKyYZz+D8oLZY604FlzcCoum1kCx
         tOCOTAXt89GZEPAQ9zORR3TPSfEb7yaUgs722M2FrBIX8H3FqmBaDNRwJ2fYqO19q4G0
         U8RrfOu9LcvI+WEOS2lT9DrK7NFxsU89yR7YrD3Ws6ZZj4oPJmX7sK5ttW1Lh/bcAdd0
         rtLPTh5Ymr3JboMjk0ev1d7ZKC4boFoiKBhoYbMDcG0z7KTo49GsCW8JDuWP+nKs0fro
         vHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837727; x=1772442527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7jtvfcc2J2d2gjxl6lV1fr/Y4Rp1PRR3tE4w6l6Cyk=;
        b=MT7+mmS0keugCTCEwlzvpO3f4cixShTHbIWxik0X6Uswk2Ek57R4PUk8LQpx3VBmVT
         kuzMAV4ifvqdaN9aKx0+GKURMHl9CGMM4oSsNO0q5Q0t/Jy3FhqDITjFgA2qIdqZ4iU5
         f3HSWFz0NlXIkZZzxWLR4cI2xs8Z26BiSGR9MwbZvXmv/FmXr4Q7zFa0Frm6rdJVg2zc
         A53zFY3IsPV8AFsx2IF/UWDty5a5HfkHQrJ0jBje+fRGgBFJmO7GX5mEI3Ti6KjIDm5g
         3q1XuGkzxHW+NUGiU+exyDThWkLS9TvJExstC5oaqHNdED1pxSH5+G6vwn5JWABuzYUR
         ou1w==
X-Forwarded-Encrypted: i=1; AJvYcCVP+beyH7HyKqMPkb9gU/b20+lM66bmps2Tt829VNKMn3/wwBiCTKXuX+VV4ntYECx6RTN3FhHdKkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9233FZVo8USIW9v5GQVvaIx4s4PxXmEPaNGxoLiEhAOs8Dry9
	lM2pfndJZ2yTajnrnRofH7ISV2lbqmj1zSbiT6Sa4lbJR35HGCddou0LT3sHlBzqk6sSIF6DumD
	RGPyL2fPsYMuT6//wjbgUbMTTaU0D0/AWKa1x7Amtm7akPxOhgSYXO4zGj0DJBAY=
X-Gm-Gg: AZuq6aJlai+kqiSi9ps7nadK9fNfJmCQSyLclgT2Dd9qO2orf4Wnqi/R1sLT5h2mqLo
	R17sNshcFLojhAWjjzm8es01M0hQ9tkic4EoOXpotXlk/oAWjq2ZggWptiTAcQxfrM9Rnk3nDz7
	gSGiRoYRhEZ6u3J3cZ+bnXq9UyjY+G5Qj0c1NJqhBJ48sA5SanuXwvnwTIqcLAfrBAVo+xiraXk
	rjZUwOXSX5DFQHEI4OtqK021aBIIvuToH6suXSSTo7GH3BvyKfJsvDn73FAwIaIXguS1/p70TJP
	nCRgL+QVmz85bgCz0CWnzZWy+Zy/xX53XxsaJOo9du3MWI5FkLXBifV3yRlUzcOsvmdbiC0wK9D
	tiNIJ/r2z6TxNV32F4ibiP4R2YpfTieB+IMxL0pZTVD3MzSe3VW4s
X-Received: by 2002:a05:620a:4891:b0:8ca:110b:38cb with SMTP id af79cd13be357-8cb8c9fbd9bmr969754885a.29.1771837726667;
        Mon, 23 Feb 2026 01:08:46 -0800 (PST)
X-Received: by 2002:a05:620a:4891:b0:8ca:110b:38cb with SMTP id af79cd13be357-8cb8c9fbd9bmr969752585a.29.1771837726178;
        Mon, 23 Feb 2026 01:08:46 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm264049295e9.7.2026.02.23.01.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:08:45 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:08:27 +0100
Subject: [PATCH v2 9/9] i2c: viai2c-zhaoxin: use i2c_adapter_set_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-ada-dev-set-node-v2-9-77018c536610@oss.qualcomm.com>
References: <20260223-i2c-ada-dev-set-node-v2-0-77018c536610@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-ada-dev-set-node-v2-0-77018c536610@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
        Lixu Zhang <lixu.zhang@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
        Hans de Goede <hansg@kernel.org>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CmIFvWiWgpCQ79cxYV/h0Rf+mkxgiPi/0lLFWuQX+5E=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBkO+cT/FwQ0Sd0O0e304NY3uC9BodEtRHWS2
 geXlgt4S7CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwZDgAKCRAFnS7L/zaE
 w7AoD/9LMJ8NA9ZZLbnscpsC50azkbOY3PY+WsMzKuMWQHDw7cC/8mxzcLjCKzCcMo+/SsnkFrj
 NQBfmJEI8GucnAf/hmpfVYCACDQ7/MY5oU0QchGro2feA9ANUyPebBFVPR470df4C9SKh1KasQ/
 HMlcF1XQ7mBvyArp4+y+hBCInQSKOfbvN02mtkpmDd1jSrAs+98iKapTTEBQrftK+VaeI6NfW7h
 d4r5KVN5HcwLu/sxsFgqC3WfOslRvqJ4sgLM45nRmVkcKmGSYTqT1bv0FOhiNKTMeH9pommXPyE
 83vy1kwvwi4zQhf8L6SpHZTtxbttWPPogObamjRQzr4bcnSIbAcHrBmxg2zGX/R31RJOXn0ComL
 motgz+HJek7jL6eHc/atZ1UsaX/0kUfOKbhmYoVIR0W9lSnvaQm6ew1R67K3FtTQESCkjEoT+7+
 LE1Tf1U7XM5aXAY2TvAQRD28lEDkhWEjvLmIo4lIr4q331452Xj2AEE6UpXXHAW4JnRv8ET799P
 ZpPmWgEv1B361t1li122It2JbQjBAD4hYrs2bYmyfOlDAsEt9oX2kM5CP+40CmYNihngx1khVuK
 eWa2EfPlqzfDuv11YNbE4qcuToUP8QPBALN7bDyzMwrMz9yFoGZXCrllZp2/kMG5uL1z1mTkvD/
 5n9iDSn1wIBS4+w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX3Hm/cPL8QqtR
 tNi3wKoarI2Ff5hxPS2nu4g8OeO5AHmvQCBbNivrjtRbcEY6sav+VRtVV5Oac0xpYbsubkMYEZj
 N5OvnRTkKMBALmuIaF/SXUjGhTRmeb4xUuhWs7eaVcGj3BnRyY9wpQHcLzH2U59hHCdhROI2Obf
 I+xDTxLN8/8rfas3OtaIYy9UWvfBQzBAxvq8qiemBLKCo8rim5FXNlXO53B/WlScO8lmH9oBK5B
 sn5Pta6elNXu2NFLm4ilGC5uj9m32Bmr4Bd/AHMMYPqqFcQXlcqHh5u8avRxdkLQrsgV9+Adisg
 AsSm083ABvO5PVZhMh8LpBA1cjjlPvqKd3NxKBhNR7f2w8c1Ly6w9o31eBmXFsfywaOu8LylEBy
 BoRVB3waPacbUkWXGOeRkRtwlFlQTwqlL7GhWJvutxpPU/6X6wW1qa4WLRzj0CclsyRoNW/Cjzo
 y/6XML6fRiCOmWp0hkQ==
X-Proofpoint-GUID: dpaBFbqzdsv2Q4xvOYGuhMYF4uuOontZ
X-Authority-Analysis: v=2.4 cv=X71f6WTe c=1 sm=1 tr=0 ts=699c191f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=k9GdQ240dthP4cIONAQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: dpaBFbqzdsv2Q4xvOYGuhMYF4uuOontZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Use the dedicated wrapper for setting the fwnode of the i2c_adapter.
This allows us to hide the dereferencing of the embedded struct device.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-viai2c-zhaoxin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viai2c-zhaoxin.c b/drivers/i2c/busses/i2c-viai2c-zhaoxin.c
index 95dc64902b7cdb01beea04acf7bad8f20133d965..87ba7367473d117f8cb7d4bd422ae49f0bfb6881 100644
--- a/drivers/i2c/busses/i2c-viai2c-zhaoxin.c
+++ b/drivers/i2c/busses/i2c-viai2c-zhaoxin.c
@@ -323,7 +323,7 @@ static int zxi2c_probe(struct platform_device *pdev)
 	adap->algo = &zxi2c_algorithm;
 	adap->quirks = &zxi2c_quirks;
 	adap->dev.parent = &pdev->dev;
-	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
+	i2c_adapter_set_node(adap, dev_fwnode(&pdev->dev));
 	snprintf(adap->name, sizeof(adap->name), "zhaoxin-%s-%s",
 		 dev_name(pdev->dev.parent), dev_name(i2c->dev));
 	i2c_set_adapdata(adap, i2c);

-- 
2.47.3

