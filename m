Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F09189BB6
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734085; cv=pass; b=hesPHru2EtZvaSMLZAlOzGDUo1BhMeuH/AGuwJtnzIFB26yhEgo7KRqN/ArU9KCR3Isv53Vdt929KBOH8vd15sDfwFshSTJNi5uALmu4RiXwXDeipxuunDf5pGW+o8i9RJjAuZuqJI5iwNfIarYOOFD9W/oTzExaVplG9JmDzN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734085; c=relaxed/simple;
	bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RDNpjZppwkBeywz1cl+NViGeIer1TsJyKWR79zd39+N5MhDeyJGc1hVsDjcqBoc49K1c2j0Iz/pIO9Vnp+RG7I8qdcKy5WNpErx8Ol9CF0+kbrCUWsyzCLBdoQ0FgRKz0/WqFv/JxjK8ee/mxc/+16gdXb+v38NNwo1F1Z5uR6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGKLSsZb; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGKLSsZb"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-679f6ee3fb0so3847060eaf.2
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 10:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772734083; cv=none;
        d=google.com; s=arc-20240605;
        b=c1FkvLbDC6KBgawdl2oI4YiOeKcampIY9o2hU+E6DFFnsWxjkd3mzNP79OgjdlqKYy
         S0YQZ1RAEtwD2OXymtEAztTFVISoAio0xk99uxdLfl+V37Y9SMkGFW4Bz7bpKKRQxS5Z
         UBc3X2BmrATCuD1KSglhVssgrfyDyRngduJ6HIOCc5+LqRewmFMu5g/mH7c7/XajGWR2
         DZXxZnhKc3nx68gg+lEOT+Z0je6PVleT/kTPoCmuQp2zWXVzaEoICd2vIlRMzKnC3FtS
         gZtWUxfk25M6iowKvvRfRY/XCTnblA7FZmSV/1Kq6iTWWidsQDDSRuLyI6okCgBS3Pa9
         Bmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
        fh=wMGYPVSxJ5k2h2Ue2iLOkkdqK4K2epU348aP2aSNYIQ=;
        b=L+kRbGUk3SmVYA+7hOZLVso2b71B7QHUphFJTz8H8ikI6JzLDh45l5LgC6eHMZ1lws
         tz7GatRNLBIuihc3W0ItZ+y7fR9VS3CMD+uZl62qwDrqYnU3jVRyeyXDYRlNS42qBJB6
         3OUp7KWyYrrh3IbnUzDcuZg6efH/gRi2DY2Ot0dAvT10iGwS0HU7jth/62lsLMZtTjfX
         mNQuGkAmyYsfFfMuBKbpFkAemmz5Wb43xfBLbGcRJucG7SatPTyauUjVlFMrKqB95PCo
         7RVlX+TChUUspX5Xfk4bboU0ckYqEUZBdXpE/s66/7KtTgTj3vjZC0/w7njX62TyiXes
         B8Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772734083; x=1773338883; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
        b=FGKLSsZbn/2UeqILgRP96+X83NbxO61CSXgmrdoBr+z5QDMxTVpnhFi8sv7/U0WhKj
         B+QqVj7TSBUyRv4ewuVXbDX7QuA6fuCqK1ZsmdK0aWT7FDp+Ks4uYZ+mPu+UaT+6GWsB
         nEGCktuaFLQrK8SAYfcH9SGFky8KQfGd1tPpFGSp5qCPbNuPnOmD0AQcDQxDwgVWFmuz
         sWf0D+soaTi/GPx+CSHcBjwItSz4BOcYvrIUhgTFbHViMzEz2Gx9onTIH0l154vOLHBR
         95ebN1FJXoh146PG/AW+aNaqcPWbXsmGN9BnwkMzej2IVs70xCTV17WF/SDV3aNp6p4S
         qMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734083; x=1773338883;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
        b=aBlJdb3PjW0r11+e9tZePaLZ49gfsa68MQ3FF0WCuLsLTYFhW4XOgqokLtHn7jcwKG
         rew8lsvHUIAZpQp0uFaAg+khPYPtIZfzeLHTOc1gBzedO8NCG3BuxgN07rBew2fvUZjk
         o2bFYAHzJea2ZnjCcj7tjOrWOzGFixUb1vmBq212AatCdk1Drr+0ACF37q4p7A91ORcT
         qY/Mff1PChiOdhz8Ezv8aGzVaekU54YKvai2f3fxAsY26JcQ1xewbLnVOcBjtjgWeNal
         3RpKGH0elwcSmPgzmIiwDwVaOewJ5vm+darMVmUcgZPnC1M4gMtQSF2FqhcCcRrgm2K9
         NCiA==
X-Forwarded-Encrypted: i=1; AJvYcCWQg1dp5/hbdP/hwiNFUOk9Z3vRldwOgbJJKGNge1kmSncw5UvaZaxPOXIL9lwqa0Oj9XhNt/7oWIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuEZ0giBY7vtnSa6xFdVNoJY7EgHn4RFuDoCHzwWaLPrkBPRn
	odBXp8IUXVAvVk7hF5dezQ9z7zACmQ0tuQGRtFvE1YwTuqLeJAzHyD0PS5pFAFK9MGd45zi1u83
	mE5CLDCj9cXfBwpXlC2uU/crXiq2pEfo=
