Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DD35B62C
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837601; cv=none; b=jr4GKzU50oKxzb27hmKBzgkz4Sch9qEOlYZ/jTNsXJcEM87TA61V+txPryzdB2OLkr3ikBuWvELXr2Uv6qfSIa5L06c1PA2qUNZpE6cC5J37VbtZsY7MES4c9mpsUADzJxY7XfjUIZuw+MmTy3TEatrxOsLJtduN3VASq2xbq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837601; c=relaxed/simple;
	bh=u9n9l0NVttKMXo8Cm/QnZobv6JruCHoppeN1fvpKWko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRAwp27+ifzAtwsCPfykghqkEJTbbsB4bKX69hKUo4Aexlvy1yuVJjEp2UiPk8Cl3a3Wfz46qwGxjXZQtjgKEtWyvB3dAOXZOLoZy3gLxpd8f5VnBT65EsgCzuv1gPwkooRor5dsbfUVfVxoyyaILbC1Aw79cJmc8TNqgmBbkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ks9LgQaZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gw95vzYO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ks9LgQaZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gw95vzYO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNRjIr2554584
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Fj+YoY3aFmHNkVAQ1kxm2aXYDxfPdFiRa1WlYNrDfI=; b=Ks9LgQaZ3rISUUiB
	UPhLyg/wvHNrMuQ5MWGAkiHx0iTOMmkXYe3Oz/aqmkvOAKX51jAY4jDR0H4ZoTL9
	u3f8F9FGGFVb7seJ0dt4qNmUb/HHrL36jZ2fKTHhNqsTIv6HNKltCodV5RFZRSoF
	IeGKpz/KS4ztmolA34vbLAiIibrhLpIcBlIHcGo9llC5ajpnrOWXzWr+PkFnC1b+
	9g6P/WEhspfqn4px8qqJ0cmtjRLXgrYitdoEVqVNtMcSPtixCMNKxHw/10/QXYY6
	hV+QRuOd+9Sl3vBXhlqaFfuKPPDX4cVO5T5OpDBDeiIGS9wYL+6vHU35jWCqbSw8
	9V6u8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyv2p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506a07740bdso408419831cf.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837595; x=1772442395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fj+YoY3aFmHNkVAQ1kxm2aXYDxfPdFiRa1WlYNrDfI=;
        b=gw95vzYONNCteCUXzl3Gp84NeTEEcbsXinpAA/yQq/Eu5NrHEnM7KMukZI5OhvoGKA
         64lOaa8p+2/lna6ezxB4riqRbcc5j26LzR3q5QGTtimh0Cyrrc86T1hiVnuZlGm2mMBp
         DN3n5+Ml5Ym4YD76tFXOc/xX24KSpu0UEaUxCbisGV1FwcnDmTm7pPjlitSeA/Ys5xoO
         25rj30K8U5hpHsFOhu9VyphSaoM2PHbo5njezdxBnrIoxedrnrpWycches2++11x78vG
         a1iXf5pTuNSJCnD8eufLCEHR0l2Lc35QSgESoG0kKYt/db+0+ZOziM1ZQTiWVaLdrNkh
         tAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837595; x=1772442395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Fj+YoY3aFmHNkVAQ1kxm2aXYDxfPdFiRa1WlYNrDfI=;
        b=traBw+BeD1yYK8hmJ00tfjLs8MWtULgcY3iyeepuenS3PlQN2hgsEuB/bNq7X4ErAa
         qOemtpKLXYzZglWC8Ho/AaO9OlwdMg0tX9Wqm6o2q8NNob/n0PFWXbZcnKw25SQbcRBL
         2B1nIXTzWCcDbTxK6ft5guGc6rNlRWH3JCI4f/NIeb2jTV8lULNaGKRjHw/DmbofURGu
         k9oicv8B1DIZPHD2EkaXTE5GC9d+y3hyZcV+gYmQolk2lLO5lDCdcs436Dxrx5LUDo8O
         Pnu/p5HuSFwCl7WJWyVJNzHY57BKvz7q/GmELfIzxp1Umb8cf4L6pkW/NIeKa5XGtThJ
         NDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO2mSYT6pSi+eS6F8d7kelhPuNJ8EXKsU0xXUDGWJlJYobd6w/NIzpcQ0GQGPRS5QTdyA9+VLd4As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aLUyQyMGMUdRy1+az+1S3IJHkjQnAYDri6CHqqNJyiN4q0PA
	VhAyR3REsNqMV8mCSrkU2LRVfygqZC+6L3LWKhFfhnk14sNrvbDidvE97UpLbI1X7wqgAam9MQI
	8yjWezHBvpKZ7UTBzjcrYyMKptKMfDpPWZBnSrR56bEYJrUVtnqEd7ECZT++np6c=
