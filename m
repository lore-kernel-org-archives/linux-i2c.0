Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71E362139
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173715; cv=pass; b=AC+J2/U8Dk0H6ulxQkEnkTgDQwS2ifijvO3dXvDIZu5nDoncj+z1qRqhrcu6r+YYQpCy8SLRp1xCBbJuWyZCJRiHfRiXfLULpjcop0DPQ5ETo/ZeFPwgwcYnL4D7tmwXH+kD/3xbwCAN+5SOBYngU7mNG83sS/PWR9DBvbRf/Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173715; c=relaxed/simple;
	bh=pM53znyuUQvxPA++OjurMKB4cNr/htil3407xfimIuU=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxml1Tyfb6+tUie0iJq6ijecbZXdUi6bHLNdhilSrg6QRIMRAXoaVpvAkvIJ1vs8Bh9lFapA36rIQXM5mbgcS9iH+CRORqtUOuCjg07jz7r1qrqGF4pD5aXRnOvoNvM0KYCzQT3ZGFjm9XGjlhKgc7et/2f72iXQ60dQNdqNJ+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=YpKxJdjx; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="YpKxJdjx"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79868cde1eeso18286597b3.2
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772173713; cv=none;
        d=google.com; s=arc-20240605;
        b=KZC6esV3CjqL9W19zNhepMwPgGR1VRVlKg/a098L9kMilrLx9mWpnuZYA7OVPe++rX
         S8c64wnuGsLISfGlixlCUxTLrvEzoJAn9mOn3UWaOH8nHq0GBZ0sH+C1W+1A+AqomsBC
         i3dCj7YjuQeEyMfUqO54+zC0MP540Y6re6c9m1xf5d53f4OvWGa099ehP1KrWwyCxm2I
         DxWhcBJ8zFBwiVtBnqEBYMMYtbGk1HjGrcNdMOb4UXQV92FWJVZF151nMDQ4HuXVJMuo
         fDX/7rpPxbW0H8dPnV1HZRVg1yga66qux12WuR+94mh0v6Pf+P1pyb76g1vr7DO0nRVs
         CU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:dkim-signature;
        bh=rt0MoyZ89NKec8nK1pUHkC8WL4N618d2x5QsA2eqv+o=;
        fh=bIYf0bTElcgA8kvn/C43Ki0CC0X34eMFpvgMpAk2HnI=;
        b=KGcU4YWYOTH4noyx7FZI52+++SUf4tu2Q7LouJoYYe21dkMD6LTv+O/RZaQzBusDEa
         XZJpYKmU32GNuo3IOkJnNblB7Se6hZcrxTPyWa0eFXjb4LP/EvudsEiosF8IcV0rI5xp
         CgKC4mIJ5CqFHpg5NLjj+0MRNbYw/SLRHabvhucAhX7lSXSj69nVxyT+nGNiKNpgVrOK
         /5Fv61V9NDzAgeMaws2UNS2ABzOm4zxgfrlI/fEhLRg5y7Q4b+m2sQ209fSYDuBq0uvV
         YczAiMV+muU8lRVMbHiNCc5+jIvTgXgewOeYohS50XK3FUL6fSaqgqtsqrLyGbXDdOel
         bRBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1772173713; x=1772778513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt0MoyZ89NKec8nK1pUHkC8WL4N618d2x5QsA2eqv+o=;
        b=YpKxJdjxNtMzEDMm4QE7tzxqX7LA4KhH9t84jRdn6oOuhwG1Zziqs+o9DqAVk5ntju
         lM/GsDp8RLCpmqxqMs6ihpEXESSLKUVr0vf/YwtrmB9E5kpwfeiTH/cLssUPa0wBHc0v
         QpZcDKzk1l53Ik4wBZ9IlllIYge77k/6nLCSDDgpKwupXK6vxF+S5wI6MVXI/33V0ouV
         1R/OFjgjhhl0UANNq+7YghzoC8JDlZzeJrH79LDjXlpSOwGUDb9RhyOxVPqh3FfYZx2a
         YA+HOfRXjpPNo0W0LX3pSIXnHwHOdfTS880OJJRCOB5Eh3wBlKmFd0OQkhz141Bd4/PA
         ROIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173713; x=1772778513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt0MoyZ89NKec8nK1pUHkC8WL4N618d2x5QsA2eqv+o=;
        b=ejOO++kk84XG4iFcs/a2WbYrIY12vsCW6riM9EUfhOrF3rgHJLScapOKelaYa+rWw5
         7KIbj/O0vypx7M/coOeMBpk9H6pxHVgH/aguirCB8qZQAa0L0b+ubey6Sur6vEelLOFh
         oUlRPCUqpZEdAy0p9obtAvW0yUndgc9BAHW/zQCcsNdnltVbqC6Xq6b0AFhoeVhRwcX/
         V8eFt8AJaoEHPhBAjNiN0OhgR2HMkyLFXNBwvan8GNb0qDNgKmZGDm3RVotPs5Efm4Ie
         qq+nmu0D/RSOgM0dbohhev/5BhIErIeRkNXIU8E+10v8fRSvYCZ8LNiJBo2kT8cvlTsa
         DnDg==
