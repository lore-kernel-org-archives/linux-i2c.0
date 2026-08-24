Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80728466AE6
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589217; cv=none; b=Rt2gpCQuykE33/MVEBUsow+FoUCu9nFCgSFHlnpSE4KL9pi60GAXExwJPkncUrYRXJ2GbAfW5N5l0LdNHBdiNDiL0c2D2JK3SgFkeg6j8EhAUH9jHTDne/Rg5SShWNJdA5bvSsfLr77/nUOO9bz4fM1Q+WdvQu2THmJNWR7KRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589217; c=relaxed/simple;
	bh=w1JC9dewX4WU3I2ZIVZo5liBTzcNvJohtskdnXxXOdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSbstHLP8SyjzQ5MT7OQzVed0mlWO6O5lmpI8IXHaF7luJnXebUyHhJiu0FL2L7KV8+FYl+NYQayyemtO36fFbADYMfkzYKbGcXqhQp6mISNLsONTy9Vr7FyKMF2Js/ljntpRkLHykNttFVKzNSUkO6MqLNn+jlzOApBAB55odU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XbXriImG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XbXriImG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2020421077so634623566b.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787589213; x=1788194013; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sX2KzEm5ebg5NoXaGKqMog7fZOixXtskSxkIbiEjjhw=;
        b=XbXriImGNFpasMA14yQePadQXhDmxWKKsPZJPbx7uroxkdqwGiDvOm6nSXlgjqkMvl
         flW/qoqCy91Rkw/ABSTpsdHLLmvX7oI1Te59bUZKQytGHw6JxisFBrVlK+Xx1ewytjJg
         M6FBO/2wssE0L9YbdyuVD0seZl7VxthiGtrpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589213; x=1788194013;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sX2KzEm5ebg5NoXaGKqMog7fZOixXtskSxkIbiEjjhw=;
        b=oNRmce9l5ZieJetcFXY77po/izITAqsVwsiHojvnW6JGaRmtM/uxE3528zi7UUwvNW
         QDS216yzvJShOVgJmsQxbjFwYtOtVWtxboHReVSLZMMKSZK+rIpHjfVqoWL/xArwk3qk
         TJcZDOLqwT//N6cgRcCKKOsTEj6QBvPMgsFAcX5NauvTLQDRqMAZYgYWss54UkIBs89g
         l/64J8jKO3eIq5ImoOC+oVl3lcbYfHVeEUEr8TRim4ZZVVF+J3JqHKrI75VvY8PQDXRT
         1RefBneXB8bQsj1Bt0BBrEFSLcPBBC7yjKqNnUb0IQ6z03tAGToswtL3RnVMYH4lP98J
         tIbA==
X-Forwarded-Encrypted: i=1; AHgh+RopwdLg3NfX+m4gAHZt9x5eQRy+VoJOrY+LF5H7IASpzNYFGFBqlLlE8YcZYz68GItuRnN1ZN/iUAE=@vger.kernel.org
X-Gm-Message-State: AFuF++ku4qUarqb1MEF2NA5qYN2I6zj1obHuB4vccU/jXVLdfLCT5PZ5
	MVTQb5Sv614IwsV/X4Kr60dz0xcxYsc2vPLFzapH+xFBs1w8nYCr8U7Lk/cbwJaQ3P27X+ksuIr
	5J+S+Wjw=
X-Gm-Gg: AR+sD13ofdcAWMNKhXD7rrPHTQqmC/lmtlw45ch4n+xqJlWgfAB4gpxsUnmh+i4HsYU
	upvCp4upjTn9DQYqM3P3/y2vXoKN8ut6nZDK53kWKPxKCZyLQ/rLFdrUUKvK2UJdSIEXJK2dbfN
	S59A5e+mzhuFA6IAls7t90P/7ck+BUs7rW9iJCnZlq/jcTdDSj1aJLGXM2PG8+FlIO/4vuw0DDu
	FDoz64K1xUz4caHidDV0t8BCINRAmXSD3fw2a67bXJrL5zeOFrbnmqfHMqD6HeFzTyqyIUA/aPB
	b3x4kEVfsIP0Y44RlpfizLtUuImvcxwwAMh7mrdrIjmW8wRzpmHGstetVeZtxh0veTRcpi0Irz9
	+jz8WYXISAjz/TQ02/mt5iO6mTZ4+rXmTIayH3trRTzKd4qQbD7MBOv+iN4PIO+jhLgJtEiHalt
	Fmmqo3Y1axwAFxBWPNjzhlMNCowevo0cUybbCGnKXvOByd6x4M0zwaTQYPQWlNWPhCPd1jNfXO/
	BwRjNCRIUZgkmq1jdm/xl2ASWbntG/onrfJjg==
