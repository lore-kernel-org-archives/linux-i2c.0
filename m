Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80624397A
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438537; cv=pass; b=OSEpsrIiH7AGKeFQKwbTgtM0kmEdYHUNYmZkKB5xu/cZ9cHj8ILtwOFnLqQvDKB4K4g1vAMohayYlSQsk6NM+vvJ439Vp2tNqoe/FptV5vVfxVEMbDaRWNaNpqFjMu/7Sg7wOdYXSNKOJ6OGZzuikusEBaeP7sVPFVXnj5PFioA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438537; c=relaxed/simple;
	bh=+ac43UU2AUQrSK97u9UGEOszTRTdeBowAhfRrskEKl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjtwK7xitWzLsx2D/ClxLANi02G+1qicGwlgEv0BmBt2778VNe02SnJf2xREQCTkqbXKZPYAyl1NYPiJjN5Ayd5H7aZs0WmEEf7HdYR8ibULCoCxxXicLYOUovxJ7pQnx+UlVz6JP7P22C8vv/lzltISLfghVYxacl5do4zvbjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ6UO4Pc; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ6UO4Pc"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b972641eb96so350908666b.2
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 14:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773438534; cv=none;
        d=google.com; s=arc-20240605;
        b=MBjuVpDGPlLaXMjAoSjLFEEOomTYr5eSxs4k0LcaBBiopcrIPvuXlUn6/1pIz106et
         Edx9W1fq3TvsMD6VQXWCtGgpXsjk33rqUbok94KxoE9TXJrPCxZw1eWMuYVgVk0BOBw2
         KbXpb0Qrm2ZvM/ulLoEWmIClPXbUccIyIVtgiFC6ysCav+2MJI5fyjUnVQ/gGq8FXLGC
         rDAnc07Qx5Unk7nwQCMBUk9YPsp6K5EjhznPlDolm/P1XMsQ2K5dOVrTbBEt0kqHWSbs
         EaVzpSrlAI+36bsppzxszTXA6PO02joIomekZnJllxGIdCbEEh3GcYpt6oavCuxT+yYc
         Zgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=og5m3EI8g6Lkpx9tArNrMEyQTpBxjM5bkfRM3pMy1BU=;
        fh=1WTmiXFT7EZRMo0blyyQ76NCTvaZVS/ggZ7G9CQJkxw=;
        b=M6X9TYHCtEmWjUSqfiKHFIzdAdKO2n6SvgNEe05CZMfjZvJRO8rFDTb1joPlCy7EPE
         xqa6VwjgGsV6+AP81iuSPz5bUhM9HndtwUwXwampSbN+i7DPaCO0kqDSbznSbJcOaLa3
         LPDqFTRzHDGPfVcy7gmrta+pLbLRsfw+4uTOgzIYmW99D3XjSgE7a/bbS8PAYRccVGEB
         r1/r+u9gCdqINlgFRGX7ma1vGlMemx2XCDn/Ziw7MRxPxvWWlKnEmI6tReGSilkoOvLW
         KR76wljQmd24ojMFG458qydmLFAvnkWhbnli4s77roNUtOcLcbG4pVjxcTLPQudG3+XM
         FhUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773438534; x=1774043334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og5m3EI8g6Lkpx9tArNrMEyQTpBxjM5bkfRM3pMy1BU=;
        b=IQ6UO4PcxEv3rvX+xeEUU+rAojHW21nxxZKLikbbUoKsxdfevikzdsweD+fN1wb5uL
         1Z0rGEntEfVr2G6EspEudhkmkoh5jhqFbu5/vdaDjp8DhGvo0G09TSbYllIJVNH4IhFD
         IC4BJpR+kQoaezcxPJAGNmidIJ3jH9Dknveu19Uz468iozLrWukTFuof1uwfhlG9thqW
         5BnUoY+55lXG5Hmgs+MSfBwAfvzsdzUfte+TKgZH4Nosi5pyI0230iUdtdKhYpYGWosu
         a4eJ9iYKEeKkN06xaBx3RMP9qSaaxa+FKGXen+5s3dOQYiedcIqo+i8vPLNcBWSJFRt3
         620Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773438534; x=1774043334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=og5m3EI8g6Lkpx9tArNrMEyQTpBxjM5bkfRM3pMy1BU=;
        b=FNtFfJNFcUXjKneMBpdXoXU3kqgBrGE9zpQ1e8LaZDH6MbPCjwoy/1wHDSU7yMtYGw
         GcoecMcDUxxbHY7z1NPs+ZhNPgN/nBnC4jO8XbGPJZg1BuU9apIg5U+r4pZ5ScVPlT2g
         BBTz789FBzjifcX75f/65WnQHKYscUu4O55DPNLhFiUzWox2168D7gGT1sDp6E1WGLE/
         PO2lsxWeqF9oX64nFCLhT179sFM1fkrxDADnkssXhh6kwd140FwG+kLYXvHFPzzH1gom
         eQABTPY3Uo+aSCveVcwZzWmRjExpaao79fM1V0vSV9A88MSMUR+n1C+hlnlpdmJ9nxky
         ZgFQ==
