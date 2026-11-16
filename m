Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794833713;
	b=whhjXxbhgRTUqeHqCI6oGt9YzHcHWvGP4c3PbHQtNfbOfgmqII5zQTSLsIEvJ8jgo46b
	 53394v30VeEW7wo2aRtVdoA35grVUsP0BmbKALvB1g0e+YUYiuc9o+GXgeMIGNfi9I7mJ
	 kd7QJ04R7QKvWw7qTzyCQP8Jk7ZtZdh7aHFvifTQmBGBhLv3tYkWF97hkf7H80u8B8/oW
	 Xbx93Fazqb1/A3lUuOJNwirgdCoZeKjzi+SBjehYKXFRH33Mm0fgSNoHyyewOuSLXubUB
	 MmNP1NU1bBNjyt1UrNAuWjlVvPmabxNBzUORXBuWF/CayGKkiweo7FVT1tefqG0cZtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
	b=aWG1Jj8TfUwm8aQKUv2JvAk9Lgl4S5IngQeqOqOnshkJkVNR1Q2iRSbwzB5VGTZiT2jK
	 PLYS11f5NvSsFZ724g/5zSBlC0QSCEzhQ662sXivFvCnATqneCDVoqbZgk0kWPJmNIMQF
	 1TSmINiiOyFE2nKjqzq5nDjfewW73rdCFFvT4J04THZt3+wt2rXo+ZADZEBmCHkrBrvbh
	 x2ROokTVH5JV2nk5Nn4HEauQsz28Zjw6otaw3HgO8pbf1rCdPuIgfqhtZrV4fXq5MKizH
	 jzOXCwm8qKlgQBMo9qGgJr4Nh19MH3kcRygn2CWfdy6seA+yRPS4OmS/9UQKjTeyGdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUdkIEF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F583606A31C
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F583606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUdkIEF
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ae25dcbd81so32644641fa.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 04:55:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794833711; cv=none;
        d=google.com; s=arc-20260327;
        b=fBvy7YV9jpZGx1UGHkKmdc/isNiNLVUjPyfVauMP4S+Dn2JrFyVr8GiXgmPwahosmC
         z0xhJvR1zjYMt/5zljp2kg/Omr7GiON2pRuRnc+k3Qfjb14AFEriCohfuikj8/m0E7e1
         rkifJZCL4WcNGMmVWo4ok+5sb1BuKgT+4OzCsmApTcaOLGot4HztO2Lu+xjjmyPsRVNe
         f2hII0VKVRgmUtTjwgbfDlMEC8gMUfxjg0XS4HMhboRpgfLim1k74uDUbL+MqwnNVg14
         K5Tb4wLYXgU7+vMMQaFeQqcGnolIO8LGT0zOvePajHtXvt1PDmsfDmQ/g6xSg6xdBJBK
         dYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
        fh=wUAOkfvSzAcjKVFcfaeoDb/sSFN0hZjB06Jjs1G2FmA=;
        b=ZorZitTG7TGRv0FxNXq9H4fCH1kkIlhZYlr5/TASSjqgBKxdkWgA9k3fE7aMfftKSz
         KS/X2s9JFAFwgbm7/B/2AwlHLnhAq7ynYQhywG5Jmf+0uCShfe8GDUiK4hGO90w5TuMo
         lSRh4OHKG1Wtvf/F9dmXzPU07phCP6cBIs8XmX+F9lg0CRLxDuxgNDrx1UwtUfFP0S38
         zo08QhLMLquDNf3RVN24alh+DEY5wtZbwOVmB2UczC2qIQxRk5GVdPUFExhgNAr8E1eO
         CC7xwt+ngdXl9a2aAAFqeLXEk5JCObXx1dLcaUJ2GMXG0MLbPHA4wcMLFsrnMRKSA627
         RCXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794833711; x=1795438511; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
        b=rDUdkIEFHrVKOz8Yvn2/z37kQHYyt/RDgEnYYDsxPf9B3RCtONXGSL5Hx8JluI2Y0N
         BURT4yQEt1oJMuQWNuXyF1iDH5LeQX7hyGplVkJ47E35SMjNM6B2+7LsFZM6bhI6VZsE
         pfrnsYnz69WuHbP4ykHal2SGhvXiGjMN3qzopwCsZITjeoE8p10L9OgThc575Wmy/iBe
         hgFZXxHyN85hNo6AstzNv7QuQNwcVveoOFP1qqUH2yB7rAqFGoQpOauS9Ht7+hYcnBVF
         iYlXG4Yi/iih2ptmiLjZWQ8t9hI9qtTjEDjHLvfLTtD/wCTC+bTOcRbXqyTA3FCliXGK
         Alvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794833711; x=1795438511;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
        b=vKzHkxfxD/wFC0A25EGv+i6KZQ+1lmIG9l/al19JD3AFDJBOb4L6dq6hUjgbIkToNj
         6gNR7ZhK3UBNcWK0JKsnPxwN6Xm1I8DRVMmJ3vTeq1v/LbL7zI2J+SgOFmRhnRCrKi86
         QswohuSelKvIgd8vm11cYcKbkcU4PuiHfUdtIIBH3N8yd3dMjhldeMsfz3/u2+TY5d+3
         sBvz4nXlwZtj1pSjPKw8vCKG1qKYLohjn4jiHWUFKiWP8Qkm4ZTyvw7qOfQQkEI06LgR
         RoRv3ssAlY+5RmCaCER0xTc9GawMIGTJ+wQixcAOeRhO5JG/Y2Jazjq9RlKM08gQUjt2
         /iZA==
