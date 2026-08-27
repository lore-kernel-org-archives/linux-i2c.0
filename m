Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AE3A5452
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817577; cv=none; b=ih2Xan2yEfoBdx2fe5H/ILzVVXmqzQWGIjcfxDK3KrvOPPqbEHaYRMSAiSjZcwWkZynIS3XiSfA+OkT1hq5LXwxqr11JUqKtGTsDZ1fso4WmaE2FDp2sCY8modudwbeKWx0rJJBbytgnZdobnmRgOFOXy6PY4isyGhXG8rs+15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817577; c=relaxed/simple;
	bh=AhF4RXSyKUiCoAAAkiY5QzzA273/YmWbFz5K0WcWd3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEzOT8BIlVQ+25b0+yp0nZNEnvRTfam3FYgJW14hEpO6Ow8kpgtTmZS3O63UbK6M48AAWLR2gxi3NAidMyjZqg0E53HB35D+9tYiI2ulApVwwJhB5I5u9+vx7RfRwOS6zQRFc/gaGwLbMOyl2wZ+KvPwe9fp+NqZCNBSujlL3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-783d429d0cfso839577137.3
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 00:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787817574; x=1788422374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=veOq8nn5oPUxcnaWxlmevqsZxizj+SHbK8Mk08fVSFc=;
        b=QaDVW0pTV03uJCLSVlMMD+gBpa/ZhYR1UCMsCdIiP93a5L53/wMNiAjaVBFLl1G8eE
         nRVCKiEOV0GFxs6H2CKIKuXVqUMev4cEZJpYvy7Y24IxLox4I+8Z/SGYs0IS+6lgOK7R
         H4Ci6IXl18FHi/cPfY8w31KE5hog9XWyUIkbh5vfWGU8LOM+ScOb8gspF1diVhjcJIFz
         zJbXIv6KXTFmEGEZ4j8jbogIp966NU9qWWLi3GHZpQVuu8t1u+Waw2OEuQTFakORIJmB
         FEtoM+bz8Lpp+tRT4TJuGDutDToEQX747YoLjv8MapcVRcXvjPkyMOZZZBjVUAb4WCzm
         xAyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqykK9sgakp0NZkXqMMgEAK24kLl/dMNXKtLQNJO6t5tkYPj2Tf99AR1vMJowX4HEJD+NKrP0dc3dM=@vger.kernel.org
X-Gm-Message-State: AFuF++laXE1ShwKNmfAXsGRmDVbfMjLGF0uOQUzxSvIXsQNLu+SjpjHG
	Gyi2f1qIfXsKNsj9ZCmuPOLQgY1M1b0q9znHgfedRl5qm4S5jrzATvU2qf0w3cgc
X-Gm-Gg: AR+sD11f3UCPyblZYKcgFN+wDvN3Euqq2BkpVsDmSk+yyAQG3aLGpeFNoICswD3WpjX
	ARFXwTIkcwSb2Y1J8NQP406sxz/+RvGsdRm4B985yIYBscQbhz1B1CRdRl4Ikxzty1GzpohIg37
	oxW7tYQH5aukcmTCr71tMlGDiyWKxp5jRdpwqmklN4oU9c/trhboGr0L3Uo/8s2+6fJck7sZlKB
	vRTyE0tQjv8+IHhuoq8mG63+gMTOJf3WbMw7+hHC7A5S5vusenvQ6CAnekb4lJ8XulqocI7tJXD
	GlD1XQKWh1IViTwIESMCkrdFpuvMY09XwS8ikjzESYszK94iaF+Y0Ee+TdEIqWyYZeX/7jzeB9s
	FhkGMa79N0EnAD+PfTQ9j27/p4BiA4XPzyoGkYCAhqigAX06rijAbpeDKxQvSBxZB3ASfjKYjER
	PjLBsCK0CKT9fG2v/FQSQO82uFslEgHcyaCFfABblZGRx+LhmEpt8NpwWSQASHyd3Z5UowiCkEL
	Tp3zQVERrP8cWEaaLSXGFrdAQ==
X-Received: by 2002:a05:6102:868a:10b0:784:a169:1958 with SMTP id ada2fe7eead31-784a16969eemr510690137.7.1787817574367;
        Thu, 27 Aug 2026 00:59:34 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97cbe311309sm3974473241.9.2026.08.27.00.59.33
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:59:33 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97bf90f4b41so989313241.2
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 00:59:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdwH6STvWJw/LBl9NSkuZD1ZkhWHLDroqZiwjTrTW1hjJHlpARPAQLLYAiUHXxvZgJE8V0y68GNRk=@vger.kernel.org
X-Received: by 2002:a05:6102:162b:b0:778:459:f215 with SMTP id
 ada2fe7eead31-782bf9a8e38mr5448748137.3.1787817573651; Thu, 27 Aug 2026
 00:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826083524.6056-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260826083524.6056-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2026 09:59:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXj04QoxituCF3wRcyzN7qZrVBn7-ukNkKDd0OfhB8zOQ@mail.gmail.com>
X-Gm-Features: AcwNN1WaiSSDv-J3T2K0-5_UW8SuowFlCQq_EI49heAklJYMtVZ13OyYfT4lCnw
Message-ID: <CAMuHMdXj04QoxituCF3wRcyzN7qZrVBn7-ukNkKDd0OfhB8zOQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Wed, 26 Aug 2026 at 10:35, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> R-Car Gen5 can make use of it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
> @@ -83,14 +83,14 @@ properties:
>
>    dmas:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

Shouldn't this be 8, as there are 4 SYS-DMAC instances, and I couldn't
find a limitation w.r.t. I2C and specific SYS-DMAC instances?

>      description:
>        Must contain a list of pairs of references to DMA specifiers, one for
>        transmission, and one for reception.
>
>    dma-names:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6
>      items:
>        enum:
>          - tx
> @@ -137,6 +137,20 @@ allOf:
>          dmas: false
>          dma-names: false
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,rcar-gen3-i2c
> +              - renesas,rcar-gen4-i2c
> +    then:
> +      properties:
> +        dmas:
> +          maxItems: 4
> +        dma-names:
> +          maxItems: 4
> +

I wouldn't bother adding further restrictions, as these are not related
to the actual I2C block, but to on-SoC wiring.  DMARQ is just a single
signal going from the I2C block to one or more DMAC instances.
The number also differs among I2C instances on an SoC.

BTW, all I2C instances on R-Car V3U have one DMA pair ;-)

>    - if:
>        properties:
>          compatible:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