X-Gm-Message-State: AOJu0Yz/trpEIBqo6NlPfrnnZSzQGGcHSWd0jSO6r2iHoYB5bJuWZfvi
	Bf1qWF0Czq1xnyRunFX6WtNM5d4S2O6m5VvQgieX1As0ymMXEOZBybMva7Waetpck3EAPEueleS
	6MCVmknZpBCuVq8Uoo52hBD7wSF8SDSw=
X-Gm-Gg: ATEYQzyBrQ88fWGE04Sqe0RTV/NoyoIKxTBDIaX9tN+UEKZ3ILIiqGd9ot7zhYHN6Le
	97O75XApa0DPb5WW032S8zdqj6/La4049VNV1H3xufjpR58eYhNcNuWuPrTtJYMbqLhlsF1XGc5
	O4FDpmgZg8p5P0faDeqo/PtmdTuqUG5s2MxwhY5atcwAwaOkTDtgo3xGXAbW1hvTxPeeEre9vS0
	8vozP9kk9txvnlsI27qP7i6IxhsPBfsntNG0Lf14zVPkj4/OF5N2SdZU2Jx4hcmnZ62zPJwyv5j
	EC+AHZQID0ecA5nUA09gLKS9v2sYGSkWGR5yPjb0rQ11hW/5nCnEELCFwmNKLvtFPcF+iR+087S
	7bwq5w3IFOtk8VhtH
X-Received: by 2002:a17:906:2099:b0:b97:896:7c4 with SMTP id
 a640c23a62f3a-b9765352484mr178298666b.51.1773438533882; Fri, 13 Mar 2026
 14:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313002308.119343-1-rosenp@gmail.com> <DH1I88QT17NI.1MZERF8Z4M6P5@bootlin.com>
In-Reply-To: <DH1I88QT17NI.1MZERF8Z4M6P5@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 13 Mar 2026 14:48:42 -0700
X-Gm-Features: AaiRm51_uufIP7vby0iQyhJE9Np66DA5ybD5UNuzVwNcO2sPLvT_d9qY5sI1mJE
Message-ID: <CAKxU2N_sp+OGQWr_+vjHmCGfe+FDA0=4ZNJ6+MgThbbXU-3Aqw@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:23=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Rosen,
>
> On Fri Mar 13, 2026 at 1:23 AM CET, Rosen Penev wrote:
> > Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> >
> > Add __counted_by to get extra runtime analysis. Move counting variable
> > assignment immediately after allocation as required by __counted_by.
>
> Not sure what you mean by the last sentence, you are not moving the
> assignment.
Yeah, will remove.
>
> > --- a/drivers/i2c/i2c-atr.c
> > +++ b/drivers/i2c/i2c-atr.c
> > @@ -58,8 +58,8 @@ struct i2c_atr_alias_pool {
> >
> >       /* Protects aliases and use_mask */
> >       spinlock_t lock;
> > -     u16 *aliases;
> >       unsigned long *use_mask;
> > +     u16 aliases[] __counted_by(size);
>
> Please reorder the parameters accordingly in the kdoc documentation above=
.
Will do.
>
> > @@ -137,22 +137,16 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_a=
lias_pool(size_t num_aliases, b
> >       struct i2c_atr_alias_pool *alias_pool;
> >       int ret;
> >
> > -     alias_pool =3D kzalloc_obj(*alias_pool);
> > +     alias_pool =3D kzalloc_flex(*alias_pool, aliases, num_aliases);
> >       if (!alias_pool)
> >               return ERR_PTR(-ENOMEM);
> >
> >       alias_pool->size =3D num_aliases;
>
> I'm not really sure about that, but I suspect kzalloc_flex() does set the
> counter variable automatically if it's annotated using __counted_by. If
> that's true, you can drop this line.
It's automatic with GCC15+.
>
> Otherwise LGTM.
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
