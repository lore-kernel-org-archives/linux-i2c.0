Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B737E5EA
	for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339404; cv=pass; b=tVxD5msvFUXiEPcxS3YsVw+b2qZu/v5q60ryyts3rRZs4mcLQX5xEUaoa3JerHcUTCFWPDk94r2LxUz8TfUzsue620gIllg6Aahf/vCfvL6SY08uwYTnaIQuSbYdCLZr2ZCrh+9XScuYiDUt0MKk4artLy52C9bY+KEjXIovii8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339404; c=relaxed/simple;
	bh=nRWtorTzFUCpTNAMPfvtchJBwm2gA5LTQZCmbppyTgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeIyi5/E9Wp/ZV+GDOkWgIH7i0s0IN90ATSXno+COzuKOrIwwUQxBiA4p224U4yt3xYNun0Kq3WP4xegem5oWmo+QU6cIZ2Hy2yjG8U7nqlx8MwtHfYjwDtxJo6P2FFkJeaWQFljUKqX+POG3t+hmAtFXiVfeLrdiB8XybOvxpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htfUz/Lw; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htfUz/Lw"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6688a2dceb8so752353d50.3
        for <linux-i2c@vger.kernel.org>; Sun, 09 Aug 2026 22:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786339402; cv=none;
        d=google.com; s=arc-20260327;
        b=pmc2BRg9/WCUPwAE5F9y5feG/Utr2ciMoAWFd/9wiPdprjxD0qStpFItgI121+opwu
         sRg5TVzDbQeHAznhF7GRBOvEDKr+0vmQ5hKRSZBgAtieFQF1ZnGTdLeOiHXvz4gsdi3X
         iYcMjc/JMYxojNhtaJcCZbJHLVFwZhgi5/dO73CBj7EaTH4BNDAzBjuCwEUKut3+8o+h
         2LRUvpTfU3Wp4l1pGNG/2nIoPDKnXCUbjus8HOWpmxAoMj/+aqNiweQ0fD+Y8l0slNOF
         V1Rg5BBRm/e1xO/biOVBYEqmgOIALaTuEFNFGyvFsvgnLCpmHOOIz1pN7joIYJSTUn0W
         MUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4CUaInJTpwQwrQNEPX4tsX7iKPUF9PSnuP5rHsDFXo4=;
        fh=O0umIWMGoDyuiZ3hMUoy3HGtVLuSICjdqLPTvzjtSg0=;
        b=RGwP8Iqr1/evkMmIRaUmAk0YbpwQOLrdOZZ8cjqcG2GD0krquqc0SmUcnKi//lfYli
         2SR7+BwUecd3e7t3kSSBw1M7mYMq2vFSUoCjnAEnB2W9kAaadfVP3ozxPszmYnNJUV2X
         RDBzDBArGbWIQa5QNvsoPAJTsINj640Sjur+FFAyYtHjwrjJJzghABBiEeYtJY/gxLqj
         YcYe23HTZBJTj8cNWo/w2VLhOPVVYb6U+oLot8Df50vmSRtNIxegz1e4syI8tBcHa1uF
         vnAWL2lTYmgvHzNyeEuY1W00WsaYWTs84EBN3txB7GwXbTmHQ80GiJMSxwxUwhNcDBiH
         hiuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786339402; x=1786944202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4CUaInJTpwQwrQNEPX4tsX7iKPUF9PSnuP5rHsDFXo4=;
        b=htfUz/Lw7qev2v3/tNBUrmCeS7rKBCW2wYH/9pXwB/Y+XDh2Rm7uFSxo8Y72g6uE6s
         pGYvUQ5Sch8JGRmr/mQElpxkiB738lOTXKfQh3tGSfuDTO2ac+fTkdNu1p+n9Cu09AiW
         fKtpxABme3mSuE4F/4SxzLB7IWacmIYCsQrmgkARZdayNH1Joq2xJGcKL+B66rP3JH6S
         YFic4xCbEgKzuGPjtLMdqgyXoPr7YfNw+i8s1BA/GxsO7pDf8jAxR+w8goL1hlGCW9VG
         //wQh3SY/ZK5bXBRQD/T4pHHkIsGAt3JInOooRnH3HfeJVP5HmtXyTpkAhX9TOSPaX19
         yUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786339402; x=1786944202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CUaInJTpwQwrQNEPX4tsX7iKPUF9PSnuP5rHsDFXo4=;
        b=fXejO9g/RCtsep0ROUxcMrucP7ljT1wJ/CAfwogWj1a+rNEAA6nR3AWbz7usgxq1+k
         FHnCkaXSlTfYu/XbpEgi7ecL4enBqjDRlZMw3xpA6XSfqNDrLtnzsczww2ukyEW9dA+H
         fmtcjSy6sEUXNLUNCgqUCXQoxVOk101PZGCMw4vEFnnBEP0xND4892yVn7ZngCl8GXxz
         EHuuad9rptlAL0D5jea13Dh3G4eoPTF9vIJGwNN1yNFuMkOD1/yLmYiutOt0n0OjbkzV
         y6pJ83kdrez2yd+B6AhQZfNnlKvRn5dmzLmlmnsxGzfDxJVCpAMmsM2SWGLWCma6aXfV
         D46A==
