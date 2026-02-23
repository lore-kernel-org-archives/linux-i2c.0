Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD334DCE6
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837215; cv=none; b=sF3GCNtNQzwkKPowzAj/6lgvKOeI2rMSsA/wzJnpmoj+pDrNTNp+TSLO42y/bo52FOgohj+eP3fIWutd+nF8bgmuclsGgMmbgKksGkk1IqMKDYr0oFmj72rEH2L40rb/4mtPJezOunNGGhocB3bSR7FWWAGqUxu7H5G/yAAr1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837215; c=relaxed/simple;
	bh=1vPODltnTM4Mj89cEM+Xo4mC22cbE/KV3QxgDL0fRbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJhXxNJwpaKOFvF2wfGqbSjVjzrf9yGv0Or8OTS/uxb2a504IHsYPRMqAuqalE3tA7t7w2pQMfpAR73Q2DxQDU1UV3ZzalUOntyvMuoyBVs4QYNU0YzFkk+CpK/wpKHbv2gvV2WEeKp/x7jg+MFqUAABPv0mfx50uGjx6v9Mq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PSRJZgRv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/5a/C7p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PSRJZgRv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/5a/C7p"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNQ6AL2061057
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	37S+cXhzJ7hIOalSo3T84dnFkx5qpw4OnqKSfI43WtU=; b=PSRJZgRv7ZFbB8fJ
	Ct2ywslvEODZYZD0Dteb/AtL1psfjK7xJSxCfYTywYJyUj64Py+RsIS4jn2Sz3wg
	SrvlcHpwdObHdk+hcFJmGMb+OeDJ/dRXBm1yqjE3G0dX9n7lwbQadBpiEgKTxSQ4
	Y27JqAhe3EVd56Q1Uov6c0DP0GJoDT66dNRd/1/L3bxGBd9MzNc/PSO1pYizrJqU
	1gipxi8xP9ya49/xGglniiT0N7PADwozdAJ29h4itJooEMm0obJDAcCpYuzck7RZ
	h7WdCL2Oi0JtixPv+YwAa3Y5wpxBCjZ+Voi4T291wstbp6U3XXSOHLMBBp3dS0vx
	n4jQwA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wav2dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8ca3ef536ddso5083424185a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837211; x=1772442011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37S+cXhzJ7hIOalSo3T84dnFkx5qpw4OnqKSfI43WtU=;
        b=Z/5a/C7pGSGoCEh7ULQhIejsqYgYj7R/TICAfq6bcFscxwvAzHQkTc1f6PljYbLA7P
         9DiRdKNOBzdY4Gs/3oZ5OL+HJA0XBfSZ5gqWr4bxcaijhFaKXFD+HnEJ+C7OEltHgQc6
         QbjL6oiKT9Eacf1bsbXNcxu1MG84mfg/ThauX5AYVJoDP3sficGRl0M9vbT7jO7ruAE0
         scRAh5bRimsH9ISov9MAiq/JtZY5qOLjqCchrbpsxKuQG4kf7V/dEWe3lVDAm2qTMMBj
         mZSnHfW93A6boZOG2ee+gbXvf+OnRFx2g2Vh8fq5zDRWGGr8JLC9g48ylD54rNKNGVBW
         1knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837211; x=1772442011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37S+cXhzJ7hIOalSo3T84dnFkx5qpw4OnqKSfI43WtU=;
        b=kUM9WFoduCgracmXihHvYBWp41HuzR2YfDwoM53PbpKh+2G+UKCV+t79FQL8f0Cord
         3lSEG5l6lmxPlGN0zIWwZgdM54bo3QggBXwI9YSpK3S3xlgFbSwQqCGfe5IqeQnWwmAj
         dVC6x2JGxhrOjCmji9sdlR/5m5jlu1pQXqwZv6zsydIj5AU8eITXxoDl2RpHILI5nony
         kFdgUPav3jIfB2msvMALhJww2fpDW2lknvIlhnjSIoZ0yZzrEo0/voZ10CECvXQt6p3P
         Mm9e10uH9sazYpjKewoLsDy3b0IRjpqpg0O0UoId0cihJFiET+4K6Um+rlAcgun0Yn3h
         lTtg==
X-Gm-Message-State: AOJu0YzuDAhJe8p8YAJvkeTC6i6/LMjUjpadldLJt28ldZ0p8D7/5xA8
	oDfvwWHLrx4y3uU44gAdVmpJt61QuLvHmeqtkghmEvMRrLXfmiZ8wlZzKkqEibsQPYCL5TYDZ4l
	qyXLRXOs4G2FnaN/CCosnSek3goDK9NfdIRMu4U1XM/MbVx42VpIj30fPO2Chtys=
X-Gm-Gg: AZuq6aJdfQdnTbBfGTLVjQm8s2gYDRY3aAQJL97L8pOTLcEM9Qa+icnKPVkxcehbn+Z
	ZG9tyxDzHa+LSl7A6a6zEgf5Ivtmko2pVuH9Nrmizf0nEc795p40ziRxKxxpA5hTrbeGFTpopYs
	RKi9oGaPAHKdAGkXqo0L5boUa+FnQxsClj6DpBCcJXR/ETjWncPSzwuiRp7xyHWEFFGGbFga6P0
	2+ZO3Sd00Hi2tfjJo5UUjIKslnhxF375hmMqguN05hINJBCNgIJP83MNVFRK8rT6zpN6BBJhNCY
	tukCUzvcgPR5xP8hpNVQtoX3z9lb6xFm7VsjCRQ1ZoP6j89XWt18YPnnGs1H7D34G+GVDrsHHyw
	NKgi+cpHpHBPeq5yV2V8Jl+hYtqY1cyy4l8hsutd+zAneTX2czI2S
