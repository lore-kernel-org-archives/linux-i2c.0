Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2023BF675
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491762; cv=none; b=LycF6Adjj4beJaeAZKtre/jEw8VL4qd2J/I4flQO03v5AmZ+/DpwsBf0/UMzHjXAgD3IlNmj1UPHVRo0QTughzk00GkDVCjFoByvXDltid4w1fOLUS8iznOuJbRx7ns2v15aYuR0xIjbxzaLwu7Msf4+EbbdqZrpPveeOiWiX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491762; c=relaxed/simple;
	bh=9y5Ba/kdCh+YSYRj944fOFQR4ceen70zdD5IwToq1uk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nn+pyzxnOLp4Ie/At3NlH3CzVpt/3suV/nMck1FAZQHS2Yd+gHFOHMnqLxWBUvtEZGHjSl8R8HJ+Df/Ms0vxlDlF4c4xcBYw5vrTIwAQ26sKfqC0S/oyUcdbc6anZhcK47i1oH5uHVdt8gJQ5cfND++q8TmYAEC9MyRlhJ23BH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=X5fc7u4/; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="X5fc7u4/"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so10988243eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778491760; x=1779096560; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+E8E50x1rMckI7MELpxX+cVsF2ptZlzflLKvbVrkxA=;
        b=X5fc7u4/aAlZiMFoFXKe5Zqw9vVJ2TXtUeovqzzVzR4Kh975cEUyYPVQUiSZAPj1xV
         VGbAxMNymjblYMlDK2JWYDqgYkY2nXDimxojaCZd8gVaX/TsqK45R+bIFShqpmUzXbNB
         ABbKnjmuWbK9dAiYB7aa5igJ+/X/PhElsxFzeQfZy0Up86+FZsl1sHLjoBzN7BYMKC1J
         Kq1Tvmgr/zPb5N3W4X9pLhemiNwyBcCFqbonxV9l0630TyVHKRzEDuCqE9IVyDwqlrhB
         qq7HKQNlbreo070kl90j3EH/bNdYpAkUqZLFfukFfgkp8UMMUKDpd0ysX2fJd6EsBLfw
         HSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491760; x=1779096560;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+E8E50x1rMckI7MELpxX+cVsF2ptZlzflLKvbVrkxA=;
        b=O2K0R59WnxN44uJYUFb1Er02gYFfahCZVTRJsFEoJ6per8dR6PHIJ5WXux3GkaOq1F
         RYgS30KnfD1QKEbpr3Lla7836O1HpOYXWfz7y9O82CD4z9PhR/EQGVolNrcPxr4GcRqc
         vjz4Ti4Z+D5/Q8qTUMGh/4qZ1TfXZak1t22guw4R5EDVINX2YGYg3VcUy9rtOBlOKPk2
         4YpUFGww7SVHb3XaJ4Nu7wBNjYcMRcMWKlW/QQ6t/TDxRkzxpTMRFapZ7Pzi1a0kx/V7
         Zf7ESxDJJ3vN0rFV7JfxkKGiZmSva+WwvQOc1356voFcgZY9zdcg3b9qZhyP9D7hmI/l
         qlYA==
X-Gm-Message-State: AOJu0YzyS45B4YAhpZPuAxyqfRdvc4iSjFucQzRTwmkdy0dr2SytWCRf
	8CxFvtPWn7vm03ia7OdVTkNAUIlPkdIDm2tTIDS/X1MYRSzZ/gp3jcBquO7bLO+Ufzd2Ue/fIQP
	GkxExUo0=
X-Gm-Gg: Acq92OFE1OxEnbZWcBeOZVn51RQCdJzqKvoMYCqKAyydhNVLUkEKYasfk3i9knOEsu5
	KgRqsG0R+qY4rGrxOPTZpVLUpYgmZH5NAMiBGrUbzTZmz1V7QtjFO6L7yUZwons7ckEKcg+6+FQ
	s+5blHfLZQ1jc8C93sureJr895RcF5Hbx4ebM1ecfR6v8GwTrgUcKXBZS3oQOwvC8oJXYnXxP+F
	z8TTHqWd4tRy9m5niQCuwdi1jFklxfuO5gqj67WGRZfBL/rqLOmRkrqIPhuneWgWy+uCEQ+/USx
	WJoY/sKrxsK6RM3VWRJa1O5oYJK6CSylDzwpTtIQZjAT8BjFXl6jSkv8kklKXKz0CALPDjh2mRt
	NWgiwobHMiRNPYdrgLxLIs6ilZck16hEPsAI2U6RJ1TNIgK53/8Qp75sj6ePnAc9CQLHoPC8mJD
	IZoMnNRwtTNlSMv35h+UoIKPA=
