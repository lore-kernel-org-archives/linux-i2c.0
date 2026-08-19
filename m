Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E752E0B5C
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137424; cv=none; b=ADF2iRi+f7ybuYA+17lUhSdMS0OjNvF9VOpKoJFH3TkvqTpSVV4RUzddsVGxwzm6qPwrcAkxmoC87e7fWZtL6IaGcvFkBF9v1eRi1Uig1T5tx1sd0Ldi325jl1K+LUDlM2Xo0VL+OQl0hTpR6t/f4JYxfRmt4L8tnIkaaoPr0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137424; c=relaxed/simple;
	bh=QBojQsi8wY+kAhHZS4n4dE92YBUTLKJtOxmkrL4V4pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgAVQsuLLk42+ab0/mb13ttIQaBD+oKVKt1+1fwFlnfV8Td38zH9Mc90v4u24TqJYULf6VumnWeKRx90IdfuETlvqpcQdv0XrSe2J87dz2B+rzL9bs8pY3hRFDG1Zlx5pYNJ91qWzyRGcs5OeSDsdkqNHSLb87C8MREWbVlwLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pg2z3eWx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pg2z3eWx"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b2a1fd0ab0so109333e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787137420; x=1787742220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A4ELa6x+Yb5HCgORI6eX8lid0seyZkrG1l18lRvxugE=;
        b=pg2z3eWxK7eWErztV+PPmYVcQa3PCKvlEAE+KVuS6Hw9VpalQcpiPtIr9ueHzNZHZc
         zeeoDDcITYKYRILPgfe82rXRMvcULtYKFMaNIo8I1NE7xdOwFQ7x3D85S2mSNM1q3lzK
         nBFoG9hjmH9xFG8M8UAbW0I2tZuNYXp3+nB6ooO9M8ypah5QQ1FYDx+fTALdkkCRdUtg
         tzCkAkS8yz1ZzK6ZjU0177qb0yY2o/SVP2BgWlkhNmHDpcNEx2ShiAPynA218hLpq26h
         wb8s2m2bU8+bdK7Rc7I8fQufXbvHKpp91sqzoQONqLERsAvBX4mVTZp4FLetUw7Y3qox
         KFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137420; x=1787742220;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A4ELa6x+Yb5HCgORI6eX8lid0seyZkrG1l18lRvxugE=;
        b=Ow+X9iABeY1Y/bLJ6Bj9viWGZEIxrLd4uOfihPu/pobaCIG8dMrjOzCGsXynPVg5HM
         x9Fl1TtnDOp2M/RpsEJFE41zVDvS2X+h6NChcFG+do1DQAadYINRseNzYE32SMRXDvX4
         Z2U7/TeMjaiZbnTdxQ5zCPO+4vu0mx/0jaskpAk1vH879f+Qc3QzexUMjdR8IqKRHdoI
         Vq4IW/PvHngenCQh9jIdAyJRxWGU58pc9++FnjychlCXL2/t7bRwRixxSmm0NqNYeJT2
         dlUJQhlTR5j/uemOwVp1j/U//hwnVAR6ynErypkgv0QK7ypRRXkhhaV0uzKaG31D6aVN
         rAQw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1zoEzli2thiWM5gu5B4WwAkZzu0xFy+5YInNcHM6zeXEiq2TSXmVZVq8GGoUSl4/Iq14T8Rw3VJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBhx2bl2j6YGd93ZO1GPnv2titVdK0bgp+OdoZZJqvbpjffno
	hNiOHDz6kKCFlE/z1DjIREicUpaSiqWY6FpYnDGyJRnuwlRe6JNdxw6I+KEi07bzgPo=
X-Gm-Gg: AR+sD13wF0B9JTVk9I0id/HQbumF22iNENZdU33hUIffsDByVY2O70LeWi+4/MKLCd2
	F50Yaec/dSqq2Dr5EjojeuA+6L5XfJwB2vtuSaJfaDwxfaCwW3fNxIIhGvmI8/NEx+IckZKogh6
	RM5lOADkv9odluBSJvUVEPycuPVBhRex5NCKccrZTGv+Z5McDXDhUp8+KWy4e5svVanywqxz1Fj
	Zaq1T3WwBDnH0pZ3pSXbta5VHFDlQTy0Xd2v65QVWRbUSRqqt4/PF98kUM/QZ2KarTEFHJn77/4
	sDe81jd6wJIhNb9Pa628XBwYCC4UMAextL3lFw+2p6atNWcNiBODLdCSHF0R0/3vGYb5RxAvuGg
	ibwd4lETmugF4FojjTk5ojZt0KKRmYFdmr6nsGqiE0a0SOFzgU7oD4Qz7I3tcm+ZM6pR+/zuqAT
	vZT9qe1zr+tSa6BPCQaRLViQ1yVA68iv//Ya/37LtXElghIeE2nqWfRBYOOVuquarm80Ep4go9N
	quCah24URkrZpN3ng9k4p0sREow9OTRTNOGPFOR9g==
X-Received: by 2002:a05:6512:3c8f:b0:5ae:b2df:c11a with SMTP id 2adb3069b0e04-5b4788fa611mr702473e87.0.1787137420382;
        Wed, 19 Aug 2026 04:03:40 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788eb02csm430814e87.68.2026.08.19.04.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:03:39 -0700 (PDT)
Message-ID: <440f21a9-4564-4f89-bbef-4095414e486e@linaro.org>
Date: Wed, 19 Aug 2026 14:03:38 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Wolfram Sang <wsa@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260812094425.3515179-1-lgs201920130244@gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260812094425.3515179-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/26 12:44, Guangshuo Li wrote:
> cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> does not call the matching pm_runtime_dont_use_autosuspend() before
> disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without undoing the autosuspend setting during
> teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> state. Its managed cleanup disables autosuspend and runtime PM and
> restores the suspended state on probe failure and driver removal.
> Remove the now redundant manual runtime PM cleanup.
> 
> This issue was found by manual code inspection.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
