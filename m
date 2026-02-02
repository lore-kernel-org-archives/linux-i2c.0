Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8630C629
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015810; cv=pass; b=ikogaUEWaeRtkhN7fsVWvXqu4E0pXiizCBOlxKnyrkNj9speFbXJcBYgQGn0/uz45tFp1Iq02fzBHLsaM3OG7PQaI+WazWMmnCSEH+qj5aVftn5vU0iOyotLuVaRxkkmcMAw/T6jZWMm0fuLNfPaiu+EQDP3hYgHgrtyE1ka1rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015810; c=relaxed/simple;
	bh=HNAJ+pGHRazqEhH9FmzNtS/WbWLjvfH3T16cgzPg9yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3PSnLZQRffXw5lPMGLG4TgvHxpWvdec7J5B10XX/OVU9HQfn08l9VqsLBu7nUGsCfXSv2V35v7PRMeJT8lrnl/OPVmiDkgY6g8vLjPeW5KBnWJuAgIeNhE8fCisW2ScHASR3F/c01zvdnby1WBE4pTHeXH+6jVk1F91SQbQCa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPV1N49t; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPV1N49t"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124566b6693so6766149c88.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Feb 2026 23:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770015808; cv=none;
        d=google.com; s=arc-20240605;
        b=MwkgFMptMEk2bXOM+cz0Y+ac0iaYwv7Ds1cDF6/YU6E5vLz1hz/vKbhS1XfdcpVUYx
         RHbPcMVXKPgEWseQ5sMTVE7MqkWbX348xUtOtGdC4OZL90wgKc6EpDMraBXZ8rR6RUYH
         UzBe1zkt+2GMsGhgCM5Vdh65SUBO1v+7BqCqt3bgqC2Wso23LNS67COq10etZ0ZMSfdr
         Lh2EwyYBjElwy56yVvhdgJLZ44f3BsT6WUh8cRpyqadmo/voDSCqmlvYoI4PKZ1fqTPT
         20V289aecOZTd9BKb0lSxarXGiY8rGg/vGBK4lvlUONgKfSPHlJIQwOYde7SVQevY4lj
         w6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ICbfX1OsG5PCbupn3f0cjGlfY41ZBX7Y2aMdJ+yJ58E=;
        fh=L3oWx8bSOB7fhJBEAGWmyPTJqw7bdx9PHdgsVe1WfAY=;
        b=RSEjD2r2qhSW1ossuYpdqnqaUOSxhXBcddydgCBUhKO7KkTiIQsBGyiq27j+JYF5LR
         fcoPgId9cEmJSNr3hlnp8AeUV1+LOJ6/sM8T3K/w1dBw7A9lovD6c8jcIImRf7+jTmgL
         OJbEI15nNlPioQvgEVRlI1kM3hjo6Sl4gb//XXZ40t1OA+8rfi5Y0nY4IYGZrV+ZXzwS
         Ujvt344UEu7ycC6GDUp4R43jk5m7OJytUoeJkHbMgcpTonfXa8J7w78nPPwtmSAESCyG
         hhtbp6NjHfFv1hzHJPW861Rl6JTtOAHE4QbOoi5wKcB/MNwlJkoakfJaNzFKYRuV4xV9
         jQ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770015808; x=1770620608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICbfX1OsG5PCbupn3f0cjGlfY41ZBX7Y2aMdJ+yJ58E=;
        b=YPV1N49tfV8Pyfvf5X7pVZN1HexOLXN+3Ln9gdvGR6kdaCg9QEAw5vz6Xjti/8MWMf
         2mVZ7S6uGGkEbEo1f3S8iFFCHgpKLPiMVr5o28RJgcFXnG5UQYYddKwq8ibjt35oLp1i
         1jWDUze87381n3/Ou+XqH0ePPACCH4euagHDutPIWJWhf585PfRrmHOZX5nG/TAXagjT
         S5x3I6UjRkezbSYASFcoPGQm0CDAb+bWtF0gW+Ysy1dXy8Wg/8tFAuUFakSp3t8JSHyS
         ruut/CQm7GFjtigS2ezY037zs2mpxOi1nGdpn23GbQye7/3amy+9REZZt5trBvQAq7dP
         wl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770015808; x=1770620608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICbfX1OsG5PCbupn3f0cjGlfY41ZBX7Y2aMdJ+yJ58E=;
        b=kfnF6du23dmFLAm8aqyfephlJk0d/GfiM1pWvsoEQ9IO+BJ8huMRA2qbH6nS758fjQ
         zljN8Z+yFRn6dMUcHTno3sbgOyteNWIEjtLCFt+VkWNHRHV69U8W4Qct515TY4pGs8jL
         1g2O+pmdDYoY2FDQ8aOtNFGj+mEloeMjw4JaGM6l7ZYWusbemc7wKA6uIQFikW8KFjaD
         euQZcQIWhsI2ipCYhePrlynie7i4QPlmq1380WFS/yBGPu4s7856jH0zO5OerRylQdaI
         KNNmqxPgS/+puiJRPPDp2oJd8wsn3m8vM+FV4Kv5ZajfRMY3FA+25reUu4bQr0I3WU2W
         9oEA==
