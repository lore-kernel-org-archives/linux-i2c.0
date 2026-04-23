Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A283DEAEB
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946642; cv=none; b=sZDOwpTt4kUiMrN/S7T3LDFLJgDYo/RcsOYZepyPqMCQhqg4BYHcFAxfYnU3/m1v1HITh43oTOO7SVq1NvpUxpDW/tSw509dPI9chTAgam9GeEZPqwbM90uvxkPB07wsuhVK+zVjWFWQd1wmXR+sq7eblCaQMfL7bS3kNlaKxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946642; c=relaxed/simple;
	bh=EGXTp0wx6AQ9wDHrDij1sKvhPUQTzuTtCxQwrDfCxn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR2f50ih92KlGW9v/7/WQhXBaO0ASQPuWVZ/qU0V8nNFVqUvwpCsrY7hf1tPfu4d5WqgeE2f6WI2mlDwXfHlVFE27RO8nZ7hh/wAq9bqww6xKE+XWj0K9STTjM/7fzKBDnMi3ygdPwIN+oRIUJqRLEpQoIZJP5uzU47VhmL/6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCIaw5WU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCIaw5WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B35C2BCB3
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776946641;
	bh=EGXTp0wx6AQ9wDHrDij1sKvhPUQTzuTtCxQwrDfCxn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OCIaw5WUpGJ1CqRR7u/rSYZiK8JGwbEIdeksWC4jB+60HPkYkAyB7cm44bOw4qFt2
	 fut41QpKI19D8AputEW4KKpAEduwr2hMvy4GQCYe/hWOmrzIajUPUTaij4eQimUIGo
	 9FXZRbF30PMLz9VVX6evvvLSmdKzx5HWOjsOD96rAXc0mOklTNDa2XXPvpqUKwf4SI
	 r0rJIXDugMHiIPC4ZtTr6P/+RDmLduTB5kJV+j99qGWNOurFNxLg23Nh9NODQGbvho
	 qCfgZpNtTrAwX9TSkYCMU3pNawQj0IobHVCcxKt+GR2RlwPR2eVW6sL2KCtpG8k7vg
	 dwv2TItPczB4w==
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c6df0b9bbso740191c88.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 05:17:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwUYuXpxokjIXNClAXzR1/a/EI5A+6eZUDcdT6ayEgKlo+uiiTp
	DtfH/3SKZKYfU/HLV/ZwB4HdDfYJHxGiyBGLdUdr/qbXLUmKomlj2xQtMvUQnWXFjXApj4+rR9L
	XDVS28XIAoSrXYxBYF9p9mXk/46FObb19zn/76qFXyA==
X-Received: by 2002:a05:7022:23a5:b0:128:d752:e076 with SMTP id
 a92af1059eb24-12c73f6c3dcmr15916280c88.3.1776946640543; Thu, 23 Apr 2026
 05:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421140755.54222-1-marex@nabladev.com> <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com> <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
 <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com> <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com>
In-Reply-To: <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 23 Apr 2026 14:17:06 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
X-Gm-Features: AQROBzCO8Sm90soKwBuKVLc0aPo4U7aGgZVfn6g4O6wojs1Zmi3ad_KifJUZL4g
Message-ID: <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:04=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> >
> > I see. Ok, please send a v2.
> Does this patch require any changes ?
>
> I will be sending the DT changes separately.

Sashiko is saying this:
https://sashiko.dev/#/patchset/20260421140755.54222-1-marex%40nabladev.com

Shouldn't we report the device as read-only in sysfs unless it was
"unlocked" with force_ro?

Bart