X-Received: by 2002:a05:7300:a987:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-2f54b360d4emr10771251eec.11.1778491760334;
        Mon, 11 May 2026 02:29:20 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm14931099eec.10.2026.05.11.02.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 02:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 02:29:19 -0700
Message-Id: <DIFQPMZMN7AN.YTWGF8U973JL@nexthop.ai>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: reg: use device property accessors
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Peter Rosin" <peda@axentia.se>
X-Mailer: aerc 0.21.0
References: <20260115003523.26660-1-abdurrahman@nexthop.ai>
 <0e85c0d7-3fa1-62cd-f09a-1712ca7c03b3@axentia.se>
 <1013EAA3-CA3B-4CCF-8FDA-2D5839F9C0B3@nexthop.ai>
 <CAGYn4vyBw7GeTysF0o9Es3MEMjZ_tYtog0HRBjoSuPuPSP+UFQ@mail.gmail.com>
In-Reply-To: <CAGYn4vyBw7GeTysF0o9Es3MEMjZ_tYtog0HRBjoSuPuPSP+UFQ@mail.gmail.com>

On Thu Feb 26, 2026 at 10:28 PM PST, Abdurrahman Hussain wrote:
> On Thu Jan 15, 2026 at 11:16 AM PST, Abdurrahman Hussain wrote:
>>
>>
>>> On Jan 15, 2026, at 3:03=E2=80=AFAM, Peter Rosin <peda@axentia.se> wrot=
e:
>>>=20
>>> Hi!
>>>=20
>>> 2026-01-15 at 01:35, Abdurrahman Hussain wrote:
>>>> [You don't often get email from abdurrahman@nexthop.ai. Learn why this=
 is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>=20
>>>> This makes the driver work on non-OF platforms.
>>>=20
>>> What measures have been taken to make sure that things continues
>>> to work on OF platforms?
>>>=20
>>> Cheers,
>>> Peter
>>
>> Unfortunately, I don=E2=80=99t have an OF platform available where I cou=
ld test this.
>> I am open to give this a try though if I could borrow a device that uses=
 the driver.
>
> Hi Peter,
>
> I haven't heard back from you and was wondering if you had any comments
> regarding the code. This change makes the driver work on ACPI based syste=
ms.
> I have tested this change on a AMD (x86-64) based embedded system with a
> custom Xilinx based FPGA which maps a 32bit register as a mux for several
> Xilinx I2C IP blocks on the same FPGA (i2c-xiic driver). The FPGA itself =
is
> a PCIe device and the firmware (ACPI) description looks like this:
>
>     Scope (_SB.PCI0.GPP6)
>     {
>         Device (FPGA)
>         {
>             Name (_ADR, 0x00000000)
>
>             Device (MUX0) {
>                 Name (_HID, "PRP0001")
>                 Name (_CRS, ResourceTemplate () {
>                     Memory32Fixed (ReadWrite, 0x80900010, 0x00000004)
>                 })
>                 Name (_DSD, Package () {
>                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                     Package () {
>                         Package () { "compatible", "i2c-mux-reg" },
>                         Package () { "i2c-parent", \_SB.PCI0.GPP6.FPGA.II=
00 },
>                     }
>                 })
>
>                 Device (CH0) {
>                     Name (_ADR, 0)
>
>                     Device (EEP1) {
>                         Name (_HID, "PRP0001")
>                         Name (_STR, Unicode ("PSU1 EEPROM"))
>                         Name (_CRS, ResourceTemplate () {
>                             I2cSerialBusV2 (0x50,, 100000,,
>                                 "\\_SB.PCI0.GPP6.FPGA.MUX0.CH0")
>                         })
>                         Name (_DSD, Package () {
>                             ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301=
"),
>                             Package () {
>                                 Package () { "compatible", "atmel,24c02" =
},
>                                 Package () { "pagesize", 8 },
>                                 Package () { "read-only", 1 },
>                                 Package () { "label", "psu" },
>                             }
>                         })
>                     }
>                 }
>             }
>         }
>     }
>
> As I mentioned earlier, I don't have access to an OF platform using this =
driver
> to test things out. If you could point me to a readily available OF devic=
e I am
> willing to test it out.
>
> Thanks,
> Abdurrahman

Hi Andy, Peter,

It looks like the patch is marked as "Changes Requested". I haven't
heard any feedback lately. Did I miss something?

Regards,
Abdurrahman