X-Forwarded-Encrypted: i=1; AJvYcCVfqXqKFok9g64ZPnJS09qGyyi/vLgResxvngkA7Qch/ykIofb2dmf06puidNymPRKX//pDTJsk+SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOy2na2Z7MkNbW00NbSy00ZoPbgMem8Qj519Lwv6DArJnluge
	2Tp8udNdfrwRizRW20l4royhI8gPLmktJJBt/xjJW410+MQeFYjZUeczl0sxL4gAm/SrwpRK14a
	nlVKp9ExRyqbkqY563vjVBE6H6mdRQp8=
X-Gm-Gg: AZuq6aLVkQgIYZ6LVg7ia7SZAnaurXaMF/jjaTHbGFZjlanLut0YYs+z63ST9xUrvtH
	7/IWWX/DYnuGnkUkqqSoWqawTuxcaTeXf4tndGl/AH71EEP4+fRraOvs2IGPdq7Mk9aSXT3tSIO
	ohnbUMz2Uap1LVvHqejaaAgMp3uXd2ScLyagEXokII0LO8qIfQYlVNSiV06cC763q7KX+BbO90e
	ga6IWMH9POjNh6mObnDhE7ti1r7eptmgSdamiG6KEihNeabxRbbELMsJ/hbp2MsO+OvY3Y8Dgqt
	tNEO9FHM
X-Received: by 2002:a05:7022:124:b0:11d:f890:6751 with SMTP id
 a92af1059eb24-125c0fa4763mr4861440c88.10.1770015807443; Sun, 01 Feb 2026
 23:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110172003.13969-1-tinsaetadesse2015@gmail.com>
 <c36306c5-2426-4a9c-9abd-9f3cdab17ed5@roeck-us.net> <CAJ12PfNkde6__QQXMiyBbEoHMbY3efmtsqgbyiKBtBmyfpX5Jw@mail.gmail.com>
 <2740c3ab-7cb0-4931-81a2-30b85e8615f9@roeck-us.net> <CAJ12PfP+Dbxd5fFAx-zAaJQ0B53Z1nXAiPbkmivk6smKajf1=Q@mail.gmail.com>
 <e994308a-389a-4d67-9ec9-39a5f0d3f4b6@roeck-us.net> <CAJ12PfMC_Potx9aNxaJJ3y=sX=rzyhm-6LJ8Z8OjUyDxiDUNsA@mail.gmail.com>
 <39b48803-e236-4acc-84e9-18162770f9ae@roeck-us.net> <CAJ12PfMN5SOcYc6vBJEz57YVcxXAOker4WA61Xh1znP=i8aBRg@mail.gmail.com>
 <5ecc96da-0c87-45f6-ab57-c3ea8eb28de1@gmx.de> <b4ce70ec-7a7a-4ee4-a9bf-55d0a64f8644@roeck-us.net>
 <CAJ12PfP_P0cz7NrAMBehVtutQn4-OibK33KTNtjec5Qd2msdnA@mail.gmail.com>
 <CAJ12PfM5xf0+Qy07S5OoLPkpnhZz+bj5a+hTSGTfrEFN2R6PCw@mail.gmail.com>
 <fb688a65-b2cd-4223-ae04-130b5657712d@roeck-us.net> <CAJ12PfOvDe5-tsuZGeGpOZh61MztorK08NFfDMV3mkP8dNpDfA@mail.gmail.com>
 <2e6f0437-0dca-41e9-ac80-f0843120cf52@roeck-us.net>
