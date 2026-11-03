Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793684838;
	b=zl1BMlqVePfG/vL+eX8IkJ46mCZTuEMKW7AQ7EZ4q30hV8wuVX0CAw+SqdsmGfdXOeSk
	 CzNupI+A6jkgnlKSm/Dp0Q4ceBgH5L/hfh+tr0OtoTPdgL+glA2ceKff12sGRCSsOvvQx
	 TyrsfrBLvg1RifqgpiBC7aZod/RMjphF5f7aTW0aPCgRtNnL2c+qfz+HuCeY/tfys363v
	 DSXvvLUwPdVmVqMd+6K6b0Iq6tRHQB0J/f2ITeLN91EKrYAnKPIEn2SfKy+Pr2Vl4cSg6
	 Yo5VsItwlK4HQaYdIB5iELShsnHQ3uWXNzEiM8g30TPW024emxRWygOjgGvZGk3pzRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793684838;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CAUzZfGxBOdGVKQARymZnvw9tUEu8Gk9GBeF1+1UKlY=;
	b=eUyEW80EADcDzS5Z3LgVVAzpcyFiQacBa1Ymlh6pM4gR2AqyRhnmTKkjAbMGIQrYYq2l
	 Zcy4s7Ho9TBkYwxlTNaw9HhMNRVvV3lK6pj2BBzpJETsN2Ba6FKVLNavvoVno7U8S8LJc
	 3oBzxRyzy5KufzXCjwjYasBbSGuwTw4FUMRd8aiSE2rwUUD92T8xf4E80+uHqOBPVYaL6
	 pWKvFwv5onEgyayxnnqGc+1tPOvI1RHbD+kXrGveS8Wmp8OklR+XPODm7xid9JBNYCein
	 jT/45FegMh+iIj2pOKxr1pqGqy5QRjjYOEb4gjpbUNxnlI1S1VmHRB0yGJQlmj1TL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B9WPCRoH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g56Tr5nY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3C606A329
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 05:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B3C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B9WPCRoH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g56Tr5nY
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31eReg471263
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 05:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CAUzZfGxBOdGVKQARymZnvw9tUEu8Gk9GBeF1+1UKlY=; b=B9WPCRoHyNWKGB9D
	L4dsvqEUClvH8NYUkX61OcAYrQ7xjNf8OsnFL8BeS8ivn8fOebHh8j2Gr53ZrKh6
	6ctTJdl0ZoS4wmHYDLR+/08RvCfJxzW/kPXa0K7cW41jngrpCOWaIY6LQkDQwyJX
	pc/oqb9Sfa1/hL935YqWfv8iL7ENTA5UNB6XUVuTVOZ4NG1qYy0RYXXAn+i6+JaE
	dAtNI49uAU+gger0nd4XxtGguv6Heck9tdclAGjAIlIbqcV9UwW5+P+biYRG2YaU
	pDVTCiB7IXKU61B9PByE9Cd8wuz4R9xucjIUAAdWtJMAiw1U+M7kvVF7/je2dwm/
	b3H4Hg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq081t4mf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 05:47:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89f9fdbabe1so5162915b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 21:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793684835; x=1794289635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAUzZfGxBOdGVKQARymZnvw9tUEu8Gk9GBeF1+1UKlY=;
        b=g56Tr5nYTBRguwedEcBQiCAihdNQBz0x3U8KSv4CKoD5x1qbdtDlrpaDDpbgYZ1Bd2
         U9GWKN88ADi57o/kysshNxRjfhR7SMLlHQbngl6W2IoEhjDDPWGxfSGqd18v3gY1bMdF
         Ro7XaCyaL5VfZcBjrnztEZhilDGytP5PC5QGT7oMSctJm5TZ0u0VK0cXsBaev2ppMVir
         bmW/hj4+dzczrAGOcp3EI8iRoScRqtp0sET9Nofp+ZLAf0oO6qRafd93lXvd+NL8nvLr
         1D59Fqh3ddTIPT1yQEVU9QrH3ByI4F5tq7F/Am3kjAa1jDQjqtIupr11x4T1EMqd+5D0
         396A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793684835; x=1794289635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CAUzZfGxBOdGVKQARymZnvw9tUEu8Gk9GBeF1+1UKlY=;
        b=wRVDlhKB8jo924IV2u6ws+WL6nQlB9Hgf30hYZHorqGeN55Znz55tgteVhReBq9cVj
         1LGRnPNs8A1MQX6iw8CZnb4L0w0IYKefQYdQwB018H8iMQKkFwG1LLe8F+yIsHW7XbmH
         CbICqlUABFkeHrGXmXIIv/ZkVtAURlzq0otty1ETPIGDAq6ENBXq4wCJwGWDjNOhCznW
         NZ2SEtb3rmVckwTpri4Tx6Zn2C6r0UQIVR1VrD1vMhjpGvO262dOZhmtk5HVkC1Mn5l2
         7pbdeqeeOXGzumIWokZCGGM6/4LAI4mcxNOQWPfdmD0oCP+uiI2t3y2cd7xte4ca9v31
         WU6w==
