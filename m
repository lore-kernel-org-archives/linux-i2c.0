Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE24367F48
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754434; cv=none; b=obbKZxqxS7mzD4DnCQ6nPrRZGdWZozgQ7Xj8m914TXNL71ufK2A4SKKrA1ICEnfqEFDD3yGC2JOKae0rWU5pLyMoolncXQbW8Nq7+Y/ThfHP4lkm0t33oWyvu5RT3SkncsZ/dTX7aPyAd69HMT9iP0zjzV58NZsJ0Yj0+4fmPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754434; c=relaxed/simple;
	bh=W4pjUQoMEum1rTBka7R+6cyJe1uJzGSmpQoSoqotukY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERJwASlLgphyn6Fbv4NaBHMO1Ba+fqINcVY83X0izodF7+A5IRof25Cb5V/D6Fa5hhzcrCxNYqboYYvp3H+fdi20Ls3yxlR2Lz/Twz3ytddFSmqzVxICEyhieBsdIArauV60/e95ZFECtvKxPjCSxfRKb8d07s1CqjqfWWJKsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eiVC9egI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FLDkX6H+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eiVC9egI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FLDkX6H+"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673AKRPK3654877
	for <linux-i2c@vger.kernel.org>; Mon, 3 Aug 2026 10:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL2H0jG7cWNshG9pGpR0BK3e3nbsXkAHLazXPY8v5m4=; b=eiVC9egIHMMMr92n
	lN+F0/F8ujtHP6bInwATQerx1UVy7WsSWQfNyM54hSY6Y7bW6QQZ0oU1PD01qnGP
	olkgnM5/ullIeDEBC7ewLwQoYKtWO6Q4pzcnOtc+2HUKrlkjgOR3TmP4KcnZKHwR
	aBQ5k2x2RE7dJ2MdkSdq/mR9KQ+2bKyBS5ItBLGeFbp0DgpVCuZ0fVnb43ommTEd
	ld1RRpvIQrMiw9hHTZDVi0EOltfpfEc5ryCQ4CHsCVHOvhWuD24QaQ86ILNV6TL6
	0MCUPFE+EEdd3ljSsMOM2qMik8zKgyRLpzgRWFIa1KsexykQ/+VYlkVbpxCyRv6h
	M12fcQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhb17cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 10:53:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so5293568a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785754432; x=1786359232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eL2H0jG7cWNshG9pGpR0BK3e3nbsXkAHLazXPY8v5m4=;
        b=FLDkX6H+W6vMICMpDZ7iP76IztzTo49HJxInNuV13WkdwDHQzigD0q4Yv57SSgm6de
         JFXCWsZQvuLUVgkvmTwNXOfDboa+3EmY68lBj66lKjunHrRm2fYcJjrAOV1JsFk/AZrP
         xiSwsYM6ldfYMHt/cvOPJI1uZs4q0ZculuoBOQ7rJhe/yXRvcEueeJlaMVPJjkg3BkQu
         MiGQECdI5X0eSP6F0sgO3IBYz+ymqubPJEU5r6zUnboNruaprjBtEely944ozVLntWax
         /aTmit5fZms1uiTFLz0ONsD6pkPLnBO9nQ0QqeNultr4VAYz7FDDO9pU6qYJp+gkkX1j
         kHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785754432; x=1786359232;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eL2H0jG7cWNshG9pGpR0BK3e3nbsXkAHLazXPY8v5m4=;
        b=R2ktVIwwK5zvAahrkeWEQ++TidTNMmQGMhsKuaxmnSSjSnyGhfon2e5GEnm9/qo1rQ
         Tsgx2bpOXPPj+0ePoHisIzecw22nNVlOmefHdqh2mmoGIX6Th7HeULISkxAUBrhSI0uK
         JWNNZhrik3ZIEobc5NlZ9rp7hUcalQXrHLb35TCourfu8bYJtI6wyCQ8fB0Cjrrr7/vK
         PPMbOCHDpydFaPp1eO/omcAoj7Mz7CpHg2rug2kl33G3UcPVU27lSRsG09k3PXWFl2FH
         P70rNXMi9PLqZXW1zbrLt02mkraaJiM1yB8Ao6bgKz8fJAgfNl+DUls+IbCo7ifkLUTu
         qkdg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4f9tsdIBeY/JjWiTyXlVsA2o9AOK3TSUr5fCYDxvG1gnnJgG/iWRmVxtSVmqPVzlxFWjazHYB4Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yepWEJIPnkmZHjQc/ACBto47FDalzhpAGQw8xkX4YAhvyhOj
	wokM6Ht5hv1KHaFkEyl1Kv4gTEeZYE07LAJUyb8ZtysQ7czdxZ/tRWMA8ZSLXovuC6jpJ4qM7NA
	i+lLIAth7ytuVyWUwqGgMkxaExXEw2pWLrLxbUK7Qz8ZRnnyQ4m+tVlwUhlw5taQ=