In-Reply-To: <2e6f0437-0dca-41e9-ac80-f0843120cf52@roeck-us.net>
From: TINSAE TADESSE <tinsaetadesse2015@gmail.com>
Date: Mon, 2 Feb 2026 10:03:08 +0300
X-Gm-Features: AZwV_QhKtPR-QchlXezAOqyUyiOKxbatmmyhrr8KzdPFSYOev_c3_JStBCZpXcw
Message-ID: <CAJ12PfPPNaM0LoCPdjLB9oRwL08CVpKcDgi7H4jd439CuxgGQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: spd5118: Do not fail resume on temporary I2C errors
To: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Armin Wolf <W_Armin@gmx.de>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000738c0d0649d1eb01"

--000000000000738c0d0649d1eb01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 6:21=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 1/31/26 23:30, TINSAE TADESSE wrote:
> > On Sun, Feb 1, 2026 at 4:25=E2=80=AFAM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> >>
> >> On 1/31/26 11:50, TINSAE TADESSE wrote:
> >> ...
> >>>
> >>> Hi Guenter,
> >>>
> >>> While investigating this issue, I previously mentioned
> >>> about a flow where SPD write disabled state can be
> >>> exported as a capability from the i801 controller, so
> >>> that the SPD5118 hwmon driver consumes it.
> >>>
> >>> The SPD write disabled state is known to the controller
> >>> driver (i2c-i801), but this information is not
> >>> propagated to client drivers. As a result, auto-detected
> >>> devices may be instantiated and probed even though the
> >>> controller cannot support the required access model.
> >>>
> >>> This raises a major architectural question:
> >>>
> >>> Should SMBus / I2C controller drivers be able to
> >>> advertise bus-level capability constraints (such as SPD
> >>> write disabled state) to client drivers, so that clients can
> >>> make an informed decision during probe?
> >>>
> >>> A capability-based approach would allow:
> >>> * controller drivers to expose what is possible on a given bus
> >>> * client drivers to decide whether they can operate correctly
> >>> * avoidance of device-specific policy in controller drivers
> >>> * consistent handling across different SPD-capable devices
> >>>
> >>> I actually tested the possibility of detecting, propagating,
> >>> and consuming the SPD write disabled state using an I2C
> >>> adapter capability flag. Using this approach, I was able to
> >>> fix the issue even with the CONFIG_SENSORS_SPD5118_DETECT
> >>> kernel configuration enabled.
> >>>
> >>> At this stage, I am not proposing a specific implementation.
> >>> The goal of this RFC is to get agreement on whether this type
> >>> of problem should be solved through capability propagation,
> >>> and if so, what mechanism would be preferred.
> >>>
> >>> Any feedback on design direction, or existing infrastructure
> >>> that could be reused would be very welcome.
> >>>
> >>
> >> I think it is a good idea, but how would the flag look like ?
> >> The i801 controller only write protects a range of addresses;
> >> I think it is 0x50..0x57. So any I2C_FUNC flag would presumably
> >> have to be address range specific. You could try adding
> >> something like I2C_FUNC_SPD_WRITE_PROTECTED. Either case,
> >> you'll have to ask the I2C subsystem maintainers for advice.
> >> I would suggest to give it a try.
> >>
> >> Thanks,
> >> Guenter
> >>
> >
> > Hello Guenter,
> >
> > Thanks for the feedback.
> > I have attached one implementation that I tested and confirmed to
> > resolve the issue.
> > I will forward an RFC to the i2c maintainers, and if you don't mind,
> > I will also add you to the email list.
> >
> > Thanks again for the guidance.
>
> Looks good. I didn't know about the quirks, and that drivers are allowed =
to use them.
> We live and learn. Go ahead, and please copy the hardware monitoring mail=
ing list.
> I'll hold off sending my patch upstream until we get a response; your sol=
ution is
> much cleaner.
>
> Thanks,
> Guenter
>


Hi I2C maintainers,

I am working on a platform where the Intel i801 SMBus controller
exposes a hardware feature called "SPD Write Disable". When
enabled, the controller blocks all write transactions to the
SPD EEPROM address range (typically 0x50=E2=80=930x57), while still
allowing reads.

This creates a problem for the spd5118 hwmon driver, as SPD5118
requires write access for correct operation (page selection,
configuration, suspend/resume cache synchronization). If the controller
silently rejects writes, the driver can misbehave and generate
repeated SMBus DEV_ERR storms.

