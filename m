Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A231D74B
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180280; cv=none; b=DOAMr/twREnRyjAQQXhtGQRjyU2BKJgQBZM/MimwPDqIAWxjUFi3UcqGulRXPCOb56TdKS/ZLUaGD4ZtnS+8n6of0ffIvLubL6nzN+/2Eh/390dTemlGoWfBf6gCHxdKgj/efDQt6zHj303cuxG/a4f7nnIRSPyLgSNxitk2k0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180280; c=relaxed/simple;
	bh=T2fvxlOvyzqFwmbiIi/WNiQRyhRS3OG8inuNWUXrY28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJAYleBIjQ1KTxrOPM+cOZkjgjNlOkq7i0ob9SShoc/RvU3Z6Q+brMVNLdAQ7ad+WMhRGSrB6cyyeZB+mL7al+XGKxxyMYfTzRb2u3nnsTsvQB9Y68AvkR0l5DLvYza8i871S0I1q1c3Mi1KAoB0QuGabRZaUqpHMO7vHcQI1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8EeECZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8EeECZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37C61F008A2
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781180278;
	bh=T2fvxlOvyzqFwmbiIi/WNiQRyhRS3OG8inuNWUXrY28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a8EeECZuDAlrC5oBAgvR1hzA5xezuA7BijF8qDYki2ipN/xh7btF/G0KbYL1yZOv9
	 9Z3BabfVYMkcHspspLvW2NTPOZeOi8IR17AdDq07lQAituYsYVkCNg5QsL3b3VuXII
	 hdPBl6enGVJp7Qhs69GKTLWQwho8Xe75ceKDSU5THA+E6i2FOPtm0+aKeQocHO6eiE
	 2QoD2ud5CkF9PJSOQPR4VDJxEWVAlCRBdZysdi5MMqUDvG8zjhWbf3uAEwiiMzZCfs
	 eq2L0kMJkjXXBzNTdlqfsc2yMiKu8iLg4maeSd1N7e9w/bFH0kO3M2863vgLePH99z
	 t/g+nmoGgptuw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa88b4f792so1157945e87.1
        for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 05:17:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9p1IC5as4+tM5p3eJBevRFWtamnNrR/pHzLr7hAFx1nYNqveviF9kqq/zhyU4K9jnlLy23J04xT4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAvptHR6q0h0GqSCPrY/fFoYL+GjlilbXOSZsuLdzI4lBHCNxB
	adpyiewrBHyjyTGwLesYMHvAgNDiEuW0UvyO651ft9v/WLh7ADv4GA3qoOwAYwB9syXDDhDZqiy
	QTwsnQO1BQ7G7IScT1Hhy2CqN2ExmPPM=
X-Received: by 2002:a05:6512:118b:b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5ad285daf65mr662871e87.2.1781180277617; Thu, 11 Jun 2026
 05:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <20260602185339.GA404948@ax162>
 <CANTFpSX0Ehpno7b=xrnqzmENn=sfKj1UcyRzXvMyy4Rcyr7NhA@mail.gmail.com> <CAD++jLkx_zx_w_rSm9FxzbPOFMgMrq8NvfZecANLkmrMv=19fg@mail.gmail.com>
In-Reply-To: <CAD++jLkx_zx_w_rSm9FxzbPOFMgMrq8NvfZecANLkmrMv=19fg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 11 Jun 2026 14:17:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLm1yVs7sasB4vxO8_ebxHG_Pc1f3ZpPa_eYc_6oOeqnAw@mail.gmail.com>
X-Gm-Features: AVVi8CeGxSPjS-HYngKq-xAX3JQnF3SLm_mVMUy1FDJh_FcgDRO74I4qqbBv8T0
Message-ID: <CAD++jLm1yVs7sasB4vxO8_ebxHG_Pc1f3ZpPa_eYc_6oOeqnAw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:14=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
> On Tue, Jun 2, 2026 at 9:50=E2=80=AFPM Hardik Prakash
> <hardikprakash.official@gmail.com> wrote:
>
> > I am preparing a fix that skips GPIO resources with no resource source
> > string (string_length =3D=3D 0 || string_ptr =3D=3D NULL). I will test =
it on
> > my hardware first and send a patch shortly.
>
> I have not sent these two fixes to Torvalds yet, so I will drop
> them from fixes.
>
> Fold in fixes to the two revert+this patch series and send the
> fixed patches again please!

On second thought I kept the revert and just dropped
this patch 2/2. Probably safest.

Thanks for working on this Hardik, we'll make it all work
in the end!

Yours,
Linus Walleij
