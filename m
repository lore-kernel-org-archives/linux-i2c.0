Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE9449EA4
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752794; cv=none; b=cWx8rlEU7qjSKfBnTfLI50WxE5++b/hPQzqX2dc4buZ5S0TCuzwhgo/FEG05OHzXD8lRuH8ML3eg74RaS0wKTeBXYOdWA1QYSx8qD7/c8If2AJYoUHQQtMjY46kbOJ103lHj/CAlGm6gbJWM9O5fF0Q0yRjonR7FuMydQ2SIwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752794; c=relaxed/simple;
	bh=3LSpxPMPHBZB4XoJ6enxTlYmQ3Ui0OnSeA/df2jpdDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgJ2P4eqs4ytG5/2EUQLBJ9POb+lwW04iAtduis+pBmdthe2tNzo3785V3ygykwdD5OJOUQOcwkTtxRAbNsmZnd0LS4YHDlWgGdyJA904DwX3ilpnz8ktbvr+e1Yy5Ceb51IsAAyg8wp/q87pexcaZwpVPgwvLefL2t1abmpF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkeyBOw9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AWvNY9Sb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkeyBOw9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AWvNY9Sb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U6oU5q2009189
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 07:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nNeLhRG9mdUW1ExO11XbOVCdLGxRbopNguBedX06D8=; b=AkeyBOw9FW2rckWv
	Vksy8cusoSCYFD3vrzd+FV0OULCAi0g4+dbR1pLZqF+qsgS8LXdW6fwTz2eSmWO0
	U54kCI8Irq0k8rFQ/3jOHL9yIynVqDoHxBpSp8nzLjfGUiqrwWNSQxBfnnjtVZsR
	bLAXWg4EAz12sA1+kgNLXyCHIc3WBvdP9JErBlBrpVNDOiYGTd5EuT1+jiMkPsjm
	mDSM9ZFkfPlT13R7zVXIjC9xvYXqrMOrASAoWQajmyc8hzePX7pssQ51tgBHXXwi
	5A2rfQRsEZUJknQwUoHKa6xiiyuPwpmg+ymqHR+FW12MqrBAiUz/0jCCFbNdEN6p
	4LkeLw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhehery-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 07:19:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so5276506a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790752790; x=1791357590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nNeLhRG9mdUW1ExO11XbOVCdLGxRbopNguBedX06D8=;
        b=AWvNY9SbDmAGr7dNi4LtZv0D39ACA7CebGgQdYH39A7Y83ke1RhvppsNuPVJWNXehv
         0HZep+/pXBCZaYgJu8ypIdp5I9qeDTG9QnkNyH8zoWLsUyY4ivQuu1hVRJfSsQ1AJFbE
         R3DJUhRX4ceNCnZSb8OdChsGAMOxxfhq4+i7sqlJ2bLrq2K0p/znqhX/ptdEMKQ+sJMg
         YCeq7pn8hSWdhiKFXkhcw7l0HxjEuixJ3zYxIS8Ikeh4Uwo4kP3xykbtEbpoJqriEFdw
         OhJEP98+rxUUqKNrhfcMsuXfJC44Ejw2KlRnY+Cw8LSBFdj+D8s5D+ONadJj5lKpd9Xs
         4vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752790; x=1791357590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nNeLhRG9mdUW1ExO11XbOVCdLGxRbopNguBedX06D8=;
        b=rTfXfDs21Hd+aoA7W96lPV9/CYWRADxYvXMT3jFR6rDzelqpqJ2izZYk9TiYWeAnxx
         QsX0CIXPTBPvOxXXwlPSS+umvzQ/Q3sY17br1YA9bnCXRZFFPkhE8CN1oRB1hLJaT2C6
         QrdIP6hI34gAbjcWxuHNDCaJa4/8p/M2eJQiLGqYQvM4mj7jhEDct0TkEAgGRwAF6jkU
         HXanBlnGv8wfAW32MezkaRpd3ee26nwqfCMqEWW01yl38o0qjD2mal5oD2Ot0T0pSsGO
         1ufCfZ0GjaGADawSZt4XEFEvKMh6wbn6JUASvkRABJlfM/5hs9pK6vkOzbHUMtiFyO/E
         CGIg==
X-Gm-Message-State: AFq9FYIVIO2YBaNPm37PssDTyHRqI60bK2DsN95uSnlp8K72ajhNUs1y
	jvr7BaY6Z5qEC6YoqhU9iwDwugaOuRE2CJUx4xqvkuLX55HlnYt+AlFMUGZ+0AVg0DS/971aRSc
	BDDAFTUy9t5/w8YlVJaCGisCqjGwvvhdnuYz+HPMDvvXw/AZ72/xac2Cs1P8l4sE=