X-Gm-Gg: ATEYQzySjHomIWiZCcE3Auhw6CRlR6wdER7P8g0yiyhHihOfTK+3AQZqloMufzVlnJv
	AuxmTD4tm97gyBeaN/bcP5Idy+YzRI1ZSHOULwcZKx5uDtkV8fCw1Eetp+ReEH357JYv59V3F2D
	LrCw5c4L0taXcS/VXk4E8ssyqA21aCmCUyHEDIRAMvV3H3qCoV2p8IaXGHE1Kqlpq8wDHKkcVsm
	HboqYOFzyNdDrMRJP+q73HJSQxfTnKGy+G6XEAs500TiqDcnRGAineKcQjpjSQG18/txzUXT++a
	JLJnFLf92cdxEoQKlYb/FQ==
X-Received: by 2002:a05:6820:210c:b0:679:92c7:2bfa with SMTP id
 006d021491bc7-67b1775ef53mr3685861eaf.45.1772734083290; Thu, 05 Mar 2026
 10:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
 <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
In-Reply-To: <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Thu, 5 Mar 2026 19:07:52 +0100
X-Gm-Features: AaiRm51Raf-y2de-B2FAM9JLv7VRR7UXKPzLnoPFCQ0guVESPck3kTB0HA12eoA
Message-ID: <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I did some additional checks on my system with kernel 6.18.13-200.fc43.x86_=
64:

1. Kernel configuration (relevant parts):

$ grep -i "RMI\|SMBus" /boot/config-$(uname -r)
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
CONFIG_RMI4_CORE=3Dm
CONFIG_RMI4_I2C=3Dm
CONFIG_RMI4_SMB=3Dm
CONFIG_HID_RMI=3Dm
CONFIG_I2C_HID=3Dy
CONFIG_I2C_HID_ACPI=3Dm

2. dmesg output (filtered):

[ 1.615300] psmouse serio1: synaptics: Trying to set up SMBus access
[ 1.618151] psmouse serio1: synaptics: SMbus companion is not ready yet
[ 17.949336] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[ 17.962506] psmouse serio1: issuing reconnect request
(repeats multiple times)

3. libinput reports:

$ sudo libinput list-devices | grep -i SynPS
Device: SynPS/2 Synaptics TouchPad

Interpretation:

- The touchpad is recognized as a SynPS/2 device, i.e., fallback PS/2 mode.
- SMBus/RMI4 driver stack does not get loaded, despite the kernel
config enabling modules.
- The "SMBus companion is not ready yet" messages indicate that
psmouse attempts SMBus access but cannot reach the device.
- I2C controllers are functional, yet the touchpad does not enumerate
as an I2C HID device.

Workarounds:

- Using psmouse.proto=3Dimps avoids lost sync events, confirming
fallback to generic PS/2 handling.

Observation regarding previous reports:

- Unlike the 2021 report on ThinkPad P14s Gen 2 (AMD), I do not see
any "bad SMBus base address" messages in dmesg.
- The kernel attempts SMBus access, but fails because the RMI4/hid-rmi
stack does not initialize. The device simply falls back to PS/2 mode.
- Therefore, this does not appear to be the same base address issue as
the earlier P14s case.

Conclusion:

- Behavior strongly suggests a missing DMI quirk or regression in the
SMBus detection logic in combination with i2c_piix4 on this Lenovo
ThinkPad T14 Gen 2 (AMD) with LEN2073 touchpad.
- This is reproducible on multiple 6.18.x kernel versions on Fedora 43
stock kernels.

I can provide full dmesg, libinput outputs, and acpidump if required.

Best regards,
Mate Racz

R=C3=A1cz M=C3=A1t=C3=A9 <raczm0812@gmail.com> ezt =C3=ADrta (id=C5=91pont:=
 2026. m=C3=A1rc. 4., Sze, 16:02):
>
> This might be related to the earlier report from 2021:
>
> https://lore.kernel.org/linux-input/3d6f7f74-3214-4c03-b352-a2a0d27ea42b@=
amd.com/
>
> and a similar report from 2025:
>
> https://lore.kernel.org/linux-input/b2d0af40-876e-4a2d-99a2-236b583e9497@=
gmail.com/
>
> The 2021 report describes incorrect SMBus address detection with
> i2c_piix4 on ThinkPad P14s Gen 2 (AMD), resulting in RMI4/SMBus not
> functioning correctly and the device remaining in PS/2 mode.
>
> On my system (LEN2073), the behaviour appears very similar:
> - intertouch has no effect
> - "SMBus companion is not ready yet" in dmesg
> - device stays in PS/2 mode
>
> It seems possible that the same underlying piix4 SMBus detection
> issue is still present.
