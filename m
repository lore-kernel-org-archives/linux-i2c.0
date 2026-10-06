Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740C255F28
	for <linux-i2c@vger.kernel.org>; Tue,  6 Oct 2026 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262677; cv=none; b=O/mT9mmo+pu3HUBRbcfVyY8HDr3Ape5JSn1YZE/qAUIwVKNgMheKo3kHfaXu6LfbtvdZnHc4N+0bD/IFP0kUrVx5U7UO+CUQs3Q31TvgVQqzGF+kbZgFRp1MKbir57rmeK/3M40UtgWRr6gepQrN5MyD/mMbtsnsPTsssGHSQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262677; c=relaxed/simple;
	bh=a1JEW3k1zmF8z5nj6EAZL2tUpE/tQqtIEkgMf7GCqgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7EzL5Lmq4AwbcBaSBYS2sN1EfaZOpWplW9JkWKmgykkiapJwRiqn7nn5diaZb7eQDCLghm3GYCsVP9ofy9h0BHUk8+lwuG2IXcsZxvLHJwpOpLl7Pm757cFUgTvY6x++BhCvCkpsQLcXT5lL3a3arI5U2VyxWPkKro0PJyphak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P/VcwWyo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RWOjNQhw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/VcwWyo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RWOjNQhw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6963APNu3803337
	for <linux-i2c@vger.kernel.org>; Tue, 6 Oct 2026 04:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gQzwae4o1iSNwmG3c/z/nj5af5VdgVaz2HBMvoJAgX4=; b=P/VcwWyo4ByvsUB5
	VqxAI/xuHFY/tEXRaBeZEPQ9wcJ3pfio53m++M9ohVeOZWJietfc0NwHxYH5+ydE
	RjPwP2fG/28sivUqvhe9vZI7opnGv0Ia3njVAHTQkQ2FArn+p2AnJcM22i0loKBp
	skWR2/pCveD8OMznbqSAlgSWRjN7b0ky+fREBgcTT6uC7IEWHsVIBsP2hSbvOE8t
	lZSvMRMCLSVeqRLGfsi7KHfcPq2xHGDuIKYyHejEicjT3Q/VaURB75V1RMmt3lpj
	qQye/caNtq0i0PddoQQ+xSVfOgoxeOPyZYSLUWU3ZXIci5n1Y4oIn0o2m0acE0RU
	3ADkMw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj63773-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 06 Oct 2026 04:57:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so3961864a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791262673; x=1791867473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQzwae4o1iSNwmG3c/z/nj5af5VdgVaz2HBMvoJAgX4=;
        b=RWOjNQhwwzRQF421zs20bMntdHVCYah+BpueoY8hIj1EaE3ttBn/BO0ewdFHx2ObAL
         BHei/VS3ONUbqG7eQ9kJxfHc2VVXETe06s5AUcVAn/gnN7XmOliBMJ1YDWdwp3/kh6s8
         nVJ5BqIpCsKbvHjtTXoHPxsD6KLG0ps5CTgfhBue5fm3O7L8tm3zl41pav35cfAIVyi5
         U6k9ol8gXkfgB65p5pMQwDc4tp5eWI7PiWIrJCHmM4qT/ZoBLTjjNo7oxVyRYenICief
         ccxTbIlr4YWsAl9TRY3rslEStE/4q3n+AwWDAVz3KOA4lixro1CEszefruQ/XbAAZvN+
         4iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262673; x=1791867473;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQzwae4o1iSNwmG3c/z/nj5af5VdgVaz2HBMvoJAgX4=;
        b=liU2dCNjJ1/243Vt0RszMSJA+CQu/wZajSySixcZxl3eeybZZ7Q37hiyjT8tfYKzGa
         mvBjyYeMOAOQwKBM/yKNBngitKFYo6frkcq9RDOIRYVR3apTK7vAauNiEjgRDky8J9xB
         ZmzKMld+R7E9mJfHkLpubwygenbzfjc2Lr9DYyzRz4/oL3C4CeWidnSLbsYBc8aEE/88
         kTQrlB7vU//wxDII02wg36mCPTy2WrlZVXB8/PvE/C0BvUQYS5H1uqvUAL5F0YRHY0W6
         0LY+7ztfyO6HOrXo5QfzWqm24OoZa2zMLAwE+gtkiILJFI/QAU/Cq2Mrs432mCpWmaco
         0AAg==
X-Forwarded-Encrypted: i=1; AKwUvBwRp5OudnsFJFfu0GXVEqszBOriYZk3BFRqXGVBmdLowRQ1Zp5v6NGZBZGglA5PqvUdg+O1vn/P5Kc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/kQ1l68lDubBmpFQLuefOhjfSKWEoh0DdP9xBGmavkeMWpVtN
	KCh+V9XDOJaTigbQmTxPiL5e+SknQzakiCnEpcz3HGzA2XORf024her1BB0nB/SRCgmAiimyaZc
	ecgKEFQ5ZcbRhx5p8vaYVGZ9k/LXqBwox63PcTac6COdiCYUMZdVfqeIP3tpkD4w=
