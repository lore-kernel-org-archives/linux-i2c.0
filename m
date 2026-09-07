Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF336D9E0
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758075; cv=none; b=HSnXp39bxRaz3aHlhYwsiMc+/ay/Bf5c8F0fHpnW9N4SpApxytl3txa2bdwYX092nHXfnjPzRbOjN74NN6docZQU61VRgvupwxliB9T+MWSSUvmYL4yA9VxonIAljO2t4wLnijUw1KpUzMligh14zaq47SXn+WYMsEHXm5pYzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758075; c=relaxed/simple;
	bh=3G/cmt5IDXWAN+ERb/IvB03Z9XYoO1EQh16xc/CmS1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYd+ZBISJ5ch0eydgevzpMYWCYcwZ6fdn4VB1ffwT2Tsqg+ftpuO9AqQB8mfhKv33bsjbEL44a+nXo0FL5Gw44bB18l9j1Ytq9rmxYqb2BM1k5F4DTjeDzJ+fBAFFxFH0bOWd6CPh3TvTCef4FTR99yfOKG7FziYOj+m/HjmU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mwy+yUl2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PasHq5j/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mwy+yUl2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PasHq5j/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873l1kN2820245
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 05:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LLnYiOITNXR4UwC72EqlUUdHBM2uIZGN4ddMUc2bFDY=; b=Mwy+yUl2EODRvCLr
	KbS8kHmLlasN+XK0R84coOfT5ytnlnppsv0Pe6hqUh97VzyfZWvytsqKwwsnGrVn
	DATEOfVeAMV7/4+zMiyKyCdr+HkLVFOSOuoEleRLBADAUtK+cAOV1KCmgVKmBJis
	NGK1z63mvUT+egzy3cBCYG42MUAc15WODybrOk2AzavdM15PlUgNc+mmDNr5NfeC
	+4KQlmRMTigI+Y/D+mLHaYprroVEyclajmY5t9H75cudRCai/9igQXvy6wysM9gR
	j1kFURbrC4dTyhCvdwBJcRoeR/dzrg0tHHP2cVgo3/pAGBfFBOf/xSps2jSFi39P
	RcEUzA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggadhn4eu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 05:14:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso4964378a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 06 Sep 2026 22:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788758072; x=1789362872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLnYiOITNXR4UwC72EqlUUdHBM2uIZGN4ddMUc2bFDY=;
        b=PasHq5j/P0eTBI+zx/ddEFkicx8VQAR/wKt42RCo3CFJRo06LCVApwMuRrNvEDaLlS
         MYbBAt2XZ+eKtMF+oNTwURhXTlvltW+fC2BP58PnuRd02WptFHurujlejkXdHoitwyqY
         Vs2D+lvmTkjwxFA7hBg5zHhIGCvEdAZWGP9sPpA2e1DC7Q/WSDuyzybjpFQ/8ryMgKS7
         oQOx7N0sFqSjMqu3/a3el/6w1haekmVispUYwutjUUHRQYY4o2LWKuDnETw4FZSXWmw6
         beDGG846mV0FHLnHjMU9e2Xcxocwe1vRc9avZHmTKgMT6o5YpgKq6r+tL7s26xqYSX79
         lAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788758072; x=1789362872;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLnYiOITNXR4UwC72EqlUUdHBM2uIZGN4ddMUc2bFDY=;
        b=LOemglaSynPgq1aWsS2okUiFlzat/xRn9eiQzlHac9rddl7soWGEefiXuh9nFiY7pi
         QaywBmR/vms+c+03bC813xT9bIy4spIG64NK07MLrE59K8uEelkIJbu8rc8nBLyFiJcA
         sQuNsJ/EZQs5JsM6z3FCyfeBdnLMxD+bQxWuNwTyXFIu7mtgQp05O7kXMwvrUQzfS005
         MM+hyG/C3C4LCo7vhUA9pbzIZ86/Y0vcToCOK0IhDvO17jBoivCNV89CceHErFY1O1Bx
         8D4TKaSC8OwGOKKdS0S9i9Y3kf/8gNfQOXQVt0udz2Nyu7veFm//nBxyQeZYXyuF4y/B
         Wydg==
X-Forwarded-Encrypted: i=1; AKwUvBwuWigr+zUoD2nCZhSC5+eKIfMk1YrPjNGpIyn8KcuIoXaEs9oE58Y+WoOPMVklPrHNp0TEJ4LBvM0=@vger.kernel.org
X-Gm-Message-State: AFuF++kvHSIRlu+ygh+VCLzpYWDEsV2mQ0FHTpWXAi4d5bd3HBjU3wDL
	jGUj+8Cb0sFj+Z4gF01qd3xpV937g2h+BaZz9GOd4JTXThy7qNBk5LmT6P0eUBDHgbnWN6l8P0M
	6YPvVW3P3Mb9Z55MZv+f/ttqvmUFCPAsTb1c/PwqmZXFsI/gQ0302XecEy47Bj5g=
X-Gm-Gg: AYBFou1bK6EFB0MVZJ5nZTZeT27TzZuQIxLE2koFSn7CAppD+X90PCO9V1KkiQ7wmQZ
	hF3dg5f/zKHxPoWMpz+yt43rDTxMq4Dj65tyRk404LZ5WZyVHJYLmN3uSmf35qFknmk7qq/mlr+
	pEWFBQm1aQ5HejoQGIM2MhWuVt5kMnz3ch004doPgJNyHRLMcUDZVBViMyR5XKqSYXTn9WtsTr4
	MTZIreCLVtGf0dYAGkaQ6KBK5pBa2n+99S6vadEi9rkHR8DK9Om2m4XPHvfd8bunYQcnr+2mIdt
	p7IWbAmhI9TTU3GTVv8i64WmPiU9Cz/VxSnKXNhqPj0zJo95HELLu2LEcSTwai7GCmT361s6itI
	bM29bk9d9ovJ8WSGUNU3v/QWipUCOsZcACA==
