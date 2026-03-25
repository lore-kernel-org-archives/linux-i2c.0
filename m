Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEACF3CCFDF
	for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444820; cv=none; b=QreIyXYSgAPaLfFpn+2OzrAbAKW/l1oO23hjiTNRovu9w1NKYn0T3Sg98m67nMZofPHbb5ICOdHO5hQogqCdT+f658H05Btxy9xzkp9DpFtQ7aQnzt/Z6Al8ALp5qiAXQ/2j/VT6iY0Gex7rVXAL2FN8ddf5/6z2zXZuw/SfRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444820; c=relaxed/simple;
	bh=8OKtuZUHYMcCm3anyLFXklzdxMpproKBUw/yLg5vFyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wm5bW7len64/DohB4u5815cZYT+lDafpf805YYkWU8+Jf8n6Wjs73d27kX0etTyNCIZcCYrRUFVbxf/4eGHcWeleVypqIwYZXEZgMoWFrdQvFV3pfKgi2LpqIteUV3TlRiVX/jDoP0w7MMlchrP/xP1OazcL/Y4WLQx4CRYqUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6FZAy69; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmMc829p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6FZAy69";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmMc829p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774444819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRyCtRyiP2wwgn3R3NnCHPYbolki/Fqd18W5MnkvIrE=;
	b=V6FZAy69PruQG13IiiLe0r2+60K4WC8szf5WnxUT5yAcpjl7IIZJ71ud2zmiHd1JlMBHEw
	ZKsYhUkp46yGvE5IJRKT8u7ETUaUaPcLQC+NJDcvUeT8ssaqrmDcCB2pjk6Xb18s9LjrdV
	yIlTSUS7rlPcSnEMBqH9sUFf60yvCQ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-PQTlEPIQObeeF7mFuAerYQ-1; Wed, 25 Mar 2026 09:20:17 -0400
X-MC-Unique: PQTlEPIQObeeF7mFuAerYQ-1
X-Mimecast-MFC-AGG-ID: PQTlEPIQObeeF7mFuAerYQ_1774444816
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439af7ba802so4825587f8f.2
        for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 06:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774444816; x=1775049616; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRyCtRyiP2wwgn3R3NnCHPYbolki/Fqd18W5MnkvIrE=;
        b=JmMc829pnBiTz8NUjDuEmMSTiaZa1m+/cs8WeJ315xfylCAA2ZEUhFUqS/FPrZN7Pb
         oNTknJyHqaFjs/XlKEX6t+foc9XLt1Uxc9fUNLZLsZKieBKefhBP3f6RO02cBIUnim1j
         Dy6jN0Q9JberXcojueS644EDnds9IpXlMVEAiVC2EO/d2NJ67eW/JGYQNXDPMvWwLSE0
         VdUYg5gzCnWl4NyfuWC8q+jAajtPN6AEjEV+m7nfRwJ66hcNY5Sgpf0WE5NhOlu2adFa
         z/JsTjaZun1iPZObBcLXudcghnjTy2pGD1fc8hcH/+o0PaOWQCa4N1xzn+Rm2XqeW9hW
         z0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444816; x=1775049616;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRyCtRyiP2wwgn3R3NnCHPYbolki/Fqd18W5MnkvIrE=;
        b=NoLa3k5MfIJM1r+tZSY5PByrePa+ZgdbmYYKN7yNjr1+MPcoYaHEtseaDttj+6Z+FQ
         EagvQAKPc9lwiNIVrc4gq09pcrsoypxR2cB6vcupp5bCi8rpFuFVB+vmLJiT96t97sWs
         nfOxIhg0sgLqMyLgQ5f2a5WlyPwK8v1VQibWEYpbQATcMSKvlt4c7mEpdaJwp42E1JIB
         0O8vV3hURCmklKX4aw6NW6LT4j+0ifQikbHwxeI8F6Pm7lkd87UgJIhXEeRvSC4gLqpa
         7+evukoqsEnRz5mGH+/YCP70YIvtd+MWRpH66n8N+Izge/Vvwm5eM5dFkhJibwedJXkN
         JZfw==
X-Gm-Message-State: AOJu0YzCBXhiZ1mVgrRonSLbkzd1E6hDwVPTg/SIxcrTPej7DbbDSJTb
	iJvCfgLACILTiYqXRxs9gnz4lG3pxyOQzGCFBXGs3i/GzaXuXh4IYo+KVDQmJ8FWCPai+HmgqFW
	rS9dOaKZNcDPVrpunWCg9IWlr+ilsdl4nmnwH9Qs4BhtNDjcSaOJz6NO/DRHhHg==
X-Gm-Gg: ATEYQzzbG+2vp6VPTwhoNz44lAmoFJUu0+ITTXYPu8k1+scSXLCjZaLColHEeA3TbLN
	x+poM2745Lc9N+VwByqGDEqqwTUuksrcyTNnOxkmhefeYmwgseGUkJv14VWFejeFNaYbouEKx2m
	UuzDo3Ux48pB0CkngSzFkpahdkvIwWcb0Q0c47WK6PN/HppZch+iJu4LbYxR/G7G8lKICjokkWx
	M9cYglgucBwwHdZS/RxCPfX7uMOKUTBqNM3Ha6NmU1y4Wv+O83xrQX1P3dj/hbslwftXuQY/HrX
	cL+H9Oh4H9H9drhTSvqs9Qx0KZM9SIHFjW1nBIxGk8jM/kDVQZCOAX4h8Saehj6Ue/a9B/wnBi4
	xLid/hMsERw7ptVS1HIvv88KDIXAZg7f+dRvUAmq14PgWYmD/+nOsTvSBlLLCJG2PRhMC49zv8m
	eJhNDs
X-Received: by 2002:a05:6000:2dc6:b0:43b:6955:54c5 with SMTP id ffacd0b85a97d-43b889a872bmr5150941f8f.17.1774444815949;
        Wed, 25 Mar 2026 06:20:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc6:b0:43b:6955:54c5 with SMTP id ffacd0b85a97d-43b889a872bmr5150862f8f.17.1774444815376;
        Wed, 25 Mar 2026 06:20:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b8567b2e2sm11278629f8f.33.2026.03.25.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:20:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yixun Lan <dlan@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
In-Reply-To: <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
Date: Wed, 25 Mar 2026 14:20:13 +0100
Message-ID: <87zf3w6o6q.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@kernel.org> writes:

> Add a compatible string for the I2C controller found in SpacemiT K3 SoC
> which use same I2C IP as K1, so make it fallback to K1 compatible.
>

If is the same IP as K1, shouldn't the "spacemit,k1-i2c" compatible be
used in the k3.dtsi instead? My understanding is that this is the meaning
of compatible, and there's no need to add another compatible string for k3.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

