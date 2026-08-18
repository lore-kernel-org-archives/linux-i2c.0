Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8E18FC97
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063342; cv=none; b=FmRPph/dIVAU7ZuEAPzE5OB1rhIgdTTuDg7gZfrjlKxgirnh9McqIWZoLO+ix/mAzB2G05pAhPjdcM6Ys4xKHC2jgQ8nsTIJ0Dz0wCfZqHRRQx+Ssm+iie36p+JB2lghEi8WjYswdsNPjFHAiuW14UcLnpWrg3kjzToi5ykxvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063342; c=relaxed/simple;
	bh=mie0nTDpXVpzdLJv114Gdf8KQXJnlkj43PK47MND8r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nANu2uX3kXb+zqT9QWQWJn+ft27HaSNs8giNIFUcdBIJShKPgjCckaaXolPIsRVKIkNWdIN8E3wWBKUHVbb6wBX90AmgvobP25hgqeCT23Fn2onGsrsjaz1Q+ikB02CWFyu0+GHKerhgQP+gA9Eyl9+6HvSOL+Sns0JH60aCjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso6819560a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 07:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063339; x=1787668139;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Thf+EPoHrsWTegx4PKx5P1+Bl2bUkRvVPDASspkr+Vc=;
        b=NbPHqm7uMqExLY5+75XXRFkuJjotgWRMA/6SPPqNosCfc4q7rOiPWsIFNiP4q1HLqg
         N9iS2yr562w7Q5GHSqZzoZWBNvYcO1saGfz24zIzhFT/9R8ENuub3rRfnGYQP7rdhrSQ
         PaoiioHSYYe4q0gSFJUXKTTab766kh+D5BROQOHDUa9yVQqEcV+VXfTyELfNco49F4uP
         t6TLcavydTTM9PXWMGNi5KAB7cirGJN8DgBOy+EzJcdneIc5Du45nqg9cNkJB1HJtj4b
         PU1/U2ZfAwmtPcR/vV4/kGo1ZPO7p4vVGYc5VU2XxmJZheIzm5WckjzcrO0AOkSKHcE2
         /P4w==
X-Forwarded-Encrypted: i=1; AHgh+RqYq67hOwORzpFqQAHxXacxNVr4G/BSfpOAlODkmdk1gio2SPUNkXU0yPKtENZZZQfwZzso6df13Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiE+WLUisUqDQ/L8QwVXnfghdEKxFwcPRQAZb1vhWB9NV7yf3
	4v8oqIAu8YfDOaznNJ7rPFjpJop2mPMsAlzTIDnxn7pmOJdz0BihvGtxsnhHcSDvMdQ=
X-Gm-Gg: AR+sD128rGNuGbLDXhzCkG24+yAZLzdCU/GbZTJCS0qZBFJz+mx6PlNHOLCQ1JjZpMv
	AktXypx6RMIB3Ik94ISvoU13SGrfvIHxg9L8mR5lTApXybaBpjhAkEVsMzvA+O2K4BAF6riiOX4
	QWrOBlBZ6TJxKhwbxBu9rltMeXlECVcJfgMzzfKz3INRe4kW+7XivyFq1wbXzBDHwMqf4uO0X4O
	C0AkjnkYc2/ylj1aj/8eyscVcT1BdpbFR13tg+L4EA4pp701d4c9s3WPAfMcLbHBhoYCcAIhY0I
	V1KK5bwB+cYIwaXssY07NyFqcFnAM73GyHgQokCgnrkngkDorNhANJgXmwEGHrtrmC3gK7T2Ae2
	CL75tpaRyTdphGMVh6eXucVWd7C69hwNvruRfyF/GtU90Jk/bLfe6rs05BCNuhCmHLIWqU52YrJ
	U7B04J80A/1bxXyGkl5UeniYjjvIg7/nlUUFthXzmyIb8/Rr7lhUbE1VBKiZHMVtyZPQ743bClU
	AiRH+8dwhBaTIxyhPjTvcxmgA==
X-Received: by 2002:a17:907:d08e:b0:c1c:2c32:1163 with SMTP id a640c23a62f3a-c2188ac8fddmr506237266b.25.1787063338781;
        Tue, 18 Aug 2026 07:28:58 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe7b854sm206690666b.4.2026.08.18.07.28.57
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:28:57 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso10258968a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 07:28:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr+GsiOvxcooS0FeXdFOXdB+qPeDJhut/rO2oR9D1tE1ByxVS5HmdgURWp126vCHIqM7VEx34Z2Qeg=@vger.kernel.org
X-Received: by 2002:a05:6402:e85:b0:6a3:edb6:2228 with SMTP id
 4fb4d7f45d1cf-6a3edb6285cmr3102580a12.17.1787063337203; Tue, 18 Aug 2026
 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>
In-Reply-To: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Aug 2026 16:28:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSpmZuDPDzfCzvKbts+=a=savqD_mpf82TS6XyZkZu=g@mail.gmail.com>
X-Gm-Features: AcwNN1VFrPk04Bohn1UQSujmmF4EIHRApBL1V6XFH-gGP58HhymsZ-nEzcsLZu8
Message-ID: <CAMuHMdUSpmZuDPDzfCzvKbts+=a=savqD_mpf82TS6XyZkZu=g@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-rzv2m: fix runtime PM cleanup
To: Jiawen Liu <1298662399@qq.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiawen,

Thanks for your patch!

On Tue, 18 Aug 2026 at 15:21, Jiawen Liu <1298662399@qq.com> wrote:
> Update rzv2m_i2c_probe() for the confirmed driver lifecycle defect.
>
> Keep the change limited to the concrete operation shown in the final
> patch.

Please write a better patch description.

> Signed-off-by: jiawen <1298662399@qq.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
