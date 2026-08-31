Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5E3D092F
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166331; cv=none; b=ikXfG4TiXWT4ew1WSjoEnPp8tuYXN+/SpBacN/lUB1MWTDmzQ2BxhKQEFrplbkbESdmOfwkKbJ4/daSAZPuP4vtgE66uTCFeoUSo4HYLndZgziV5o+V7rub6/wOU7YSiaLCVPhXtMfw8v2YSxGhhg821X9ezm+rBdPpqsw0k/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166331; c=relaxed/simple;
	bh=+2hOgK8tLcdWYDNwQNgvsfIaBdx8Bs2buQwhXdccyfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYwS1EoRzW2mzKxKp0y3H8OmH+bE6FoTpNQvULo+YNg8pUUGP/yI/mIxSeghuC1rOW/LDuwo5DV1acQAZ6sOs8v22qrpjmdzF/WWigxZ1Iyqy7W0Gve2IUAFn9w9kGnFNV7ooOcOvOoM/df1zxhKjJcoy6LFtOqntgN9Lz98NGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cb9qiPO1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZKr0lqgg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cb9qiPO1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKr0lqgg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xaro2924435
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 08:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	palpmFZZO8X/xAXI6fll/8vpW1RA6tZdCLOM/AIPfzE=; b=Cb9qiPO1ic/fp51i
	A9Y2ZhtgOkhSln+gHhILBIxKRU9q+EFTQfIhJ4xKf3wSbJzN0zhWjc1wjKvCjW/J
	20tRmMpCyW+/6NVKa9ju+y4z34Z1xhpfyAlboEeTtuW95Rucj6k1F4i1tL719VRR
	H7wYpvc/yeIs2lWB1lSE8pg+CBO0IWoWkT6ey/hVX/H+KRECt+7Fqi+odS+2dl0A
	qFhZoqADFb0HvLuYkRm1kwuOOxblBsRmGTx5jITenBO5AvipKEk6e0kwpMD4rdQU
	pwUrlCvklDqEPsTAtZqr77iOoDzCBPICWFBDq/2a/PhbXYlmLsDkqzi2JheDwFRQ
	RC/M7Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w9u5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 08:52:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so4450132a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788166326; x=1788771126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=palpmFZZO8X/xAXI6fll/8vpW1RA6tZdCLOM/AIPfzE=;
        b=ZKr0lqggpERgyt2PwFFpwRR8N/Y327I9zHYwv6x4DsUqaHWXIVy7Mys44Brv3aA572
         ntoZQkBy14LK2sfd2PRsq+fVZpbd0Md5eIACexD6+JeeKSqPl9Wjj93X72cGHHq267CJ
         4WiOIP13ckxyKa5a/Ph7Rz1EV8dyMeNwi6tZfpkZlNK8g6hxgtCTyRmDhx2FfL16vR+8
         Bw0Hk7fu4+ZDJZclWLS9NqsLnD7fw8UqvPFwVABNIf68nsEroLoL7/mTDKftnbRfRkqA
         QdoowKGdsDlSxD5XGSD6IAlG2t4nK+C0TG11xtul8vsyRRbvfv+bAkxCx3R5WwCOHITd
         XUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166326; x=1788771126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=palpmFZZO8X/xAXI6fll/8vpW1RA6tZdCLOM/AIPfzE=;
        b=SXOFN9WVZ1kkriyBSyKbTxg0DRRJf9WnqbcS/dYuwfUV7CWxjP3qd96aV0zpsg3F3e
         yzS9W5KwRnyz0x29I9VmdS3/Dg59wtdkd0OZm641b/Q5F4qQ6YyqqMnC3lEn9DR9BeRp
         mS8dhzb7mYIsOkWDOf//tnvphQBAGv9/AIDD3axuGZSBz2eqajz896JuwIQt4qrcvi7S
         3D0856kGzFq/pwM98AMv3RT4iBerd0RM85BnzcNMeCO3hsKo81VUWRlCd/RNtjtZolZS
         f8wfdNxqa9pWMNGapl5tAmcq7mv+eJjbbRIJeVyDFC17FoEpStIbIKTrSm8vlIc0FYh3
         4j/w==
X-Gm-Message-State: AFuF++nHe+1nVyxocCZoOVO0o/On1/HUdJmwf9ZrbcRhyia490hztP1d
	EVk2gJtkZTvT3apOCteLUYt4I1cO0RFraToCLoBIKtbH79BoFnPOEjN8g+g8LrswjcWHuV+Htp4
	MB7nZxqvDu9tJdEWR8gzttnw6OWfAE3jhPyTDyuhkcdc7ITcP28otXl/qYOAfYOM=
