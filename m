Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC073AA1B0
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815176; cv=pass; b=WwhSSoh94tXi+hgFJ9Bcq7NCZBX9Xu7OzTkS9JquiA153uP8ZqHZTgO+oI3i+qgamofXf7KURlFtdkCYDE9BEcxLVS4KroJaiFTqW1ElFOmESr29BYlFXkLcAP4D+12zOEQqFXq9cR5cuYaFp5bbtfdZDM+P4OifsiJyZqPhAcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815176; c=relaxed/simple;
	bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvKGJKN78o29ntQcOWUqJl9t6eDfME78+Sp1iqspQ3YwtDjfKED2pqjqGhmG81yyWe3NyGyAgSyrpjLk1zDdr7j1q1If9bKbDtyVfdrXcAZ/sfBUdHLVAepcJmfadXu5VZ8cKkaE7cTMsIPj7xd9U3tvszT2fglFKd8bhb4CpMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rErJRG4Z; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rErJRG4Z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a7109f568so21619257b3.1
        for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 02:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775815173; cv=none;
        d=google.com; s=arc-20240605;
        b=dQNQoooKNBrtD8nONoV1rSIg1HKV0WZE2Z7McGGdY7jXlBA0x8FglCD2XoXEPkNf2s
         i25TZSQQaJ4TVA5aNetpA1NFdls3vwPOswHN+PaRZ7tHfkfnIhRKD4OjE85VsQBp8pCy
         Lw7ZBFN2EDCGpnLt8Zh/YJTJnt6JBNSeJKPa9iJuJZ8equ5D/yQaZgNxd0WPXtXCmEGT
         9aCJWgpWufbTXO5O52BBeu2PSIABCusPfDADAxsdV463kFOhe47xfXS1SotVpwNW7Owv
         K9pKz9XHdc0yfTtanZSpt0bJwUUoZ571LcTJYqqwmheI4UhH8WQ23uUlU/Xf+YfSyHOF
         HE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        fh=OUkqWuYYqWZ2AnGr0EniInhWtxZhDjamGmwVZTd9YXs=;
        b=bdZwGRKGhqcuB0kwJR5b4CGXM/leatwPDi+sjfjhezfb6FA8LWIAlHgONKNrRaLbmW
         r7WP9Kipy+lepJ5UrAUqFcL+PT0BMnyrn0YSijbL/jA/cr+VR3psy5Ci1UQvl5n1e6o/
         DKgfd5l1Vas0cB9MpHpdVDKpkQiQbdnoCXc8XQsBKtDbuchzdaQwC/jJqObEXgN7VhF+
         FmdMPeJzMNzG4Woydtv04cGU30LA9DPZgkUbuM2jHxb4q6h+daJnZt3n1ZB16JxdvMtF
         XHQxi2v5IB9F8Km3zEX9eAtBOkw8ESYzPM9yR/rJaGJs/OGVocymTwn0ZRtbcwFYgJZT
         +2fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815173; x=1776419973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        b=rErJRG4ZXVbUQMFbRFnmhepxOtcXBpodg5RLaOgBH+BoRSymMMJ7ImR40QJedCzbyW
         tMf1Kw0G48yG1WZj+bNeo4MywgSjIiHC6+mdUiWs/1trlCFn5wz1/AAEssiw7iJpV45I
         HfNU8cXmReN8Nsez829lTb/TBvUrr77OsqHawEgFSQ6vY1oOAVLWJ0U/Z4+fMTe/VFCg
         IR23/Yp54EUoq9dhxidWHZuyoQIaTlIzdzfge5/sD4+zoIksk5Yd0vqptdZ4fGSwlDMf
         y/S/uZCe8K9ouwDdws1zrrxjoze6PKxwMOQ8PgDitKmFK8vgUphQisVdc+pg/trHdpwt
         wTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815173; x=1776419973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        b=n69w8IR36X5kCUfPvmjfh24bfWcVklmNJqQcVxFea0ei3InGjvNK0hMT5VLZxvm1CE
         d4vx+nDgOIWC5mwq9My6UM/8+17baSD9oADknqnz9BxrVerpwRHUCekbu0mmMQuncaX5
         zTL9p2O0oHuwWvCNDD1S51EMvXNX9jyz+30lkOgcsGur4G5wyjv+B/gZ8pnUxTDvVsWi
         9/JtlzLOTdfi8cYQEew/6T9KxB0WQmwvBv8G65IxJLlBndw8E6Bka4m0zxQrIbIaw6Vx
         tQJQo7JPJ0iHlW5fFLlXLRW9vhoQTN8Qh1osK/i+Hl9h1nugypDioes+AuF58KRfJfKY
         WP/g==
