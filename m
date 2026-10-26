Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004130;
	b=wlATlgo/0vt/9EgweatceSNSeXP8FP4nJHglsWKsip0du/8ObmIwWLA19P41Z9SPxS4l
	 oIWU40ugQkHUKDNGKPuLbj17LTz58iHQvSwipQce+X5p+T/YAga3088rWbTgw7njEksN+
	 yWq7ir/grKhF/2uzkw6/pKVup7ILdNC6tUr1Nt5QQRgKGpINICGPWvtfnxipcWsD9iC6x
	 SVQpQ8bTQsNWi+kTf5ESHYW5NMm4V7fVjzAqxBGEAjWIhLK3L8RU6dthN73Dz9C5cQq7D
	 FfMPzlYV5kpFSK8KomblL2EThlMNnw9DTG0ONyVDAPkUU4A/tx1P4FD62LZPkBcXEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004130;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=qzSDOlgy7IPmTrnuWw7M56rTWdyjH9dWqupudfVxyvk=;
	b=sj0PF69DFbF81vuSUtwuwPfL6C/ytoZv3Zm262GOMWLlYlqlp+Yyk+ar6/apFYEceRNa
	 cM6MzKtthH7lLA2ZZ9lGlTisaJ8iXB0c585MMy9KJLdJDmWK6TjTMOvek1mMoWXDf6kGX
	 rf+LMdFLvfL6pF4v9IQbnKZq5CrxR8+8kR3DxxpuhVBarGpnSuhO4IqZ017saH/PtVIkO
	 qrjZ0N7SuvbVvpR/0AEay/Ki3lMxYz573KmnLhZtGUIcZ4mcTrs9CM/BgotMnBPSNQWTp
	 z4WuVaUTqBx2mVCYsp8uopVXSqEdGmEsTQjf/oUXtbPu9hvNcASPtdXtrniiak/p8pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48911606A31A
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 08:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48911606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-990703f817fso1547627241.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 01:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004129; x=1793608929;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qzSDOlgy7IPmTrnuWw7M56rTWdyjH9dWqupudfVxyvk=;
        b=Uuj2QHId1EEeHDFnP1FoHtuP1nvTZpaMlRaBd0puF7etirO7ahce5l687RDeNBDp8K
         8G9BzvcsWyGljQk8Z/CJCbVroxRZWYKZBF+SXxE0tWxTvIXKwAs1cx/OhPHmgiNBj9RW
         qeM7X+3XuQeenHw/9AaqFbryFPntlZQYPPAQMapQUn9DUcU6LSQBRrKND8ANWPqadHf0
         EP1gF9wGoIM9t0bbHZXivIJulpvviUkjnbNqNpn+01zuxQjLFFLHVEwh6QVs3i7HEW+l
         3ootdZN4PwxC2tZAduuyDLGdYBxheQkrzKoKP4ckBNDdqAWsKkLt9AfSLFSHl40rxtPC
         v9tg==
X-Forwarded-Encrypted: i=1; AKwUvBxWaVdBuIslvo/ISZnkP6o3/3Ybb2c96xQo3eaI2U6Bm93zeXpmcONk5hDOheKOf53fqdFycsZAIUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ283gPGjlJCt5LutS9e799z9X13Bh8PgorRsCZVEVuRkGImAx3
	QK9ca01RV2eJhF8s899LJQhFWP/0UhaaAE81pBCXlcfP2oKzgWLN3U8iGqzoMWGV