X-Gm-Message-State: AOJu0YyuuEyvDY6ayasZWP/TYtgsmLWSgTM0UQ+Zc5cCsna9J+06oa25
	53lb8ilajXyonNn8hEq5pyaf7H4F7ZdvQXRrmjVQ+7LV2od8j4QpYXLdiXsFFTM88dIPwyetXau
	mVkzxJwzeDMcqV28fBXYJoxMCaY/06kZ62aCnSiGe0A==
X-Gm-Gg: ATEYQzya+ROGimVZNX1QvF7N4gAWI4atRRq/wiIkUIeboVwstWwKF4CeiAUbidgu3LI
	aKupzHcUzgpiur+wia8/j+JWX8fyw8K61WBYwwoZUSFFEg1XL4H2zlYCQxeFcaEJUVqkJ7RJ6kr
	CVsSLWKvsyNS95xATxKPpXA01bsBc8yEaXFhYYkWU9nfHqrWzGRheMDAYuzKnrlRKz9E4rsIrMK
	ped/OLT9eP5gZJGMop74+Kp8ovjFVs58QNA61fa7251Qipqs9yECIYh+upjJ02EhqoFyVYeaNVC
	CFLS5kax
X-Received: by 2002:a05:690c:4804:b0:797:bd3e:1feb with SMTP id
 00721157ae682-798855a5f97mr17216397b3.35.1772173713093; Thu, 26 Feb 2026
 22:28:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Feb 2026 22:28:32 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Feb 2026 22:28:32 -0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260115003523.26660-1-abdurrahman@nexthop.ai>
 <0e85c0d7-3fa1-62cd-f09a-1712ca7c03b3@axentia.se> <1013EAA3-CA3B-4CCF-8FDA-2D5839F9C0B3@nexthop.ai>
In-Reply-To: <1013EAA3-CA3B-4CCF-8FDA-2D5839F9C0B3@nexthop.ai>
Date: Thu, 26 Feb 2026 22:28:32 -0800
X-Gm-Features: AaiRm53-lhkMsdlLwsqEQd_mi49Ce2wrOlgY7PA39gqyoqHOeTIXgt9a6QYWrwA
Message-ID: <CAGYn4vyBw7GeTysF0o9Es3MEMjZ_tYtog0HRBjoSuPuPSP+UFQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: mux: reg: use device property accessors
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu Jan 15, 2026 at 11:16 AM PST, Abdurrahman Hussain wrote:
>
>
>> On Jan 15, 2026, at 3:03=E2=80=AFAM, Peter Rosin <peda@axentia.se> wrote=
:
>>
>> Hi!
>>
>> 2026-01-15 at 01:35, Abdurrahman Hussain wrote:
>>> [You don't often get email from abdurrahman@nexthop.ai. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> This makes the driver work on non-OF platforms.
>>
>> What measures have been taken to make sure that things continues
>> to work on OF platforms?
>>
>> Cheers,
>> Peter
>
> Unfortunately, I don=E2=80=99t have an OF platform available where I coul=
d test this.
> I am open to give this a try though if I could borrow a device that uses =
the driver.

Hi Peter,

I haven't heard back from you and was wondering if you had any comments
regarding the code. This change makes the driver work on ACPI based systems=
.
I have tested this change on a AMD (x86-64) based embedded system with a
custom Xilinx based FPGA which maps a 32bit register as a mux for several
Xilinx I2C IP blocks on the same FPGA (i2c-xiic driver). The FPGA itself is
a PCIe device and the firmware (ACPI) description looks like this:

    Scope (_SB.PCI0.GPP6)
    {
        Device (FPGA)
        {
            Name (_ADR, 0x00000000)

            Device (MUX0) {
                Name (_HID, "PRP0001")
                Name (_CRS, ResourceTemplate () {
                    Memory32Fixed (ReadWrite, 0x80900010, 0x00000004)
                })
                Name (_DSD, Package () {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package () {
                        Package () { "compatible", "i2c-mux-reg" },
                        Package () { "i2c-parent", \_SB.PCI0.GPP6.FPGA.II00=
 },
                    }
                })

                Device (CH0) {
                    Name (_ADR, 0)

                    Device (EEP1) {
                        Name (_HID, "PRP0001")
                        Name (_STR, Unicode ("PSU1 EEPROM"))
                        Name (_CRS, ResourceTemplate () {
                            I2cSerialBusV2 (0x50,, 100000,,
                                "\\_SB.PCI0.GPP6.FPGA.MUX0.CH0")
                        })
                        Name (_DSD, Package () {
                            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301")=
,
                            Package () {
                                Package () { "compatible", "atmel,24c02" },
                                Package () { "pagesize", 8 },
                                Package () { "read-only", 1 },
                                Package () { "label", "psu" },
                            }
                        })
                    }
                }
            }
        }
    }

As I mentioned earlier, I don't have access to an OF platform using this dr=
iver
to test things out. If you could point me to a readily available OF device =
I am
willing to test it out.

Thanks,
Abdurrahman
