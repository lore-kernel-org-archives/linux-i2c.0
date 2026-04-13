Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031313B19B0
	for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072386; cv=pass; b=HLPh2VjbUIUJ8qBqVfsdTewBBORIEmo9dn6qGQXgT24iaTKgQpcKuDK+jEa2uYoQG2s7X8PSuc5E8+N9CHSBhi23DcBL0XyeNtcLqORFaFF+mTX1R+eNRP3wB3qy4UFh2XeT8HHVlWguL6CrAt0rk5BN82SkbrzxhYR8Ib1sciw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072386; c=relaxed/simple;
	bh=AIj8v0Hi8sQvxNr/C2OEW3Yh01lDZBaIZhuDD3/FUIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+SE/czMh8FgjbYhl7CyVMXMffpDCECXL897UPyrMiWY2pNSOrpXQzrZ2m3AA/FiCpPXKWS9UDdQLlXhtJKqXQPBJuxELtTD0jqDpuYnnSNPX/SIwx2iwlEYqjJzoCfpfd9siMjjkR+3SSAAFI+KCk22RfC5kyBz4intZE/leBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpKGXT4e; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpKGXT4e"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6718f336888so1067437a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 02:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776072383; cv=none;
        d=google.com; s=arc-20240605;
        b=fuANHqdsP/Pjo7QHWViybc+lxSeYamO3UAdV68cWXU+LfXL5+9StTfkZdqMIs9kLO1
         SIRidU+rlc7spdLVjmboQydD18lidGrsChvBr4riFFEEIU8BHMF5Dr4llY+GBv3KnBs6
         XzxTZe6eR0qwHP4XT+3wZt2EQO+C/OX155qiPgaoERODkeMJ/wM18+8mgEF66uWUrCmM
         2XfYnFjnU+Mw0Cz+MCCUiLienuIpxZaqL33S0LQA8MwdAHQMCHt9YFZcNx7W4AjTeCr5
         ZTccNGmc7ZcR86jT59UNZi+aNqH6COL9jbyFGXWTk7jGvnzmBbaTMXDaPX/zhlIqx9H0
         kDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n3iu2/uJJ+f3nvEEkeX9hHnOtEpFD7REsnR2pQwo48Y=;
        fh=bKofIr7qbky6OF4epWGLsZLYHZ9fj5GSa4i+0lbQcDk=;
        b=IfKI0gH+QiVVGMkFu54MrTow0D4FbPxVI5aLBZcHwQ+T2JxufzabtJUANR38wTuuVl
         3HuitRE4ShMqDA5e5f+ydZK6JoPsr8nh+HMHfcHKN0rcV2tHm07OXIbTiUbOpZe4dkPq
         QiMO/P/fns2CN7mjim8Gv8FFIFcwivoxmgCwMMd+u/zckYeFAwChY9vWgv+FhlSunGT3
         Y6RhBv65GFdJCtZqZZygyoh8oFQ6SZtHAnRlPLEmwaj32KhXY3C5f4Mfn+sYVzhJYE56
         m1oJiRX3Q3bNfu75fB0J+BPlXVwRUs0pHG49NaEaaGBUXO6HJ7WoqjIy63beHr/3AXUr
         sxng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776072383; x=1776677183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3iu2/uJJ+f3nvEEkeX9hHnOtEpFD7REsnR2pQwo48Y=;
        b=DpKGXT4eKUOPmGoqmf5ucGXl2aK6FSd7vE5q9FLxtd/gtoZQl8vXRescoBW4u7CW6e
         rwbJG01mF55h1YyBUopzO0OIv/FvFg5BVDevT4gn7HDa3ad+zdAdddA14tuU3MbO4m8a
         jP1I9EYkHf7dkH6OkhUIEo/0kgr+YCZ67jZa8Pjkn744BTPlfbKi9jpOI4mqHnT+Dhs9
         66P7IF5ONRFZGFRSLR63xd+HS1ezpWNyUebmXHdyfBNT8f12INddZ0yu8s/W/MPCbgks
         +lAbGYwWSooNqCb0ezT7ZtFN9KFyKtZ56R9t/ylNODOU9/6BeWPyjs0W8dty84ThlKW7
         Y90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072383; x=1776677183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n3iu2/uJJ+f3nvEEkeX9hHnOtEpFD7REsnR2pQwo48Y=;
        b=PrAZD5eBkUYVoT52SJDTJ+Z0zMNjNpd+beDYtoA5lVDLAg/2RvWJ6K0R7Lxzzb2yfL
         i8zoLhnHDlepcaeQo0L4PTtnx5DeaY9iPgXDhOmmxUqqhkLNdXhFa4tp+GRrQOVy7rau
         xVyX7f8MrZQgDZYxDK8C9khkB2wnvz1tA0wOuBz8zEvVCesSuM9AWRlpS382Cte3hCyS
         qrxR6MGNckcjtqZQZBFw4wmSgMpcuol2/HxqKhggh3/NrBqlsaNsgIRNVJ8YyV6fV242
         hMJXXat/Ww4S2Ax+zbvGIRW22a1YFTrI9qcOOCzH7Me+3i4giJo3Pyvpfi5NF+VFHZd/
         yaiA==
