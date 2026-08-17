Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01B3FB074
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965858; cv=pass; b=o95XiVaL259I2U2RC2jmmYatjsthxvH9op6yW3A/O38BOkOAJRzA+kVAvGgFEpw5sWhwGh4dFNdE+SOzl2PYbRYUpsML4pKwYg6+t2V3LLgi8UXizKBNeyIXzfmHYvY6uRhOVjrIuQGW2LA5T/g5zRiotYbX7F81earnkUTvUHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965858; c=relaxed/simple;
	bh=pjqPtyWtlCb8NZsTEaCgUsbU2sAf8qLZetVe6NY+2zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlnU+JgB39c2pGBf53rY8DOXCBt7PTtKt4xClatDEfOAFVxP/0DxUvVPPmJiy5Y4muse4ca0IW109A9UW4nADCPqx+zNaDbJleMu+PjDL3g6M9tQGyRMW8vSJ9pqLKXVa6fwgdRp/rbUFMwtoOR9h5Y59R949Q76zVhjCalJduA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEvVUauu; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEvVUauu"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a10d02ff43so5814326a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 04:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786965855; cv=none;
        d=google.com; s=arc-20260327;
        b=Mu/TD8KIfq+utslEagDRuCA00oXMcGCflDS1T32Sv5WZLAvVRGyebd58ZsIhjoM4bx
         3O1m0dLknwOFUS/H1N9fapo35nkICFRZ1rrflolDlkyUaR5FRoVPQEkutDNLR5djL0tt
         XnLQudc+eFSqzTfn0Rjfgt3TvFESQjhWkEXpvbMNgoBO0vjqgeK5JgCtM+8OLWqQAPuG
         wE/btZQvbphnunxChUzgsb2RYxb1DHSBcMRMl8+AlLYsBL76FOUR8fBLglN1uaqosjGb
         gcqo4cflatrViZnuH8N/DhG3WASDmrezFNDAqvKHDv4AhgRM76ZvF00Uc88lvre5DQTD
         OL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pjqPtyWtlCb8NZsTEaCgUsbU2sAf8qLZetVe6NY+2zE=;
        fh=/q8faYq+pn8M+HBaKo0Z+I1iAELonL/tB3epFyUTSAQ=;
        b=EY90rCiSeyURe6sTv7/ykhX6UT6/5xATkfyveQtzSzgeUNh++jyuluqRYpAc7GffGG
         7LfnTdL9JQJAeI/2JnulOrifSJzz0bx6Gy3SdQWx33v8DZg87tKMLAfq6f8AQ1+Wn9wJ
         ITiIEVnPLkGKfC98Cvlb456ZCiE+Dckg121gU33b9eMELz2QmxcitDcXrfyOasHqPlPV
         T0Ymvvr56ssVupqoLYOc3Px6tiFCjih7DzblY9xmQgoPBvufWYbOZtJdK6wzsBjS/len
         sxL4zvyq5UrTfHHME9sIIkdvFZyoP2TeDKMJ9MPthCxbpJSGSbZCfSpYlp7JP4CE6/Am
         Dptw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786965855; x=1787570655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pjqPtyWtlCb8NZsTEaCgUsbU2sAf8qLZetVe6NY+2zE=;
        b=sEvVUauuEoJ+sZQTf7gdS/YewZhAWU9+59k/Tqed3ps81usXToKqRHFvYDTvqXzaJg
         jb8yQs98IJkIBt1iA8IZUHvy2wb6Mkc3UgGyJ28qBEX/9htW6JTCwUu8TOO5d192GF4r
         oobtl/jG+JX6hj+5t8B+pV2e0/oy3TJVbQdp0Ft9WhUD68ceZmioj47PBpR4bYoZP1Ow
         j51wjl/6y41lMAEq1Wgmmjs5s4Gf1iHWD8KdYPscz+Q3Hma8qWDn2TVI5ja1lw4ojmJI
         WSF/mIazY2GvoON7/p2KzPvE39ZtAR4n/OxT9dld34Uh/dlF5Cwh9gF/y1c+oKDAuq+I
         ergw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965855; x=1787570655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjqPtyWtlCb8NZsTEaCgUsbU2sAf8qLZetVe6NY+2zE=;
        b=f4IxoGk8moFG/JAcZRMZwat5tS8t8dRM4zxSV/Y7rRyX4wBUu4dC/bEx4e8XK40+oN
         jyJTOiEVwSOyQ6n9guE3djBvXJCniN2FSgkXQQErJASNSQk6vUuhXuxzl7DNC7n6SOUy
         xLdz5Em5lkqZy3Hz7hiX84zMxahAx9O2O3r3LVTcziDtIG09NKsCMAqVGkCjAvGv3VAl
         ckeWGGkha+xV91vnpheGWmgW7Gcex4JmHQ03cba1ywFPxzgc0xaFEYrlbZVsVysL5n7v
         VeTSXXB6gnAXgNVDogpEso4ZIu1GCDh8ABEjvzq3ltMRJXHfbtzooeCXCckacWkPXz8L
         DEpA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7NkbnqivyzeVxsfxD0v5LM5dXMrMk+Z9xoSJG1oK6xJruelCV8MoIrWcli7KCzJCVpnEvq6aNDVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOG5FW6mFwZxkAkHG/kzZ5zqYj22wefXkYhfQrQU8U+pfxfSHv
	wk+VJpIIACKHk6TzYamSRl9IsQx5ob79G9S7SxZ8haPDPTbclWBDQ5i5lTDnS8eM1RYivnsJzGZ
	yj0FbWKam2ELn+CKIeMPorhtsNmIj