X-Gm-Gg: AYBFou34ptzylYNWTiOgsi7pIq4FnFVGapAmtDU7hqkr4wxwlE/1gN41dhTeS7/YTR6
	eCAFQsB/508nS6Dq3KwqT/l57Zw/BQnPcgoMt4GOmIH+T5RHQsHroMMnwPTTf1k/XQ06qkgc1kg
	K1vTfOmHMWd4paKOXApiTgYMgCnCSHCVlcEOtVX8a96k4x2eka0WmoIoGNwbTmlRS66iA0O5I9b
	fm8mLbZ7FAKmGMr++7GoLtmy26EfGz4svWoEmfsUlfBjGv28LB2qxUBhmg8g//UKplv9iBBXDRk
	Y/PG4EK7R30bxOYr/YrRbXNdmZA+IR3iYh70MdhMsunvLawfp43rQl9yobD0oQXpRfQ4fvC7s5S
	O6KEwe6bhqp+7/uS8atZmfcjJKm21vUROidcCV3+PR7n7tELOoGYEeJwlTSlqHo2rgGCt5Tbd9M
	c8Vt2ZWJzVDxskKRxU9TV78hhS5e5uFtft7Iojc++COt3tzv0nLDRWw2o1UiPlw6gGmevl6I1eF
	qRSDWfao+Dh0M9oYB0Dv1EpcPl/FBs/BIXYzk5BKeR6AN5uq3ROPe9RszW+0MA6G6+JomR3sw3O
	hQyTkPMa8E95hR4cxg==
X-Received: by 2002:a05:6102:6ce:b0:7a0:eb10:79b5 with SMTP id ada2fe7eead31-7ce5cca862emr2715930137.10.1793004129304;
        Mon, 26 Oct 2026 01:42:09 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e6cfa14sm7441097241.1.2026.10.26.01.42.08
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 01:42:08 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98ff53fb739so1721744241.3
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 01:42:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwz/Ug9S/VyDXQLua5qCJ2BdmireOdVHe34cYLd+MBCTn1DxdzlwCZOxBk9ceh3CKVaDh2yFvRqbos=@vger.kernel.org
X-Received: by 2002:a05:6102:4b1b:b0:7c3:ac79:9b09 with SMTP id
 ada2fe7eead31-7ce5ce62789mr1802171137.30.1793004127932; Mon, 26 Oct 2026
 01:42:07 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017233416.47b09ffff48f.i2c-sh-mobile@gmail.com> <atvUWb-PzouZzL5D@zenone.zhora.eu>
In-Reply-To: <atvUWb-PzouZzL5D@zenone.zhora.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2026 09:41:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXnJqADrLwGHdcdbAF7LTmcevhhXeuiDvThjjnnmdg-eg@mail.gmail.com>
X-Gm-Features: AclHuK-70od6XOcmvqKR7Sl7Q5xoAjafCFmOmm0SnnlxPySBXQ6b06PhHFeSvys
Message-ID: <CAMuHMdXnJqADrLwGHdcdbAF7LTmcevhhXeuiDvThjjnnmdg-eg@mail.gmail.com>
Subject: Re: [PATCH] i2c: sh_mobile: request IRQs after mapping registers
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, wsa+renesas@sang-engineering.com, 
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Oct 2026 at 00:09, Andi Shyti <andi.shyti@kernel.org> wrote:
> On Sat, Oct 17, 2026 at 11:35:16PM -0400, Myeonghun Pak wrote:
> > The managed IRQ handlers are acquired before the managed register
> > mapping, so devres unmaps the registers before freeing the IRQs. A
> > transfer wakes its waiter before the ISR's final register read, and
> > unregistering the adapter does not synchronize these IRQs. An in-flight
> > handler can therefore still access the mapping when it is released
> > during driver detach.
> >
> > With forced-threaded IRQs, the handler can be preempted after waking the
> > transfer waiter and before its final ICSR read.
> >
> > Map the registers before requesting the IRQs so that managed cleanup
> > frees and synchronizes all handlers before unmapping their registers.
> > Keep IRQs available while unregistering the adapter because client
> > removal may perform transfers.
> >
> > This issue was identified as part of our ongoing research while
> > reviewing kernel code.
> >
> > Fixes: 7fe8a9993337 ("i2c: sh_mobile: devm conversion, irq setup")
>
> Normally, I don't like taking fixes that don't address real
> issues, especially speculative AI-generated fixes.
>
> However, this looks like a harmless reordering that seems
> correct, although the issue it addresses is rather
> hypothetical.
>
> I'll remove the Fixes: tag, since this is purely speculative,
> and apply the patch to i2c/i2c.

FWIW, no issues seen when boot-testing several platforms using
this driver.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
