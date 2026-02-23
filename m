Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280334F475
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837591; cv=none; b=KHM56x3+DH1eWDoIMieZm6Czm/cEETJykJP3sBQbyWqDCW9+KQ9vybBkQ8LK+UP6+nUzBl+2Fit5bin1ncr32PmHKvlgtu16KoRPVk97SZfaHcpIE8gtK9Q877VQRHuKVhxRJLGRm65ayU5VjuWR/6ldkP2P87L/Hwhe5Xbtfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837591; c=relaxed/simple;
	bh=rx2dtWdEbZEet4K2jCNLxIpDHbio19pJqqBXzjxrlr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MICtqy2C+CpRIUru+Kopo/YiHh70RnwGh4pz56UyNpubLqMYMsP9+1AFcrvSm3/r68NtbcjDU67LOxJaBY4y3CJRWU0EV/35Zf+4TwYUrQLBdY8QqBfpV+Q2EHMsW5vLUSn1dc7ULSCiSfwWVhw8LdbvFAT17i9Z5iu5UZEUtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VohCfQdI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ix/ySmlD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VohCfQdI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ix/ySmlD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNXlfW2565272
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+8jCZSnA725645bJCGnWztTQrVO6H2b3/VrLHIDxkc=; b=VohCfQdIzABLDJmb
	Fw038ZU0I0zohd5ZrlgbtoUHT0ieW1PFZXc8rioSQuz7MeTDwfTB8XscACuRc/Jd
	nUaOZ1g6xn1krs6hx3IM0wp/eoG9ZHT6JBAMYLidRoP8ogNZ4Ur4cdUvm3vABeex
	pTlCGPUjnNdVbxz/D0uiBmYgDN5vRVENYXBOsPjyUdHCLW9bNPLCywWZlhPxogmV
	Sc/qCB7kBRTt187PfITDacTUfcuzXjy/1e9A36D3lhB2joKKWdOkQhCUEWwlxQpg
	+31mliVns/XJIeAz4EjcCJYUyxRRVKgBNEJ+GOwRRkVWxgzmgJEJuZ0nCqcO78Rs
	jtFvEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyv2mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c711251ac5so3581937885a.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837586; x=1772442386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+8jCZSnA725645bJCGnWztTQrVO6H2b3/VrLHIDxkc=;
        b=Ix/ySmlDqmkfh7DkiNWWJXqoLEgprGZBCux1nrF3L1Z22u8v5lSULD2EN//vavinmC
         K3OKjg40n0FNjzBT6y86d2osDvBBe3/Pyj9xwX6KoIeNmhYXnSBCggnItXS4t7utT56w
         duB3Cu9kXb/XKyTUp2qrL6mlHE717TROCdxW/Wq07T36m6fIP5h+0q0T48LEadEuUgaj
         Z6r+Zg6Rjpjobdff1RaAAsDcqWwitNtJfgtDRuWjpCVr4wufZAvyQHkBy4jQBp/tMRaf
         mrtfHydNKKw78qXNboXGMYp53BCRgGC3GggKcYqTA4rFNfP6pCtXZtcZD4tPAKWNQvml
         6QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837586; x=1772442386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+8jCZSnA725645bJCGnWztTQrVO6H2b3/VrLHIDxkc=;
        b=BWJYy7xJnYFcChpjfmK1L0gOabvXLapZjt2wZ9nrd07aH6C5DfET76AtQp1pCCjcYV
         DyrLkhn4NODOTovsgqL8iolRMVVSs8CXwY3LgL34oOLQhGf2S/mkaFFIPXjeBezD1Uza
         zuKaeBBScjuluhMN5mH6gPc1qKtntSw2B8dSrZBj8OBy4GGYHvEnEkKvDWnboeHVboOf
         MOqpY0VRjOT2xQ5xcQCooQMHo4jvXlcILOO4UDliWvtp4XfFHctZWsJarU/8mUrivPaK
         VUsDQfJ01Nn3/A7pIjxQLe+ujkFxSdE3oy5GXVBGCiCWT7mPMK/w8htLWNm5KtfAbPu9
         +M7w==
X-Forwarded-Encrypted: i=1; AJvYcCW6Fr4kr3/UakvIO0ueIbQjUZA1M035ktEHFmPSGxAQ+U1wl5+dyvfTte1pTlG31NTdSgogQkuFOPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxthx6oB488aOYTmIRwxmwjU6WomZ4s7J0qVQrORZZlGwvmU79A
	uXCWacFhbobwGXI/wjH/EdOiwH5j44AGAj8AvuiLlp3NlcpLyEinr1sZfhAQExXzoeA0HmSZnXm
	LQiIiGbWX/VhENptZ6CeMPsQrwegW5ySgUXbhIkpzYc+EQ0+K/rqYnaM9mCaT7fY=