X-Gm-Gg: AR+sD12hpdg4nV2N2K5ML4dlaST4lExFb5o/QjfjxkXaj7SudlFtm96vX4Pv4McZQT8
	UPCdgMb4Pe13mc0m4hKCJLmNTQFeEfo6L9OP5xq85h89hmOK+6woWqDqb6WduzD2kZkF7pwQhP+
	B7fZVzQxG4gSm20Z0aQGCEC8P1bs2rA1hVbFFsGvQ2DlYazz01m1qecy6N6QKUqWD2n/i6TVKYs
	xUkmv7ryXOZVOSw7fDQHwpil8uQNyrU6e7JrI25le6bFW0trtdK1q+eXbKrN/lozXASsiVJCEiv
	uv3w2VwRyWPMbct1utepA72voSqtEME6QMiWLXDKER6cwoXOa4qseKw9C9Dm9QynjbyQrAPtHXM
	eBCZlfS74wIU4rs8fptthvpZA6IsSG6ki
X-Received: by 2002:a17:907:94d2:b0:c19:45df:1856 with SMTP id
 a640c23a62f3a-c212a11a823mr1135761866b.17.1786965853968; Mon, 17 Aug 2026
 04:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu> <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local> <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
 <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info> <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info> <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
 <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info> <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
 <444caa3c-01ae-4516-b63a-576e095fef94@amd.com> <9095d7c8-92fe-4163-98f8-a53bbcefd6cb@leemhuis.info>
 <CANTFpSV9jguMzmfN7STb7XANYdn8i34bVmpT=0NdJ_o=3_Y1CQ@mail.gmail.com>
 <1bca212d-fe9c-4666-8ac1-743f8c9ef1c5@oss.qualcomm.com> <7c410f84-86f2-48e7-bee9-4c5c038bd115@leemhuis.info>
In-Reply-To: <7c410f84-86f2-48e7-bee9-4c5c038bd115@leemhuis.info>
From: =?UTF-8?B?VGnhur9uIMSQ4bqhdCBUcuG6p24=?= <trantiendat29042005@gmail.com>
Date: Mon, 17 Aug 2026 18:24:02 +0700
X-Gm-Features: AcwNN1U_DY-Jh0bRZciqKsUnmNuaDADygrkxxJJBvtyvTrqpPw_tyLNImJDo6Hw
Message-ID: <CAG=RFTXPTJsTf=cGRi7u6OYn1DzWHz5d-rwdZLu0pUg2AezAWw@mail.gmail.com>
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: johannes.goede@oss.qualcomm.com, 
	Hardik Prakash <hardikprakash.official@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed background, Thorsten and Hans.

Confirming I'm now on this thread. For reference, the bug I reported
(deferred probe on both i2c_designware.0 and .1, ELAN0307 touchpad
never coming up) is tracked here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D221889

