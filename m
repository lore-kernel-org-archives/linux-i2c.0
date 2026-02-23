Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4A34EF07
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838065; cv=none; b=C4M6Nl+hyv64UCjMJTnEEC31Qmj2ojK5N82VZaKHOO9ILiSOxidMNwHfrqqXfpFGPEVwku+B+DT3gGYgPiVTurLa3R9WSgJo04BtddK23I3HV0QEYEVolSy2jh6nJNEc88gnzr5GrbLCjvBBoxFgpeePnmrxTyKYlVjADq6zxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838065; c=relaxed/simple;
	bh=pV4BB7VESvwwOGoINJ0yyIw3maBinxln5Jf5/nDWw4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0DPtfDnixUYGwvzTeXh0hSfFP/iG/52pR7VUyvE3RqJvTQzhQIWbRM/3yzEitzxJtIQQZJjW77TpJiVxkemCa4JZsWmeqenBSHvwXxu/nn4/eI+6dUltiwUjj4mk7OB2/nxHjRgpyjz2LLUSi8lLfQ+mno6KKCPlD7sBl7WV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ToyIMv+4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eFpr++pD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ToyIMv+4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFpr++pD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8O2Ka1543248
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AV/DHL0paDpUXzhwtvc8PrdZr2Xx/XbyfZPyz0Y56tQ=; b=ToyIMv+4gPxgJGDz
	OtTJXTi+6ijgFirVZaPLg6Jy4RUZZX/AFbbK6RX8Fhl71qcqqPoNGUpt+HIkIoYx
	KR6qVao5alntB2UyLJWIr5+IeFEVsdgt+LTmo7nncGhgyO6pWAx4qD61h4uLIB3B
	o90pKouDd3F14S6qyY3DuPE2J12wqRQSznVP4aELkujb7vuz8p90KIAiAPm7R3TW
	nZ3IliwtwLlDnho2o8M54txvXbR6J9bvN5gRnY8dFTSeyGYPZj/sxLUNk9NlpXzZ
	D1DSFY6dg5vPPwAMLMHoHqL37h7BSrFoOU6IELobApS8Ifq4umNQV4JoOpgjMcqW
	Vg84Xg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5v3v2x3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:14:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5061d1ef1f3so647586761cf.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771838063; x=1772442863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AV/DHL0paDpUXzhwtvc8PrdZr2Xx/XbyfZPyz0Y56tQ=;
        b=eFpr++pDuJ/YU8EVovKq+Gk9MSk83uPorbnoHM41gPylFSFNMtZaQYNmAWC/Rg3D+4
         g/DypE4d5pBDBJQEgWfUMqx4mj2ri0Yr+6/8RE+BZlT/Z1L0EI1kzRYIaTs9a14mutgT
         8OBDkD1X7H69xrJu5DUb1GSiZgXXnSTpTKeNvIZkTfROcUeuTLDUQdrhNtXQWYm1BhO1
         B5ztBKKSkDSBN/uQnyDeOH4xo4v6V7J3gsiwVlHj/VG3oDAWm3SGbtAUU9BJS/EpZmxC
         5O/23hgY9o2CrkCtxgIZ5q5mtqY/xRode9Sqo/0LfYbQKdsTRdEbAJ+ZEsqiqCh02+t7
         PLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838063; x=1772442863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AV/DHL0paDpUXzhwtvc8PrdZr2Xx/XbyfZPyz0Y56tQ=;
        b=epKhBo/tSav3Ch0reHyz1Vcy8P5iemxfE57HQjKo4bHBAAcRUDDyhBZPcI91V5GPob
         hhlDYbAQp9C4pGSfTY5B+0f9sQeC/N+AjDG5qS6AgSm9Qov07C3UMZkLAg5TmqEI8Cny
         3C6TVpIxCobFlGeVAt62eY+Fr2yxrcPQ/50dlAD2l9qj3LzVoalOwKYidNeBLzGac6ea
         Pl7PVWR/88Dq/fKp0iNNYuPjUJBtljsSi5k5lkxMYG1HUq3dG9OR2vRNMH+JkEnM81Zl
         +qTxraGPTFx+CXKN2c2VHYJTzk1i1It2/5fvAfG5IOpSuQUH2H2OufKjOmoYxGKjgzl9
         sejw==
X-Forwarded-Encrypted: i=1; AJvYcCVpvfWhsb3vma0my2jEMUVKLmQxkw6jtbYyVJAa99I3cyl/gXbxU/8tzCCkbzAGJFMooQSIQAs2jMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaqk6UIvZaRdjC0hSqWFNb7Y/iV5P7YDtFR4ch8OiwOoF264ge
	r8LydZ0dhM6FMbzhyKN+C33DzP4o6O8PuOCW9D5M1t55OObdET3J/GbVWpud42Q6qQZvQzpvtpl
	YiVf+dyXrO+Am7LPBdbKQL30MeYyBcQlszwoaVh+QsO3o05VHaEJIQtAJikjHJ6752fP4ens=
