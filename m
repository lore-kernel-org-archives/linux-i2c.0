Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3316175A69
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201555; cv=none; b=OevumYbl8UB3rXPs8vG/WT5SafGF4kPtfaARXxW0t3VmRxNaA+pCeT/eGHglGxWpaUdY7HdC6NZ6W2HB7CR2q5kZBP3hLBqyi5uZmy4Xh2qozvECRfDSeqykPXBkgfz+PmRt1p3DKdVOQRHduqfzKVPZwSmUZXPJ/o5t8oMyE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201555; c=relaxed/simple;
	bh=uHSgj5HDh0k+KYAjBzazfDNRLKFkmF3zX6BBZ9bOpdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmPrrlFwRQG2HZgZQrgHuIQoKHpFKTG6PtTE+sv+GqMeJketyH6k/gtK/SEkP718tLH5nrXsxXWnNxt28sx4LDLUNI2d+05IEAmFr7qfUlmed+sf5AMKUxnLoRjsOcRnjJJc4Yl6glez686xuuDl2jBkzFF0qxUKI5Rai3cNABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvSKJ8bJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvSKJ8bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF3C2BCB3
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779201555;
	bh=uHSgj5HDh0k+KYAjBzazfDNRLKFkmF3zX6BBZ9bOpdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dvSKJ8bJEfLvc3805/MYHmEyMlJUR9px5RuT+2NwPrSZAh3vFP3ajiCuk2g9w1W0n
	 FnTzS4gGjRA/zjT0/kK2BllR1tzjwVlrHQaVYOc6i9SIpexK4obZT0E+l3/NIDxzd0
	 v7sXPt5nEqIaxdmP/6hAH3CDZbqd+0YpyK73zrcR+Y0XBxYTONUXuCT5BX27/QRzHN
	 47hDhyVsQ3568+sE9D1NCCxSYEvqhlGzLzWKadXo5RuYzIsFNVEveWCMsLoIg6au5/
	 Te6mIDc2irSpia6naSszshbCNt1UPHU9mGsxqb6Ffdqym0TOFJLLEKUSb2inxeRsao
	 nn1pfYN/2gFdw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so6719678e87.3
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 07:39:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+rbRuaOP5UnbYR10u3XtrrTY9X7U/spSh/RPh42XgsrsXm1HQC5Vywl0q5a/hKCnLldmOJP90we7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEL5MmONtvCDxTsyG2d1O3TUScoib0C6PPInUsVkacs57P7anr
	dxqGBpjOubjI8nCydZ/QXcP3OMpm2dmlXx444hsRq/yeIco40+G6wwykd7R9c9fptneUFUE3tDU
	NYm/pmLl2eHBTGKoY4MrOiVbqQ8PQMFhriMqcxxdj8w==
X-Received: by 2002:a05:6512:2241:b0:5a4:6f5:6c4e with SMTP id
 2adb3069b0e04-5aa0e61dbecmr6778725e87.19.1779201554005; Tue, 19 May 2026
 07:39:14 -0700 (PDT)
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
 <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
 <agsh652HlC4rg1_1@ashevche-desk.local> <CANTFpSU7XaNKwe_FPsTCkxQYeq78Tqusr-nsB-Ww0_teuiWdEA@mail.gmail.com>
 <f0ee2722-1e56-41b1-b70c-5503a2495853@amd.com> <CANTFpSWT+cR8Yxyr5jrB2MUidqKteWuPjHOyK_rpSkDUN6SWQQ@mail.gmail.com>
 <c4993bce-5d39-416f-90ed-d870f4ac9254@amd.com>
In-Reply-To: <c4993bce-5d39-416f-90ed-d870f4ac9254@amd.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 19 May 2026 16:39:01 +0200
X-Gmail-Original-Message-ID: <CAMRc=McSLEF_nrkRdJJu9=Bc_KmPWYKDHd6tOD9tJqs0fksv0w@mail.gmail.com>
X-Gm-Features: AVHnY4InVnYSq63BJ-iaOIhWG8RU-27KTOC34DtVfiCOJ59nAK13h3RM_R7kKVc
Message-ID: <CAMRc=McSLEF_nrkRdJJu9=Bc_KmPWYKDHd6tOD9tJqs0fksv0w@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, basavaraj.natikar@amd.com, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:28=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> >
> > gpiochip_add_data() at 0.285952 makes the GPIO chip visible to the
> > system before amd_gpio_probe() has finished. AMDI0010:02 starts probing
> > at 0.301454 while amd_gpio_probe() is still completing. This is why
> > device_is_bound() works and initcall promotion does not -- it waits for
> > probe completion, not just gpiochip registration.
>
> What is the boot time impact to adding device_is_bound() check?
>
> Bartosz, thoughts?
>

My thoughts are that ACPI could use some fw_devlink. :) It's not a new
problem, we've fixed it for OF systems.

Could we modify gpiolib-acpi.c to return -EPROBE_DEFER if the parent
device of the GPIO chip is not bound yet instead? When resolving the
reference to the remote GPIO controller we have an address of the
struct acpi_device. I suppose there's a platform device that is its
child and then the logical GPIO controller device, is that correct?
Can we check if the platform device in question is bound at the
subsystem level?

Bart