X-Gm-Gg: AZuq6aJesdvmRBROb3pVAXb4UrrnJyXg+M9VEvT/6B1xhQAMz6fcs5+s/kXhSQCR+Sd
	f7GOtvPOP2sPMmsXKI9qa/eEiOyvyIMnINvXYzBN4x+wZ9efRbnbtf3G7qr54/L40uiuAg8CSFe
	g3XfXWW9XvuzW9TwZKo/Y4homv2UNuyCNXD0+trnOPMg3Z0QUVgeo5dR3qRpVCEXPeBYb60JzR0
	CN/0DYiBZOXk2MOq++/lM9VPOmHzHtUNR2dFggcnbCwyUbH+d30863ond/TreGw2ym1HhXtwmRO
	Llv9gnJffrwZTdkN08QGSmSZ8oP4wJAQJ5bTP9pboidqDj2Cv/m2LMohS/VfCgld4h0kf6Ued/7
	w4eYYydA1DesOBy1xqGYhbfMPoLdXI7D0gKL0rPXWaBtqte2SWKFs
X-Received: by 2002:a05:620a:d8d:b0:8c9:ea1c:f218 with SMTP id af79cd13be357-8cb8c9e009cmr764191485a.15.1771837594974;
        Mon, 23 Feb 2026 01:06:34 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8c9:ea1c:f218 with SMTP id af79cd13be357-8cb8c9e009cmr764186885a.15.1771837594436;
        Mon, 23 Feb 2026 01:06:34 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:58 +0100
Subject: [PATCH v2 12/12] i2c: bcm2835: set device parent and of_node
 through the adapter struct
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-12-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=u9n9l0NVttKMXo8Cm/QnZobv6JruCHoppeN1fvpKWko=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh6jRDDYe/3k1buXIvSNZ0TnkcrKdAhpsYOn
 u3Iy5X2HQaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYegAKCRAFnS7L/zaE
 w/fxEACOqkkkfaqNDgIlMNMHdbLfBNUN+gmyyErH+9RBYgw21lotLXldvXjukuDR43t7iBhEwQ6
 v4RmssSTTIPx1IaBN8RKqSTKhl9DxJTZoQG/RWkex+IXlSU6aNk/eapEsQIS/ImmReGyQbGzaUC
 7BGuDxYIhXrvzKsSOw1FzEhWWbMSZ4mtTdk1CZeUrsOGpc4smvhI1+XwAzfjXYf65/NK5LMjc8l
 exdlUnuKLFmfZboiBNCo872Eq0XM7NQmb7eOa67A2jpyxL3X9WXj2R5d1/Fr5IMGeWkZdnRpjSj
 5NU+AHl99u6k9MDIpqfSEV1EeSM0vmqqL/8Ixa1LJa7BDu2RNTN42T2+jCzGg42h4AIkgCTP/dl
 l8qVhh3hgMSHhLhJM9H9kPZwlvkqzO1eLwurRNKpTgz5jOjqwmhiOYxEKoxyr8+0J5LD6n5NLYg
 ZSNAJM/fPknh9iPDrWlWBHqxOKOSrZnLL6HXgCJ42zZht03ftuKgxXbEtQOCU2LIHKaePurzFUH
 3cKffAKB4Yo8oDatXqW/WoQ00bR9iDb5ms+rU2bXP8WjcYq5y2u8vrw+bMM8L/ZuzYmrOzIgmO0
 +mvyxeWTLzka7zKtqqCtpQUs7kT8hJHPP/MEXSqM3WPFQz0WeLm45y/8qDGNiDy+7ahzeaOkzbr
 cwHccInIQJYdhYA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX0HusHI8Q2HqW
 qWtr1+vUKO/RP9PTAJvz8xmuKZWq1pmCbhsX/LzAQIFPc1bnN7/WSosMGcuTnYFapphEni/F1TP
 Sqo/WxoivaRh3UBnvPD03qL96DrZW0iw9skZ+xEXCkb1nT5p92yaZ3iZNguMrAIXRClIHAJXeZU
 3EbbxkcwUtcvOu4gCH4FOjyooYoEiuhWfPodRBCvcgPQcu2kiE3wRIP8q/J6PONDbZtsbOv/0/N
 k8E8bltJoxPKZnLnQdBjY3rvebYiL0RzEQL0/FwsP80JDwqdrsPkpk0F4P9O+ol226yFb51o2zX
 J30vPpLFocrr4ogTXXLl5ZqRlcgS7udlk/T2EdlLlCiWQtkAqWKuWbR047v+R0XOvD1u6Y5V8Wt
 NzPo2BFXqOESUHsQqs38F2FJXOFkrTFDgC+myexqOSo1pp4Qaz1rnUAQKxkdLCUA3GwJ2tiym1N
 kC2riB2I0zd+Kc42+Tw==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c189c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=w6fcmXAubz_WdynIYoEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: uy8QWJMbKG0pxto-BFGWiOgKn7UodMUv
X-Proofpoint-ORIG-GUID: uy8QWJMbKG0pxto-BFGWiOgKn7UodMUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 0d7e2654a534e92a529f27fdc049812359678522..4f7e4a178b33fdd172657cc625a34018b18f88ca 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -474,8 +474,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	snprintf(adap->name, sizeof(adap->name), "bcm2835 (%s)",
 		 of_node_full_name(pdev->dev.of_node));
 	adap->algo = &bcm2835_i2c_algo;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 	adap->quirks = of_device_get_match_data(&pdev->dev);
 
 	/*

-- 
2.47.3

