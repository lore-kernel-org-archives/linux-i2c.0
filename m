Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7D546983C
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664414; cv=none; b=UD8r2P7R0VmDM4rtT+JCfk8W3CZYsRc/itTwusnXAZ6nbqtTwNpBW1WJcOV0WNwRC/ENBLrXBSLecc0COpO/mSw7jwWl5p85kO2VxV2spdZ+apCGu7Rut4y1ZETg7/iGnQxf6+AFtUC/IRVpeaSRto67CfiI4ypSmEfFsw/3iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664414; c=relaxed/simple;
	bh=9/3kMz7oD10d8hH/1927Zsh3839HLOBI3rMLP1VBgYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTS9g2FIERkNXmAr/A5DRDyz0wyZ4hUJw+a4pwCGpKtCay2SC4/8Kr1GLztvo0n7TgWB9RsKGDnGNIchOtorktphcZAxh57yRDKUmjH1Yf5m6j1UxMz8EbKN9vtJkQAKi+sIyetdQyEFAZUUVmLWz7Pvr9Xkd+W7HhoywQK+zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c16794450aeso703419366b.2
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664403; x=1788269203;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nkaEb+Y8kcpcVv/97rIlADSPio9zFKmAgHXudGugDJw=;
        b=GuAOR3A5ofbkWh3hJrn21QLzk5tCnwOVCy2WWK3BSlFIMH800ZHLWmL0ZsuMG+cOS1
         e9pvVE1aD3FhutVsJd2MvyyV/2AaqUHVRgGn7wGXjRdF8RbIGuKrFQRhfezWpN1bMjHy
         cJACi6prijGCjFgwsDYPsFPsk/0X533rKfSM8M0xlhtaTQC8BByP26ExtkIZtNAxuskm
         vQS3EoOnfjg2PM7q5i5hDQpT9bj9UINQs6dhWSoGePqtHydNaVtAp7u0+B29ueLZtiLt
         rVhA1+N7c5OU91a+R1+Z4vhXCPRJoeCgu2Gvv32w8jGWPYOJWZ/w5SqHm2s7UVmXIQEC
         lDNA==
X-Forwarded-Encrypted: i=1; AHgh+RpuGdebCRHElX0EHcMGGKot/3tYdX70T52Rm8phqzPyioELNZZiDdoAoh9VyEguQjxuV5o9k8fGNdg=@vger.kernel.org
X-Gm-Message-State: AFuF++lq9+DTOoNz7v2KAWknBFADJNVUiwL6/INs2gEBko590kdfHXSI
	hDLe4FhXz4iKvlpaUVwIvpcT1En1/Agn51zgi3tgy77g8++5NuDOjj1eikI3EALShgs=
X-Gm-Gg: AR+sD11lbzQP0aubqzQiCUfrcz7aoaddUGDlaCGrR8zYiYlf4ZybLYFPIx1DRjr8470
	wC2y7j77ZCi1Ihy72ESfwNMTN+RJxU7Ord7DmnYMuvQzEhI2hhqZQ4CpbkjhlmNyRa8toRuJiX6
	k7gusS+8W/Hmv4rkpSI4eKHXXTMW+wlC1xK7MGB3EgEFamDI1ETvtro2KcZLjaWpJTMOyR9w5sR
	Y71Ae+ddjivmFdrwi2RHxhmMDmTjDjNuFsnwLeUl3IRboKGaE2XRuR6pSyi6O58E6Ub8uivYeri
	vgVeWOgKlbWOHjaBsP6YBeylX9mrV7Z3q00l7n0la5dfxwVPIbKRHXyB7IS4Y0ChQ//+tY7X8CU
	ho+Y/hpp5KtIPx+CMNvLLGonicTJZF5lDBSr0xFTOBWJTifTXrqrxBKA8VjFwagNBb6N7OHUEd9
	MZoYZkr6c/w49Efo+J7PDDBOfMH/5mgciFm2HSaFEfhQCTjqaseNcpyQxXPXlc44VgC2iCdcJTm
	9N6oYVGOIRzVvjKZclQxcKDIg==
X-Received: by 2002:a17:907:9603:b0:c07:43ed:1b3e with SMTP id a640c23a62f3a-c2469f9a365mr3933083266b.0.1787664403258;
        Tue, 25 Aug 2026 06:26:43 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8edsm1772891966b.6.2026.08.25.06.26.42
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:26:42 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so8764390a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:26:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr+8J0pGOluanpeJlz0vkpLE4C7xbac7fIqLV7GbAANVwsdfKzq9rpr9U+BGCNRd647fT3TJZjdenQ=@vger.kernel.org
X-Received: by 2002:a05:6402:3647:b0:6a5:7aad:e75c with SMTP id
 4fb4d7f45d1cf-6a57aade7fdmr24471444a12.6.1787664402461; Tue, 25 Aug 2026
 06:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520131206.932050-1-claudiu.beznea@kernel.org> <20260520131206.932050-5-claudiu.beznea@kernel.org>
In-Reply-To: <20260520131206.932050-5-claudiu.beznea@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 15:26:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6i-ywN4TZS2TcOV9C5w2m+eB2_jXOn+qijM9MJjo8Nw@mail.gmail.com>
X-Gm-Features: AcwNN1X0RJ_J31vKT2WoIR2711Efguy7FqLWJRN03sI7-8E6CO9lNuf4fndEPi8
Message-ID: <CAMuHMdX6i-ywN4TZS2TcOV9C5w2m+eB2_jXOn+qijM9MJjo8Nw@mail.gmail.com>
Subject: Re: [PATCH 4/4] i2c: riic: Drop empty line
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, wsa@sang-engineering.com, 
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 15:15, Claudiu Beznea <claudiu.beznea@kernel.org> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Drop empty line to follow the coding style.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