X-Gm-Gg: AZuq6aKmPgWlnS00tHTFMbOzG4ggRgHQ+RZnWfqDfpS6qUoW2XCZ6fwsXR4+w4GHiF+
	ZpbhjOOqHqQ6BBhfZXnrwXm3d56Q8ZPNqgPUwPFEBDDAv9CWq7vBaY1KijHlet7K4AtjBbrk040
	CVyyQQaXjukMrqTIokMYA8s1RZi3oGHWz86tvoK6kyALmiLS4jRwD9Q/3WYKU4p6hvlPrqwlUy1
	Oob37vEeqi372ZPe8eNOTf3GeoIjIzu9hpd8dvEwz0UdchieIArEx13NRfYbS3ZLow0JBnDaQUP
	XOaZ2U4clC2Oo2DUZA4xUM6de/vT/VEb6zBhidDdPn8cHjoENWsOqlAnk81DHi6WMPGNqypZnyX
	bwbO61geNBr828SlqooF9G4NOOt8tlMze2Rh7wzZ7yCCw9kI8Cwsr
X-Received: by 2002:a05:622a:19a3:b0:502:9866:7547 with SMTP id d75a77b69052e-5070bc6c303mr121335671cf.43.1771838062840;
        Mon, 23 Feb 2026 01:14:22 -0800 (PST)
X-Received: by 2002:a05:620a:298d:b0:8ca:105a:f5ca with SMTP id af79cd13be357-8cb8ca6e5d4mr903307085a.47.1771837570545;
        Mon, 23 Feb 2026 01:06:10 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:49 +0100
Subject: [PATCH v2 03/12] i2c: bcm-kona: set device parent and of_node
 through the adapter struct
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-3-d78db0a6fcf7@oss.qualcomm.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pV4BB7VESvwwOGoINJ0yyIw3maBinxln5Jf5/nDWw4w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBhyCl9Rsm+yhDXm29XU/HR2ugRm1pVK1Y0CD
 7TkNCnQDmyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYcgAKCRAFnS7L/zaE
 w7sLD/9SO5N/l8NkJMRZ8orITe68nCScnBshSzOQl8EaGa3Jvtk/L6f1vmYPYghezYgbU0WUPaN
 3OGPStzjSplnC5Uz1Vwe6MXVBKVTcbFm7QE2UOnTNgutHhrBBFyzeRvaVxQfNpFtPvVtANkMVNO
 x4gDOe34eQU2T/3XWReYHftzyFtIH5/HUN4lPIfv9Zmji2bY1AqKceOY3SGgp9t8DAhgDHMrriu
 3dDpBleL8kMsea2pzl2AX08+3SNj4BUPQihaut2B8qV+Oq4Aog2HlJ+o9x5cuCCGmlzuXzTR/kh
 Ia7RmentNuQ3hevCck55A1CgD7SXDP0osGD41ERDL//ZnADXc6bwgvew41k4GfQljU4dyloLXaV
 9d+QWNt1A5E4rl0YRPBya6pxjKsv/aGWyUH+k0/VXskdehU3dHYT/d9SYyBYEBqlk02LbEWVf3e
 IoT+UtOmEVc73SghWDbQu5u2keilAj8ivk779OFrHM3fM9bZC4jkEm1KQJ0a5S0LOqz7jxL8mMt
 qmkDF4Jr5jhmohm/R74LFaWAGcpcBDcSqpBxa+3shxx+3Nmv5DNW71aB7UmPbU9djdUxDMjpBFR
 hz1SlZPTMQYxf+zrDk6TVx4BnyUMUhyAOYttQlGV6VwcHCm4NRVUWGwJARKC2DnUtAJd4Si1BtW
 tbT+IjCraKX9bsA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=YL6SCBGx c=1 sm=1 tr=0 ts=699c1a6f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xxYytfOIdaUIj31isgUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: yqw3GC_3Z-8zwjf0h9rAp-LrjZm90kXA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MiBTYWx0ZWRfXzidowBDBfXZj
 NXrGVjTpwG3n4sHxEIcbL52M0SIAujUWKx015MZAzoh1lhc6sYiInMxN9ypKZy8EVAtgM3twaTr
 +3uv1kkFndaAfuK45KACpPR8IzKpq33IgyA9SCEYiy5FR6E5FIQBfmGQA0GqyvGTagNtED9ZTl/
 D/YVHuDXALaoEgG1Jq9cXczZGbKqRPqNrYk9oxwrNY/SiLvRjEubV6Kpl3B2olswxZoMi9SL6Cv
 jPJTxJe01t4zuN8rkkVC9/OkYXG78ryKfNnRTQDLZW5R7lQLDMavoVkqmsTmN9rymmi5u5LB9Y/
 M3pMRqV5GGg94JND/y7/qZ9oJbBap7PVfrLIb2TA9TGq1P6GxDDv88U+sPm5pob2a4yYordQW3s
 uSTvujhhcdeibvrcG+Ne8MxdaGqDMo6NFCow7s5xg5uRa3H9UPiJWtgZmwWIYSOKZ3uQc4mCMdA
 qrdvqjr35vTc8r7dZ2A==
X-Proofpoint-GUID: yqw3GC_3Z-8zwjf0h9rAp-LrjZm90kXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230082

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 9d8838bbd938bf6c43d9553d9f54acac1282f7e8..edd79689f40f451fc216455c9da5704bdc73c62f 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -840,8 +840,8 @@ static int bcm_kona_i2c_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	strscpy(adap->name, "Broadcom I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm_algo;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 
 	rc = i2c_add_adapter(adap);
 	if (rc)

-- 
2.47.3