X-Forwarded-Encrypted: i=1; AFNElJ/p231Oq9REPVGlPRTzrdENSFxZ3UVqhnAjxLGjEg7c+NmvxHyEoKk/uUZwdArKei8ktb7n6pkCYNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgsVoETsbGbxom2Hyg+sMzUTPl4GbVyCySPTS4NTbxBZQoB5Na
	s/PvVpPgnlyA3UT1IDcsz+7myVQqAgd87JuyzYSP2mXrFH+efkaMzmKxIFT8oQPXz/wEMiqKcFw
	Y+L01y4DxrnahAHIMZAKAmiNSWWu+fRQVB8Henf0=
X-Gm-Gg: AeBDiet3CeHM/NHOGOdVEbMmgpibWjDuCeFoDM7n8sXaqF/U/ciiHDLskn+BrTwuPtC
	kSijw2NljH+l5yQeYtPZMdaNA392frqwxurVHOOEWeIWQavptcy4aqUrr/gnMFuhXTW/y5GprhR
	/15GVjPNbvaUYeIrvVfoEtZZ4b17li7AJbLhiSlmUVUvY2/y+SsBgrkP7yDFXCPQ8US3tFMMGpG
	QlKId1TF62cmvQVKraBPkSPTasJSzup7LyqSOMtAhtlKJdTIrJB68KmOZEGn7BkN8zpGVhqV0uX
	0r8TVfED/oHHfiuSn/0=
X-Received: by 2002:a05:6402:34cc:b0:670:8d21:dcb with SMTP id
 4fb4d7f45d1cf-6708d2110cbmr6408870a12.19.1776072382964; Mon, 13 Apr 2026
 02:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775900045.git.zhoubinbin@loongson.cn> <CAHp75Ve59GPAFvKM6yOkPmr=kmHBjVL-Vz78X0WDikiWd+2arQ@mail.gmail.com>
 <CAMpQs4+QmyAObvCcJOFnfTuufG8=M0q5m+XMkaP6-SOp-8wq9w@mail.gmail.com> <CAHp75Veymi3z2atMuSeDyrhyx-HLHgCMzJF5EgpJZzTGgpcD3Q@mail.gmail.com>
In-Reply-To: <CAHp75Veymi3z2atMuSeDyrhyx-HLHgCMzJF5EgpJZzTGgpcD3Q@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 13 Apr 2026 17:26:09 +0800
X-Gm-Features: AQROBzBh6eBs7REn1Qv9IV594bWuIgt_mTQzWy_FshpZ6l48Ew5CqcVKTNMWbYw
Message-ID: <CAMpQs4LaQ27ZQhyv-s1OVcBF=4DR=_SiDTrpoB7F4qPRHEWB1w@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] i2c: Add Loongson-2K0300 I2C controller support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 4:18=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 13, 2026 at 11:08=E2=80=AFAM Binbin Zhou <zhoubb.aaron@gmail.=
com> wrote:
> > On Mon, Apr 13, 2026 at 3:52=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Apr 11, 2026 at 12:58=E2=80=AFPM Binbin Zhou <zhoubinbin@loon=
gson.cn> wrote:
>
> ...
>
> > > >  - parent_rate_MHz -> parent_rate_mhz to avoid CamelCase.
> > >
> > > Was it a special requirement from maintainers?
> >
> > I=E2=80=99m actually a bit confused, because when I submitted the v6 pa=
tchset,
> > checkpatch didn=E2=80=99t issue this warning.
> > But now, it produces the following output:
> >
> > scripts/checkpatch.pl --strict i2c-ls2k0300-v6/v6-0002*
> > CHECK: Avoid CamelCase: <parent_rate_MHz>
>
> It's a false positive of the checkpatch.

OK, I will revert this change.
>
> > #512: FILE: drivers/i2c/busses/i2c-ls2x-v2.c:437:
> > +       priv->parent_rate_MHz =3D clk_get_rate(priv->clk);
> >
> > total: 0 errors, 0 warnings, 1 checks, 574 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place
> >
> > > Note, the physical units are special. The m and M have quite a
> > > different multiplier value. So, even if asked by somebody I think it'=
s
> > > still arguably should be kept as MHz.
>
> See above why.

I see, thanks.
>
> --
> With Best Regards,
> Andy Shevchenko

--=20
Thanks.
Binbin