Currently, the I2C core does not provide a mechanism to expose
write restrictions. Rather than embedding SPD5118-specific policy
in the i801 driver, we are exploring a __bus-level capability/quirk__
that allows consumer drivers to decide whether they can operate safely.

Conceptually:
1. The SMBus controller (i801) detects SPD-WD in hardware
2. The controller exposes this as an adapter-level quirk or capability
3. The I2C core propagates this to I2C clients (already handled by i2c-core=
)
4. Drivers such as `spd5118` can refuse probe if write access is required

We have implemented and tested this approach (open to guidance) using
a newly defined 'I2C_AQ_SPD_WRITE_DISABLED' quirk flag. The goal is
to keep controller drivers free of device-specific policy, while giving cli=
ent
drivers enough information to fail probe cleanly instead of
misbehaving at runtime.

If this approach sounds reasonable, please review the attached patch series=
.

Thanks for your time and guidance.

--000000000000738c0d0649d1eb01
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-hwmon-spd5118-Fail-probe-if-SPD-writes-are-disabled.patch"
Content-Disposition: attachment; 
	filename="0002-hwmon-spd5118-Fail-probe-if-SPD-writes-are-disabled.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ml4tfe0b0>
X-Attachment-Id: f_ml4tfe0b0

RnJvbSBhN2E2ZjZlNzI1YjAyYzJiZjk5ZGIzYzY1YWJiMjJkMzkwMTQ2NzIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW5zYWUgVGFkZXNzZSA8dGluc2FldGFkZXNzZTIwMTVAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDIgRmViIDIwMjYgMDk6NDE6MzcgKzAzMDAKU3ViamVjdDogW1BB
VENIIDIvMl0gaHdtb246IHNwZDUxMTg6IEZhaWwgcHJvYmUgaWYgU1BEIHdyaXRlcyBhcmUgZGlz
YWJsZWQKClNQRDUxMTggcmVxdWlyZXMgd3JpdGUgYWNjZXNzIGZvciBwYWdlIHNlbGVjdGlvbiwg
Y29uZmlndXJhdGlvbiwKYW5kIGNhY2hlIHN5bmNocm9uaXphdGlvbiBkdXJpbmcgc3VzcGVuZC9y
ZXN1bWUuIElmIHRoZSBob3N0CmNvbnRyb2xsZXIgZG9lcyBub3QgYWxsb3cgU1BEIHdyaXRlcywg
dGhlIGRyaXZlciBjYW5ub3QgZnVuY3Rpb24KcHJvcGVybHkuCgpEZXRlY3QgdGhpcyBzdGF0ZSB1
c2luZyBhZGFwdGVyIHF1aXJrcyBhbmQgZGV0ZXJtaW5lIHdoZXRoZXIgdG8Kc3RvcCB0aGUgcHJv
YmUuCgpTaWduZWQtb2ZmLWJ5OiBUaW5zYWUgVGFkZXNzZSA8dGluc2FldGFkZXNzZTIwMTVAZ21h
aWwuY29tPgotLS0KIGRyaXZlcnMvaHdtb24vc3BkNTExOC5jIHwgMTUgKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aHdtb24vc3BkNTExOC5jIGIvZHJpdmVycy9od21vbi9zcGQ1MTE4LmMKaW5kZXggNWRhNDQ1NzFi
NmEwLi4wOTRkMDU0NzI1NjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaHdtb24vc3BkNTExOC5jCisr
KyBiL2RyaXZlcnMvaHdtb24vc3BkNTExOC5jCkBAIC01MjUsNiArNTI1LDggQEAgc3RhdGljIGlu
dCBzcGQ1MTE4X2NvbW1vbl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByZWdtYXAg
KnJlZ21hcCwKIAl1bnNpZ25lZCBpbnQgY2FwYWJpbGl0eSwgcmV2aXNpb24sIHZlbmRvciwgYmFu
azsKIAlzdHJ1Y3Qgc3BkNTExOF9kYXRhICpkYXRhOwogCXN0cnVjdCBkZXZpY2UgKmh3bW9uX2Rl
djsKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50OworCWNvbnN0IHN0cnVjdCBpMmNfYWRhcHRl
cl9xdWlya3MgKnF1aXJrczsKIAlpbnQgZXJyOwogCiAJZGF0YSA9IGRldm1fa3phbGxvYyhkZXYs
IHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOwpAQCAtNTUyLDYgKzU1NCwxOSBAQCBzdGF0aWMg
aW50IHNwZDUxMThfY29tbW9uX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJlZ21h
cCAqcmVnbWFwLAogCWlmICghc3BkNTExOF92ZW5kb3JfdmFsaWQoYmFuaywgdmVuZG9yKSkKIAkJ
cmV0dXJuIC1FTk9ERVY7CiAKKwkvKgorCSAqIFNQRDUxMTggcmVxdWlyZXMgd3JpdGUgYWNjZXNz
IGZvciBjb3JyZWN0IG9wZXJhdGlvbgorCSAqIChwYWdlIHNlbGVjdGlvbiwgY29uZmlndXJhdGlv
biwgYW5kIHN1c3BlbmQvcmVzdW1lIGNhY2hlIHN5bmMpLgorCSAqIElmIHRoZSBTUEQgd3JpdGVz
IGFyZSBibG9ja2VkIGJ5IHRoZSBTTUJ1cyBjb250cm9sbGVyLCB0aGUKKwkgKiBwcm9iZSBmYWls
cy4KKwkgKi8KKwljbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7CisJcXVpcmtzID0gY2xpZW50
LT5hZGFwdGVyLT5xdWlya3M7CisJaWYgKHF1aXJrcyAmJiAocXVpcmtzLT5mbGFncyAmIEkyQ19B
UV9TUERfV1JJVEVfRElTQUJMRUQpKSB7CisJCWRldl9lcnJfcHJvYmUoZGV2LCAtRU5PREVWLCAi
U1BEIFdyaXRlIERpc2FibGUgaXMgc2V0IG9uIGFkYXB0ZXI7IHJlZnVzaW5nIHByb2JlXG4iKTsK
KwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCiAJZGF0YS0+cmVnbWFwID0gcmVnbWFwOwogCW11dGV4
X2luaXQoJmRhdGEtPm52bWVtX2xvY2spOwogCWRldl9zZXRfZHJ2ZGF0YShkZXYsIGRhdGEpOwot
LSAKMi40Ny4zCgo=
--000000000000738c0d0649d1eb01
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-i2c-i801-Detect-SPD-Write-Disable-and-expose-as-adap.patch"
Content-Disposition: attachment; 
	filename="0001-i2c-i801-Detect-SPD-Write-Disable-and-expose-as-adap.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ml4tfe1b1>
