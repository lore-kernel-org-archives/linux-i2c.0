Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9174F4753
	for <linux-i2c@vger.kernel.org>; Fri,  9 Oct 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576993; cv=pass; b=QN0o4n6EPDny3akRR2NdE4iXSol6rNwHvEr7LoakQQtpPyieUd3Qr6M/UpElaoVWgNzqOdwGN1qkILsIpAR82YBDqDg5w6WxF/peMoYgFEJM39WFvoZoIxYZh63kK4yvEfhCFivMaK95U0kbYXkTYs0ABb1N71DC4KTO0ST+mEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576993; c=relaxed/simple;
	bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3XhT1ZQq886Gu+sPgPrpdTExNU6ifo1ueBTiAvm1jjxAhIozRFXMCPN5nm9K/F6YInprpu8mPGBZO50UZmOUf/S6KBbZC+cb7NMvm9GfIZpAb5nPAd89X2YcgIWIG+kJFXBMzWW/tQhiZ1IQtBgmh2iNnyl5uDaZLz912LPJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=J2PJsXPj; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="J2PJsXPj"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b06c0794cfso695867b3.0
        for <linux-i2c@vger.kernel.org>; Fri, 09 Oct 2026 13:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791576991; cv=none;
        d=google.com; s=arc-20260327;
        b=YotTi2KH2Ui1f2HXc2TeKlzhJvifNDdjeN3laUM4WzPDCrIa6BswgK012ZFRZBXxOo
         /vgu1GwyzRGE+qVeM4NxhDuoVr0LbHYeJLsGGd/a++bNXFYtxAII6oP2uqGRu14yr8+Y
         M+518upQMgNxv0mHyEjmolYbm6FPf0Q7Ye9ythMQh168WVYnHzK/jee+y+n+vB9jH97N
         nXqHCrY8QHQwfugNZsQ5u9ijw/M54kGvvlU4Vc6V04IsrrgdntAVyMHWT389SHf6bApt
         BB2jsC1OaCZZ3m7I4eOnWZRVY4o1EN/1H3u4qWpdQZURgNGSDNrt3FjWScDVWCn6on96
         nonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
        fh=/JptvpZZB7+H6yQNQOKp+GJhQzOgO4Ynfxzq2gvO9U0=;
        b=picIKvBqPetC1A66GKAM1UJnAIwCD0iEV27BsxvPy1zjiB/Lb9TJDjHwf7mBkVkRPF
         sxvPzKYYKzD8aQ5Po4IsaN23Y/CR5w/FIIBMbujTYjbLW7WI56kXFpixlWtR70jjufMe
         lMJQjQYjxWHREeIQgtKK6H7napHsSQGVsr3NJe1Ozm3R8gsQZybCxzZ281KeFpcnG5U3
         0IheFz/TNrmAi338HiHJyzRYSsgitH0A7q6La1T+wl6ch13jjH7Eu8/ajga9arhX5cRf
         XJe82ik/i4Lluk05ioqJTEEuBiLCbTW+p7w83Zm3in9jfS9tgkNPJAipZgKQdGopRQvM
         wc3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791576991; x=1792181791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
        b=J2PJsXPjVseJD/FlS1ey3Ik6q6O/j9URIcuzNuHvqwAAHUIdkHiTbCsZYMoNDZxVyx
         CqsHyrbhrIwLF/udZUSYeV6KwoWW5PRSyZW359Af3xOlvMX/qI+BPXz1J07q25rvTVeJ
         wFu8WbOQzfdR9A/0FWTtr2WyXZq40SjQ/iom4j+52+gjKu59BWljoJCMhm51OKojrjg/
         iRa94YEeowQF2FRNep3TLaVoT936kzrZ9Cbg0nhRWiJ0LvMYhvK9TIRerF6pc/JRFTOg
         Cv54jBZTDLUC+2yZJ6u9QdTSq3pCvFTTkEycQAfDqMws1Yq/lTmZYJn+Pe4UGR194c0V
         2IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576991; x=1792181791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
        b=zHlskI0q7x/UPpIKCUHw8xgPDFQHZPF0niTkgTbd27J9mJF09Aag5gpPVE2yrTS1RY
         XDSMretVOQUFBKyHZq4GePJn5oOxh5qnGBFWuOJZN+PaljxE2aupg/vK/qQUzX+vVbrr
         2E/5xHzhXhjB2f28wRHeyY3JG2Yv4DwdxyW5qqmzVAQtNlBuE3uiwBd0HJOZGAeOXgm8
         0hPd3j7tsipMxwCCZYEpMiOLz0cdHR+tllZVtxQDapVtcNmKOp1RTZL4xEq2qd+LCr96
         xeVc6AEa09JjEvG5ibVGsVWiCW1ELcaA3KOgjEiH1AgJbAwpiAuUJOgVLNc6WkOM2kfV
         i5Sg==
X-Forwarded-Encrypted: i=1; AKwUvByheOjdSn0foJ6/22dF4MPwQH7vErNXKVK3kfXU08X4k7IDX13hVIPPGUNcGoonqLbxCzHi5+OlJmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnUFg0irtvdmrzq74abUbqBxVVPNQiGrKxODXOgIPpoxW7onuZ
	moXF1SuYhxw/us5j+a/Lu0Uf5c2pOw7lC9ajG0xA5sanxhiAiS6mSYJaR40QywcLQrU7oRw8LD5
	svkAXXspydlbkkxSIPHFuW9JlSymgAstLLtTB03RjfQ==
X-Gm-Gg: AYBFou24UO2vGvHittsNETPgiPWaKiY2QwBArrIXR0tnYjfkF7wJZSJgy/5Z8K9Cd4h
	PBlGto9WFU8FzbFk0cFFzcy7t+6wtzOOyEy2FhD8ftfIxfhBLCSjSFW3LkEbGGP11gB+Ec3X6Mb
	QeOBToA+SGMndze2ZPv7cy0O9qDfHjs00BSqlr1VXCQ9uK8F6i6hKV4rvLcaO7XMxPyCjCQq5oa
	W+ursyipR2plH6fmVInK24VHLb1FsO/6ur4ILelC35GW4fekaNCBzdfUcs7AJeiwrEKQ+mVaMyI
	9/eJecjPJANzwTy2q0KQfKnbJS7KjRhjJ8Eo+Lox1oLj1fK1sX/Z62k=
X-Received: by 2002:a05:690c:7483:b0:8af:5430:23f3 with SMTP id
 00721157ae682-8b07edcf030mr14065407b3.19.1791576991277; Fri, 09 Oct 2026
 13:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai> <20261009145800.rc-reply-0001@kernel.org>
In-Reply-To: <20261009145800.rc-reply-0001@kernel.org>
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 9 Oct 2026 13:16:18 -0700
X-Gm-Features: AclHuK8NoU9nFQdsnoGWTbzltxdeCAjZZJguqpmO0Y-nucjuamlvwsTRrY9h3TM
Message-ID: <CAGYn4vzAM2RVv3y5qW1C3P50qYN5J7UKmj-LsMDv9EdqrX=G6Q@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "i2c: xiic: defer RX_FULL until all trailing
 bytes are in FIFO"
To: Sasha Levin <sashal@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Siddarth Chilukuri <siddarth@nexthop.ai>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

Thanks for handling this.

Best,
Abdurrahman

On Fri, Oct 9, 2026 at 12:01=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > This reverts commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7.
>
> Thanks for the report. I've dropped e6fe3ea04f01 from the 7.2, 6.18, 6.12
> and 6.6 stable queues.
>
> --
> Thanks,
> Sasha