X-Forwarded-Encrypted: i=1; AL+hErGxcH3ii8HtRERU+8eHWfnlB5L1Hp6cK9HEZJBzmp3S+NdEXvCMcqcofeoevQCr34+vRlJ+TM3Ox+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PmmYz/M9T6lPyYamtHvKqxZtoNG8XzAXzgn74U1fovAywrVuB
	EnjoEghvjcZ+p2tAZBDrUCw0qoKbCPBPdI5CbccQE7jMH2Anx993B4Qq/UX4HOmkKyefwjEf3I7
	Ba5pC9qlzGJPqSvgH/L0CtIW+bpytvLE=
X-Gm-Gg: AYBFou0noa0NX2oCVOSEtoO/RNWPa3w/9gk+QcwJlIO3tMBvcW1wd9qwTWkbOZNJwxP
	rFsu/s34deFPKvp5hVlNUZDxp7eP2StLtPKxoNK2KESTG0z0N+TrlSJ3q2gQJFynOKTjU/WFaDY
	zHWn1GOb8Be90nxk1Z0rsAJyrgXFlIlQZm6bstoTwDVwz9JTZTP+WObe1uC5HyZ+zQnmzIrYMWL
	Actd8sm7HRend4LqfcUw8fu1mxY8SloWnS/9pLBKIaJWAZnyE7vYxITRWR+sAjGxvrnLGX+jAEQ
	ADA5G2DBcWC1jy4HCOCX1XZevUsod/GSGhRrQWbvHzDNBm/rzSmYqO1LWACuwRtOLj9zktTJWo9
	HxCFaXZcLiKlP9gebuaGFijl/4KLSmkB+ehUTDE2cI3ORo4HsA06pmVPh7jXQ9rVIDp2BqKUdqD
	Kbez1Q+99PMx5lpi+ycTI=
X-Received: by 2002:a2e:ab07:0:b0:3ae:25c8:dc84 with SMTP id
 38308e7fff4ca-3ae2b53a651mr28470961fa.15.1794833710970; Mon, 16 Nov 2026
 04:55:10 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: A Kishki <alaa6394@gmail.com>
Date: Mon, 16 Nov 2026 13:54:34 +0100
X-Gm-Features: AclHuK_wKENosxNMnjaz2CMZgmvlOpLLh8FDu5SjExkjedGch4987GIiOjTGO0s
Message-ID: <CAO6oLZEsN5gkaDvS97i_7bgPFOE-5eX8WjmGcWCcYHvTMQm9Kw@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: testyiprywatnosc@gmail.com
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, lovekeshsolanki00@gmail.com, 
	linux-i2c@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I found the cause on the same laptop. It is the SDA hold time of the
touchpad's I2C controller, not a reset race in i2c-hid.

Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
(08/18/2021), Ubuntu kernel 7.0.0-43-generic.

IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):

  normal boot, touchpad dead:         0x00010001
  boot via HP startup menu, works:    0x00010048

The ACPI tables give no hold time for this controller, so
i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
time setting if no one set it"). After a normal boot that is the reset
value, a TX hold of one clock, so the touchpad NACKs its address. The
startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
workarounds help, and probably why the live ISOs worked, if they were
booted from the F9 menu.

To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
wrote 0x00010048 to the register through /dev/mem and bound it again.
The touchpad probed at once and works with hid-multitouch. A rebind
without the write changes nothing, because the driver reads the same
value back.

I run this as a boot-time workaround:
https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix

A real fix probably belongs in i2c-designware, for example a DMI quirk
that sets the hold time for this model. I'm happy to test patches.

Thanks,
Ahmed Alkishki