X-Received: by 2002:a05:6a21:114c:b0:3d1:e510:9052 with SMTP id adf61e73a8af0-3da39ee2689mr32370825637.7.1788758072096;
        Sun, 06 Sep 2026 22:14:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:114c:b0:3d1:e510:9052 with SMTP id adf61e73a8af0-3da39ee2689mr32370785637.7.1788758071745;
        Sun, 06 Sep 2026 22:14:31 -0700 (PDT)
Received: from [10.217.219.15] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm27645812eec.1.2026.09.06.22.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 22:14:31 -0700 (PDT)
Message-ID: <fa7e7439-6f17-4dad-9c9b-6793ac7cfdf3@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 10:44:25 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dmaengine: qcom: gpi: Add I2C bus recovery opcode
 support
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
 <20260826-i2c_bus_recovery-v1-1-203f0ec76f84@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260826-i2c_bus_recovery-v1-1-203f0ec76f84@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dNMWp_nl2T6OFyxRirP5Q_fr8nMCCY4Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA1MyBTYWx0ZWRfXxOxEgVi9/vtV
 zQiCE2G7LWZbxQ1BJ/QL8ueRx0t6mkoWtdaef6NBQPwWjRyk2+Z9p5tCVfsNerAr/qtEmkkJL2F
 3zLG6FnsQ5V3yRkakpPpQn0NOjnaoglg+Dh8OMA/hdmohZ40T03hyx82J5S3HJbdIwF1MTdje9s
 PbojSKipU9KI0qSOgGGxsMKGQ2SvK6QlSK/3odP2EnLrGxVd37LvkKcxdKUGbWXa6xM2swDujxo
 KFR0lh1v+6f+50Oxt5+Gi3tjCh7r6aLYcV0nm0H/mJlwzc8yyTALekjZoInvCXwXFwBRyIxk5Qn
 qvW/6QjlHEyaYDvdCu1iIzJZyeVJFLipBndbchsSdB6Yy0B8wrAB89Xixcj3ziR/gu2Ojukz94Y
 xefDPjzGzJ2cNOErQNG3ZMX2aoQF0eJfaG0T3H4xYHOROt6icqXXdFCKhKbL9DKh3Etapn+kFoM
 GHpws2Qy8nXNzI18CrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA1MyBTYWx0ZWRfX4zfM22zuJ012
 BBnR+BFWzfoyaxBzyAKqXsZsMnSUnhANzrvw0zAivukJs20tHdXo/F8lfgF1Htq+4CTYyBGjrbX
 F1a/6h/RuXmBs9BvKgeeQRnvCTFsots=
X-Authority-Analysis: v=2.4 cv=OceoyBTY c=1 sm=1 tr=0 ts=6a9e4839 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fhPPmUa07wtAw6AntU8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: dNMWp_nl2T6OFyxRirP5Q_fr8nMCCY4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070053



On 8/26/2026 3:21 PM, Aniket Randive wrote:
> The I2C_BUS_CLEAR and I2C_STOP_ON_BUS GENI sequencer opcodes release a
> stuck I2C bus, but the GPI DMA driver has no way to emit these
> zero-payload control commands, so an I2C controller using GPI DMA
> cannot recover the bus.
> 
> Add I2C_BUS_CLEAR and I2C_STOP_ON_BUS to enum i2c_op so I2C drivers can
> request them through gpi_i2c_config.op. Handle them in
> gpi_create_i2c_tre() by emitting a CONFIG TRE (when set_config is set)
> followed by a GO TRE with IEOT set and no DMA TRE, and reserve the
> matching number of ring entries in gpi_prep_slave_sg().
> 

start with problem statement which is being fixed by the respective patch.

Rest of the message can be simplified as below - more you can add.

Allow GPI DMA clients to issue the GENI I2C_BUS_CLEAR and
I2C_STOP_ON_BUS commands used for I2C bus recovery.

Add the new opcodes to the GPI I2C interface and generate the
corresponding CONFIG/GO TRE sequence without data DMA transfers.
Adjust TRE reservation logic to account for these commands.

> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/dma/qcom/gpi.c           | 30 ++++++++++++++++++++++++++++++
>   include/linux/dma/qcom-gpi-dma.h |  2 ++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c

[...]

> @@ -1825,6 +1843,18 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>   		nr_tre = 2;
>   	if (direction == DMA_DEV_TO_MEM) /* rx */
>   		nr_tre = 1;
> +	/*
> +	 * Recovery opcodes do not require DMA data TREs, only CONFIG
> +	 * (for set_config) and GO TREs. Since gpi_prep_slave_sg() is
> +	 * shared with SPI, verify the channel is I2C before accessing
Not only SPI, its for all GENI protocols. Can say common function for 
all protocols.

May be once such conditions are rising, we need to think of better way 
in design to handle such cases.
> +	 * the configuration data.
> +	 */
> +	if (gchan->protocol == QCOM_GPI_I2C) {
> +		struct gpi_i2c_config *i2c = gchan->config;
> +
> +		if (i2c->op == I2C_BUS_CLEAR || i2c->op == I2C_STOP_ON_BUS)
> +			nr_tre = set_config ? 2 : 1;
> +	}
>   

[...]

