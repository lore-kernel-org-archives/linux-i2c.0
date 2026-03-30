Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A23AB284
	for <linux-i2c@vger.kernel.org>; Mon, 30 Mar 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858405; cv=none; b=elqkjwASj5NeVydNLqknHFeWN/UR8jHOWZRmnsmi5jL7EBQPkWXuwwkWYnBYNwUr4jueG7WneMoz07s7KBJ8posM9Vdm0pnAvzMfGNpiWCcP5XVXJyKfJ/tNxRO9uH/xPwg5LFft2Zd5pfm72sWmwY5BgUjXAmdiNDZJiIN58AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858405; c=relaxed/simple;
	bh=I12ZMybdCEL1+sBz0zjm69FWWXF7EDYCmjxzXtAD94k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo5t+8jhGFKJRj+wNhpdpBGxS7R1J/y+lpoe+ySF2oZ4diCFG9BiwoU6egi9cPiDG/9KO01HmLODBXMi5k5L6iuye22q8T+G3zDZaFHQAIkfvjeKhysh1eF/Q/7Iwcb5X4EJHhRKZWQfr4etUXBUSi01qIuQYQ2y/QP2gmXljjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tL+M+z57; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL+M+z57"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2adff872068so16702285ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 30 Mar 2026 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774858403; x=1775463203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+Rk6xeRr6lRsoXLZ3DwiTNhcEH4M7IXDtOiENwg6TE=;
        b=tL+M+z575d1R0sBj1mM6TRmQHBLzYYguaGby+0QYTCjNJEINCNuE9QU9RwPPahNmBa
         qWwajrUOjOhAcNCr69w0jfJmYML7NDH2ZSDwPYz35l80MWsH+TuQKiwhEa6nfHV45gCv
         CHst1Z1tps9KjjIWX54tW2lJLkmv/V8DQjHRjADKwpIhTjUxux9o/IKQiW8ZunkuFDp4
         4EALq2GGI6MtCcmODEbHhJM4umVs45yVDcsmg92T9+ictOv/3TYRIReIR4X/8MJLuBw9
         s4SoDG1EYAw7eJbz3BeGGn8U+dIXy3Djv9toMjO4PPJfMiD7gverjM1soGzl457OgfoS
         J9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858403; x=1775463203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+Rk6xeRr6lRsoXLZ3DwiTNhcEH4M7IXDtOiENwg6TE=;
        b=Bg8GmUNo4VuzI8WBqoD7txbky/ldQor55QPRDCWl5CyL/UcQKoim3gYWoAnNoQE6Ml
         Rn2MFfXPei/I1PRULA0OTCyggP9TbuJjiXY100T0flhoe2erh0EI0iO0NGjLV20ivckP
         +dPafhu5t00IKPihfZAfKjBAAw8O9lVrLxQvtZ3D9zTJQXDjoZtQjHPi5yd66s0OxpYr
         ubvUiIKFzwpdaCR7VDe0VGCyaRVrgyPIuNhfB85GKEbhJ6rulsP1Obk8rCeZ94+RKNOm
         GpktGEbH1hSyL+sF5/voayLdhBxegUuULNHxUQYYkE9gnV8y0vlFgXAOmjElyG1f84Zd
         yOaA==
X-Forwarded-Encrypted: i=1; AJvYcCXfltzenDnQCOodo9dV2DLGAQJv4wILwJLgwLaNj+Oc8DRs+5blVRqSAwK638KDspzJABNXb9qt4/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6cgylTMgr1MlRSpLGRTPmp4b1Zq0+vvG1NDJ0qU4TI22Axed
	hDJhsy4VdvVgB0KEKy90STsjNiQAgzvc3btITERPKjAMPJsBRPopsOPY
X-Gm-Gg: ATEYQzyg6zIxeYZWKaCsz4yBLhWfxwYwUj/9/x/rLUx1XKh2Qu2mi7N4XpEU6B88b/b
	30jWJ4YPypgPx1PIpb32x1kUC2Yne5hvGFS6cZgytW1lS+fA4Pnoxm3QLMeD4WTvDvNaEhc18od
	WJ/jEmg/NXoEJzjfMjCjA+o1DZepGyIrU89I8skwJjx7hFY7GaAsTEasjUOTSkiHJkTitSGklbv
	n2fMsql8SRApXwL7AprYeL/axv0Rr8Bm7akBkVFJ2zVvX9oRXg9CUlSQw5XUkkxg3ia2RESKQWE
	lxE4uIrTORTIvJ/Ye2Iv4fxFwlhSudRyiNXDG34N45jIUzp8QDIx0y08iiVGOOPEhJVcWfsQVnr
	1PPqInt12sr20XbcE1I9HnRQEezxb7N+CBxxat/fMqulo97uAA0aexb9Dtz0a0bxFPapb4SBED9
	Z9gWdN+cxSIkqSvSetpvE=
X-Received: by 2002:a17:902:f611:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b0cdbf72c3mr120475445ad.5.1774858403197;
        Mon, 30 Mar 2026 01:13:23 -0700 (PDT)
Received: from fedora ([122.173.26.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm5745435a12.23.2026.03.30.01.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:13:22 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:42:44 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, andi.shyti@kernel.org, conor+dt@kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com
Subject: Re: [PATCH] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema
Message-ID: <acowfAeFD1dK0Ei0@fedora>
References: <20260323174236.147507-1-i.shihao.999@gmail.com>
 <be702ca9-e3c5-4b45-8592-966bb5b31080@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be702ca9-e3c5-4b45-8592-966bb5b31080@kernel.org>

On Wed, Mar 25, 2026 at 12:20:41PM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2026 18:42, Shi Hao wrote:
> > Convert the Conexant Digicolor I2C bindings to DT schema.
> > 
> > 
> > Note:
> > This patch is part of the GSoC2026 application process for device tree
> > bindings conversions https://github.com/LinuxFoundationGSoC/ProjectIde
> > as/wiki/GSoC-2026-Device-Tree-Bindings
> 
> Stop here, please.
> 
> You are not following the process and required steps, thus you keep
> sending new patches with the same mistakes.
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

      First sorry for the inconvenience that i am causing. Just wanted to
      ask that what went wrong with this patch. I have just send two patches
      as you requested however i am not sure about this one that what i need to
      fix here. I would really appreciate if you could tell me what i need
      to change also please spare some time to review the patches i just sent
      and give your guidence because i might have messed up again. thank you
      for your time. Thanks a lot

Respectfully
Shihao
