Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6D3C76AD
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113146; cv=none; b=PAiRQkiFjPbNWrYuRuTOvVYjFVjDgSq78/ZgtvvqY95FE4BKquO1ImSoqaVQuCEdJTmgN6QlqAZLx5NS9Tjezo8KGw5lY2jp6k7VaVA4l+ffa3Tc+FfTjUUH6J8pHMj1WtWhhwq17n79LsGiGjeiQJKxT1NsRgM59/IOns+LuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113146; c=relaxed/simple;
	bh=FzwYa5fwYmVjdkVxZSUjEoNeU7VgcRFX4nzFHm9Tu4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxeyhX4TeKF9s3nh10xy/Ql9d2nZkCbOce8ySTSn8pKZcfZkDa9X5sIZvSFgqXpdiAVIq9LkNnHEyJN/5oNUMV6aAtcCVzKzOUub9mcG5Kreqj4/HEDpzM2CzbhnBWNJ2vah3ZSlX7EmQZQiGkgsaW0GP5zj6oDeT5+TTr2EsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1PzgXB8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1PzgXB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981CBC2BCF7
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779113146;
	bh=FzwYa5fwYmVjdkVxZSUjEoNeU7VgcRFX4nzFHm9Tu4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H1PzgXB8fwKez1GlgeSCa2GcJeSqoJFypd9gwduetQI0aCZEjRYwwZgiE/RK8k1I/
	 tOJvpY/4geXlHOfLieLeEcf8nPnCAnSXXbsvoVDrh1itmG6wu3dfUzssAP2LlWQ7yv
	 QIWwO1vzafnvpq/tltLGBhJnQoHT3OrO/rqe77+YdnkiO5tZILPRW6fcER0eNmsXh9
	 O8fN9rxk9DxKpre/8QxH1/nSoWgNLT4+axZQLZBYJwaabpgInvNH8s1g8/qZmn9jRk
	 s+AeAGiuW3tlOkox+qS1LNwiQbXWMdXdWUYQjELrm2yvit60uB6DTxn0KfIY1MQjH5
	 MizE3sqMp85og==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393c40246afso28333121fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:05:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+x0cr1FA0HcvZ52FoRtrlbzmGYnXyiAIxIZ31TuZA73zcTyN8lpQjBwBtOfQbm1gdSf9bhoV6njuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3YBCYBSc2uzFI6M4933ev9NW5ShUxODvwyYFAaI68sQnOJyH
	59Cnv8cC8ccuEg30yeR4+e6LMgvMsxhWn+aFZI/JJmgq89TkcxWM5WufNNx7Kzrw5s4pcKBMmt8
	QK4ruGEko4z+IX6g0SeObPvanmgFNNO/c5PZloLqkhg==
X-Received: by 2002:a05:651c:1584:b0:393:e571:277a with SMTP id
 38308e7fff4ca-39561a478f6mr45005391fa.9.1779113145240; Mon, 18 May 2026
 07:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
 <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com> <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
 <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com>
In-Reply-To: <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 18 May 2026 16:05:32 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
X-Gm-Features: AVHnY4LMSKNNO7ouuMhRBPWlrXwz9IqtMTUXof_A2zP9UA-Wx-ZastFasA4Bp2o
Message-ID: <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:46=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/18/26 08:40, Hardik Prakash wrote:
> > On Mon, May 18, 2026 at 18:17, Mario Limonciello wrote:
> >> I'd still like to avoid a quirk if we can.
> >>
> >> I know my proposed patch to try to probe at an earlier stage didn't
> >> work, but could you perhaps try pulling pinctrl-amd even earlier?
> >>
> >> Maybe fs_initcall()?
> >
> > Tested. fs_initcall + patch 1 still produces the same arbitration
> > errors:
> >
> >    subsys_initcall + patch 1:   arbitration errors persist
> >    fs_initcall + patch 1:       arbitration errors persist
> >    patch 1 + patch 2 (v5):     clean boot, touchscreen fully functional
> >
> > The initcall level does not appear to be the determining factor on
> > this hardware. i2c_designware is still probing AMDI0010:02 before
> > pinctrl-amd finishes regardless of how early pinctrl-amd registers.
> > The explicit device_is_bound() deferral in patch 2 is the only
> > approach that has worked.
>
> Please try arch_initcall instead.
>

What is blocking the pinctrl driver from probing? Does it return
-EPROBE_DEFER for some reason? Pin control core is ready at
core_initcall() so it should work in theory.

Bart
