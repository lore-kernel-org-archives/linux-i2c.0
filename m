Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACD38398E
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584248; cv=pass; b=OaNDabJBvWDl9w84yIbCz1LaoVP1KqBgrqsz+ldMjr3/1D4K6coUFg/A+muvicZEbLjXGqsTkf8D4rXWM0V5Y84rZhnifKYxR6vxEyeZL2zNnxQOEyfl2WcJsdeYRzgidnvbOsE4Bu4DoOhj+Oo/DBhRgCfrv56kGHsj9DwRLmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584248; c=relaxed/simple;
	bh=R509GgJQHdK+0hnI8YyvmuJeQo3P8HBd/6X9MujUNy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3wqpePdcHAuZkLzNG05xfIgiSdHRvq21BkVG7Y8sooxdsSiPojNDZgiTCX0HFBjZ6pCcBkHTjJxAISyvKLaUvFIW5Xk1yNRJJNC3mFYLoq4YOIc5qz7SHLlggFOc0cNvcu3APV/qkg+OA+KzxDQ4MUx4Hh7utSnc6EKZ1sGCT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6jFnuGr; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6jFnuGr"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7c0dea734bcso28799497b3.2
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 04:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778584246; cv=none;
        d=google.com; s=arc-20240605;
        b=ja+wNY/C1h3BgFZBkf/lMbhmZj4yjq5GOfByIqCGyD2GFz1OPpA0ga0YxVbO6B31i3
         dYbwutVZh4/n0PEAH9p5Uw05EZ7voVhIkqJTFn9AXHC2jhgSJHFVtKFN1r1/q0miS19A
         VJ3u5NcqUiKAksQUTL9SlDHdCtqVrrXMr6F0WO5C4FoQECpzXbhTuKOu835e+AR+29n3
         lyTb5FSWeE0J3RpgjkhTgzrgeMcpRmlWgPd0YNHBY2ntRintgr+MZ+RiA0Lq62FIQwhu
         vXmuDzE+72GNoyTigLeBatSb/G9CtXUJ6KJykG+H0UEx31CNFr55s7oghetrRB6KwK/3
         xeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+pKJ+Iqn3Uvr+SlvvrO7l93hbxmujnjKMsO3TefjE0=;
        fh=lfUJyr0W9A9IWmi7UmXOB3j699/ieYcdIi6H+txP7jg=;
        b=RHenFP3yJXSwIrD6K1bUbyogVPIh1QFCXNltDR3Q2xdLOPCOXwunqMJL7AnB7N9tya
         ioa1P8KBvtl2KsHgAQrGR6qoAPy+tZBzp84aNiB+vm4CzOAy3GH8SgFrbs03dGTj2RCC
         y8fGRGFelAXB2GqJG46UYGt6Ye88lJZdJgYoG/eNvLr5LUEIp0hfAzB4G1E1Qm8l2KTw
         6iM7TaxnLyvwCFJ2YLjiH6wHrf+riH2tfot637FvwFeUhnjofmrXQSEqi0BYNz/ojfNq
         Dp2JP9c9XSLzQ6Q5wd+Gza8MrKIv1cpbRyM1tNUBcHo4otJ64aq2dbBKmXl3tHQQTLCp
         HfsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778584246; x=1779189046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+pKJ+Iqn3Uvr+SlvvrO7l93hbxmujnjKMsO3TefjE0=;
        b=K6jFnuGrtdusrW1OuzVLCJK/ET1IF3NqSVYdpDSd2UnJtQmCSQonjjW9VwPSY4rxWn
         KviCS8+ocwl0SJXFtj4gOJuk4TfTC3aa6mM44+YZZawkpSnpU/SnK37TpM/XaP6gjyCl
         sMbkQu9B594XruCpRuZN9uoCWoy//OhDi1paIirPdQklLcFZS4R4BwtwfviQ4w5yZ5WA
         UQ+2iQ+hYUoRXKUMu+Ryn23If226eBoa3C6SqU0ASFL81J6ulHDREWz1hm6IYNrnE5aI
         YJxkgmec3yoTBv0fR8R/D63TnJaNgiKz92ruWBfywdo16t7ZjO6qPYbX5ShuNc2/FeM3
         euJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584246; x=1779189046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+pKJ+Iqn3Uvr+SlvvrO7l93hbxmujnjKMsO3TefjE0=;
        b=Zi7M8Plj/o4+XeoeBHUmla6lRs8xuDwoa5XYkqWHjgtMTvFkW5KG33+GpQxMPp3209
         +Zmh9/PJ8RZwKf1VwYnk77vkN2yWXLjOJH9a4fr6Zsb2uGsEa5nMxGhDM2ZR/MPaUlud
         Bkw80xkcgmeIr5P1t2mbKOOcQlxxvV3HPTtK/E608MZewv8Tbtwk5/+j9UffnHnI3WsB
         IEfPnWnJOFe2wBVM0odxGqEiME1Td6v5Feyooc4ozXEu36CercSmMDeaF8RJpijTufCR
         XfVniNv/8W674pNLN+EmTtx6kFNGEYtVj7fN/Hl9XQmmMZ1XDWzN/E5734c1r7g97vi0
         H/3g==
