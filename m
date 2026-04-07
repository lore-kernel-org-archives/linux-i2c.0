Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32B24EAB1
	for <linux-i2c@vger.kernel.org>; Tue,  7 Apr 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544365; cv=none; b=jd2a+zznpyAez0cuCeQnp3v8kiljaB8KQlwtwtkWIoutV6/BkVxtRSZB10murQvzQVeICQnjowfysag0nz5f5PovzZp7QUwfRX6SDTlPbro7sqdc1WC0rXX46cx5ydfAOI9Wx9VJJ9BHOchtBr+9Cke1XM8PR1gjdVqQURCsLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544365; c=relaxed/simple;
	bh=HQrrDxtcwGK/iFtT/P2zPZVACxKuiHJKiRSBVfBJrg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3F1dr0hXY4n/B+/Du0iqHV8GzXycozeUTovj1urYkI5Vl3zrNBc5pmIvMj0nUzRgXehSCcskgKUI3Ndqby8poo1LkpduhSonsDuv7/DdWKDvZjb5/2tY2FtABzpaQ4YULDFENt+MzSLA2eIpUpWu+ljHYIXzh2EpZLmz7xE+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjKSvIT2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjKSvIT2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2429f98d0so30063905ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 06 Apr 2026 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775544361; x=1776149161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAMR1Z9vtKESST/3iamBPofUUiGDt2llp0rFYa+EoSw=;
        b=cjKSvIT2zTtOhzSef/a1Z7cwD50mwrbaenkO6Q44QJJ2cphkSbAG2+GnERqh1721zL
         DJcxJ3YfDMqb1mudRRiKAD1oplFuIMCMDFnOzro9Grd0Hjs6Km1EV0Eg33gCg+U96/kb
         T1t3lTWYGMz3vCsG461UUO9Dqc8SWOUz0ADRz81XKyOSNvpEg4UsN9/Se7cMcsJ7lh3D
         RLxC4Xjl/AJbncBd9RhJmkOzaCDmWCVubgs00+E3Of7WOZBi3KIhJBmj7vcYcYezSiAH
         8vgw05S4+46dnm3pYy7R/NQqmNK9U8PJMdQlIIaewe2u9fcDxkqMTIYbIvROZhW++Ear
         MMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544361; x=1776149161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAMR1Z9vtKESST/3iamBPofUUiGDt2llp0rFYa+EoSw=;
        b=g9oVqnyd/OoIi66NqLTgxZbor1UzUzD26vWVo7OS2vi45t1d/oxzx2bUykLadzFKk8
         0ElY6v8VMo1esCsoxKb3yzFNVXvAGUvYzFisEKVjNAKDva0hqDKuf/M4WJlN6bYGVmSA
         MoB1yLKUE7TgviaobNzPToVa5LDcwBwEQuvEYGRsGVMme+iYUkFbR6Z8haDQBVZV11hO
         YiBDKOrLudHw5DApmttR+KeI1GbYHjNtzyW0SCfeQJt0JATdAMohR/XESYvJ1TfXGTIj
         Mdz6nOIW0c2j5QHnrZJkW/9OLx7nrSclTeVL1zH9hkDyXh7VZ7ScjilhUhxaqXwrvg21
         etqg==
X-Forwarded-Encrypted: i=1; AJvYcCXuAi/iQCNmGrsazqc3g08YRT/6PF8znyP6DQcKv3HjW7b4FVQTr1tj6mSnjLSXGAKwXllYNnAI+kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1FF1MPhtKroNXLxwUceEI+eLjmMkR+IfcJp1FptkABPuyqfA
	mmZIlatjdgYdWLX5BqaYR9rPj6QIyM+MGiYXVVtDtLh4GJNePIRd8OYV
X-Gm-Gg: AeBDievzx7SegIObB4CBZ2BIBIy4QksKyHm0xzPymHIUFE1QAlTlbpafnxcPeO6npJ+
	+8+JBfR6eA/rqjxij8ZlWxxiNdkEnwVgXpklcHNymmLzffv2vunvpuWOP1x5lwyEpcPFnVtn1VV
	KbJRGWJDKssVSrGqZ3miq3fyGccmeKCLIINwjIHx9XFPzOGDZ3PdtYCCnHPoaeLT3HieSbd3LAa
	PCZW4aCH4/po8n76oJT5iYBLs3bFoYQbCckByXt3ZAyCd2/Y1pBRkgfibWIjFpJLmt/73/xdQhn
	Tf/i6BT1QDiHa5Sv1VnU41Sc8fmHvxpnDk8W6zsh4QLLVqrcea2hw5QwzyU5ZSZHWxa5WnKQLNa
	0+YIJf3LchTsiro3kWoy1dl2ibsP5ZlckNZgK5EWMFsp49OPSatHKbnAs+Xb7r4u5seAOURaBUw
	Dm2awdHkkY9QLGWc3mf5bFj0736IqHb+QBpxPSKCgR17ixnGbH4vsJzrvyA14JIbR5Sojvsbc=
X-Received: by 2002:a17:902:c943:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2b2816e6c38mr156290835ad.22.1775544361064;
        Mon, 06 Apr 2026 23:46:01 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm154607025ad.61.2026.04.06.23.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:46:00 -0700 (PDT)
Message-ID: <289da0f4-7a08-4876-8157-5226a0598f1a@gmail.com>
Date: Tue, 7 Apr 2026 14:45:59 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
To: andi.shyti@kernel.org, ychuang3@nuvoton.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20260316063726.41048-1-zychennvt@gmail.com>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <20260316063726.41048-1-zychennvt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andi and Krzysztof,

I'm following up on this series. As detailed in the change log, v2 addresses the feedback from v1 regarding the modernization of legacy code.

I am preparing v3 to address minor formatting issues in Patch 3 (DTS). Before sending it out, I would highly appreciate any technical feedback on the driver logic in Patch 2 to ensure it aligns with your expectations.

Best regards,
Zi-Yu

Zi-Yu Chen 於 2026/3/16 下午 02:37 寫道:
> This series adds support for the I2C controller found in the Nuvoton
> MA35D1 SoC. The driver supports controller and optional target mode
> and runtime power management.
> 
> The implementation has been tested on the Nuvoton MA35D1 SOM board.
> 
> Changes in v2:
>   - Overall:
>     - Rebase on linux-i2c/i2c-next
>     - Switched terminology from "master/slave" to "controller/target".
>       
>   - Patch 1 (dt-bindings):
>     - Simplified description and fixed 'reg' size in example.
> 
>   - Patch 2 (driver):
>     - Modernized using devm_*, generic device properties, and FIELD_PREP/GENMASK.
>     - Optimized power management by moving clock control to runtime PM.
>     - Simplified code by removing redundant .remove(), .owner, and inlines.
>     - Added dev_err_probe() and default bus frequency handling.
>     
>   - Patch 3 (dts):
>     - Moved i2c aliases to board dts and reordered nodes alphabetically.
> 
>   -Link to v1: https://lore.kernel.org/r/20260302020822.13936-1-zychennvt@gmail.com
> 
> Zi-Yu Chen (3):
>   dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
>   i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
>   arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
> 
>  .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      |  63 ++
>  .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  18 +-
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  60 ++
>  drivers/i2c/busses/Kconfig                    |  13 +
>  drivers/i2c/busses/Makefile                   |   1 +
>  drivers/i2c/busses/i2c-ma35d1.c               | 792 ++++++++++++++++++
>  6 files changed, 946 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
>  create mode 100644 drivers/i2c/busses/i2c-ma35d1.c
> 