X-Forwarded-Encrypted: i=1; AHgh+RrXcMz/oBK7qmId9Wf+iI0IaqL8NKn0Wx6JLYOOSYOGNoN9w9KkzBFkT9r99nSRJ1J0rvJNngkhByM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5C4a/ywEfLR7vTeEasaDVKGziT56afKwLPk0xHyDeYuN3YPm
	7f2fKRu/nRpWyvci6PcpnxOwezOguiiwefEoxh1RS1v+u0fXizCy/On0R/yppt4dk1ZruZ4Czbe
	iGKjNcoTka+LLjIDF9YKd5xH95LfGNRg=
X-Gm-Gg: AR+sD11Am+2xDI+1y9u9hjyjGEG5r/q+XI5d6nqtRp4TgkUsTvJKxL2cMSVuH8G//yR
	x7C3sR2dl4PQtnDgEk1P6TBLws1a0Yuu2EY+HbQFLnZXdHPxMrGDZWVTZaWwJ5PrEpUEhmjl20E
	Di7Gb5lK8EJ9Elb+V3ABgS6hxIYdPPbQBtbxyGvoe+zadqcsiP8GmRWVj9yHm/6kG91DaW1QDhz
	qlZsxNEr9P+3SeqUngiTfBam6T3xvDYOt96HZb+W6WhFAgohlzsjl1wHnDrG4NJTZywgxdoSp+i
	NKszf8MieqBfUszppmXcYwBAXZBeDcRE6Qskkr0gz8Qe9w==
X-Received: by 2002:a05:690e:4102:b0:668:37ed:12ad with SMTP id
 956f58d0204a3-66acd206e31mr11235972d50.19.1786339402205; Sun, 09 Aug 2026
 22:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701035025.3082927-1-a0282524688@gmail.com>
 <20260701035025.3082927-7-a0282524688@gmail.com> <20260709092759.GC2045740@google.com>
In-Reply-To: <20260709092759.GC2045740@google.com>
From: Ming Yu <a0282524688@gmail.com>
Date: Mon, 10 Aug 2026 13:23:11 +0800
X-Gm-Features: AUfX_mw60mPRtAodJtPHW33YszFKPUsZpTStYaWt5nfL_V8wGiYgE7fJSI9_-fc
Message-ID: <CAOoeyxXgqfts9ytFEYLe=jCpBkPaPwrzwTBQX3oTsTME90CEBw@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] mfd: nct6694: Introduce regmap-based transport abstraction
To: Lee Jones <lee@kernel.org>
Cc: Ming Yu <tmyu0@nuvoton.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Thank you for your reviewing.

Lee Jones <lee@kernel.org> =E6=96=BC 2026=E5=B9=B47=E6=9C=889=E6=97=A5=E9=
=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
...
> > +/*
> > + * A few firmware commands (e.g. the I2C "deliver") transmit a request=
 and
> > + * read the reply back in a single transaction. Model this as a regmap=
 read of
> > + * a SET register: @buf carries the request on entry and holds the rep=
ly on
> > + * return, so the firmware exchange stays a single message as before.
> > + */
> > +static inline int nct6694_write_read_msg(struct nct6694 *nct6694,
> > +                                      const struct nct6694_cmd_header =
*cmd_hd,
> > +                                      void *buf)
> > +{
> > +     return regmap_bulk_read(nct6694->regmap,
> > +                             nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_=
SET),
> > +                             buf, le16_to_cpu(cmd_hd->len));
> > +}
>
> [Severity: Medium]
> Are we misusing the regmap API by passing an input payload through
> regmap_bulk_read() in nct6694_write_read_msg()?
>
> The driver handles command exchanges by modeling them as a regmap_bulk_re=
ad()
> of a SET register, passing the request payload inside the buf parameter.
> However, the regmap API strictly defines this as an output buffer.
>
> This currently works because regmap bypasses bounce buffers and cache for=
 this
> specific configuration. Any future changes in the regmap subsystem, such =
as
> initializing output buffers, enabling a regmap cache, or adding bounce bu=
ffers
> for DMA alignment, will silently discard the outgoing request payload.
>

On the write_read finding: it's safe as-is (REGCACHE_NONE, val_bits 8,
so val_buf passes straight to bus->read), but I agree the read
semantics are bent for this one request/response command.

Would you prefer I keep nct6694_write_read_msg() and document the
in/out contract, plus a note that this regmap must never enable
caching, so everything stays behind regmap as you asked in v5?

Or would you rather I add a thin transport helper just for the
"deliver" command? That reintroduces the ops-style you pushed back on
in v5, so I didn't want to go that way without checking first.

Thanks,
Ming
