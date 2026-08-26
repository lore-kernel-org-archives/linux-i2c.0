Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1C3B774D
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731775; cv=pass; b=M73RfY0C812UwV1Lp759XEp08egzvCIwJfnndPuvHY8peHJih9ZmYxQRRvmtfIfanM8/F8N07teaMFqjjuohcoFah7sB/Diw7WfsBw1isDWrZg4tf/nT9nSkuvbKzS3yjL+pRcEWLrmOmHkKiCF27J6QzpKkJm7Df6AyhcTg/wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731775; c=relaxed/simple;
	bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssxA1sEksYQUjEYwEm5EED00eWaFIlhpliqovFx5D6B+G711UbynsTtQ3zE8CEaMunLdGNyv/Bdt0ykTtD4wpyHe0pq+4bx2Sr2btdUTT2kEcEN+lhMSEH6rWVR/vQ/u2HesHx0ZYD8lS0OmHdTTQz/oKvG8rzixCN9UOkne3KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/HUr/A8; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/HUr/A8"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66d116f0de8so1010628d50.0
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 01:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731773; cv=none;
        d=google.com; s=arc-20260327;
        b=kuXYQrrmYmtkoKs+LochdPiwF8+os0REsc31QK6crsJYL4p8oaxHOnCLwfXBTbCozk
         R7YAFZfSwQ5kjq5gsZmDJjTftUtMgyHRwTsL2iprhwDEjiOrSrSo5nL4oMHmhyUJwDAX
         bMVfAqnTLSw/N3I4LOEqBey+IDju7CgYO8OTqEDhtGTad52UJDcXEHdMb/T9JHtZ9SBU
         Nq4FRPErE53RxlpaNDg5W+uxE/gXT/Y0P5FnORFMaIsmBO1GQZP39dRLBIk+YY1L7qBK
         1sfpEmowtlICB39mLMG3QevLAGf3L9ZiyDW/9ksHudNj1CIoQPbAhN8F3+D/04CGMeWa
         iewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
        fh=mfPL1EMcVkUCBVemi5ds6PnKiRCRJA8ZtAsVQjOyGhk=;
        b=pphjWFuttngoGsEwHv7OwlFaK9aY9OJasFCRV5nrlzZzeYwmONM27Hvp8U425uHAfY
         pLf6iIkRMvquW4BYYpKlNGEaDQmwPtW95TMz4NgIsFCNfSCItsCpC0qxLBQpkYQvlSp2
         aQs3jgUP0d1lABTAP8273GssmXUfYk3bhwZachHGcSAx7AYrqqVz4JbeNQFtP1Hb9MDD
         y343tRwQlZ7/4xlrMRqkgPt3WbPbYpZUdjh/l2nxOqUUDkuFDjPQRS7QoFA2Zu6t+YbZ
         Uo1EkhTBIAD/ZaW9ndtYVYcu76+OlGJqamDo9nSPqyFgsxAhQxTTQWW1Qfnl0XYvzrus
         7MfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731773; x=1788336573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
        b=W/HUr/A8wHZCnvFtrb245HWJtPBllfFhw64O45q0k2OW8fbbBu9lZCD836e3Js8nE6
         DOEtW9aPsXrC7patNZK9K9f6bUn7+423xtCqst6Lcf2dqsUb40QZaIhb1eu8Ls4095SH
         ExyfFIy/doFsafTucwtAWs276H1gpdZEY/QdwnI+yD6ImHlELBQ3TpOMsnEbRaeVU78r
         +mcJwcPwqML4zcWUVfCicBK/OG86AzRsAWX13juuzW0slVR+6ok6cfNM5FHCVq0f8YWe
         p0t9Eev++EDuDIry0EX31zG8k2sgMsuC6NkWjOQyCCVOSRQciDJ1qcdVxHjABj5+xrmW
         duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731773; x=1788336573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
        b=f/eQRNPCkotAu5fRccxlGKQ8K+Pa/fsB9nZ8qqQNrAb2e2T8DJ1p4qU5PV1lObd02w
         /hosguufDB509+aB0sM2gMnTFGLWPrFIRNcFPQiuq4OEa9EsGhThYlsYeT86OGFmQSZ+
         BoheVkM84FwEClQK475LNEMkRhUV5xRkNXy7+8Yeo2xleU2kiZBAvhI5ZaAls6RCbVBb
         AClA9c/lm5THDlCB+iPSqewdMd2j04V6capcqfjKwHVzmYb1jXS71jOaz5+qi+FSIxe2
         1amXZjOhu+97O9guDu+fBl6c+iv3l+5dN+Muo/4dozb8me1t0YaRb8WhBSHJTGEiyhPN
         6W2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpBDtvACwRF9pGBINRInOU8QHgdxprNGWKoqVxwbp8DL/L9H+2+KweIrETlzJKo9lpFLInlNwDBTVU=@vger.kernel.org
