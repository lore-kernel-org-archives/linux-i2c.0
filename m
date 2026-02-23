Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD30350287
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837593; cv=none; b=PBB2rg9LeXC1o60BIbqQvc2ywc/tT/jqvp7XthogkZcS7O2pYEMPOFwg8X4gqUrc5v2S2qrNXaIhbEJ7hr7uSK3CVc4751Tyxqos13aPb/JWsuqAxUuLEt2D2nJbgYVgTMBH7osq3ycu20bYpogkXl47eA9wLiyXDHMAmv+s034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837593; c=relaxed/simple;
	bh=iacvmP5MKst4koF4pQzdNY4+k8gIR/r7nU+j4v1o/rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2qJiflNkS++Q+a2zZg0KPT/8glhffBqbuLqBR09d9Z2BH0vgSLMiMT0vUrtd/+ayMWaQqnIlKWSRzidW5UPqmfOT7E4OXEPYup8pD1o7LwfmLGP9gEqaYI+dK3XH0CXLeqpQKWU72f+oJZfGcn1t5X7Oo1Hse9lyj+hWYJ1G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAQdRWvv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ihNmpRB7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAQdRWvv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ihNmpRB7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8O2IQ1543248
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FyxLSzBCpAOYWjHIriWOLjSl7tu83i2BCeDdIz9SsH0=; b=hAQdRWvvV0G+NLiW
	MEGF9Jf95N7zQMt+9m5bmPGFLSo7Eu9+Mt03F6fs+Se1rzZb6pK1IW6IfRGnhR1Y
	o8ODSwJeWHfhUQUeazDO9mCdk9QlBo4vAeoXYSwgR0uaIuKCxeXh9bFuQ1eLb23N
	KDcGNM1YBpWlOOSI87m3Xfjb8ZyG5mxvfyVWEEZEWgqQboKe9MTk6uJhXGSORwts
	sNYIDpmBhp6n2XqiB3YvgX3VwBIC3I+pZMDCysz0hmBryFQJxW5Ni6liSbnKx2Go
	aegRmaZmzQeBegQGQEYD2xBPgA6stAI4RC2dePjjcbGPKQ8VRsE/OsSEjYVyiwuS
	WdohNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5v3v1uj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c881d0c617so3938632285a.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837587; x=1772442387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyxLSzBCpAOYWjHIriWOLjSl7tu83i2BCeDdIz9SsH0=;
        b=ihNmpRB7Cnua5Q32sp0DcIUh9lVh9CVnk32oWzV1KYxX9g3Um4qDk0xqSHeH2U/dXP
         qGDNssAgMpC6P409Cno8kFyJZZwEBO5phEUeVS38L/EqpyDIHs4+xODCHyZgYEvh0Bbs
         oJD4neCF9in9zvZvB9CiielsgcAjg+zCCIW8vFhosqCdErzciMEkaJFJYBJ5AhrbA8mN
         +A51B+CSieqzmdv5cv8xXIgwOqIndS4jBP6csqEBNWjoWXH2kigFOZabzf2rZD6x8F0q
         yN5Sk8JeQGaLh+lskMBoMGoEp8Nl3JMIQZlHGDvH87s1OA/JNqLRuWtZZNEGbWiDIBay
         8lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837587; x=1772442387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FyxLSzBCpAOYWjHIriWOLjSl7tu83i2BCeDdIz9SsH0=;
        b=JaRHrN7j/lrkfNs4OfuZynTKFItbeBdF7pI15lGWlLeHhBWzXTzonNMVkFciX8daOJ
         V1zWJNnczpQZwvQ+nJVapJM2sm5MJ75nrhPWqmhrzuxt/CCkY+U4tO6J/LQur9DcbjGB
         mXHBTDURemKYtN7yQAK6nNQQVn+2Qq4gYkalWFVsJD+P6NkubdLogjYPKh6ZLZYCGjNf
         JeCLsSXaDTLBgwiVlurbOwzZLK4YRxsc4ChpltRYP88WRwNOsF3tHrPwcyrjWx0oujGx
         BqNZ8qhI9C7an0dZyLR3jhNuLF8Iu/uf8Swca/au/B7+rrGBQOWPekZLywDuj2n0qMDe
         C4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWxo3Dxdjv4i3/AOxf1kof/pJATlFsOY0Gz5qJz11avdnDCWNOhuUs+/VJ2k1NwXN/1SE+9kSmHra8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPEvjoDR0lJcu/DK3h1dZmeTxoZDOvms7Vt6+Yo5hsouTuJlD
	bTDjKtj0o/mgkigt5QLSHnjWnDmO0KKtU5ABJ5OAeElXdWS/apTuHu/Pk9Q239KzhGDb05Q+4vr
	ZF0rS1O6cBSfBGqXnWAzoWp6zle3o+J/jNJ05rJ8jgBpJtamfbarftWqnLuSeReE=
