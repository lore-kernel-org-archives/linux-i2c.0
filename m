Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138823D812D
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496517; cv=none; b=g5uvlKpGSEpAJw4wEQLRKkR7xfP1u1IYjm8pK9VUBv0EEfnFw+da5KRMRXRLpc557EZtYhRMtY4pcobSzZqEXLNaIUj7DhQ241qvmLkFnOvaMH+zzTfn+7gXjWg4T8n00mMoP5TLVLpTTkGcViYhUuihwkfAfk6iB1MxW6nqx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496517; c=relaxed/simple;
	bh=A8Td6TlDzJEWR1jqngdKvSLINzNZ3gyx/t5LGV07KpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWDQdL4vmKLJ1QgWszT+7AW0bvRhMLf65gA7QlaEgEYwQQ1lnYTJe/gltBiMgYQdIttdxzgCBcGOhmos1oFzBCfSAd58UZBtIw3od64JC37PHees3iiptyUdLvn4eavYGWRYDcZNTF2J8TWsMhsqxXByJO7tfanvbG/ftdzH5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN+Ad1UD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN+Ad1UD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD9FC2BCFB
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496516;
	bh=A8Td6TlDzJEWR1jqngdKvSLINzNZ3gyx/t5LGV07KpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IN+Ad1UDZH7A8g5qQcq4c4IwgckXJ04429l9jDSXm9FE3MWtZi/dgw4SCzTC/d9Gn
	 wWEsh4qiZGNlwhSDsc2dGji8iLlA5LA6gc2V1bm5taR5ssJ7woZCCwFai8AravhoX+
	 SZ/Hr5J72NKB7fb2avr8LcoobURMoCV0npHTKZeUXGXc3mJHoBQghEBa4ifVCeevHY
	 507QUEw/c/V6uOz0igH50OtzEImcSoKpmdv1C3ZBwzQ014XDrLSifPsy+JdIBqHjBb
	 ra6/pThRTPKOBKs4lKpwPURcjrtCo1eI/uV4STrcRDuXYLHYFBOk0L8TBckJUy0xr+
	 w8y4QQTGxktlQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a88db610ccso4781846e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 03:48:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZC+Bbx0FmtpNAEHELuUY4C5WHaKHzf5iVXgYFLUKKW6PuQMoMB9aDS06gUCwIq0hYTQSOUa+F4kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWfFytPt/btMQqDoLmU6aIbRQwQkGDZHTqOFiAXuWQlrG2HOI
	Wdg/TXJM36TFLazz4VC9IMpkPmw8rBKDu/xJ3tD8HCWojRPRpwgXGL+SeclZYVvCERKT395g/r+
	6GD/gwQKd7WuLx8mDx3Wbs5aL//8B+bDHyNqHL2vXVw==
X-Received: by 2002:a05:6512:3a88:b0:5a7:470c:daed with SMTP id
 2adb3069b0e04-5a8b6ca6e5bmr3605371e87.16.1778496515174; Mon, 11 May 2026
 03:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afiNrr4Llm0LWw-5@ninjato> <20260509091208.18346-1-jie.i.li@nokia.com>
 <20260509091208.18346-3-jie.i.li@nokia.com> <af8IB46ST70lXVsk@shikoro>
 <CAO3NRJg3wPVLgnyd=eD=TkkS5J24ww9WP3nNuiCnCL8=aLEmwQ@mail.gmail.com>
 <CAD++jLmcFEcHoCWq_4=7so5gV5Usj45n6qOYj8xrfsgAYufkEw@mail.gmail.com>
 <CAMRc=MdGd-6vUabTd5aJpjMbxRT3Mo8YH_jVyZzGLPyFsvce5w@mail.gmail.com> <agGwa7ejgQJb_tyr@ninjato>
In-Reply-To: <agGwa7ejgQJb_tyr@ninjato>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 11 May 2026 12:48:22 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
X-Gm-Features: AVHnY4Ihx3Rr57Cp2E0exnGlpeKgAxFvr_XKU04Q8mIIwWTNXsD6aYKIkDfqx7c
Message-ID: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: core: support recovery for single-ended GPIOs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linus Walleij <linusw@kernel.org>, =?UTF-8?B?5p2O5p2w?= <lj29312931@gmail.com>, 
	wsa@kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 12:33=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Am I missing something? Why does this need to go through the GPIO tree
> > if it doesn't seem to touch any GPIO file?
>
> The new function this patch uses is only introduced in patch 1/2 (at
> least it is not in -next as of today).
>

You mean this one:
https://lore.kernel.org/all/20260509091208.18346-2-jie.i.li@nokia.com/

? Why do I have to look for it on lore?

It would have helped if I had been Cc'ed on this from the start, it's
the first time I'm seeing this. :/

Please combine the two series in a way that makes sense and resend it
with my address in Cc as per the MAINTAINERS file.

Thanks,
Bartosz