X-Gm-Message-State: AFuF++nKmmCv9abIAyLynhUFsZnAMBIVO/N8oXnqZht2wKqmdyzPLAEH
	l5SgAtWjJgMOqUk1cq3q+v33qIjJtnchqYf63F26JT2adm9hvl74IGT5vZsgPt8J7ejCAW0HEYu
	Vk2BsPnwb19ymhwWG5OCTMiMgS2RyTQE=
X-Gm-Gg: AR+sD120rgOo5UbXlpwA3SoK8empvr9QxlB8+0/So5fMK8SNIpF1Io6TO4wVkK6Vbjx
	qerYuttFimZauqAdyI08DIzyrpkvSY+ZApJhmk3ag2xuB/MPgBXp2SPEDwUmPDOsTmXkwHi/1zi
	krcxMc+pTRZXV8kYr1WPmHiRYvdmGm2AVxwheaSlhtMXwJ7p35AoGlYRVHefYp6x+kqw06+oe0K
	IhbU1068eDEOJfdcNw/99QZAi9u2sMS5B8dozKyCLrpM9HXDoQfMmvS41Nw/1i+646ktUMvDt4B
	IRrCjvIBzzE5zwIiEEqkEPYj19sG0G0ipKt9CWZ5YYqZizI=
X-Received: by 2002:a05:690e:4146:b0:66d:13ee:2daf with SMTP id
 956f58d0204a3-66d257d9e4emr1314684d50.43.1787731768110; Wed, 26 Aug 2026
 01:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808152654.2943371-1-lgs201920130244@gmail.com>
 <144ef4b2-a200-4634-a4ec-539a0ba9a15c@kernel.org> <aogYAmDqlgmnEd3X@zenone.zhora.eu>
In-Reply-To: <aogYAmDqlgmnEd3X@zenone.zhora.eu>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:09:14 +0800
X-Gm-Features: AcwNN1UWlYeU_Fm6Vv0GYzUXavNzpuhA_CQkuRUt3KOhhAYuo0_VKS3Q7UQ3-ug
Message-ID: <CANUHTR-eRRw+uHBzAK42jVmnfEv_zV=_RgPGtiBCjZzjr4PJ5g@mail.gmail.com>
Subject: Re: [PATCH] i2c: at91: fix autosuspend cleanup during teardown
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ludovic Desroches <ludovic.desroches@atmel.com>, Wenyou Yang <wenyou.yang@atmel.com>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Fri, 21 Aug 2026 at 17:22, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> On Thu, Aug 20, 2026 at 04:50:13PM +0200, Krzysztof Kozlowski wrote:
> > On 08/08/2026 17:26, Guangshuo Li wrote:
> > > at91_twi_probe() calls pm_runtime_use_autosuspend(), but neither the
> > > probe error path nor at91_twi_remove() calls the matching
> > > pm_runtime_dont_use_autosuspend() during teardown.
> > >
> > > If the autosuspend delay is set to a negative value while autosuspend
> > > is enabled, the runtime PM core increments usage_count to prevent
> > > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > > during teardown, this reference is not dropped.
> > >
> > > The documentation for pm_runtime_use_autosuspend() also notes that it
> > > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > > driver exit time, unless runtime PM was initially enabled with
> > > devm_pm_runtime_enable().
> > >
> > > Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> > > error and driver remove paths.
> > >
> > > This issue was found by manual code inspection.
> > >
> > > Fixes: d64a818859af ("i2c: at91: add support for runtime PM")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> >
> > How many separate I2C, drm, crypto, hwrng etc patches you sent?
> >
> > You sent vast amount of patches, all separate, making it very difficult
> > to track and respond in efficient way. Do not do that.
> >
> > Group your work per subsystem.
> >
> > You were asked to clarify and respond to incorrect fixes statement. I d=
o
> > not see how you clarified and responded at all.
>
> Is this a kind of LLM command or what?
>
> I'm going to check only the patches that have been acked and/or
> reviewed (people have spent time for that), for the rest, please,
> follow Krzysztof's direction, put them all together (or ask your
> AI to do it) and resend.
>
> Thanks,
> Andi

These patches were submitted manually.

Thank you for the suggestion and for taking the time to review them.
I=E2=80=99ll follow your and Krzysztof=E2=80=99s guidance and group the pat=
ches by
subsystem when I resend them.

Best regards,
Guangshuo
