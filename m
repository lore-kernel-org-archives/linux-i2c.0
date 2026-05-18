Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B3372ED3
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124973; cv=pass; b=F0DJmh5rpbxFci0dxXShnUdvqRJe1IV0WZO+25BizOLRpbyWELjNgqdIpkMpS6FsHxCrtl12egjnOAJV8SwVSlbzLrlOk/jJdOKk/MmbdygEjFWqnQ9LVmS6XLL6W0V/Vo+2kAvlksVuVmlbKeQNba9+TSkFav4vkuvuPkkFtWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124973; c=relaxed/simple;
	bh=TOLeJsmw+Vv2qAImKueCZ5Ta/mvCb0OE02Yl8ir0Zn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZuflK3MND+fHSikRzpT3DtQ2nd+1fqK+b7OUe8qsE7d5big/QmHhKm9zj5/UyeBk5Ba7f1946/ghrw+G7FP7OAfOD90z17FARATlnYmpEybNVewnpDILRagWEWM15absw2EAs7gUbm8TC3frXviodXE6bztuVawEOK6y8gy+DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrtIfw0z; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrtIfw0z"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65e39d1dd38so1998345d50.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 10:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779124971; cv=none;
        d=google.com; s=arc-20240605;
        b=Vm0vpcfflGDn1ahHlkt3eQd7ob6fcc95oJ4i3HXHReTiILdr3NNJFER9qTjtUyQcRJ
         cA86cjQWlFEIT/XAtS+r0qPHt7+6Q+lXAJSTwuSQQ5VMv0D+UnrUdGtVdTHN3gaA5owU
         Spyiu8V7MsdRFFvQM0C4hOL5nU/ikUPXp7fMddBX/2UW2zocw2nx+D0zuPu+RyUDj/8E
         AoyJTcJ2qEVFBbgAb21TU2QOL+pLGKYl+/YM/J6xLTvphr5Z0YaHoNTmd2bhr30G1wWD
         fx/j+r11KUinPMcv5o4Vgly2pBNMiVXF5d95Nm3+Znd6vcBcFNc9pgZ+bRIz+3/XUoCJ
         J1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gmumUmgaNEOIQSCm8QdKse+2Q6ZjwZ4ybhIGQ185Rfs=;
        fh=vcT95uc26c6vUVurhI1ItehAzAGQwKnoNUw3HhN4jfg=;
        b=DEnuKq3bDh4mfj3N2AuFx8QbDrR3l6RvF3D98xy/+nmMPol8oTfX0ZFjb/4aV3Ckel
         OHnamB9aqhRosBaHrZ/2TZv2XtEia0/JC8ddMy0jyvHhZZqC0r6i6lxuCah+T34xdQo3
         lp9ydlaEwwQdvxxRpztP4j6BqQWrzjn6UX5Qo0jBKt3LRXSSTojO4lsp9DIuNV159xpe
         8EJqKVUY3ccyF5dma3dl2jtWSgi2HWe7uFR3/BZrwwIE3xJlH4wVfJoM5Hmo55LM8s8m
         sQ97NK8Dd0RkOEjflErBC3EGzRE+ImF1guoDfHSWUff9Gcb7sUAOKGaYSooB/2UHZExZ
         VJ5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779124971; x=1779729771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmumUmgaNEOIQSCm8QdKse+2Q6ZjwZ4ybhIGQ185Rfs=;
        b=HrtIfw0zI2D6miaUHoPnyD1FimPj6N1Osg7ARug9bXXaFdwJtb80dqRl93b7cAIRiI
         mfRRpt5bxnfSypZfMfkVst7EKGs5PrTcLZm81nz6DJjMGHIT2Y83ZkPBjjLjYVbvXTUD
         cCDIFnKGa3w9Hdw/HBvUz5tNj9/51PKOtrj593NnccJljvA9wdaUmnKOYwDRYb6xNB81
         buUU3Nq6E9yi6S2kHZ1tj68kwn0f3Wo7m0eowr06GmhvFYfFJgmpWtJU9SeI36iGNUe8
         vCJ/35tezR2AhbBdjnZCIRFwFXac5Q/7JMJOCyq4AqmvfBiFmw7tx9tolN9KsjRpqOTz
         oyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124971; x=1779729771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gmumUmgaNEOIQSCm8QdKse+2Q6ZjwZ4ybhIGQ185Rfs=;
        b=mm5VN9LL6qZtRCLMax9nCQ93aFv8JkcNiMhySs7INH0zMcTh6n6gKPyLbFDyDOBYeX
         6WVHsXJAK97H+gy/sOQisbeBZkcqrGR4doNp9yNrXms9dKeikE5A8JwyfGC/g+/mEeUU
         z7rIn5LmxTWfzQc99WQOlwatIj/vz6MHnpIQGkamDExvLGLCTusEWbGAjkX+2ezZdqgd
         6YWN6kDYURu78sekH+Z1KY2LlLQZnaMA77jnWNZwE7AcL0VqfPw28sywO2We42lNy7CS
         0Ag0kLTssLdvgAVePaB0BzkFeE7U+Kmb2rbejfKNCcIuh1ogyT6Q4LiylnP9CQAc5pFq
         JFNA==