X-Forwarded-Encrypted: i=1; AFNElJ/zeEvPj+nNxYcTJCJfyDUHGKCpYvpuncPgJb4yf0O5fsbSo5JlhVjaFZ/jA0AV6ZD0CrHA1z5Yyc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsu0oqCKU+QNWsa7AcQEV/fYbA6mwWxBllzIpwn+iKeEX9LS5
	xKsnG5lCEEAqM92QVsDwFRI7qeR/ZOs09+eWkC1L0K7xemxZDTCrSiZCOW6qX0TCLPA7UqwM2BW
	+REnAefV2/JKA4/ivoLmOo5vsv/OAcKE=
X-Gm-Gg: Acq92OH4pxHxFBgHECH2rljKefmob4JIioWw9HBF/NMx89NRlebkP+H/JJbnAa9na3t
	PpY8pGYqdUwxOrDowqKkZOG1yRm21ngs64YaxqArinMkV2pMDQjbBy3EeoPvhwFzGcMPuteVmP1
	0fz3Ity+SOU5sBMndtoBtO06tB3VkmyNwYdlcCJBddf/migCBDYJhEQ9vqbGiTzNuYpGx7eWqek
	w+fZ/RcaVEL5ac4ql35n7zMRJzT8HWaOIAjldVBHr8eQzlce2/vhR0CzblvT1zwoV/lyxZSI6N9
	VJftD88Hq6/EtuetFBcUGojDk2p0ZOyVReQrBXayp8xhsXo5eTUJE+gEFtxbQJ+dgBrkjq4FGFQ
	IVrE3aGouYhjcQ3bMCZeT4aAPZsO1ngVc/JvTt2Tp8ZqcmVNnFlX3xm1N9w==
X-Received: by 2002:a05:690c:6e81:b0:7bd:5cc3:f8e4 with SMTP id
 00721157ae682-7c102d41310mr131723057b3.13.1778584246421; Tue, 12 May 2026
 04:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073139.16343-1-hardikprakash.official@gmail.com>
 <20260512073139.16343-3-hardikprakash.official@gmail.com> <agMHIhMzS_8AicAI@black.igk.intel.com>
 <CANTFpSX-U5pJ3zQ7NMQMpSu+bw1wB5weW7E-oQ51oE7oZg1cZw@mail.gmail.com>
In-Reply-To: <CANTFpSX-U5pJ3zQ7NMQMpSu+bw1wB5weW7E-oQ51oE7oZg1cZw@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Tue, 12 May 2026 16:40:35 +0530
X-Gm-Features: AVHnY4JzFdAV39wCJmtBkyd9s6za3RvImm4fBhY_MGtRf6DmNeStCURj6cu3plc
Message-ID: <CANTFpSVr0k_nryChHMFDbNmosUf_=+nRaCDn78HsUw=Nr1rhfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: designware: fix probe ordering for AMD GPIO on
 Lenovo Yoga 7 14AGP11
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linus.walleij@linaro.org, wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking the time to review, Andy.

To answer your question directly: yes, this patch series was indeed
written with significant AI assistance (Claude, GPT-Codex). I used it
to navigate ACPI analysis, interpret GPIO register diffs, and draft
code I don't yet have the kernel experience to write from scratch. I
performed the investigation, testing, and hardware debugging, but I
want to be transparent about the process.

On the technical points:

1. "Existing?": My bad, the commit message is indeed wrong. The
dw_i2c_amd_gpio_defer_dmi table and dw_i2c_add_amd_gpio_link function
are added by patch 2 and do not pre-exist. I'll fix the commit message
in v2.
2. Fixes tag: Noted. I will use the correct format with a commit hash in v2=
.
3. dw_i2c_hid_uid struct duplicating existing structures: I will take
a look at acpi_dev_get_first_match_dev() and simplify accordingly.
4. device_lock deferral probe: I will add one explaining the race
between driver pointer set and probe completion.
5. device_link_add comment: will add.
6. ":00" suffix hardcoded in the warning: Understood. Will correct this.

I'll send a v2 addressing all of these. Is there anything else you'd
like addressed before I do?

Hardik


On Tue, 12 May 2026 at 16:37, Hardik Prakash
<hardikprakash.official@gmail.com> wrote:
>
> Thanks for taking the time to review, Andy.
>
> To answer your question directly: yes, this patch series was indeed writt=
en with significant AI assistance (Claude, GPT-Codex). I used it to navigat=
e ACPI analysis, interpret GPIO register diffs, and draft code I don't yet =
have the kernel experience to write from scratch. I performed the investiga=
tion, testing, and hardware debugging, but I want to be transparent about t=
he process.
>
> On the technical points:
>
> "Existing?": My bad, the commit message is indeed wrong. The dw_i2c_amd_g=
pio_defer_dmi table and dw_i2c_add_amd_gpio_link function are added by patc=
h 2 and do not pre-exist. I'll fix the commit message in v2.
> Fixes tag: Noted. I will use the correct format with a commit hash in v2.
> dw_i2c_hid_uid struct duplicating existing structures: I will take a look=
 at acpi_dev_get_first_match_dev() and simplify accordingly.
