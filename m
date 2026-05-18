Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5645481258
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114228; cv=pass; b=J1EiwnJ1nctPK2VbW9kYcK8bYDvTvcO0/m+zVo9iCh9CIETpqTWjVWoTYvxaWZKfbeRlXwTwBRvMtXuem9jKNVcfBOA0bDXSf/272cJj9cUzC/WwP8v4+b0/pzfJXBAeGsM02br1cl0KwBlAJhFb3tIyMjIGka/kYju8q8S0P60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114228; c=relaxed/simple;
	bh=pRa8rdrYaF2vrezDpKgAG2aDR45R8YIMuW2Emlay42w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIArxP3sr9eXyOqX4hd/g9jgsJREGUFhZFdagT1iDeHQzKR+4W8hhFPegDUTl34RWEQ0PxxTiIkU9mcKZJ/nyUpPsWLPhw8jZQxQrWEdTIQo1FDh2Eow+AhybD9cOlRknwYUi9vPXlb7IMVjT0nN+p4nq7uS/uf0KYBIg6nGmQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQPJfBLH; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQPJfBLH"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7c04749d739so13289667b3.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114221; cv=none;
        d=google.com; s=arc-20240605;
        b=KHVIwl81cIYIW1FnrRT2zy7yHkgAjicAKA0ZZMeItDDaEFSthzT/2LX/UdyXHTYnl1
         I2vrjI5s26hU4BWzHGUmJda4VVaaeU8P5945ZtDWuZdkfqSP4ssCQu9TO5cTYVGvzjDv
         D1MNjA22nkHTOBzKO0GqAwFfXHxfPo8S8fUIFpdBwSw99SpZCbLhcrnx7JQ72EBJ7Eyy
         05tUNeF787Yz3guFijhqQIH9/0TZhrFYTE0/bYBdsva4w2DUP1vZfwnwt5NsVfFHY0wQ
         93V/oBzLCtm1dPkS4oA+02gHt9jGOx0mag8feMHaGfizDlUAfC1IQe8ZIYABbM+Z5fpo
         qtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7z4OfB0gXheG5q1/GRQdWvILLOvJq0pnsazkpZHrUw=;
        fh=gbSSWOIaIUpN9euLWs+iU4VignF5bY6s7Lh4nZZrm18=;
        b=I+yExWFMZpDv/vFGvZ1rEkWd/ec4dMYg4cIL9DnNfQWAdOWXu/Tfa7OZjHhGfJWgi1
         rTYNFMWopxf65KaKsfeHjgwAlxNqW45JX/T/o1rmBi2VXDB9uuqMKxNY4nnztrfAh9jg
         Z/cXDFSzZbMKQBeh6vcaCAlS7XZPv7o0QRDb5dN+Qn+wYlC2/I7YNEsi5l7mKesQs0Yq
         zeGVjIysX100KOhhg/p1VCTvu7qXRtqjKhOOEMT/oS+l/+CJq+KpNJ2l1k/H9HGz8h1P
         FxDfOcZ563nfoEpcy1G+ZG1Kluj2RNjjf1rW5gNoURTs5pCU7YG85U8A2wzmt5vf1qNi
         eUrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114221; x=1779719021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7z4OfB0gXheG5q1/GRQdWvILLOvJq0pnsazkpZHrUw=;
        b=CQPJfBLHXAJjf8TttrV20WUaU39UrSaKmKbHflVKLYTujynjwhiyOaKdoFBZvwXhEh
         iHpfTUwEnb2RlWcIoke3A+JWos/s6sBLDmf7nYEQyoBVMFbL8ivjOH78Fl0dTQjsXXNY
         5Dg2DnWwDBf0WRFdNGqALK0fsNQgBuKA6FpC2zvxzDckvOT56tDkaE7ComedDSFqCEcQ
         4MwKOQoQl8eTYJI8+PEUAltpK1ZS/gSQlq6rKaWwUiuCUz30Jto3beFz6Ug2C5/KMf6r
         3vqa12okvhEEWHpABJfl5dtZl3kFiUFS64JJ0lsQRSRRpZ1IKRFktm4YS1wfpPSJxYhz
         dIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114221; x=1779719021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7z4OfB0gXheG5q1/GRQdWvILLOvJq0pnsazkpZHrUw=;
        b=rMPQvZkzgi2ygv5DHz/d+hGXgZ9TTFZLIr9UmC2Q5vMNW1MVuPxWAxEnTw+msP3fv9
         Wnm0s4d3HmUUEnsxnznCsax4s7POhtT4qyXCtqzBnmti50icA9eSDgCgo5JQ5FnxVvxL
         ogS6Y9XxUVhXOPIZVjBFf6OiD6py0HNtHizv0zlDqD2i3r5y8GBY2DUgOKyS7OqBsSek
         YEwuOxUzi2CGxPEpbuRKXUEECL6+iQSrLxmIu4bfaOaPnIPQqC3YL1KUnfXpWnPu5/yQ
         fPmNeodLXzu3oaYAwrh3QmtcMI9MBy5JThn+vErE81Xf4V6jx/Xi7yyspFM6yQOvvRIX
         LUBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vqfFEDuiKVuwwSTHT3iRuiWD3Fetm5g8V0Snjbq7995TcN0tit2WTU0AaA6Q/+ub+F55lK51S2tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDc1Hmc0Nw4NKKTpi8mahWqCws91eM0nn9R/YzLAkhLgkViQW
	trYPBHc/xZSbnn6t2tMAYGQFQmMIERW9xpAgicqG6bpfipNeDtB/jtCcvdpfh2JMqfyvsWZ75/9
	jdfgvd2Y/sjPwSQjaKSyLYWS4jQbWRRU=
