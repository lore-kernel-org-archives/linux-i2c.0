Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F33CA4A8
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557406; cv=none; b=EXjs07BOiOdpOSR5wK8CgNPGS4zRb/SgEE3yq/Un+VW+TP+jxx3wzCS6Fx6VXoOnqMirvxXQ3+gkAhNWHeMkB4PLgxNFIi7qQk2iOhnoGV8UehOJNK7cgzFXlKEoIfHaG9RODSDMMwbYVLRVP5stxsc4Qfh8dVFYU5nMHOPvn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557406; c=relaxed/simple;
	bh=Gp4TH8J2hlZSx7L5r/Nnct/d2wVRd7ZAb9se+pKxzz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiYg8j3QlUwEY5tbBL0Kjttcucq6wEZQwUbGpxOCACCa1tMcjm9qoKUIPOPwydm79lzSM5GZVLWlZz2hOm1qMR98xUeTvSoYUch+YFJi7LXVLRmLwyl1LOTvlfMYIcb7tQwPqj/FxSiVSe+EYIEsEwroirtPF5iSPXGXdaCgcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YnCOBEf4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hEzwIba8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YnCOBEf4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hEzwIba8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CGpxPa187078
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H7aPqzXzK+bffdypT6w5RZHf4yVPPVyPFUZRNwHMo/0=; b=YnCOBEf4xA0Xt3w0
	OiorpC7j/CjhdLOuryWiCjYc1KAtk3bOIOYW2zLjHPJIKK41LLThrTlgM/A7BdiR
	B9K1jcUq/bGeX/auKpbVM/RfZVzmBsXYEMYmu1jblrTz+g6Yhn8P9lGEg6cCwHMf
	4ezn89XqFRkAUyjFQGhfP/Vt1zqeQe6KY0rjYrqjmAz81+xoXH2vK/XpWlasLxKE
	i5d7FxfmvFjWZegc42e7sq1SxVw4Swsz5HHVORl93ophCWOZjvuOeipTeXRpxWyp
	SRVEOB9wHIrLfApw5onUzfWAeq7sdxUcTZrn2HHHWdKJCV05iT02V6x71czSMSAw
	yLQY3A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2uetf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:56:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so1394864a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786557402; x=1787162202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7aPqzXzK+bffdypT6w5RZHf4yVPPVyPFUZRNwHMo/0=;
        b=hEzwIba8auKrKhyR7tyen8nrBKoaSSxPsd0V75feE+IXPyuzm9oQfIs/6dRSgnqZPV
         s79GxyBVop84ZWY/0hG8RxGWRo+ZlnD+Ku0bqQUdq8ZuPCwxDQUFDnZZpjJeBzpy2iJC
         cQTyiW5PrS/f7bzdrPYco9GLVWVTjJvKl0Ng8mslQ5tM3buxN6y029NyguaqSWVBYG+M
         NZfQkPDKcrgQ6JDHRJ7tMEIEkPf3jbhYjCvN7gM9CwMQUAnqqLczuNum/cWudvTPM0Jr
         Ao3FVK10z4kaypmvAFVqpIFKOYrvF2atgbAj1/0Qak3uLgCKq/3oPFAbYbdklHUZM1Fo
         g1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557402; x=1787162202;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7aPqzXzK+bffdypT6w5RZHf4yVPPVyPFUZRNwHMo/0=;
        b=WC//Cg9i4DBMiY2W1v3FyF4IJbeLW8sYnMpYaEkBrvSB82/Om/wzAXrfVsvCusKkyT
         SITaTDU5n3zHoGY879YQM1PgVAtz7P5+9ZUZjH+sT3/QYPNeiKUeliJ3q1vzgpqXiqPV
         Ruw0t5rAJJQoA/61tRGfZUTrsv+jgZ1lkZl7zqn4bSMRLyo8kYEo0p0E1l3L/T6ptVD/
         gjEmWdIcxYMlrzuINe5BPjnaOjTMQ1/mKmlPouuxv0McU9/3Cy1JO3gvPn8VcBnocJXw
         xCQcNZCH+UrF+O/uX99qHvAN3/7uvYzMnUCEQKbd8qJld3PXGG8oQc+gMBpjDXSuPd/Z
         /2DA==
X-Forwarded-Encrypted: i=1; AHgh+RrhHFMmkmn2p1bgDmt0mSIARD9JCMCxuDMDMR1Ezx7s0h84Rlijjg+HshAfVAmY28Wj/k+Gp39dQHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7sJMsjgYBkIAWDQ/T3uQj3uPDPCP2Dgej9PHj4ffvVdAxJUfh
	R671m1v8O3YfT5v3miyJf+h9ZcMYiEqJWfy0gy6sfDYvaeqCMROF29rCmW+OSpnsaMIipTqfkdE
	nu/V68UbsQk0+bSzzSNEC0TX47Cbl0oCg3UoHyVRSMT5peKzEciRGqaj87tjQP7g=