> device_lock deferral probe: I will add one explaining the race between dr=
iver pointer set and probe completion.
> device_link_add comment: will add.
> ":00" suffix hardcoded in the warning: Understood. Will correct this.
>
> I'll send a v2 addressing all of these. Is there anything else you'd like=
 addressed before I do?
>
> Hardik
>
>
>
> On Tue, 12 May 2026 at 16:25, Andy Shevchenko <andriy.shevchenko@intel.co=
m> wrote:
>>
>> On Tue, May 12, 2026 at 01:01:39PM +0530, Hardik Prakash wrote:
>> > The existing dw_i2c_amd_gpio_defer_dmi quirk for Lenovo 83TD checks
>>
>> Existing? Is this message and the whole stuff is somehow AI-assisted?
>>
>> > gpio_dev->driver to determine if the GPIO controller is ready, but
>> > this pointer is set before pinctrl-amd's probe completes, causing
>> > i2c_designware to probe AMDI0010:02 before the GPIO IRQ quirk runs.
>> >
>> > Switch to device_is_bound() under device_lock() to correctly defer
>> > until GPIO probe has fully completed. Also replace the string-based
>> > device lookup with ACPI HID/UID matching for robustness, and add
>> > DMI_BOARD_NAME to the DMI match to reduce false positives.
>>
>> > Fixes: the lost arbitration on AMDI0010:02 at boot on Lenovo 83TD.
>>
>> This is incorrect way of providing a Fixes tag.
>>
>> ...
>>
>> > +struct dw_i2c_hid_uid {
>> > +     const char *hid;
>> > +     u64 uid;
>> > +};
>>
>> Useless as duplicates the existing strictures. See also below.
>>
>> ...
>>
>> > +static int dw_i2c_match_hid_uid(struct device *dev, const void *data)
>> > +{
>> > +     struct acpi_device *adev =3D ACPI_COMPANION(dev);
>> > +     const struct dw_i2c_hid_uid *id =3D data;
>> > +
>> > +     if (!adev)
>> > +             return 0;
>> > +
>> > +     return acpi_dev_hid_uid_match(adev, id->hid, id->uid);
>> > +}
>> > +
>> > +static struct device *dw_i2c_find_platform_hid_uid(const char *hid, u=
64 uid)
>> > +{
>> > +     struct dw_i2c_hid_uid data =3D {
>> > +             .hid =3D hid,
>> > +             .uid =3D uid,
>> > +     };
>> > +
>> > +     return bus_find_device(&platform_bus_type, NULL, &data, dw_i2c_m=
atch_hid_uid);
>> > +}
>> > +
>> > +static bool dw_i2c_needs_amd_gpio_dep(struct device *device)
>> > +{
>> > +     struct acpi_device *adev =3D ACPI_COMPANION(device);
>> > +
>> > +     if (!dmi_check_system(dw_i2c_amd_gpio_defer_dmi))
>> > +             return false;
>> > +     if (!adev)
>> > +             return false;
>> > +
>> > +     return acpi_dev_hid_uid_match(adev, "AMDI0010", 2);
>> > +}
>>
>> The whole flow is just a repetition of acpi_dev_get_first_match_dev().
>>
>> ...
>>
>> > +static int dw_i2c_defer_for_amd_gpio(struct device *device)
>> > +{
>> > +     struct device *gpio_dev;
>> > +
>> > +     if (!dw_i2c_needs_amd_gpio_dep(device))
>> > +             return 0;
>> > +
>> > +     gpio_dev =3D dw_i2c_find_platform_hid_uid("AMDI0030", 0);
>> > +     if (!gpio_dev)
>> > +             return -EPROBE_DEFER;
>> > +
>> > +     device_lock(gpio_dev);
>> > +     if (!device_is_bound(gpio_dev)) {
>> > +             device_unlock(gpio_dev);
>> > +             put_device(gpio_dev);
>> > +             return -EPROBE_DEFER;
>> > +     }
>> > +     device_unlock(gpio_dev);
>>
>> Interesting dance. Needs a comment explaining what's going on here and w=
hy this
>> deferral probe won't be a problem in other scenarios.
>>
>> > +     if (!device_link_add(device, gpio_dev, DL_FLAG_AUTOREMOVE_CONSUM=
ER))
>>
>> This needs a good comment explaining what's going on.
>>
>> > +             dev_warn(device, "failed to add device link to AMDI0030:=
00\n");
>>
>> Why :00? Is it guaranteed that this is going to be with :00? Note, this =
suffix
>> is instance number in Linux and strictly speaking might differ even from=
 boot
>> to boot on the same machine.
>>
>> > +     put_device(gpio_dev);
>> > +     return 0;
>> > +}
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
