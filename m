Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AF233134
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784968829; cv=none; b=eHUcnE0KYsldB9DgyDNIPHdKzjL3iGAmNFGrLJVouVpNi5PeSx+xdoPRrXFmUPDBphZLQeS7t9+P5m0U4v1y2TpOL0VVoPytRy0mK1GUOnv5lPCifRBvbyr9xF+ZWgrSZGogRN8fPlzzQRVN9NNdxgFDymL4gqMhHvEQYIQGUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784968829; c=relaxed/simple;
	bh=mhgrRWx2k1e0VspUwC5Hb4XjyyrXhjarhKzEvd5EjT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx5iTblBLn+eDAQkPPmMoUu/BoWHng9lEfnL/NU+tUduLZbz75f2RURB8WCe+OJUugais40FnDPLUTVl+o+/+KyWXXvG3ExWNaPXzUh3DFZwXBokVE5KTZKyGyVEI9m8Ni0RXzRwi8KKSKXvvOpZkAkYXCZOUs8Y7AUlht+TvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBYegOfm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBYegOfm"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aebf96bc89so185094e87.0
        for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784968826; x=1785573626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MLYAlle2xVguW1DVr4k68CONNuO/IYqBXxeXFAFbzXM=;
        b=TBYegOfm8vI0OCWQao9jPyWSDCEXyf1mWWwS2G6AVVsWaNQxyQu6d+h0ybvu3/9Ffw
         cMO9BWvm3Sn41BQ2Gd78AerYDXFg0yjsJ1CAJwdfiQKKAgSngOKKIcS4zw7yUl2rYYDh
         iLAJ6bO8Vd76r6IoGqTXVe7yD1/6FB6ZwcaG9gJDFKdShzvtjqcIvxrMq7dDeJsRFhCK
         H5KckgAC0k47e5Vvkn2pofAbxEE6KiXsHuUD/ll6WOBYZS4O6FBHTtAzXayBs3/vEdmw
         A8ZinE8wyE6Kg/ZpmAZlg6xRbI21GJ4Jb/0HV2NuKMoPg85VHfYQNF/tbBgvc7zBQRq4
         c+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784968826; x=1785573626;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLYAlle2xVguW1DVr4k68CONNuO/IYqBXxeXFAFbzXM=;
        b=U+r5e/ZQ+junW/0mu/vkEJLzNnFrH9FTfpiMZRMJeVc2OMrTr6UpY53jbPipkZrKTM
         Pn9VSvwTxRxFBCIXT4WYUBu6mX+H73eQqfXqSfNZP7YGxMuvtwc0CY8gudv90eBbHDd9
         inuZ6FX7z3Qd82pQ2Pe5QJa691sdc/9kSyf3evqNh03pMMLbEqgFjh9cbQ7NKPXADI9E
         kEPCjxBpxFGBqBSiS2w1lxC2JcygQpZPZCdw1o9duRsjCMvPQLRXTjzYCDYjlyD0c69s
         4WwUBYCT47zV+kSHigKaz5MlKKzAyenOcC1eqJcsE0m3dmCEVdHy3EQ9gq5srOP1XjiN
         IJQQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8UiH0rlypMDMMEKqzrESLHinvwQwlg3mh25oYi9eYqU39FTJJqR9aG15YLE++bxCA36RD2cf/xhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VRoCdys1GRofV0RajWoL48tGLOMXJ7m/ymDPfvrJCdHvW6OL
	N0FbuU9N9zcc0tqREL6vdrnkDIzr0cgL+8+eCQDK7p1RDXkis65c4gDJU9DTTKN/dP8=
X-Gm-Gg: AR+sD11Pj9XC9W5oQ1L7ace8PRk3417O23Z+yY5j777bXCOPAQZKjkkyWLIPsMKlB47
	rwnlbshZwQNjypmg51iO1k8KbQb15QnAEqeQKdA75jiyiBzq8VG1mNs0Rc+kqeGMye+2zJ/1R2u
	VdFNHjsrsCUD8epBa+T04n08CwxurMyQ9DDl5Di+4MB+Z/AW5fgALs3naDdPt/NTywVEqhVFS0o
	rYBJEM82IXK7MH2NS0dPW+jTHiP4xmflB6NwAGxQ1e3ybVKOgECXnZedTiDXjvAUBZt1ZPobnQY
	SVVsWrtp6iXJ3wSfeuHpE10kOLOi2lhL4WPjR0339eA1T9b/TL8IEPlljwfWS27uyzk9rdP3ISN
	uteroEVAS8jurJW/gwLroNjROAEGsKuOL9smXoVBiLtk9eAK5SSEyECfc6KG6nqa8KNh2E+/vQM
	HhUEfDRfQ8+9MP4Ne8twpbDdPxdsggjohm4QIF6zrALk3pNG7Ld511hY1K
X-Received: by 2002:a05:6512:b27:b0:5ae:b844:2d4f with SMTP id 2adb3069b0e04-5b2c1b5d9famr166935e87.8.1784968826358;
        Sat, 25 Jul 2026 01:40:26 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be08c619sm339094e87.34.2026.07.25.01.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 01:40:25 -0700 (PDT)
Message-ID: <fae7e3f6-2d9e-4972-a091-749295f2cc3c@linaro.org>
Date: Sat, 25 Jul 2026 11:40:25 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "i2c: qcom-cci: Remove unused struct member
 cci_clk_rate"
To: Andi Shyti <andi.shyti@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-1-5eae78700da8@oss.qualcomm.com>
 <amPtXU_RkseFbpKm@zenone.zhora.eu>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <amPtXU_RkseFbpKm@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andi,

On 7/25/26 01:57, Andi Shyti wrote:
> Hi Loic,
> 
> On Tue, Jul 21, 2026 at 04:58:19PM +0200, Loic Poulain wrote:
>> This reverts commit b641af684fc28a07bee9c808eb6c433f9d9bcec6.
>>
>> The cci_clk_rate field is needed to enforce the correct CCI clock rate
>> at probe time. The hw_params timing values are in clock ticks and were
>> calibrated for a specific frequency per hardware variant, so running at
>> the wrong rate would violate I2C timing specifications.
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Does this revert need a Fixes tag? I haven't seen very often
> reverts with Fixes tag, but it makes sense if they need to be
> backported.
> 
> I'm going to take patch 1 and 2 already while we discuss patch 3
> separately, but please let me know first if you agree adding the
> Fixes tag.
> 

please put all commits from this series on hold due to my last finding:

https://lore.kernel.org/linux-arm-msm/8d20f3ab-696e-40a4-a05a-688779299071@linaro.org

-- 
Best wishes,
Vladimir