X-Forwarded-Encrypted: i=1; AFNElJ+YEzZHZOBLNdRQ8ApB+noS3KWB1SR4dFGDRdJEyJ0KmriTfq3PBBL4y6gaTXmO98hrw5m540N8pHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OREI4lKeXZFJREF/SJFFlv/l59rFOvpzL5M6iMqI4NxBVw+P
	P5hMg691PlQDyQXD/W1WPSdk7sqcyLQdLk9Kc0LLkwQdJYFmHqPnPlHBGJxPJc+a1zO4D0awhYu
	yinfU6mGDhh9WiG/7tIRJKEo25ImDQru9qbxtpYM=
X-Gm-Gg: Acq92OFOFX1kmkeojyKDUI4aKyCLKwLFcUc5h8vMTeuTdKbIL2bjwHm6FXMXQMH1bD0
	B5KsqDWNkkt/IJhynD00XmKBl7ICCIJTOiHcdZzTbHSE9fao3Je7wmOsi/H5OBdnc8OamGcOAYs
	0Ax25F5eMH8fRCxxPom7fcseCgBlHcOSfbQunSBisPvs9hSluiEeqR84XvnZI+FUhXvhiga9CV7
	DiZubUpv5AP+y6T6vQ8Biv/xPclzZgsXSM/sUMiXj/AKWdikqe/AzdpkH6Q2WZMGe7m2/YQRJ7R
	Yxomw8JoPR6QGEj5L+c+wov9JuN4iZkngoTTOkHGIPefhZZB7US+xQKy7X7Mmp4Lu9hOGSfak8F
	6Epb4jx3hWMAGdqtHPXezlaIBQAxG7Gv5b9DWblZE2qh8k25fwCM/wn92ApE=
X-Received: by 2002:a05:690e:14c4:b0:65d:b10e:a848 with SMTP id
 956f58d0204a3-65e226d6793mr15784084d50.16.1779124971317; Mon, 18 May 2026
 10:22:51 -0700 (PDT)
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
 <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com> <agsh652HlC4rg1_1@ashevche-desk.local>
In-Reply-To: <agsh652HlC4rg1_1@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 18 May 2026 22:52:39 +0530
X-Gm-Features: AVHnY4LZGHhrjlQ6Jw1xZ3WPGv09nBU7cC2SbWJhItqgPVV67oKGDP1UiqDEY3k
Message-ID: <CANTFpSU7XaNKwe_FPsTCkxQYeq78Tqusr-nsB-Ww0_teuiWdEA@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 19:57, Bartosz Golaszewski wrote:
> If you added wait_for_device_probe() right before requesting the
> interrupt, does it help?

I'll test this. One concern: wait_for_device_probe() waits for all
pending probes to complete, not just pinctrl-amd. Calling it
unconditionally in dw_i2c_plat_probe() would affect every machine
running i2c-designware, potentially adding boot latency broadly.

