Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455014E3760
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341961; cv=none; b=lBRsCDLrzyLH7efMiItnzeDM4pGLJdb17FjPtZ6PoFPyP/LRzXi/aAo2Ce95QzObj4lK3kaDs9o/ENq6ZlcWmsdIC2d/wkrHG/pbqjUDPkUoNKQnN3zAqk2qDtlw5uZ+UI5rnM5d+UrtecuSvLDRvlRyJSPjmMnObzAYPinexME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341961; c=relaxed/simple;
	bh=JInI6IaLUgntKCu+uREg9rT+W4Ko13o9vFl7bGYELR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAv3FG1XKoabiAtfSymD4PkqWZqVqeROpU7qbzwJIbRGxiNm+ugyE2uN6Kazn3ri8JHCRYdyMZxxS3Cmgz1B4gY6tqhEoG291DBxWz6TnTpbVziKb5e97IKdyYx2pS7ShXeGWSAS9YV3ZSKGSaCnzkJF43GUTvaPlFkwxpm4+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/7z/rGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ocb3Lep2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/7z/rGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ocb3Lep2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxFZv401621
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 12:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=; b=a/7z/rGbeBcIvVDJ
	IFDIH+aKe+Rq6bW2ZZywPVfdOBkDjOYZybq/HmQbIxrR9rHxQNmH5uR7ev+okVyZ
	1vs2erWLxD1FRKaVG2EZvA6yZTo/XaVJG26Oi1+1UVqrye048RZy0jMEtXljlM3S
	3wc9rXhHpSBA6KYlGC+2SzdyFMxHjb/pofCugYeM2qC2HMkiWuECBOCv0QPoD4NT
	207QzNR00AGH0LzljPDd9/F4reQ2J9H63QtxytIL+40USJ5acX65rNwpzn/p0eo+
	5t6nrFJ0zECuws7bsV8rEXI0WrWCRZ2JxdrYduR7F8Eid0ozGj6ysP9QrkPsQc8D
	lfVu8w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3grm4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 12:45:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e623b0e95so246877885a.3
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341942; x=1783946742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=;
        b=Ocb3Lep25vhFpNyZuaiED9fpWi0LT2f9PJy/+f84b0w+DnWjLNyQmI7cO0ERTzeT1F
         cruksQaxE3UgnJQGd86alcYdAHLQ8hNmPZYIrlxT0G3ZXFiyt3YnH11Gwnyj/4MgKMo2
         ZxGPDO89tKf5xA7B8pqKC1pqIf6btaAN5StkUlVIVszFUSAaETcYuF07OVBIV66ndg8g
         yS9VnQ2+srflfjWhincFB9aboKQ5yhOPibf8ublDJNHKdaqPa53/wP3wI/g2CF6wXa5g
         lSrcuS6QZ1O5a4lvFUyt35DE9yBEef25lCjbVSE+Rom5QsMvs/fvVrThEnqBk+T7p6hw
         WkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341942; x=1783946742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=;
        b=ZMHC450iwMUJSjuPQwQIGR4Cse9E1yeniOQ72rGLvkZQN0NkB585lXBGaekYCIBL0Q
         cAix0mh1/WyA2m6VfcVSXlSesNBZueb/SM1V2rN+3ynt9Ws+v+4VdJRLKHjwvb256sco
         jk/+6b2gXlY6rZ1EQGTdNCUzuGjbb653SdHDJT0ZmnDTZTK8X/21pwj6BhpG8xnzRyZs
         dGyCXmwM0/yFo0jfwUK319MfvR1N0T/YZTqPMVuxQlKJqzJKwaKe9FgsTB6qvrM397Yi
         0biJeaDP1MN2+PqvCJ8oxAu4DRJSvWXrvWDswx9uXCvqaR8i7GwSjFeFN619B3Xl4EBF
         KH5A==
X-Forwarded-Encrypted: i=1; AHgh+Rqb0CLyu8KThqigOAAooBM9MCDSh+gd4CeZHLz3weWMeAh/nDEVT20Ge+Q45Z7TLuYn70GJjKYpgyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkmdtVbhf0AZkfNCG7JmafbSukJe2DYDSHvpFYQO2PEdBwh+2
	lJqkydgbNphTckaX2yaVwLJn+rv5IMwfUAKNpFGfuEPx3amD8rKxHpuzUp3dnpe/dD44mnM1zEg
	RrUTDNTtrWjmxG3QjsgwEikGXvzwjNOUrURCCg/OOL9d6dqiWfB0AV9hwSgq41o8=
