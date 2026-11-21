Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795252602;
	b=5sRv8KbvotKrvb9uXANwCHjMUqAEJ9gNsP362Ms5k+idrKx2KxSMmDY/K52SwoWqicGX
	 gNbLNYUgXf9syZq+520Zidl6HcQHoPtDTquFdTW+ZTUjsFfEF1dk6q45rQijn0Dow0QC0
	 pF/5daSfZz1zdmPsZqjCvxDGuhDs+0sczb2ihs+gJwFdswMynhM76QfmFSHBRMcGk/AG8
	 wBp112lCjzU3CEqzffsNg14XvGLWMXGRYbeMOORQAbsEMfOR+Nd3bmiMcnNg/n4uaTgXM
	 s9Ox0qnKN8Xf7T5gF7UhvwqdhbtcJcFMgkABAln27e76QqRBl78RCWje8jMbwFdc23w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795252602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
	b=rlYGcTjN7N18vPauVv/66lXdhbUegrkYobVobF0udV0Wr29u0zLXzO9hzm74dUxH++j6
	 qm9Pn8GVoN6wEbdzKQHePOnabrSNgLnm6IxKfo8vWN+Q/Y/xIYAyXxmL5aDb2AkQswQBl
	 xvfoN/fg+1f0n+ClQz58mv2Cr7tMOGHZ8UDHOcuQ/sTWucICt23GrXgsl9AbcJ2Se2IEv
	 7wHbQRzW2wmEW75PWlNbabRoEQMrToaQ3H+NYRZ6gw/FxCSW+svIuMGavHJdw80mlKAFG
	 0C06xqdYF4c+Z/VkummSs5edl63hi1ZGbmZL93Pysd17LngTDGDUaM3vN/pEkvE+r3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FrB49q/N";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687D606A320
	for <linux-i2c@vger.kernel.org>; Sat, 21 Nov 2026 09:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E687D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FrB49q/N
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5366ae57896so18337811cf.3
        for <linux-i2c@vger.kernel.org>; Sat, 21 Nov 2026 01:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795252601; cv=none;
        d=google.com; s=arc-20260327;
        b=EM50yi9flQcDNKdkRm7NwW+vQqzCscN/EG6wButhTT80VUzJs6qcBDLEFP1rPdoRgT
         X6fM60s5GkTSqNMNeL+c/gGzjWTl1DnVX7mpmSqoDKMVnm5Qxh6+VMojPmxsrLyo+RGj
         gGVoc+Th2FgC3EC0tihSQoXqbgx7tcZTuvnRe49+S/XDRp2PR+YO7eDr6hPiLcjON+0E
         pou1h6XiY+ZpCcX06q5xF65oNMhLrucrwkzS/XxEecw6xoidCucanl6yyqNeIa4mKeBB
         YtejRrW1P41pKiszctU2Ktr40QijIMmXZWqCvihTezoBxZk/HjsCMjDcKOgKg8hYYGrS
         kzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
        fh=H+KR/0/mm6esCvXDa4EXI4sper/t+xI8mbKRKSxKRao=;
        b=FXjcYCMiIYUGfMoIL8lHBkmBCLnLwlxKaxNVmdy8shTVspBVOT5i3g2h/KTvSfqZwG
         7ugILPsYov1lGNhxLdPypY2arQJm3tSv5V3vuPyUydc/WEcA5ZmC4WcD8VHm7xo03BHO
         6MdS4528O5Ih4Be3clB4rtwhxbyMN7+ZKRt3EVowzqmsuCexxAc5dFcngESQIlJ4kKML
         HmoRiUGIorWd3rxHDK/S886KNQFa9a/qOnVqZ9fINjFgWdHHE3nM3xnL/yfkHOB5OniX
         Yr8eGIf0CiC4Xt3Z+wrNoUObHyigKpwyvB5EjsNjkl3m2D+EC/TArXwpUwIdBgB7QKlF
         haGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795252601; x=1795857401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
        b=FrB49q/NGInqbswWV4b5DupYEM1AOAsEXsFXaq+6sIXvhpWVXJFnJl8d5xh3I/wxDp
         TZfvIeIxdg0RoU38W0pctgCPSH6htNH3LORCMQ/ifrkQgkMWLehXuycM9XFs8b12QZPE
         lA/i9Dvw8QAci4N7jEZGXYAeJX3qErCdaBVkSUmpm5531/qa/i0Dnz6LCHiwFGPXVLYt
         gpiOv+eEbb+s8WE4NpTkOMEZ06FOfCi9KbwpCiSbba3R8OqQtTDYS6rxPNUQBZEg+leF
         Oa47L1RVYFB3Dl5bHqDv6nQrcvB0MMDqoiV0pnTMNQtohIgHkz+Do44dQ9RblRXou2n6
         MTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795252601; x=1795857401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tO+IQ5hYrrtUBsmyHcx1yxw352wTLtQe+MwwVJsglzo=;
        b=oLKvGWpwWk8T+W7r8Xz+s526lT2T/cxr/NbkIix4FDDxgZg6uUKn3M/swIwM+/D1kS
         y4jgbcHI3jaAOiQaCOG7ayJJP/yEK1annBKHmTdvSCi8G4+7TVBGFehsvz39qZNAuRCP
         y14I3U8uC4U9fc7lllx2pCQLoWlVvIAdoOPiILwWLdu8UKrSKqaRRYXLgsKMw92vasNQ
         cTPp0zXaNCegoNYgwNSAoytcbIj5F4kOhT9iFfccVdtj09sP+TU6Gz2D6iK3haxcacSE
         5ePPIvmw3DNsSLx954aA2Rhh0x+8h5G1Lh14RCHL2g6lb3qHazCy4Z/+messZtWSb8vt
         9ZgA==
