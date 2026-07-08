Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EC3A1D14
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503691; cv=none; b=o6FowhdQQdYyIKA02P2jpvM6UfwOJfIahaG9R8TZVJ7bY+4JdQDPHTp+87fg4HxcjXHWqkWQoaC4FyMzYz2mAfLEQqJ8SN74xUgzXFTzKuNHJVs2WKdtpkq/5YjrJ4gt6wDJ9p55oOqby+3T5hBN25xVlKpqiMxfyx2/Bz06tno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503691; c=relaxed/simple;
	bh=QY3rsN4d5QA6uLI/wjMv8RVk5VEtFqG0/OiDi2KmA0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is+i35KHdzcAkncNTVxq/c4Cz8v/RshR09pjl2YxuS2OlzFgYAobX3ID25AobJKjwtW4Uj4XZd0jqbEWb/IptqK+tIg9DoBpc6+ItThPWKxWYar+NHZQnAj0mIz4WvPV8+zn/1l3QrYorP4oUQ/4VVw59oRwqkVPQWQAdTDKaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DqT6379N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lmu9sBr1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DqT6379N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lmu9sBr1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66888olr2204069
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 09:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amI6Zf2vaGIXrSRgG4jaNhBHWzw2JNS4gylMww7THp8=; b=DqT6379No2LYiIk3
	ihyiFrJ71QNRp5qsmnoaFPV3DvS7ESEVyE6q9Czu87UOpVhMgfbxd/Whfn4vRuwS
	oSUKH2YfkfJUOP6iLcKpySo+JAGX6OkiCFli6vT7lO9lovY0h0vXj2X+iderdyMa
	unsUkpMHq5fWkJtW5tT3MTQOatNwNqduKSg/OMZ2jGiI6EVyOuDVM5pmgyBHcqJ6
	2dWntJyjVb6+u9PlyyuqC0HYOZItX13HzX9c5sU0wJWrBnP34yukK+RstAPhpRYf
	JtD4j/4uHSmg72nbukrT9YqNKJxDXoTKr6XvADFKhB+uA0ThxDC08/EtcMS3rsDp
	dt9K/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv0p3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 09:41:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so9751985ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783503668; x=1784108468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amI6Zf2vaGIXrSRgG4jaNhBHWzw2JNS4gylMww7THp8=;
        b=Lmu9sBr15isGGeDmPBKgU+eSYjHeXPNOtU82iSlGf+c3qwzbfwb9I2nhKfTvPtoWoI
         Rd6jzQ25+rkUiRchsWd1IdGizywXH2tkhj8Sj8in9NYgaEx8qdbSU7QZ/H+DQIJSbmSn
         P9iUwlNJ1ZXmK4KnAN5RczNhVcwo7mS+16+KTQAE5AyjBKBnC3YvpEEGs0i8+Ak0qIun
         kYh0hp8osGpOeEF2oUhjymxC1efCO1Ue7QN2cTL8bbKB91L/NitmRLpmi1I2QjUJ/oiI
         961pJrgVzMYPD+Z10Z2EU/LoKmGEInMBAEI9xTG6KtJyyKUBeWtVoDCiRQRtLGROICDH
         bdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783503668; x=1784108468;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amI6Zf2vaGIXrSRgG4jaNhBHWzw2JNS4gylMww7THp8=;
        b=LzqnynJPOVo9N9tbICs3npHQCNEB0K04Umj4LM9FJAc9MzBJ1UeMZ8c7T+kn5lTWKT
         oj8hMXYO92CrDk87Z+VOu2GCP7jEn9ZMoVdXoVI+xz3nDuacXpQFMTRo2UTvG6wrxHsh
         q4NBB8S1Y3z9UrvaNh0e/7ZnDiT5TCk+tcRhJ5lwb6kIU3FpQ+bHUUMQS9Mer5qc41Mz
         MLxMWbE5QxVDd8Qt9pTqo6WiLHeIUbmw40+rvIfikSHytVSC9AMnIbxIE3O97KHRarDC
         VtnNBjzw9VJP/LXzjjG6nYSC2AVGCWaFeFJLv9OafIs3oln/o/1fEXO1PNl1/jsmxjj4
         lUgg==
X-Forwarded-Encrypted: i=1; AHgh+RpPkgrG7onBX+eLUvjXKPeWW8i40pbHly1wnHPmKDV/pVSg/YeumUQEEopgFfkv+sOKT0eiVR9wP48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUF3bWACgoQwWjrfJrJdCpniz6dQXHC5FclvmO6hLMmRE1R0hz
	9pG1xs37KcmOPP/nm2ffIbyk41V6JMeOZMy7f/JXZSWC6p/Q+4llNRoQFap0FxW1q9R8/8oNYeJ
	QSC1BtYmdDvj44FsfegJY4g8p0p+IbbUduxJRsSgfVGjWIYXTPFGl+IQmgvpdA9w=
X-Gm-Gg: AfdE7ck2QraWd2Y4ogush3kFae0ZVN+FWRLc/AhDW5jh5fejOMvcONE7XJuUpSOoS2V
	ZcCFVXmpuEVDuKzih38pPebw+Xl1ycQA9sZ28eI0pr5A18TqHVOPCln9u/RQc7+XZOvDQLTGlbc
	Rf4oETaBznnNgnctiYftUrJVSXd1+6uu0Vy/IKFk8ctVAPViut4tV8hxgG33RNEQQeFR1OTx79r
	vNByU8mAdJ40alAsu1IlOX/3PUp4A7tOl0tO9u4y44srr/FdExgUDGtp4uYm428yQq+PZXeCFuV
	uC+87KqjaPfyaXfWkLdIF52/3NRN2pm4p7r9+PM21WELZiBXP4/H9KR4tzRlclXFCQKxuhtvbau
	185RR1xsPBfVgxb9NHtFQ0uGGKmOcJMkGotN5tVyFL1E3