X-Received: by 2002:a17:906:f5a8:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c24920d3c7fmr2134623066b.20.1787589212547;
        Mon, 24 Aug 2026 09:33:32 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296cafsm1386041866b.14.2026.08.24.09.33.31
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 09:33:31 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2020421077so634616366b.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 09:33:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqfru2xLNo/A1Y2W9N4T7kawce9HcxoIiER+MrEAoTDIrrFMPLRsx/uPuZ8Sz/kOVZrTak/b5umTIQ=@vger.kernel.org
X-Received: by 2002:a17:907:3d02:b0:c21:8a0f:56dc with SMTP id
 a640c23a62f3a-c2491c2b1d5mr2180551366b.4.1787589210994; Mon, 24 Aug 2026
 09:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aowtbUKLY8W2kln8@zenone.zhora.eu>
In-Reply-To: <aowtbUKLY8W2kln8@zenone.zhora.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Aug 2026 09:33:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDJ=uKf99U0Fxcii5=qE_Gk-AgR0Uh9G0o0eQ-9HDf7w@mail.gmail.com>
X-Gm-Features: AcwNN1VRMFFRQdPUqCKu_ZqT1B-8zqPQQXLEk2Ihomfn5kv7vWBueTDaxoKXVmo
Message-ID: <CAHk-=wgDJ=uKf99U0Fxcii5=qE_Gk-AgR0Uh9G0o0eQ-9HDf7w@mail.gmail.com>
Subject: Re: [GIT PULL] i2c for v7.3, part 2
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 04:55, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> (I added this short introduction to the tag log, as I noticed
> you copied it from there in the past.)

Yes, so different people have different models - some people put
everything in the signed tag message, some people do all the
explanations in the email as they send out the pull request, and
others do a bit of both: the tag may contain a summary, and then the
pull request email contains some general commentary.

It's not a huge deal for me which approach people use, because I
typically end up reading and editing the merge message anyway. Partly
just to try to make the merge messages have some consistency (well, a
couple of different formats, there's no "one single merge message
format"), but mostly simply because that's my workflow around it as
part of reading the pull request explanations.

So it's not really even "extra work" for me - massanging that merge
commit message is in many ways the thing that is what I do as a
central part of familiarizing myself with what the high-level "what is
going on" is.

That said, putting the short intro into the signed tag has some
advantages - if it's all there in the tag, it's just one less
operation for me that I can mess up (most commonly by just forgetting
to integrate the email part of the message as I do the merge).

But it's really not a huge deal and there are no really hard rules.

Sometimes there's no summary (particularly if there are just a couple
of things and a summary isn't needed and makes no sense), and
sometimes the summary is all there is (because the details are just
not interesting in themselves,and the summary explains the big picture
sufficiently).

And quite often, I and submaintainers have different ideas of what is
the really relevant part, and I edit things to what I think is more
readable anyway.

In fact, the biggest help is keeping the messages neutral wrt tense
and operaitons. Your merge message was great in that respect, and I
didn't have to edit it for silly details like I often do for merge
messages.

THAT is actually a small (and unimportant) pet peeve of mine: text
like "This pull request does..." may make sense in an email (because
the email *is* a pull request), but I feel it makes absolutely no
sense in a merge commit message (because at that point it is no longer
a pull request, and it no longer "does", it "did").

Using present tense - particularly in some common forms ("This does X,
fixing Y") just is something I try to avoid. Using present tense may
again make sense at the point it was written, but two years later it's
just odd. This is why I much prefer imperative voice (ie "Fix XYZ"),
because it's neutral.

Another thing I don't love is pointless "Five patches to do XYZ". That
"five patches" is not relevant in the big picture. What might be
relevant is "Clean up ABC in otder to fix XYZ", but not how many
patches it took.

And as I don't want those kinds of things to typically be part of the
merge message, and I end up editing that kind of verbiage away,

Unless I get bored and lazy - and admittedlly "lazy" is both my middle
name and my default state of being.

                Linus