X-Forwarded-Encrypted: i=1; AKwUvBxHIRDIoz1xWYqL61/g7jukGEFzNvxqIGEdPAVoic2kjXZI8kM5P5Z1VFMAwTdSQGi3j7dtwaY7st8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qC5Rmm8UZnVVfe/VVvEs9bolbGKj4jfQHUQfmHI0W+g20W3Be
	DqAWQwhgRKD8iANmX4nEZgT6DgJAWgAhLF8OMj9+BikSEBtqsnVoN6Mr3Ynra487+bFEdS13eCQ
	4lmmYIBtT811FpqpiCUORcEsNf2UVoFASHhSPupuy1LgNypOfVlMwGIoNAtRhlC4=
X-Gm-Gg: AYBFou0Btuc3SF58aE4tt1eeKWNnR2/OpT8yiAXswW461uoZUyO9VbdtfiTsB8DMawe
	n+fPTiWIYJ0oDHYS2ibUF+CCODbkY+Yiks9+brP+/jLMMFXxim9cHOXRVfxpK6m7kpIkO7XIpsw
	SzUGrpXNZbqy+NFeyXDm9fnPl2pvHSfvZyOd0UkqDCxEEASAiSZXp8LXKUBi8vcQyELy0qO/BCn
	Pahh23Xc+JqC7bQi+lhmRLXA4z3Wc0er0vPxHTXQxn0jPF6JgXauqy0zkxR0fnX1zaVxsez9DaY
	2yi0MDo6IV7sG+Bfg/kP4UO3N8CztGWhM9TXkbdnnwYOF6En2wwaetArki+l2woE6+R2D/TQteR
	T5n1T6vfqiLfLssx1P0imGWqGbkRyH02rE7Lhe9QlSfv9I+Pt716oE+wZ/oa7HoTsw1ctFXa6Mg
	bDA9Ba
X-Received: by 2002:a05:6a00:1f0b:b0:899:67fe:3c52 with SMTP id d2e1a72fcca58-8a9be1a4461mr10570077b3a.15.1793684835531;
        Mon, 02 Nov 2026 21:47:15 -0800 (PST)
X-Received: by 2002:a05:6a00:1f0b:b0:899:67fe:3c52 with SMTP id d2e1a72fcca58-8a9be1a4461mr10570053b3a.15.1793684835043;
        Mon, 02 Nov 2026 21:47:15 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7801a53sm2896689b3a.2.2026.11.02.21.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 21:47:14 -0800 (PST)
Message-ID: <e44d3e85-8dbf-4ca2-9c88-817f729fcdb8@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 11:17:03 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] i2c: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com, Codrin Ciubotariu
 <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Dong Aisheng <aisheng.dong@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Oleksij Rempel
 <o.rempel@pengutronix.de>,
        Viken Dadhaniya
 <viken.dadhaniya@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:MICROCHIP I2C DRIVER" <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FREESCALE IMX LPI2C DRIVER" <imx@lists.linux.dev>,
        "open list:QUALCOMM I2C QCOM GENI DRIVER" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR I2C DRIVERS" <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Cc: vkoul@kernel.org
References: <20261102170004.3852546-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261102170004.3852546-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMiBTYWx0ZWRfX/xLgc1YSRIUa
 cKt8chOprknmaQ765eOzYyt+fzXsRko8Bdhz9yJGE4+2pN6PlfHI+2l4KvuOGBsOnV/CXICDBhy
 5DDq25u7OZk01vmkGJm6XX1EvYim1vw=
X-Proofpoint-ORIG-GUID: WEZHfi8nq3ogD-EqhxoxCD9-VAmM25rW
X-Authority-Analysis: v=2.4 cv=F73C5ahN c=1 sm=1 tr=0 ts=6ae97564 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=ibj56h0FkVxt_nO8038A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: WEZHfi8nq3ogD-EqhxoxCD9-VAmM25rW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMiBTYWx0ZWRfX35SWk+tMH4ad
 DwcVjQ/YHjk9drFzjHtTgsHCrkVQ2ZoIW6TO2Vs8ldkFG92yr3jfMFC71ksv8G8T8c2KbYjc0DM
 exILCt4gvxwi82SHox/azKYhH1UNKZYq218n5oMDs7QIshmiPVJ/5kkWIIFXwoNOfro/S2jrSOW
 1y8e+ZWSrbrm7gWBZvcYJFVUfzb24MHwQRMC9kWt0UeCNvZmOsFwCc/WZnPoyB5tXkKrkYvvtQr
 Hwn+2cECxtX0ttYoQTlq4ECIY5fVEBEMrt6CW6lGCpYX7yeMAfbBizdLBAZc9PAoL/x2OdComL2
 20EnL2dHZeqIDIHIEaGBSnbn7TVsxDwg4glblwVQAN7c98pq9/33bsZN8DC/yd2J1nRd/dI6Phw
 uJBMDuboZrVqkANwCti07A1Kj2/5kaylic6fbXxRCSLi8P/WfELoCZnMFHj60Snlf/IBb5QkNT5
 VEG9JUBYNIO06Auxl1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030022



On 11/2/2026 10:30 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across various I2C bus drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