X-Received: by 2002:a05:620a:40c4:b0:8cb:1c3a:90f2 with SMTP id af79cd13be357-8cb8ca81f99mr847882685a.64.1771837211312;
        Mon, 23 Feb 2026 01:00:11 -0800 (PST)
X-Received: by 2002:a05:620a:40c4:b0:8cb:1c3a:90f2 with SMTP id af79cd13be357-8cb8ca81f99mr847877485a.64.1771837210797;
        Mon, 23 Feb 2026 01:00:10 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:08 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:36 +0100
Subject: [PATCH v2 07/13] i2c: scmi: use i2c_adapter-specific printk
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-7-13b2a97762af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1vPODltnTM4Mj89cEM+Xo4mC22cbE/KV3QxgDL0fRbY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcDzdqpQoO1qrBXLMBTaUorlyf28sbZOZqxK
 AmDe0QuUlCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXAwAKCRAFnS7L/zaE
 wyA4D/417EoyqI0QBn4m++bexsMnLKIhOgaSKHUlCRm4WI0kBCH7GfKNgK0l6z9SvrOC1PZnQbB
 2l0PDir3Gnpx+UNskCvlxw9rjF3lBGssYYGa3MKV4RYggkAOwBTogDaLDyeI0bJw0LvXF9X5UMi
 V+vzvRzs/8vJXCcpVokzUI94EnTskk137bVDQDWWd94SiFlx30X/cS4x1o9Vz/UwklHpX7qi46E
 yMNQqgYnvg4PEPqi10LUKV10mU+2YEQR9/ooqGMteOJjbvRfb1VP00k9n8PzFzPUzWD9ZLCwHEY
 nnc2ULdIYR8Bcbu+AeD4P6PMQ1BpbGYQESpx7GVIKOdNcQrjnrLJefyJKvRpOuJd8rRujB/CwtA
 wnEutW4GlXh/yMXgnpqnOTzrQfU6hC7HMIhpMXf1sk/2idyYqgV/SqJMfZ+BMajPVIuVxTYglj2
 5euD/Mz1ZAtyF2XuBVL2mdeg3jqXPc9fJfgH6XfViUmnaKHN04uOJXrBeB8PvGFLzomwfyC3lCt
 FyF09qqotF/WPjhL+Xivo9wdFdqRe5pK/YtFHMyqtcZN9lpVIjE5exOQA6Kzr0tFqg05+J4v6xn
 caKJHWeVbnZdXH6hqq7ZJwglqDcAazl9a4qgg++XzUMrHK0w9pnYrkW1ldDjKXJF68OF0Uwgty8
 OqHs2gqY3dCK8tA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=KJVXzVFo c=1 sm=1 tr=0 ts=699c171c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=iZeLIxs0cxVxcBwrIEAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfXx7ID0XdE2uLo
 MJrUB5Oe2scWaEPAK4XUr6VVbh3KVyPP7Sj6PLQHlSq+KeFGZ5el5PTfC2OvXQ2cmNK8lDOHXH4
 M5tYuHLtI3csiydbNbQw7BKX907JJlCST6piK8lwf/YafNLvyO7BsHFRge/VCe3+vNM0gjHyRih
 oS4nVAA8brG34K0BjiNEBfV7/n8JPh6b+FEe0xsuN5bQ4t6JwyKa68Ksy6hK7wH0ZK+z4U25/zR
 y7wbP/f3boo2wZ5kblIC9lErOstKU+gjycmLKqIYJMnDEcaVERC00aNON+dtM7UGZmLSzTUg312
 KqsomfOnU54+J7J+fHJdJhbuoUNIM8tYGAr79fcXIp+0AXC/cHukRg49tmPxqr+km2qovFG0thr
 rXzL8ZfXYZPrWueqjbxw2Xsr/MbemHGOyD19GAhsJmTZwt9+YTwDNlH1OLZ48BU4BGH8ZuFMzVc
 33K6pFNugvSegyT8sjg==
X-Proofpoint-ORIG-GUID: 1Yb1XsmasNUtF8_KKBV_dTtz6Ht8jbFy
X-Proofpoint-GUID: 1Yb1XsmasNUtF8_KKBV_dTtz6Ht8jbFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-scmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 324a63efa1ab90027854646f84142f052a966537..57b8175f0fa8da52dd74c5bf8e3059358c033a37 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -87,7 +87,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	char *method;
 	int len = 0;
 
-	dev_dbg(&adap->dev, "access size: %d %s\n", size,
+	i2c_dbg(adap, "access size: %d %s\n", size,
 		(read_write) ? "READ" : "WRITE");
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -148,7 +148,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		break;
 
 	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		i2c_warn(adap, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
@@ -257,7 +257,7 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 
 out:
 	kfree(buffer.pointer);
-	dev_dbg(&adap->dev, "Transaction status: %i\n", result);
+	i2c_dbg(adap, "Transaction status: %i\n", result);
 	return result;
 }
 

-- 
2.47.3