X-Forwarded-Encrypted: i=1; AL+hErEVAMbW0FY4GmANk1uzxFZo7or3Kz61EAJKjy4PUljepu7AHKEsbkcBZJ7T5NjUIfSQEnnOGrRPm5Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nXkUH93evLVjIw2ONRdJ0q2oP6HsXqxU7x6dow7yWOql1NhWI
	es2RHb5FVeGYkPLPX0Fh11G7xfBmHZgabDs9hNSpt19NbH/qlkmhD6PZVwSq5D7DjJseMIa94+O
	A0ed/vrSQKeKH0h96QLhsu8uj3VPd5BY=
X-Gm-Gg: AZFdTZdnG5oOcc5m1rKrLqs9sf/txRsAF2AM9idZIsd94+qwgnBh5nOvR3r6Hma2IPL
	07ZViTdoDsIuT7HDZBAs1oRHyVU15isq3A9PVWaqAyoUXx7yzDv7YApK5fTaq44NfSK1phL5OBS
	TZGL2ERQEn5TFtWWJRdfw0uKwi+zXsQG/gfgbAoonIqPb0Kbjcw1WBVFXCGoogTy5UBa9pWeLLq
	8aYfGjoUOePACWaLfQYMPQI/rA0njmVWAGaaAwyMRbhZyJnWy8l2nXt+OEntu83WajkIgBncteV
	PSBNQOS2bdfTBP+ANIUKTiHd9/hgjE6qGkT1deFO/9Fs7e6UPVLHqfttHg6JOuzBG7oiZ1F4BXU
	A2URYQC8nMga3BXdaUFLtF7T9j1fst2TbMJxpOJ0hGFyG+MrgTKHMbWOFYU79zQ/JRJmPlQ==
X-Received: by 2002:a05:622a:5815:b0:54b:f7a6:5354 with SMTP id
 d75a77b69052e-55d76a27b40mr96605951cf.26.1795252600828; Sat, 21 Nov 2026
 01:16:40 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO6oLZF6OZmWeQWo07TJ+GpVPz_LGnwd2cyuiJWD-6JuuiJnZw@mail.gmail.com>
 <CAO6oLZHcHxp0tfdgFNvX5WucVe9AOYM3mBNJHFOrEa3YC15faQ@mail.gmail.com>