X-Gm-Gg: Acq92OFJzDwCt/EQiOzwFCpVcobdKRMda5segwniiBiJt1YpLI0h8aLKxWVxKfe5Hh+
	e6LzVh5Jl5pTrkAkteZPADIsYwjr8KmBOhxdhGarDwqaI4embnO2Yg6X2AhMH/eakyxAdSKeHe9
	t920xFwLRtDLqukSnhzMBpmNJc1Mlv1+8PfHZN8qK9tAlUm6aOTIYRVwBSBlmq2BNZw76M2g9H2
	660ieYAvQ0yw9VQkokRuMkan1UUpqg1HAvZfqJnaiK6xKTVG1u4gGpbB9oY5Yrw+Roz6sZMxpCN
	PVFZ4ok31syOOAp2TCrgyrLmY+1GnYuTekHK7UmDJTstYuj/AeERTqG/xx8mL/kpo9WNIpWeb1K
	VmcriNfTmHqExJfcxj3fNFh6znlTka/cGe76aR7hX+0DgC1DWKc1OF6IxMco=
X-Received: by 2002:a05:690c:f08:b0:7bd:9899:f906 with SMTP id
 00721157ae682-7c958eca6a4mr171352837b3.7.1779114220494; Mon, 18 May 2026
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
 <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com> <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
 <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com> <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
 <9d5da93e-bbe0-4359-9f17-e3c6b3a5cb34@amd.com> <CAMRc=MfT_WVMxPnYZW=mg52PHew0O4VQMGFrfo6G9vxZDDoArw@mail.gmail.com>
In-Reply-To: <CAMRc=MfT_WVMxPnYZW=mg52PHew0O4VQMGFrfo6G9vxZDDoArw@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 18 May 2026 19:53:28 +0530
X-Gm-Features: AVHnY4Ig35hP0cTA_r9SZS40mbG-rzLU3zT8q7iMy-UtxbbZdOTsMqBJJ1iVRcU
Message-ID: <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 19:35, Bartosz Golaszewski wrote:
> What is blocking the pinctrl driver from probing? Does it return
> -EPROBE_DEFER for some reason? Pin control core is ready at
> core_initcall() so it should work in theory.

On Mon, May 18, 2026 at 19:16, Mario Limonciello wrote:
> Please try arch_initcall instead.

Tested arch_initcall + patch 1. GPIO 157 now fires at 0.255s (earlier
than any previous boot), but arbitration errors still occur at 2.309s:

  subsys_initcall + patch 1:   GPIO 157 at ~0.310s, arbitration errors
  arch_initcall + patch 1:     GPIO 157 at ~0.255s, arbitration errors
  patch 1 + patch 2 (v5):     no arbitration errors, touchscreen works

The driver is not returning -EPROBE_DEFER. The problem is that
amd_gpio_probe() hasn't completed by the time i2c_designware fires,
even with arch_initcall. Promoting the initcall level gets the driver
registered earlier, but probe itself takes time, and i2c_designware
catches it mid-probe regardless of registration timing.

This is why device_is_bound() works where initcall promotion does not
=E2=80=94 it waits for probe completion, not just driver registration.

Thanks,
Hardik

On Mon, 18 May 2026 at 19:41, Bartosz Golaszewski <brgl@kernel.org> wrote:
>
> On Mon, May 18, 2026 at 4:08=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 5/18/26 09:05, Bartosz Golaszewski wrote:
> > > On Mon, May 18, 2026 at 3:46=E2=80=AFPM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >>
> > >>
> > >> On 5/18/26 08:40, Hardik Prakash wrote:
> > >>> On Mon, May 18, 2026 at 18:17, Mario Limonciello wrote:
> > >>>> I'd still like to avoid a quirk if we can.
> > >>>>
> > >>>> I know my proposed patch to try to probe at an earlier stage didn'=
t
> > >>>> work, but could you perhaps try pulling pinctrl-amd even earlier?
> > >>>>
> > >>>> Maybe fs_initcall()?
> > >>>
> > >>> Tested. fs_initcall + patch 1 still produces the same arbitration
> > >>> errors:
> > >>>
> > >>>     subsys_initcall + patch 1:   arbitration errors persist
> > >>>     fs_initcall + patch 1:       arbitration errors persist
> > >>>     patch 1 + patch 2 (v5):     clean boot, touchscreen fully funct=
ional
> > >>>
> > >>> The initcall level does not appear to be the determining factor on
> > >>> this hardware. i2c_designware is still probing AMDI0010:02 before
> > >>> pinctrl-amd finishes regardless of how early pinctrl-amd registers.
> > >>> The explicit device_is_bound() deferral in patch 2 is the only
> > >>> approach that has worked.
> > >>
> > >> Please try arch_initcall instead.
> > >>
> > >
> > > What is blocking the pinctrl driver from probing? Does it return
> > > -EPROBE_DEFER for some reason? Pin control core is ready at
> > > core_initcall() so it should work in theory.
> > >
> > > Bart
> >
> > Currently it's module_platform_driver() IE device_initcall().
> >
> > That's why I think we "should" be able to move it a lot earlier.
>
> I mean with fs_initcall() change - what's blocking it now?
>
> Bart
