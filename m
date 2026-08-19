Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894F3C4B64
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122967; cv=none; b=eUZAVUyCZy1zrxbG9fLHPbX5PsvlhHMLOgYrYwmF1sTjSu/Ni/hQAKCFlRF7DVBXCoFqrkJ0ffFM4ZdWVyOP74LRjucbVVh43Vxv70IPQNjqFGtClge96LFGTU66FwI5ZgwXPTprUNLs9GpvKoSCDjIIecz+dlIH+UAXT/PfgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122967; c=relaxed/simple;
	bh=PTwNEIMrqt/+K3EGjlpJNpPfCDy9IJFKkfH7Tp3RaHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqBtToz0jKUUiMmuCly2Hd7Gt8v2qh3EDK8VtVW1NDbc5O8i3Ov2gU8T8EfVZToXhGfToDjr/4S6qIjK3b1mBZRI/i7n/+XCA84JGW1IGq4NH41CG64YuQhE4CdpqUydrPmD9XassLaB6TzN3LxQ5oAcClBhWRVGGO0P3T5vffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JG3bKTCd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JG3bKTCd"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aebf96bc89so180106e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787122963; x=1787727763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TIxiFInvbp1TIjt+yTh8/c2oRjrzWKCSG7xfTRF3VEA=;
        b=JG3bKTCda5A8dONYAnDWfmhseMiLl3baCJB2dJw/ten0bvagiKu0PDolUkLhff2n1e
         mrdJ5oUDdpY+iN0wIUdbhkf87tHfWXzTI/95VFoCCpf7NixoGMAJogBFynR+lWidPnGL
         J51xRJ8AJeUKk4oxHEQAk8D1gUVHrlnBkjRowdmHWDrLAc5m5rf6liyvo+8nZuNQ7anM
         4UWo02uC/k/FvhvjvRvxndjRQbwZ6UGZdhr0Rj6dehaAW3iGV92q+DTNr88c0G0bgkED
         f7Zwi3LhwfPpjgaf61tIjCtbIPq5DOU8WxX6ue024HA6/U87nveyCUXLgCjhKXMtIQuF
         MnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122963; x=1787727763;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIxiFInvbp1TIjt+yTh8/c2oRjrzWKCSG7xfTRF3VEA=;
        b=H2Zi5MLxMkslqNvDUinY+A36DUIMyHfzik2N48QpJilKei0iCh+F+wLgwA2lPYqDvY
         cy1ko3/RQ1avKKbeGVZchkyGm4Km5fcFRsmD9tz2eNHTQr0BF4QunZNT88pxv0w1lcwY
         UCxISDx+WvA4M++COHoT1hf1FJsM95QAG9TnU+CEmdvpv11Rqdvr83t9CZC3CRDHUYsS
         GzvlWD17CjZA/jnNcxp8FVQgB4x6T4ZiDRRV1rixq3As7pRm65UzmwDO46w6/6fEQ4sa
         KWI6FLrtS+qU7ul6j0Z7MGgT2gMIO3s/adpvBO+f1I1kKHD+cnl7BYQxNLtg+U4W3BWq
         ijpw==
X-Gm-Message-State: AOJu0Yyw16D6f+9XumblET1/RtRbAywH1ikuGL5jQiXMqBZdiesLM9G4
	FidEzA/LrXaol49/K9aTMAC48tJU5tqFWEMifDhOn5DJ2JbShwOJdeXxN6vV7Jmpz/c=
X-Gm-Gg: AR+sD11lSpBMbGp3Xfj6XQcVpGuDI84XTjf9n2nPnnomunPKrZ0a6Hs3OnHh5MF401Z
	X1ED3WPGti5n+tXVcL5JsYWssLtpUNbnLO2vH7uWwZHpoC+sw9CtxxYrO7tVgVkcBeO+ADPV3ds
	EMEljFdGgl9MP3XNwLZKkahLwBeQR3dzXxxCuCNNRWqTGRYXfrv8pOnHubKc2GvNkiVty7KOEcs
	cXOKlI/GnfsrUv7P4+xOgKWyJFFoXHMUQ2eekP+CSBsadgvbmajyNO4Qys1CrDMX5COIz/jH+OW
	Q+nQx6eSwlo0SvH+HIdgwo1aq5Srhf/ad2+5IhQgMx7To/a/Qi+wAkiHyUAXeoL2NjLbzq3Xs1E
	m5Nc6vVk81dDAa+wk5c4kYeJ/7R4wZMwlmuq8p/D/AC7y9nx5DfptkgCTPkEOlMX/S4XDFULF1o
	9Z50SPKlxviQUfWGiHJrl4OTgBiUq9pMOBqdD0hUkD2WyZ2IKcEGRSyxLAK5j921cNYcGt3H1WO
	dvSxq8+PxrWrGJxFTxQ9BRoVdgzvbn/2pJdXV8lyw==
X-Received: by 2002:a05:6512:39d1:b0:5b4:7457:be35 with SMTP id 2adb3069b0e04-5b478be7a69mr420646e87.3.1787122963578;
        Wed, 19 Aug 2026 00:02:43 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788e7928sm278013e87.64.2026.08.19.00.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 00:02:42 -0700 (PDT)
Message-ID: <52580314-6c4f-46ef-97a2-39ee6ac4098a@linaro.org>
Date: Wed, 19 Aug 2026 10:02:42 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
To: Liu Zhenlong <dragonliu2018@gmail.com>
Cc: linux-i2c@vger.kernel.org, konrad.dybcio@oss.qualcomm.com
References: <db94c578-2bfb-4297-9955-fba690ecfe39@linaro.org>
 <20260819030354.49170-1-dragonliu2018@gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260819030354.49170-1-dragonliu2018@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 06:03, Liu Zhenlong wrote:
> Hi Vladimir,
> 
> Thanks for the review and the Reviewed-by!
> 
> On the cast: I considered (void (*)(void *))of_node_put, but kept the
> small wrapper.  Casting to an incompatible function pointer type and
> calling through it is technically undefined, 

Exactly, according to my reading of C99 section 6.7.5.3, paragraph 15,
I believe it is a cast to a compatible function, as I've said earlier.

> and tegra_dc_of_node_put()
> in drivers/gpu/drm/tegra/rgb.c uses the same one-line wrapper around
> of_node_put(), so I followed that existing pattern.  Happy to switch
> to the cast if you'd still prefer it.
> 

I would not insist on the suggested change, as for me both versions
have incomparable advantages.

-- 
Best wishes,
Vladimr