In-Reply-To: <CAO6oLZHcHxp0tfdgFNvX5WucVe9AOYM3mBNJHFOrEa3YC15faQ@mail.gmail.com>
From: Adam <testyiprywatnosc@gmail.com>
Date: Sat, 21 Nov 2026 10:16:30 +0100
X-Gm-Features: Aa3M54ryWe-nia4M9Q1ukuyExKMCK8n9O_DYx5CThGSr8x6rSKTl5VXn1VRWliE
Message-ID: <CAEru=6L_Z0bTENvObfQei7G3gMTR-ytdfr5pRPkALtbc+s4FFA@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: A Kishki <alaa6394@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, lovekeshsolanki00@gmail.com, 
	linux-i2c@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Thank you =E2=80=94 your SDA hold workaround also works on my laptop:

- HP Pavilion Gaming 15-ec1xxx
- Board: 87B2
- BIOS: F.35
- Kernel: 7.3.4-arch1-1, Arch Linux
- Touchpad: ELAN0718:00, 04F3:30FD
- Controller: AMDI0010:03, base 0xfedc5000

The controller had IC_SDA_HOLD=3D0x00010001. Changing it to 0x00010048
and rebinding the controller allowed the touchpad to initialize and
deliver input events.

I installed a boot service using your approach, with additional error
handling. After a normal reboot, the service logged:

IC_SDA_HOLD=3D0x00010001
IC_SDA_HOLD verified: 0x00010001 -> 0x00010048
Controller rebound to i2c_designware

The touchpad worked after that reboot. So far this is one confirmed
successful reboot with the service; I will check further boots and
suspend/resume.

One detail on Arch: mapping /dev/mem while the controller was still
bound failed with EPERM, despite Secure Boot being disabled and
lockdown inactive. The kernel has CONFIG_IO_STRICT_DEVMEM=3Dy. Mapping
after unbinding the controller worked.

Thanks again for finding this. This provides an additional successful
test on board 87B2 with BIOS F.35, which may help scope an upstream
fix.

Best regards,
Adam

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM A Kishki <alaa6394@gmail.com> wrote=
:
>
> Hi,
>
> I found the cause on the same laptop. It is the SDA hold time of the
> touchpad's I2C controller, not a reset race in i2c-hid.
>
> Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
> (08/18/2021), Ubuntu kernel 7.0.0-43-generic.
>
> IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):
>
>   normal boot, touchpad dead:         0x00010001
>   boot via HP startup menu, works:    0x00010048
>
> The ACPI tables give no hold time for this controller, so
> i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
> time setting if no one set it"). After a normal boot that is the reset
> value, a TX hold of one clock, so the touchpad NACKs its address. The
> startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
> workarounds help, and probably why the live ISOs worked, if they were
> booted from the F9 menu.
>
> To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
> wrote 0x00010048 to the register through /dev/mem and bound it again.
> The touchpad probed at once and works with hid-multitouch. A rebind
> without the write changes nothing, because the driver reads the same
> value back.
>
> I run this as a boot-time workaround:
> https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix
>
> A real fix probably belongs in i2c-designware, for example a DMI quirk
> that sets the hold time for this model. I'm happy to test patches.
>
> Thanks,
> Ahmed Alkishki
>
> On Sun, Nov 15, 2026 at 10:53=E2=80=AFPM A Kishki <alaa6394@gmail.com> wr=
ote:
>>
>> Hi,
>>
>> I found the cause on the same laptop. It is the SDA hold time of the
>> touchpad's I2C controller, not a reset race in i2c-hid.
>>
>> Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
>> (08/18/2021), Ubuntu kernel 7.0.0-43-generic.
>>
>> IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):
>>
>>   normal boot, touchpad dead:         0x00010001
>>   boot via HP startup menu, works:    0x00010048
>>
>> The ACPI tables give no hold time for this controller, so
>> i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
>> time setting if no one set it"). After a normal boot that is the reset
>> value, a TX hold of one clock, so the touchpad NACKs its address. The
>> startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
>> workarounds help, and probably why the live ISOs worked, if they were
>> booted from the F9 menu.
>>
>> To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
>> wrote 0x00010048 to the register through /dev/mem and bound it again.
>> The touchpad probed at once and works with hid-multitouch. A rebind
>> without the write changes nothing, because the driver reads the same
>> value back.
>>
>> I run this as a boot-time workaround:
>> https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix
>>
>> A real fix probably belongs in i2c-designware, for example a DMI quirk
>> that sets the hold time for this model. I'm happy to test patches.
>>
>> Thanks,
>> Ahmed Alkishki