With Linus's revert (d5b95e612cde) applied on top of 7.2 final, my
system is working correctly again =E2=80=94 both i2c_designware controllers
probe successfully (~2.80s), the touchpad registers via hid-multitouch,
and /sys/kernel/debug/devices_deferred is empty.

Happy to test Hardik's upcoming i2c-hid-core patch (the IRQ-request-
before-connectivity-check approach Hans described) on this hardware
once it's ready, and report back whether it resolves the original
issue without reintroducing the deferred-probe regression.

Let me know when there's something to test.

Best regards,
Tran Tien Dat


V=C3=A0o Th=E1=BB=A9 2, 17 thg 8, 2026 va=CC=80o lu=CC=81c 18:12 Thorsten L=
eemhuis
<regressions@leemhuis.info> =C4=91=C3=A3 vi=E1=BA=BFt:
>
> On 8/17/26 11:51, johannes.goede@oss.qualcomm.com wrote:
> > On 14-Aug-26 12:09 PM, Hardik Prakash wrote:
> >> On Wed, 13 Aug 2026, Thorsten Leemhuis wrote:
> >>> Hardik, could you submit a revert to the lists? And then I'll provide=
 my
> >>> Tested-by and ask Linus to directly pick this up?
> >>
> >> Sent: https://lore.kernel.org/all/20260814100719.9548-1-hardikprakash.=
official@gmail.com/
> >>
> >> Verified on my end that it builds clean, boots clean, and correctly
> >> restores the original Yoga 7 race (expected tradeoff) without
> >> introducing anything else.
>
> Hans, thx for looking into this.
> > Thank you for submitting a revert for this. Note it looks like Torvalds=
 himself
> > beat you to it and already reverted this for 7.2 final :)
>
> Yeah, I pointed Linus to this and a few others issues and then he
> reverted the change directly:
> https://lore.kernel.org/all/628bbf10-29f1-4e9e-b23b-4c47657433b9@leemhuis=
.info/
>
> > I hit another problem caused by this now reverted change, where the PMI=
C
> > i2c bus would not show up on many Intel BYT/CHT devices. I wrote a fix =
for
> > this (attached) on top of the now reverted commit.
>
> FWIW, meanwhile "Tran Tien Dat" (now CCed) with -next ran into a problem
> on a MSI Modern 14 H D13MG that the revert seems to have resolved. But
> the symptoms were different: the two DesignWare I2C controllers in that
> machine apparently deferred probe forever and are never retried:
>
> 16.429266 platform i2c_designware.1: deferred probe pending: (reason
> unknown)
> 16.429286 platform i2c_designware.0: deferred probe pending: (reason
> unknown)
>
> For details, see: https://bugzilla.kernel.org/show_bug.cgi?id=3D221889
>
> Ciao, Thorsten
>
> > I think my fix might also have helped for the broken touchpad issue fro=
m this
> > thread, but I believe there is a better way to fix all this, so IMHO it=
 is
> > good that this was reverted.
> >
> > If I understand things correctly the problem the reverted fix was tryin=
g
> > to fix is i2c-transfer errors happening before the GPIO controller driv=
er
> > is ready.
> >
> > The i2c-core will not initiate transfers itself, so the problem is that
> > the i2c-hid driver is initiating transfers before the GPIO controller
> > is setup.
> >
> > The i2c-hid driver does actually request the interrupt itself, so we ca=
n
> > simply wait for that to succeed inside the i2c-hid code. ATM the i2c-hi=
d
> > code starts with an i2c-connectivity check because some ACPI tables lis=
t
> > non existing I2C-HID devices.
> >
> > But we could make the i2c-hid driver start with first requesting its IR=
Q
> > and if that fails bail (with -EPROBE_DEFER) before doing any i2c-transf=
ers.
> >
> > And then do the i2c-connectivity test after requesting the IRQ. So basi=
cally
> > swap the order of i2c-connectivity test vs IRQ requesting.
> >
> > The IRQ requesting should then use the IRQF_NO_AUTOEN flag to keep the =
IRQ
> > disabled at first and explicitly enable it later when the rest of the d=
river
> > setup is done.
> >
> > Hardik, can you take a shot at coding up the suggested i2c-hid(-core) c=
hanges
> > and test to see if this fixes the original Yoga 7 race in a cleaner man=
ner ?
> >
> > Regards,
> >
> > Hans
> >
>