X-Gm-Gg: AZuq6aLnoEXi7CneeI+zv3mWNYXZtwtlwmSo1X7h411sKQfor7ONV8Zo1DMQN+vGEF2
	I7Q+Dlb58MKLfZNY+LoYnSbo3oZcNlbJQIZdno932bCIZmLHSYctPCoplws80FDw2GXWK7VM28c
	dLOBm+VWLtwxg46BHaG5U82MwWM5rDBW7sj1E3ix8EPLZ64jViFh7k2qW0LhvGAUJ0xyxDbKUuW
	6am2ByQlSbFtVQ/lGN8avZ5t5I6MfD2iMuf5OMyCk9uURBijsGLpFHudaXJvDa5swvINgVooTzw
	rjG5sVToX4WUSKiedLLomOW9tMYo2INLSy5GhqsW6IvlYZ2VywMSQhdb/K/oSPwLDrmKbeDTOIo
	ClwrDVayEfNG+683ckfSiCszettH3FgLxo4guBGiu4UaTi0O0mXuT
X-Received: by 2002:a05:620a:25c6:b0:8c9:f996:81f7 with SMTP id af79cd13be357-8cb8ca92ba2mr819916985a.81.1771837585698;
        Mon, 23 Feb 2026 01:06:25 -0800 (PST)
X-Received: by 2002:a05:620a:25c6:b0:8c9:f996:81f7 with SMTP id af79cd13be357-8cb8ca92ba2mr819914785a.81.1771837585240;
        Mon, 23 Feb 2026 01:06:25 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:53 +0100
Subject: [PATCH v2 07/12] i2c: st: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-7-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rx2dtWdEbZEet4K2jCNLxIpDHbio19pJqqBXzjxrlr8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh352YX7S+FxODzw031A6NZFNXTTScBQL802
 bH0eQGAhDqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYdwAKCRAFnS7L/zaE
 wwkxD/93SJI2I03XT8QYkmz2qqEK1l9t+/u3zcfCHXOkN4VxZpbr3NNH79eKM4Izeho/f9oZSlt
 hpXtbZ1986gfzwMjem3xOh4LrMM5uwhAkYvTyq4h94Z1kR0U4CdqMyz2dFTrYQofwtaEaq0QYtW
 2UsClAH3A6oAmGMw84nzOkOWezWyuWVxKZu6RV7ZQsu2HqHBrksHdxpzAj07PC1rIUIKlIzWeMd
 Gu4R+nGnEsYBsqvU9UahVeDs/ElVSq+sMVG04A+OpeDoih7meDq8ZksVqmkY8aS6MbPgErpJ14r
 rfdmmPGJ3mPF/Mh4pi+uFB3sHnbzbQFg/O8iIZLC0uwQt+5BH8WIDZ0NT3m8EVRfT1Rbmn/Dpk/
 O9Jr2qQugx4m+eo3nFBu/ofAUZ6ode1AkJY10UDo9PneFzFVwYZYyIXmGK/AjWCe73SSYxRjqHp
 7iJNoHcpQ4MRGF0MpGRK5bRPzXF1YQOJtZfABHxUlTVVeBrYthBuFfzXcSV9riTNnNnMATVbp6Z
 IUghQTpX+9+gwWg7mnnANmCyfmulcIHi28C4mPCjS8U4rx45Sl3FDmuowjI+94bcn+XCPmgKlhx
 SFf6HkYKbnTMk7XUh1wNeWm1TMpJhvYhbhvaZ5Lkq3PUnPnLuKmuGtFdtewCOPT+JqzC8AkG8SB
 Wm+qW7Ou23eA11w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX8Pcz3S3tGOa5
 HLXIRH4UkSdK4Ob1rWHaYr6OvguqazrbN0LT4F5BvkkhPU/6UKTpz9JI8Xx6dCngiAgu2V5/qEg
 LgCOjAVX/mKFly4inKAXtl+2mF8VM6SvN2H0doSIaNsUesTShYRuYe5ESSouAnbqWD0R8flJbCp
 DoBH6Z3m8EJi762RD3kjOuFdVEiSoKPxMwuTdqGz6NlVm/KQ7m0fJTRJl4AmwjCTupaF26yl/Kp
 bE640KV+kz2k9elRA8ksZ/TSGFw2+jzb1WcWQ0JndqjplinA3H3AxWP7LEw1qrdi+h1Dlp3TD56
 4FulS3KNbJDxuD+W9Kk6E4GExufWk5MtiPo0tk84eVMJaD0+HMsScTA6F1uQXnIDoq4KJ2TnHW7
 xEsKccIsn/QnAfSC/1ZHMyOvtYhCdGYgm/kVTC+EzH080L2draTWg7iK3QWlc6B+1quBjFLknSQ
 o8KWLNz2o1pJqCklGsA==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c1892 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=8b9GpE9nAAAA:8
 a=EUspDBNiAAAA:8 a=5jvZOilLG3lo3iFWl1UA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 92be36IhHr84_h7eszcCtFSeURCR9pAN
X-Proofpoint-ORIG-GUID: 92be36IhHr84_h7eszcCtFSeURCR9pAN
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 751ea421caaf388bc2337026e0860707823546d7..88ee5dfb55e469b64537694224a0fe39008a80c2 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -850,8 +850,8 @@ static int st_i2c_probe(struct platform_device *pdev)
 	adap->retries = 0;
 	adap->algo = &st_i2c_algo;
 	adap->bus_recovery_info = &st_i2c_recovery_info;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 
 	init_completion(&i2c_dev->complete);
 

-- 
2.47.3