X-Attachment-Id: f_ml4tfe1b1

RnJvbSA2ZDkzY2M1ODFiZWNmOWIwYzZhYzhjMWJkMzVhZDJjZDk5M2E4MmQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW5zYWUgVGFkZXNzZSA8dGluc2FldGFkZXNzZTIwMTVAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDIgRmViIDIwMjYgMDk6NDA6MzIgKzAzMDAKU3ViamVjdDogW1BB
VENIIDEvMl0gaTJjOiBpODAxOiBEZXRlY3QgU1BEIFdyaXRlIERpc2FibGUgYW5kIGV4cG9zZSBh
cyBhZGFwdGVyCiBxdWlyawoKRGV0ZWN0IFNQRCBXcml0ZSBEaXNhYmxlIGluIFNNQkhTVENGRyBh
bmQgZXhwb3NlIGl0IHRocm91Z2gKSTJDIGFkYXB0ZXIgcXVpcmsuIFRoZSBJMkMgY2xpZW50IGRy
aXZlciBtYXkgZGVjaWRlIHdoZXRoZXIKU1BEIHdyaXRlIG9wZXJhdGlvbnMgYXJlIHN1cHBvcnRl
ZCB3aXRob3V0IGltcGxlbWVudGluZwpkZXZpY2Utc3BlY2lmaWMgcG9saWNpZXMgaW4gdGhlIFNN
QnVzIGNvbnRyb2xsZXIgZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogVGluc2FlIFRhZGVzc2UgPHRp
bnNhZXRhZGVzc2UyMDE1QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWk4
MDEuYyB8IDE2ICsrKysrKysrKysrKysrKy0KIGluY2x1ZGUvbGludXgvaTJjLmggICAgICAgICAg
IHwgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWk4MDEuYyBiL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtaTgwMS5jCmluZGV4IDllMTc4OTcyNWVkZi4uZDc3MWU5ZjVmODJmIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWk4MDEuYworKysgYi9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLWk4MDEuYwpAQCAtMTUzMyw2ICsxNTMzLDExIEBAIHN0YXRpYyBpbnQgaTgw
MV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAq
aWQpCiB7CiAJaW50IGVyciwgaSwgYmFyID0gU01CQkFSOwogCXN0cnVjdCBpODAxX3ByaXYgKnBy
aXY7CisJc3RydWN0IGkyY19hZGFwdGVyX3F1aXJrcyAqcXVpcmtzOworCisJcXVpcmtzID0gZGV2
bV9remFsbG9jKCZkZXYtPmRldiwgc2l6ZW9mKCpxdWlya3MpLCBHRlBfS0VSTkVMKTsKKwlpZiAo
IXF1aXJrcykKKwkJcmV0dXJuIC1FTk9NRU07CiAKIAlwcml2ID0gZGV2bV9remFsbG9jKCZkZXYt
PmRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFwcml2KQpAQCAtMTYwMCw4
ICsxNjA1LDE3IEBAIHN0YXRpYyBpbnQgaTgwMV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCiAJCS8qIERpc2FibGUgU01CdXMgaW50ZXJy
dXB0IGZlYXR1cmUgaWYgU01CdXMgdXNpbmcgU01JIyAqLwogCQlwcml2LT5mZWF0dXJlcyAmPSB+
RkVBVFVSRV9JUlE7CiAJfQotCWlmIChwcml2LT5vcmlnaW5hbF9oc3RjZmcgJiBTTUJIU1RDRkdf
U1BEX1dEKQorCisJLyoKKwkgKiBEZXRlY3QgdGhlIFNQRCBXcml0ZSBEaXNhYmxlZCBzdGF0dXMu
IE1hcmsgdGhlIGFkYXB0ZXIKKwkgKiBhcyB1bmFibGUgdG8gcGVyZm9ybSBTUEQgd3JpdGVzLCB3
aGljaCBhbGxvd3MgY29uc3VtaW5nCisJICogZHJpdmVycyB0byBkZWNpZGUgb24gc2FmZSBvcGVy
YXRpb24uCisJICovCisJaWYgKHByaXYtPm9yaWdpbmFsX2hzdGNmZyAmIFNNQkhTVENGR19TUERf
V0QpIHsKIAkJcGNpX2luZm8oZGV2LCAiU1BEIFdyaXRlIERpc2FibGUgaXMgc2V0XG4iKTsKKwkJ
cXVpcmtzLT5mbGFncyB8PSBJMkNfQVFfU1BEX1dSSVRFX0RJU0FCTEVEOworCX0KKwlwcml2LT5h
ZGFwdGVyLnF1aXJrcyA9IHF1aXJrczsKIAogCS8qIENsZWFyIHNwZWNpYWwgbW9kZSBiaXRzICov
CiAJaWYgKHByaXYtPmZlYXR1cmVzICYgKEZFQVRVUkVfU01CVVNfUEVDIHwgRkVBVFVSRV9CTE9D
S19CVUZGRVIpKQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pMmMuaCBiL2luY2x1ZGUvbGlu
dXgvaTJjLmgKaW5kZXggMjBmZDQxYjUxZDVjLi40Yjg5ZjBiZjYyYTEgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvaTJjLmgKKysrIGIvaW5jbHVkZS9saW51eC9pMmMuaApAQCAtNzI2LDYgKzcy
Niw5IEBAIHN0cnVjdCBpMmNfYWRhcHRlcl9xdWlya3MgewogLyogYWRhcHRlciBjYW5ub3QgZG8g
cmVwZWF0ZWQgU1RBUlQgKi8KICNkZWZpbmUgSTJDX0FRX05PX1JFUF9TVEFSVAkJQklUKDcpCiAK
Ky8qIFNQRCB3cml0ZXMgYXJlIGJsb2NrZWQgYnkgaG9zdCBjb250cm9sbGVyICovCisjZGVmaW5l
IEkyQ19BUV9TUERfV1JJVEVfRElTQUJMRUQJQklUKDgpCisKIC8qCiAgKiBpMmNfYWRhcHRlciBp
cyB0aGUgc3RydWN0dXJlIHVzZWQgdG8gaWRlbnRpZnkgYSBwaHlzaWNhbCBpMmMgYnVzIGFsb25n
CiAgKiB3aXRoIHRoZSBhY2Nlc3MgYWxnb3JpdGhtcyBuZWNlc3NhcnkgdG8gYWNjZXNzIGl0Lgot
LSAKMi40Ny4zCgo=
--000000000000738c0d0649d1eb01--