X-Gm-Gg: AYBFou05HZoyKfLXABv/jmHe3rOePLy433+tgmS5Vj1ywBQMMOgCm1LuYKaIg5BnM0K
	voyK0+kaCwk8CXyrH/4REq3SbnW2hFFx398c4QqB9z0nbo3qjwwC/YmUYwwMcSVjQ+DReZ89dVZ
	MrbIE4FPBZNpo8g8wqqmd3AKtTxoosCyVNz/HL1eEgxR//sKXoqPudEGWrUDJAnNK3Cm1UYkIau
	qWuwuaJh2neDMlOziApDmhnSNAbA97DplFbHtP7CDnsqZsquN9Y8enlIN25wtu3qq4So8M3pr2P
	3STlRo3TOTTQ8CYxGxfo3rX7DkAsAL9QKwqiHD9PtKDUeF48il8iw7iYhCTwWccM08seQFuUsuN
	3fqgOh4rofI4sziO2JY4hrSvSXY7RIKQCRA==
X-Received: by 2002:a17:90b:4c45:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-398ceed6d9dmr12393516a91.25.1788166326220;
        Mon, 31 Aug 2026 01:52:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4c45:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-398ceed6d9dmr12393440a91.25.1788166325630;
        Mon, 31 Aug 2026 01:52:05 -0700 (PDT)
Received: from [10.217.218.20] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm46282736c88.14.2026.08.31.01.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 01:52:05 -0700 (PDT)
Message-ID: <8ec899c7-61a9-45cc-b332-a98d2c0ac344@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 14:21:56 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-geni: release DMA channels on probe error
To: Shengzhuo Wei <me@cherr.cc>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Wolfram Sang <wsa@kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Yao Yuan <yao.yuan@freescale.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
 <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9540b7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FqpsaMCCsM1CaQCKzz8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3NSBTYWx0ZWRfXydE5wwFtNYOq
 YWeKKsLV/Ey0hOWPAqipD7hCtRZ9SC/OQJrXNTCgDDT12whsAlrpjb01Kp2YsweBRoxUu5pFT/+
 A1RvruqaN05ILlCFR8fWReZExguJtnk=
X-Proofpoint-ORIG-GUID: BoSfMO9D90fEZ5OFHb9MxvjsHWCOYP0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3NSBTYWx0ZWRfX43gjVrhrILFw
 mU5tg9uYLOqJ04ZWM4Oh/nfq5Sq2YzV1MCZsDPjwj4zX7LXZQshyGVAcT55350/0XcLima3K6OG
 diOXaJJHwxmYn+vPjjlKbyKad3zLmH2rQlallJO1bvAp+ozi1ISEG/VZy2bkKJOYEl7menTWBUu
 /gC9suJ/Vzi51lXxfckQIJ4UNtkog+oo+pC5Zjw8yXciH+cO0afxUasCjXdgudSYjVSDAn7m3dX
 QbXMPMmTZrXUzxpg6BrgbH7ZwhZcULa/86UEFun5mSbWEZDjvQbIExctoNhX6UO2cDnL3RM0qh9
 FuIPxP0l4ZKLs6S2fuoY3Zz4O8U9+bhp3wpEMVCS4Nqv3DWQmWxWKTXkN4HXDLWVjzGFpXDWDUK
 VDakiei26MMX/T/wVgPlMfe2jd9qSVoXYFyRUJarNsp6xwzy6qa7PgSRD5bZSjLclJSxjF4c37T
 seBQ+AFRMblL3zFEp3A==
X-Proofpoint-GUID: BoSfMO9D90fEZ5OFHb9MxvjsHWCOYP0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310075



On 8/27/2026 9:13 PM, Shengzhuo Wei wrote:
> geni_i2c_init() grabs exclusive GPI tx/rx DMA channels when the serial
> engine runs in GPI mode. If i2c_add_adapter() subsequently fails, probe
> returns without releasing the channels, because the remove callback is
> not invoked after a failed probe.
> 
> The adapter-registration failure path used to release the channels via
> its err_dma label; that release was dropped when the probe tail was
> restructured into geni_i2c_init().
> 
> Release the channels on the adapter-registration failure path, mirroring
> geni_i2c_remove().
> 
> Fixes: d8d3bb127ad1 ("i2c: qcom-geni: Isolate serial engine setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