X-Forwarded-Encrypted: i=1; AJvYcCXEQ9d3Y4USA31WkWDC9Jysp7QipMgmgYsjrCMEpAYnZ8sK4bRCHSOj9TCewpIx7+d3pv20pEKeJ5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XF+2eAILVGrUrAziaLmz5m9isLxAmwZAm3cw3G+tZU2qtDjj
	MUG5fqwwZQUCL7hHTLiokNAVA9RFjL2udLM1rmzOx/Sa7TLt0SCtQfZcx4KJqY3+aFq3WoVjm9l
	oMheWn1YyhugQiByE+zMJ0OsFO67pXtY=
X-Gm-Gg: AeBDieuKouHiGORvjL/IkFgHDkTf2LT4HRhGpqeyy/G5mMjlhSXzT4w2kiNKv5XswQl
	z8x/IxnT2yTutj2uLBEOVIZEPJHlDDY12as78lo9vXmVlPhGGRgQ+6DSUM0uLfmUqgxiizVNil0
	ZHJJ/mbbl5U3A4tMlhxfRCgo/AvX4VNKErCjwAyEjRqTTMYXL7B3rUz9XtjB4du4AJ+5iTKgRMN
	JfE3p39ZmzMCyu7BduHIhkbhnSzXeJXkmD18quM/pkJRA6RGr+3C/X5JTDVbiy9CQB8BImpcTYy
	5QpSFBLWaveWBOcK5bZufLXrWrmGaXKkJJcX2vWtYw==
X-Received: by 2002:a05:690c:83:b0:79f:3715:1980 with SMTP id
 00721157ae682-7af6f907f77mr24281587b3.12.1775815173216; Fri, 10 Apr 2026
 02:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408053037.1867092-1-a0282524688@gmail.com>
 <20260408053037.1867092-2-a0282524688@gmail.com> <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
In-Reply-To: <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 10 Apr 2026 17:59:22 +0800
X-Gm-Features: AQROBzChhaENjKRgm1eiXEkKC5Ek3HBghHXiZXP2Ngye9h9-wWZ61ho7Hz-V2Tw
Message-ID: <CAOoeyxXqUbdd3Y0VorzVVOARVpoEkx033sYrv5Hs4tRfst2tOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mfd: nct6694: Switch to devm_mfd_add_devices() and
 drop IDA
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: tmyu0@nuvoton.com, linusw@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bart, all,

Thanks for the review.

Bartosz Golaszewski <brgl@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=888=E6=
=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Apr 8, 2026 at 7:31=E2=80=AFAM <a0282524688@gmail.com> wrote:
> >
> > From: Ming Yu <a0282524688@gmail.com>
> >
> > Currently, the nct6694 core driver uses mfd_add_hotplug_devices()
> > and an IDA to manage subdevice IDs.
> >
> > Switch the core implementation to use the managed
> > devm_mfd_add_devices() API, which simplifies the error handling and
> > device lifecycle management. Concurrently, drop the custom IDA
> > implementation and transition to using pdev->id.
> >
> > Signed-off-by: Ming Yu <a0282524688@gmail.com>
> > ---
>
> This does result in a nice code shrink but I'd split this commit into
> two: one switching to using MFD_CELL_BASIC() with hard-coded devices
> IDs and one completing the transition to devres.
>


You are right that this change is trying to do too much at once, and
splitting it as you suggested would make the series much cleaner.

After looking more closely at the ID handling and hotplug
implications, I realized that switching to devm_mfd_add_devices() and
dropping the IDA is not a good fit for this driver. The current
mfd_add_hotplug_devices() path uses PLATFORM_DEVID_AUTO, which gives
globally unique device IDs and avoids sysfs name collisions. If we
switch to devm_mfd_add_devices() with fixed IDs, multiple identical
NCT6694 devices can end up registering subdevices with the same
platform device names, which would break hotplug support when more
than one device is present.

So I think it is better not to pursue this direction further.

For the next revision, I will drop this part of the change and keep
the existing MFD core logic, including the IDA usage. The series will
focus on adding the nct6694-hif MFD driver only, and I will add the
IDA initialization there as needed.

Thanks again for the suggestion and review.


Best regards,
Ming