X-Gm-Gg: AfdE7cmBf3zKof8myCo2V4c5rdUoUU/bUiExOgKrx29Ss2sejn+WOUUI1okMhi5QKbt
	/brC0y32l4+1CrqUk4m+WG3Y+5CTDpjAySgcDfqPDddQoYMFJG444hZKyl+0PbmZ01LLNWULFdR
	Hcwa4+pUUUxDRmfEz43o0RZvx1UVaoeFDOZ8MDQz/SJJLTXNBqcLPPsAmCU5+DsQfYL8V9k0AMM
	N3TE2rKRCaF30qpgYw9iE6cJP5wSmexWcfzndgnHx4lxG+pZ4YZP79JUUX1JOT9qiP5pUxu2Thm
	KFatsCfpGeG3WfJI/q6ory738cnyWoEj17UjqXa1R4YP9c9fCXo1PjDc1geAv6O9AJH1C1fBRxZ
	WifbVyllcQaMqqX2SP/nEChH0uE0thLUW88AjVSTW
X-Received: by 2002:a05:620a:4709:b0:92e:520f:1631 with SMTP id af79cd13be357-92ebb528cb0mr55254585a.1.1783341942177;
        Mon, 06 Jul 2026 05:45:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4709:b0:92e:520f:1631 with SMTP id af79cd13be357-92ebb528cb0mr55248485a.1.1783341941714;
        Mon, 06 Jul 2026 05:45:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:29 +0200
Subject: [PATCH v3 17/20] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-17-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JInI6IaLUgntKCu+uREg9rT+W4Ko13o9vFl7bGYELR8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M7wT/WHgW6r/IRJ084xmgiF5frbzCzZ+Ysd
 KzpdXXnNqGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOwAKCRAFnS7L/zaE
 w9ZRD/4qx0uZLuhxJ51kkTfx6+/ADFF5GoEfFNlEUJaWIKNche6TlU9gsv8TAwWOVwjbJrU7/xk
 sOhCAgEztM2nKlx6ujhRKxl+2TjXk2Nj2Bw4ErxTPNWcqaXZ1D3EOtzXJ3LEIh6TWcNXJCdwsGP
 svhpNoB7rI/uxv81g0JAGCh/QKubVkGYKQ/A+iC6UlkliVEVpj6p1u1gu2ULARKemU2hsn6iUFA
 1oRljszB9ML08rf3vVWm48Sov56fj0qlhwFlNhsJc4Fh5RjWbTDkVRumhciCbBeIO9G9C/i7/ln
 WxpGscgFQ1NqoWp3/aek1bpZ7Scu9xsMTp8jTu27iLrG2C81p3vja43xg1htjZOB5gZQOfpcwi5
 EetLn2abLuSiU1vPkjPCFip/qUHPoi+jb9okhj6gHUX6yyIsoLN5g9ifxmgS6NS5OJyVqPs7QyK
 OigCeHoGtjy1bCMPG4Ze2LA711uVJ/GHLSCxqSL2dHGOUpJsWXjreBLn6ahYXEuiyhvPA9QJPto
 Erpf5q8bz8AMXTE3CMDngaXoe5hPQ2YBtHJ+JMsuwTzK96EQrncN+e7YeNhqCC781jl3KUvObTa
 xxNIMne5snlFpSJr4q7dnJofBuyZU8anvtn71Llv/YtoY1RbDUwojYoG/zLeVQfPZRWRgelgizR
 S6rTgyuGX0mjiBA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: pMTcCyVdqqEX37VL2MwN-Jg3n_jJl-mJ
X-Proofpoint-ORIG-GUID: pMTcCyVdqqEX37VL2MwN-Jg3n_jJl-mJ
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4ba377 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX6Lu9niKNFaXc
 tbsXzSbLfaeQRwT49awjGGC1CprfIyeAhAnC8C7NJjOgGFZXiP0zQY47qdwCDG9p4XySvooK9XO
 uvxWXDGbu/e4pbGpC+LBpEQ1n+abgOglAfv1kFGkm1iIrWRrWUF+W7uLYwDEuCRyHfzQarsdGAV
 Za24HRAo91gvw95zzxXPdIgo+gahvaZ2JrKID5csC8zr+ZusMA45VC57je1zQPbXUMyhHZbCRNa
 N0GzqVxQtvtf/UiTWDRq75Mm1qfvPvzPghYFKONl7AqLnli5eC7BR9PlCC2WZ5EvEspbZz1aMHe
 ClXscu33Tf5ROn6kFsfN+4stlDtQI9xG3QqmQyuu2gQTRE6XGgc7IDtAlrlbOh473pkw3MKvGsh
 v7X27H47DUZxdbdm5YU+6TTkWCywaH0LiJSS51iN8sgSIPCfo7PNtJiYStPrzFgcVhkdYZRZdGM
 Sw0hHjbBAfZoZrLBzkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXwhK6glauy8x+
 6PFC+CMrAFxM1/qbDyauixcIPOvdb/3Pxcf89ZTsaDW/nwaKM1XLsM9nRysegAdlcdTSoS5+V9N
 x+YGXmRolbmHjfpAp+Mgd3MGe5fvJEM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 07563be0013f4d28ed6318a0751670ccef01d0a5..7edc512cc37dc24551efe5fca172777a0a4b0766 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -879,7 +879,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3