Would it make sense to guard it with the same DMI check, or is the
intention to make this unconditional?

Thanks,
Hardik

On Mon, 18 May 2026 at 19:58, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 18, 2026 at 07:53:28PM +0530, Hardik Prakash wrote:
> > On Mon, May 18, 2026 at 19:35, Bartosz Golaszewski wrote:
> > > What is blocking the pinctrl driver from probing? Does it return
> > > -EPROBE_DEFER for some reason? Pin control core is ready at
> > > core_initcall() so it should work in theory.
> >
> > On Mon, May 18, 2026 at 19:16, Mario Limonciello wrote:
> > > Please try arch_initcall instead.
> >
> > Tested arch_initcall + patch 1. GPIO 157 now fires at 0.255s (earlier
> > than any previous boot), but arbitration errors still occur at 2.309s:
> >
> >   subsys_initcall + patch 1:   GPIO 157 at ~0.310s, arbitration errors
> >   arch_initcall + patch 1:     GPIO 157 at ~0.255s, arbitration errors
> >   patch 1 + patch 2 (v5):     no arbitration errors, touchscreen works
> >
> > The driver is not returning -EPROBE_DEFER. The problem is that
> > amd_gpio_probe() hasn't completed by the time i2c_designware fires,
> > even with arch_initcall. Promoting the initcall level gets the driver
> > registered earlier, but probe itself takes time, and i2c_designware
> > catches it mid-probe regardless of registration timing.
> >
> > This is why device_is_bound() works where initcall promotion does not
> > =E2=80=94 it waits for probe completion, not just driver registration.
>
> The alternative solution is to have a registered notifier for the device =
in
> question. But not sure if it will be less-invasive than given solution.
>
> > On Mon, 18 May 2026 at 19:41, Bartosz Golaszewski <brgl@kernel.org> wro=
te:
> > > On Mon, May 18, 2026 at 4:08=E2=80=AFPM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > > On 5/18/26 09:05, Bartosz Golaszewski wrote:
> > > > > On Mon, May 18, 2026 at 3:46=E2=80=AFPM Mario Limonciello
> > > > > <mario.limonciello@amd.com> wrote:
> > > > >> On 5/18/26 08:40, Hardik Prakash wrote:
> > > > >>> On Mon, May 18, 2026 at 18:17, Mario Limonciello wrote:
> > > > >>>> I'd still like to avoid a quirk if we can.
> > > > >>>>
> > > > >>>> I know my proposed patch to try to probe at an earlier stage d=
idn't
> > > > >>>> work, but could you perhaps try pulling pinctrl-amd even earli=
er?
> > > > >>>>
> > > > >>>> Maybe fs_initcall()?
> > > > >>>
> > > > >>> Tested. fs_initcall + patch 1 still produces the same arbitrati=
on
> > > > >>> errors:
> > > > >>>
> > > > >>>     subsys_initcall + patch 1:   arbitration errors persist
> > > > >>>     fs_initcall + patch 1:       arbitration errors persist
> > > > >>>     patch 1 + patch 2 (v5):     clean boot, touchscreen fully f=
unctional
> > > > >>>
> > > > >>> The initcall level does not appear to be the determining factor=
 on
> > > > >>> this hardware. i2c_designware is still probing AMDI0010:02 befo=
re
> > > > >>> pinctrl-amd finishes regardless of how early pinctrl-amd regist=
ers.
> > > > >>> The explicit device_is_bound() deferral in patch 2 is the only
> > > > >>> approach that has worked.
> > > > >>
> > > > >> Please try arch_initcall instead.
> > > > >
> > > > > What is blocking the pinctrl driver from probing? Does it return
> > > > > -EPROBE_DEFER for some reason? Pin control core is ready at
> > > > > core_initcall() so it should work in theory.
> > > >
> > > > Currently it's module_platform_driver() IE device_initcall().
> > > >
> > > > That's why I think we "should" be able to move it a lot earlier.
> > >
> > > I mean with fs_initcall() change - what's blocking it now?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