X-Gm-Gg: AR+sD10JUdoT0G6/KEbOE050hXYjIxRgvtvp2geR35xWj+e3JaivF4X2dHpzidIyceU
	myDbdbtj/mKP02zlzFJEFi0uSjwnGp9Wp+rAb09Tk+EMdUif78lHo47RUbsLyRjdNFPnsD+ZCxT
	91ydYrjMmpMutyHUs2D1YhmQDgfnybvbbKzX7y3SjiBDyR4kW5axUo5RpXIfi+xrFOPnQF8Vqfh
	4vlgNCiaZlOmaya9+eV2/7e/ig30O+FM8GnzIsSj07o4B9zX5iH+ixAYEAT5bS+XIE3t56eon2O
	6Hx18FaZR8BOntw3pm0qo244jYdzCg+wsahwlqEY6AkUbCpzHF3asELk0HEyRdRU0O78tqty1xA
	K9nxEiWR6GOBPFGjXI2FXj7VyRWjZ+CTNHQ==
X-Received: by 2002:a05:6a20:431d:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3c92a524e5cmr8551439637.16.1785754431905;
        Mon, 03 Aug 2026 03:53:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:431d:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3c92a524e5cmr8551416637.16.1785754431473;
        Mon, 03 Aug 2026 03:53:51 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddda5d9sm44339354eec.13.2026.08.03.03.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 03:53:50 -0700 (PDT)
Message-ID: <8a7fa505-1102-49d8-9343-0fce37850b48@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 16:23:45 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
References: <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
 <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
 <amh5l4Yvwemws6Cx@shikoro>
 <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>
 <amoaEGX8Q4zwHF2i@shikoro>
 <be5ba8e8-15d0-4fe4-a66c-fe7ce8da6cc3@oss.qualcomm.com>
 <amuy0mdHQlYCcRfb@shikoro> <am5e6yBm-4ZH1W27@shikoro>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <am5e6yBm-4ZH1W27@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y4-CCz3SxqaxZr67vfnAZJfx8CpBNaaU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5NiBTYWx0ZWRfX00BVFiM18iAW
 W0tx0xqw3R1RlvFjcGp12+iI27WkXkr0dCYpPgGi1vKeWZDx8MPEbBxIDuXaCyVSkEeWfDNQHKm
 PChjYtNKNDRFqQaaICUEu3ujqnPDPEQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5NiBTYWx0ZWRfX9gdclbm0Hbre
 E8zCb5lPbmlKPleT0HYPn5vrGejjpftc+yvpDgBHu23168NgTYIBAtmYTSRNCTfMgf5X6VnpKhU
 HjwhCsb/nMRHL6X5iwmiKO+JRchWVfltSnKuFdqh4b1OML44pwUl7fkb7WnMtN/ikknAtviWZlx
 lPeOjivbdv9kJNjMZMTsqMDemml9LJiUZNTiHIWxfCP82mi1fJ9OcZCtEbUYu/8OhsO4NikFF9L
 aV58FptkG/DKiE+VjVmiVi9R5JGVsxZ3ryp5/6sANYv5IWJ+xvYqGLIJ5WY4ciXEi1WhKdlt68g
 YBpJNtWvl9LrpccTQwWiDA51rhgluuu3xu5QdZJiiEpvCi9VPNBMtMcRIJrEn/F8SbpgxsVMcd6
 cNoXPgMru8Qz/3x6qLbiu3Ye5I/B4iNuJYF+lPlln8a6Ra8ORbRavnNwHmIZZpCFmaTc4a7iH97
 vZAwciZtug2/zwo4EWg==
X-Proofpoint-GUID: Y4-CCz3SxqaxZr67vfnAZJfx8CpBNaaU
X-Authority-Analysis: v=2.4 cv=bKEm5v+Z c=1 sm=1 tr=0 ts=6a707340 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=wk_Bz9T5fIWzqFoZPV4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030096

Hi Wolfram,

Thanks for the suggestion.

I'm okay with the Kconfig-based approach, as it would avoid regressions 
for platforms that prefer the existing static 1 Hz timeout behavior 
while allowing controllers that benefit from dynamic timeout calculation 
to opt in.

I have reviewed the patch series in [1], and my understanding is that it 
does not directly conflict with the dynamic timeout changes. My series 
calculates transfer timeouts based on the configured bus frequency, 
while the referenced work focuses on dynamically changing bus speeds. At 
the moment, I don't see any functional overlap that would require the 
timeout series to be based on top of it.

That said, please let me know if I'm missing any relationship between 
the two series that should be considered before posting the next revision.

Thanks,
Aniket

On 8/2/2026 2:32 AM, Wolfram Sang wrote:
> On Thu, Jul 30, 2026 at 10:23:46PM +0200, Wolfram Sang wrote:
>>
>>> Given the feedback so far, would maintainers prefer that if i drop the core
>>> helper entirely and keep the dynamic timeout calculation local to the
>>> qcom-geni driver or should we continue exploring an opt-in core-based
>>> approach?
>>
>> Well, I suggested a potential way in my last mail (Kconfig option). So,
>> what do you think about it? Does it handle your use case?
> 
> Another bit which may be important for you: there is currently a patch
> set under discussion [1] to allow changing bus speeds dynamically. You
> probably want to base your work on top of it and/or help getting it
> discussed?
> 
> Happy hacking!
> 
> [1] https://lore.kernel.org/all/20260719-i2c-mux-v12-0-a5010d623a57@gmail.com/
> 
> 