X-Gm-Gg: AZuq6aJdKa49Iv5ConmYAthoBmUFjS9RU9m47lwBAWvhjmHW2nUkTWn97k3IiXxjQbZ
	ZxhP1iUb+ZWokD/sz8XN4YgW5ZSm4lnM4XH9tLZTKlxpZG1TfM0FDrk9d+BeN3Vlxp9ttiBm1My
	1pz20wCWE3l1IHR5yty0PpX8exU8M3SAzW1/1y8C476LkmIOFN3aiDwyNNFbYfiHK3+ZRNfgv7F
	GDye/pqZlMT3cvf8QGMwOS3s5qTcGx6gA3yJQagPaMf/OvKTxDaUZsfzU+aWMMLxiAalFQ8l1Uo
	d76aupQH1/Impfl0qi7eqFC7paMIxaod+dDQtUOlciC4UCChpXyNaUqs1cMnRuJ/xIBdVucRh0q
	4x9iW2biXoOU2Y92zyQEp1RawOLkGiS4TWADw39b1VhmOKc5nOpHW
X-Received: by 2002:a05:620a:4587:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8cb8c9d1dcbmr922888685a.14.1771837587489;
        Mon, 23 Feb 2026 01:06:27 -0800 (PST)
X-Received: by 2002:a05:620a:4587:b0:8c8:82a1:11c9 with SMTP id af79cd13be357-8cb8c9d1dcbmr922886285a.14.1771837587053;
        Mon, 23 Feb 2026 01:06:27 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:26 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:54 +0100
Subject: [PATCH v2 08/12] i2c: mxs: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-8-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=iacvmP5MKst4koF4pQzdNY4+k8gIR/r7nU+j4v1o/rI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh46t9YVusxGMRyOKiO1gXCj7YchvrY73yIi
 M9XKPAvJqmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYeAAKCRAFnS7L/zaE
 w1f8D/9Kr6cIxWLtSoo/iCsrKZvQ1AH7s9U2qJB6pL13Bs2n53X6os+fQTcQ3mW6OqL9+gW2IBO
 hKJyz5n049Yg9UAulAPIB2NwtjSqS+2e3S2e4+YVRmkxHqOdSYiUcQiX7UKJQU51B0sRz4x+Jsy
 j3bdNkn8RXeXakq85CDPNGeBlub6cxzXNysFXSejcPM9tA9av5dQSSq3w9uAg6Z6JlNv2rkjfbO
 Mru0GOD4rjDb05x/1ld6B71rL2iqeiOY6LJ+5Zag0iNaqwpIroZIZGRg8cnygQ3av91fBgclbCE
 wdt/NmYrtU9IIPBwJDv3Jn1NbLe2TjwYYADsuEGwKC2OJeadyxdITubVzqMoZVdr19TWwEhMjVQ
 AEImAkWG/9zFYjU4his2ENsP0xL/V2N6R70qdXddM3VPqQUOnpD595mWRSkqQgIfVG47kt3SB7Z
 8N/tLHhNvG6+30lNhzc/F89tdmILZIhk0D15gcNcWaJ90xx++Ua/MCzmp2wD6GDTuoHkYEt4hXV
 tO1YDz8vjze5y8gIf5ACLG3claNn3De8Yxn7RhBwfuB3pg6YxMWkplKp6r2GbZJdQDHEpWdLJEL
 owN4Lg0hxbwpY928+IW+n+cKYnIuhUEC+JQbKv8kTubPpXwlNvRuGlvIyVrD413i2bk0gWxDFCp
 W78klu2oVB6AoJg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=YL6SCBGx c=1 sm=1 tr=0 ts=699c1894 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ZBRMoY1RY0NPWYz5CrkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: rZVHrKOuFc-5zWswke_2fIGNsZwC8wtc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX7HurCFT5Ya9o
 XSTHEW2P+gMABhNIE0j2064wPtIYSqU9lLGGO3qFX3YYyQNswDr5hDOUSljZIDRwSmrnKJySQ2l
 VmpLyUYXgfFXvbLrGJmzLIZUM+Y4kVqNmx+fJ5VWsI5odmizgxLy8lMg5rn8Ajseg+Fa5vUuiXG
 50puhpWrL4sWe0OCMThVzYjKjjuM61yBW1M9oIcfkY6wpU5T6UHcdjy7kRhVKaOCukluUyxCK5o
 VEr3oeAFviNVvx4ng738JIH5hmbcfKFNnH82fWGbDcAbeHCe6InFmNabaR6qxsmZB+WLkq3FIP8
 2EtwQSa8Tbpz2F7EVV+wz+vzQyHGvdjbth5szNhNZgUTJ103U7D1haDcMtjc9W01icGoBH+EdAC
 TXOvQ1HIHCOgHvBhxmKTVKQsLG6gSSp0FrBl5UW8a+GeXEobP4Is3U37NpRkFNUzPnWpvMtWRP8
 PQs/B4ar8/SW39a0a0A==
X-Proofpoint-GUID: rZVHrKOuFc-5zWswke_2fIGNsZwC8wtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 08c9091a1e35151bac8d4adb80abdbd29a62b95a..bfbd96ee2f483cd1dd872c3448eaa6a17940d70f 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -849,9 +849,9 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	adap->algo = &mxs_i2c_algo;
 	adap->quirks = &mxs_i2c_quirks;
-	adap->dev.parent = dev;
+	adap->parent = dev;
 	adap->nr = pdev->id;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->of_node = pdev->dev.of_node;
 	i2c_set_adapdata(adap, i2c);
 	err = i2c_add_numbered_adapter(adap);
 	if (err) {

-- 
2.47.3