X-Gm-Gg: AR+sD11BL3F7RnLZXPsZ+prkTCvcFnx430dd07jTQ3iG97VfAPdFbMUaja4NrvzDKgA
	WqWL3/NpuvuBIs8SyYhTPZSnpgXn+kI8gfZXbjjIklsGTB/WabFwVm/H0OGiTDqxHPX/tl5ZzSI
	faOZahlgrnmiT6pu4KjUPI+/pQrOFyprWIo7mRrW9U1B2BI6t2kjslI8963bZ9HIs9gizlyXFCU
	mXuhohfCKI8Rmu2FLNQfqVq6UoISF+NBF4VF89saETKF9kmwsImaNhPjvaZRqFx3oqKt0llkHKX
	Nydg+DHnRzLyw3PZBm3PPCn4QfCbiBEXIT1a3wTSN95/klkCrzCi32k9uQkEgc3Vh3UKdtB5+jf
	WAE7QknGl9HiGNeQ5/6V5tr9BhdoSDCvf6VY=
X-Received: by 2002:a05:6a20:cd96:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cc553f71d1mr184957637.31.1786557401813;
        Wed, 12 Aug 2026 10:56:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:cd96:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cc553f71d1mr184894637.31.1786557401210;
        Wed, 12 Aug 2026 10:56:41 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.230.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef710cc24sm19799a12.20.2026.08.12.10.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 10:56:40 -0700 (PDT)
Message-ID: <e75f64cb-26a6-4b4a-9dab-6991634e2a0a@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:26:35 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: qcom-geni: add I2C frequency table for 32 MHz
 firmware-based SEs
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7cb3da cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hsRoOqe6K9Dtf6G3Ghy1+w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eXSzwYDvwnVE6XuJA1gA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: XOXjqO2n0XXyjMCsb2Ubydqk40-fWjde
X-Proofpoint-GUID: XOXjqO2n0XXyjMCsb2Ubydqk40-fWjde
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NCBTYWx0ZWRfX6vkxMnCymB/0
 PE9zHC0tCYQ2qCQJEkG4+ya6Wnx0wQFLOBc1oY89HAvw4faPOC6yY+4UhtLus8vbQuL1PASEQBR
 Fk9lvYLQjT/YtsajTDKvsn/Yzwrnur0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NCBTYWx0ZWRfX+MjSvMrjwcNb
 56Cb8lRjyVf/wyzqEP1Uul4VvTJ3TK0jfMfyPZogD7zmi9ECj8ZEyBUXgccCY8LtwpAetlvZySQ
 1Wb51Q5+OJ/2xset96xNtCxCJc19fS8QHmiiGDtNmlTMujaMp+njIrBqVOJS0vaze48n/di15n4
 2ubyYFPHgErs/2wMyAC3/Sk70pEp/Ug5l/QCAir0Acy1XsdL2iQCAWOJS0CkRewdH+ZdeT/+t5X
 ipF18yI318tpKNcpio19oL4DYELjJz2PRb5Lk5ujcKdDjGHPJ8YL/6GXJBs//+bCeJCQRk0jmK2
 Ds6qQ41WZbmQW/LHPBh/moOEaaaoqEua0tj/EocKBGADN/RhWoTXK1VJmTBH+pXLshnJ7k/1mIW
 EIt++Pj3JSPwyML+sJ89yhJ1XejcIo1gA5K5YC9AAOZVlut6ZwsM9oeBDNZnfRC22kNCZ1N7vHt
 ANdAhaAMbMfndu7Ngzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120144



On 8/12/2026 2:00 PM, Kathiravan Thirumoorthy wrote:
> On IPQ5424, the I2C controller can operate on both RTL-hardened SEs
> and firmware-based SEs. As documented in commit 506bb2ab0075
> ("i2c: qcom-geni: Support systems with 32MHz serial engine clock"),
> in IPQ5424 SEs use a 32 MHz source clock.
> 
> The existing frequency table does not provide the required SCL timing
> parameters for firmware-based SEs. Add a dedicated frequency table
> using the SCL counter values recommended by the hardware design team
> and select it for firmware-based SEs to achieve the target bus
> frequencies.
> 
> Move geni_i2c_clk_map_idx() from geni_i2c_resources_init() to
> geni_i2c_init() to ensure SE_HW_PARAM_2 is accessed only after the
> required clocks have been enabled.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