X-Received: by 2002:a17:903:41d1:b0:2ca:f425:4d44 with SMTP id d9443c01a7336-2ccea36913fmr17581065ad.4.1783503667716;
        Wed, 08 Jul 2026 02:41:07 -0700 (PDT)
X-Received: by 2002:a17:903:41d1:b0:2ca:f425:4d44 with SMTP id d9443c01a7336-2ccea36913fmr17580715ad.4.1783503667149;
        Wed, 08 Jul 2026 02:41:07 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccdf808379sm12595115ad.48.2026.07.08.02.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 02:41:06 -0700 (PDT)
Message-ID: <76f79f3c-16ed-4935-bc0a-dcb26d2a009a@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:11:02 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-geni: Avoid unnecessary transfer cancel on
 address NACK
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
 <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-3-dd8f841f36a2@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-3-dd8f841f36a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4e1b34 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KPAMhbskJAhAJ0Ap_bQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5MyBTYWx0ZWRfX75flzlswwTDG
 fEYsa61JV4I6TrEhmpsRgKzuNnxJfq/b1pNjohfP9rq7W/1CtUesKSvqh9aq4Z2G57RVF+aLjPB
 Ir9bQyXtUB2I9rh7U9RCqBaP9ok1aBY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5MyBTYWx0ZWRfXwcpx1ayhwU/o
 DC+X5sfXHIwtmK1pIIDg7VgZhyZhghMp5aL2EqirF2bY0uZW940ivX1bMO3QXO3fEbnNcMvnhij
 y40PxB+ptElOyjn3gFdxbeHGNgApSMOlkdcM3vWEWSmz5Jf/0XSCfObDx1PEPG4fQR76MN3LYuE
 vRWpGtURhkpAwNYXW/JJuVrQEkp3MVh5pyMQuaYpvr+plMc5IUApy8bTCZz+U2n2yzu9UTsoJfx
 tvGMlqWY/8HbEo/nOt7It+Bbw91Tr+Eus0pG6SFAIcYIc2D+QdXm43mES8g6Wpan6aEqj+7IZtk
 EFTmmFe+2VqB6Qv9SoaBxk/Ev9EZf3S0UDqzxbI00xaM0oFgWJzTr/bZRH1wfNLFlajxALL9qGR
 xHgWmub6ZZf2rycpgxvsi99BHjt6P1CZ6eJWYFvzkPdSxRU5gcakdLlUyR8ybo4WTTS73wEz7+3
 /OgRqKgfpt6MumwVvKg==
X-Proofpoint-ORIG-GUID: DanuSxswsl-gkamiR61lhfJlMBNXMZTs
X-Proofpoint-GUID: DanuSxswsl-gkamiR61lhfJlMBNXMZTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080093



On 7/8/2026 11:45 AM, Praveen Talari wrote:
> When a target does not acknowledge its address phase, the GENI hardware
> raises a NACK interrupt. In this case, SE_GENI_M_GP_LENGTH remains zero,
> indicating that no data phase has started and the transfer was aborted at
> the address stage.
> 
> The driver currently treats all transfer errors similarly and always
> issues geni_i2c_cancel_xfer() followed by TX/RX FSM resets for DMA
> transfers. For address NACKs, the transfer has already terminated in
> hardware and issuing an additional cancel/reset sequence is unnecessary.
> 
> Track address NACKs separately by checking the transfer progress length
> when a NACK interrupt is reported. Skip the transfer cancel operation and
> DMA FSM reset paths when the NACK occurred during the address phase.
> 
> This avoids redundant cancel/reset operations for a normal address NACK
> condition while preserving the existing error recovery flow for all other
> transfer failures.
> 
When a target does not acknowledge its address phase
The driver currently treats all transfer errors similarly
Track address NACKs separately
avoids redundant cancel/reset operations for a normal address NACK

Looks repeated , in general you are handling address NACK and avoiding 
cancel/reset operation. Differentiate this NACK response against real 
errors.
Try to simplify and shorten it.

> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 9490aee4928c..0448654f2678 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -130,6 +130,7 @@ struct geni_i2c_dev {
>   	struct dma_chan *rx_c;
>   	bool no_dma;
>   	bool gpi_mode;
> +	bool addr_nack;
>   	bool is_tx_multi_desc_xfer;
>   	u32 num_msgs;
>   	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
> @@ -293,8 +294,12 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
>   	if (!cur ||
>   	    m_stat & (M_CMD_FAILURE_EN | M_CMD_ABORT_EN) ||
>   	    dm_rx_st & (DM_I2C_CB_ERR)) {
> -		if (m_stat & M_GP_IRQ_1_EN)
> +		if (m_stat & M_GP_IRQ_1_EN) {
>   			geni_i2c_err(gi2c, NACK);
So we are handling NACK first and then deciding if its ADDR NACK ?
You can pass ADDR or DATA nack to this function right ? and print the 
error log accordingly inside.

> +			val = readl_relaxed(base + SE_GENI_M_GP_LENGTH);
> +			if (!val)
> +				gi2c->addr_nack = true;
> +		}
>   		if (m_stat & M_GP_IRQ_3_EN)
>   			geni_i2c_err(gi2c, BUS_PROTO);
>   		if (m_stat & M_GP_IRQ_4_EN)
> @@ -443,7 +448,7 @@ static void geni_i2c_rx_msg_cleanup(struct geni_i2c_dev *gi2c,
[...]