X-Gm-Gg: AYBFou0dXEE5RNw+fPgN+u+IMYo+mjA9nAzWA5cNGzxVe+/J141WBNVngmxE1kXnSEv
	py1O19sGENHK9ZnkANngH5Zwz8UMQjdEk4Oy9CvXJL4llEz4YFVveh1Uqp53sZvB13d9tnkGmDv
	qmGKdeP5doLFomwHA9JUvXyE7T9WL4i7e7IoeckIQ1ovw/uyAXKzDhoapbumy+4obStRdyHZhwk
	LL7JjWGXc9D0V8ERzAoAwtZphVGzcokx+CCZrBT9mYAtDv177gwjvSjMsHkAXF/XPGAFTyrX6gN
	XsWBPPGpmCFnEPcMDTjZsJFVh3EPQs+FOxIuyEh8clP1CalVEqYf3KO9RDEA6g6/De5z1IdnCBX
	Um3shjFXnHenx5bFsbsWdxGhEZOaDbmLGwg==
X-Received: by 2002:a17:90b:1c08:b0:3a0:dec0:c0cd with SMTP id 98e67ed59e1d1-3a4d17a0c3bmr303031a91.28.1790752790465;
        Wed, 30 Sep 2026 00:19:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1c08:b0:3a0:dec0:c0cd with SMTP id 98e67ed59e1d1-3a4d17a0c3bmr303018a91.28.1790752789784;
        Wed, 30 Sep 2026 00:19:49 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae89d76sm2054551a91.15.2026.09.30.00.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 00:19:49 -0700 (PDT)
Message-ID: <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:49:44 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Daniel J Blueman <daniel@quora.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929041444.9837-1-daniel@quora.org>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260929041444.9837-1-daniel@quora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: B7lYrbTFg7y0JWJm_fe_aOQKS1fFhFOm
X-Proofpoint-ORIG-GUID: B7lYrbTFg7y0JWJm_fe_aOQKS1fFhFOm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOSBTYWx0ZWRfX4gb5cDThMk/n
 95ACDVRMes988iR2FJ2ap1cTadUG0XDg57E2NrwVHNWAuRrqrRlvG6Aoeimk4VrKraIg6hApaj/
 er4JpaiV6yF+ash+kIoK4F2cZZrYFzdOllVQTO+qm1yahO14Cd+4w4796ei80ipJwLLgEmvEIcC
 03ut+HHcMejbtPOserVV1pHTUGLDNwbNiEhVkz7SE8D0/HaqVvX732/oJmSzJziPvADCZKqf/0+
 5WA8e/0nQNUJ/xQz1seSdUgDmbf/NldipDERgZu06bp57qiXK4PIMiMETBHG30D8yLhgFo3A4Ts
 P0/x9MxjVQxNcb8MVJblgeqzXP/ev4HCj4jVsOC7k0yGxB2COCa0NBXx65xdApS4ZxNoR2GfZ3i
 hs+MQokvZy5ehEaSQWcizwRmpMCa2aEg5Yqh9WEHMvNRlBzJKlyXFvR9Oe3L5NM0cIgay+p8gY2
 ZSL18elVjeU+bWKwaaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOSBTYWx0ZWRfXyp7eXsgayhjV
 Rhnbfw2pkR/gJJevsyMwvuRu04G85taK9JpFkfRgE7PpTNzVorC10Vyb9myJFAlX9ESh337G59V
 XPEtz2LzMnX26m71ek97Y0M63UDmdw0=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abcb817 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=tsASe9PyN1Vfnx5TqtMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300029

Thanks Daniel !

On 9/29/2026 9:44 AM, Daniel J Blueman wrote:
> Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
> SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
> timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
> on all boots, and touchpad unusable on some boots, resulting in:
> 
>    i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
>    i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> 
> With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
> versus the previous default of 521ns, however the I2C spec has a
> minimum tSCL of 600ns.
> 
> Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
> verified on Lenovo Yoga Slim 7x X1E-80100.
> 

There might be a final count which i should get and update back.
Since this fix is working though not suggested per hardware guidance, 
should we consider as temporary fix and move ahead to prevent failing 
usecase ?

Any thought @andi ?

> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 6a39e21d5ed4..1336a09ca183 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -193,7 +193,7 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>   /* source_clock = 32 MHz */
>   static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>   	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
> -	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 5, 9, 19 },

Exact change to come from hardware experts, till that i am hoping this 
revert should be fine.

>   	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>   	{}
>   };