X-Gm-Gg: AYBFou3evki+q6pJn0WWyvxS6t8Xe7sWsu6Lem8dNuFfeZfIS5Ah8TvJNGc2b1ZVuo8
	/fzaVZ2dmXezypyS9r0S2aETtpP/jaYEdfuuqmjCYP9th7DGK7/usJz8gpXZC/pmkWHI/ZHHJW6
	50YiAuT3qXjMFFYPksiEmnbdN/+/jSb4Ew7qIWNXU14tekyv6dpUBK6daCRKvw2jrmhSzuj9uuD
	xdN4rVQYw2OVZQR1Z7tESgyfaAhOS3ZQ7/R1xh9v6tM8tsqIOS22f3Vl4xGi2umzs+alLK1e4mY
	qpxjnV4CWpvmp1Lxk7i7TRFby8Mq+poyJeAfnFMLRW0meYBAUMWe6c9MZqgFhRApJj31dIfwFsD
	UqytK2okHBd/OhhIdo323xWSZ4QiQ9HUG
X-Received: by 2002:a17:90b:2648:b0:3a8:4e64:e59e with SMTP id 98e67ed59e1d1-3a84e64f263mr1760775a91.0.1791262673301;
        Mon, 05 Oct 2026 21:57:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2648:b0:3a8:4e64:e59e with SMTP id 98e67ed59e1d1-3a84e64f263mr1760755a91.0.1791262672866;
        Mon, 05 Oct 2026 21:57:52 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85436fb54sm2819331a91.10.2026.10.05.21.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 21:57:52 -0700 (PDT)
Message-ID: <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:27:45 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Daniel J Blueman <daniel@quora.org>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260929041444.9837-1-daniel@quora.org>
 <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
 <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAxOSBTYWx0ZWRfXxOUQjFz0W7AA
 JjlawQf0rRBJsCxp/LLGiu6lAIPwBlh42NSqPebFt8/N8MCjiqZz1ZMpJKH9vWLN4B8AbHMqihn
 5JubaWEfHxEK2qAAXt058mZIR119mSonU0oiXhDtN5CUUzmZyfuhi5Lpjm7YSGVRBgJfIyJyD5a
 Rg2pyVOZ45PiZZNn9MCAKky2YpjeYaGbHoYuvvWC0Gd1qH+TiaR06M8f8D/pt083kFJln1qpyHj
 ZMsCPZ2MllTMSo8l30WYs+16srpgK13z6mYs727X1iNZQnHfTjAwTvNq7fnI0D7cXD6PNTx/kFW
 lZFCev0BLQRhfO271BLKmKKbRzLKgHsrvBe8QvL6s5Z2IfE+2l96kqneyMpEV/Swa+5qTKigy6w
 5/Imn9OWozT7p3izt6Ba9HuI/thTQw+CQGRw6QAkvkPFwt5ad+JsePU5FPv4SbNtjNPgsmimEvG
 /yQI36mmYK3S9zE9jwg==
X-Proofpoint-GUID: XXzKgTpcC0qXC1Wb2CUsjfvXZn8nqwxF
X-Proofpoint-ORIG-GUID: XXzKgTpcC0qXC1Wb2CUsjfvXZn8nqwxF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAxOSBTYWx0ZWRfX90Hpfl98vsk5
 XI15sw381tfZseNDKA8X8VXf8r88MIQE06IyPm6HRMhA3e49fzxFpaA1CK12wOn/mgdGaj7zKJ4
 T1XN+Z7TneHTZNoJAP5qms9eoMRDkiM=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac47fd2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=H1DAGgz6eS-KeOzs8WUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_01,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060019

Thanks Dan !

On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
> On Wed, 30 Sept 2026 at 15:19, Mukesh Savaliya
> <mukesh.savaliya@oss.qualcomm.com> wrote:
>>
>> Thanks Daniel !
>>
>> On 9/29/2026 9:44 AM, Daniel J Blueman wrote:
>>> Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
>>> SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
>>> timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
>>> on all boots, and touchpad unusable on some boots, resulting in:
>>>
>>>     i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
>>>     i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
>>>
>>> With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
>>> versus the previous default of 521ns, however the I2C spec has a
>>> minimum tSCL of 600ns.
>>>
>>> Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
>>> verified on Lenovo Yoga Slim 7x X1E-80100.
>>>
>>
>> There might be a final count which i should get and update back.
>> Since this fix is working though not suggested per hardware guidance,
>> should we consider as temporary fix and move ahead to prevent failing
>> usecase ?
> 
> If you can get the final values into a patch for the next -rc instead
> of my fix here, that would be the minimal path for everyone. You or
> the hardware team can cross-check against the I2C standard as I did
> [1, p44].
> 

Yes, Agree Dan ! That would be quick and fast way.
I am in discussion to get more details on correct configuration meeting 
the specs.

> I would revert the original patch if there is hardware that uses the
> I2C 1MHz fast-mode, since the current timings aren't to spec, but also
> weren't before.
> 
Agree, after having last change thought that would meet the spec.


> Thanks,
>    Dan
> 
> -- [1] https://www.nxp.com/docs/en/user-guide/UM10204.pdf

