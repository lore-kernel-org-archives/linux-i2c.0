Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EA26AC5
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787440618; cv=pass; b=FVagwSGjHHa/9oSeWGxp7WpcgTzOVTUr/cC71Rl+sqnOW8K0fx5aMelyYCJY2bGiFAikwjDqVsEBX63IhqpttMbztJ7xvUSCwYqk8/B7WMTxUYLC4g3ZWgNFtBjqGdgRIsKSkDvIU1QEH78ZisxegLWfFZ52C9FbagY/IGH26JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787440618; c=relaxed/simple;
	bh=zgLqb1lTxUJbGT6oFnyXxQM5ptly/RW2Zd+DDyDVvQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFCfVush65xJEoZqd6hRtq5/8KCbMXilFZJVYhjNCNfn7H0L0qMCB/nxZ16Q7yQ94Y+qXewnd4yBt7S5+dzRUF7SxLIPvq1Uctem9laDvTBEIUyCGBzJzJpDN+wqjiWGlwlV/FV7S5Kn6e+6PglcfYpFxo6REYbMC7Ic37/L5n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVKwC5Ya; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVKwC5Ya"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2878049b3a.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 16:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787440617; cv=none;
        d=google.com; s=arc-20260327;
        b=W6IGzo7r4w4exdWTW1ID6eUKrGWEKR0oP2pAp3ALcaIy0ciWOBn04O00NP4yWt+Mpk
         Qd0c1DTAXIvDHqG8C4tT3spSyGEOBiquoQS8rBjlTttzfxORitZe98rghyVLYbWwGfJa
         IxowjE4FsF0kTQ0iUwL55lO/rZ68wn/zaemCMUQSkJEP3mZhC5RI9iQGiheaip8lxmT2
         ONTlt8V9yfBX3U7O17cyfqSxqbfS/i2Fi8fEoq+nB9yKyPE8BAyA0KO3O6JNoW1zylpu
         HIYcUyMeiJUtxwcs1XFrjTCCRtgK4nlUm1/jccqMoY9NdPuPhFw3gZpNwFKUQkg/qCIa
         PA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zgLqb1lTxUJbGT6oFnyXxQM5ptly/RW2Zd+DDyDVvQA=;
        fh=kZfwQuDEkwl+DUy5pfIbtFFglBuKH3Rsil7qKnkjFiY=;
        b=d7VI5kf6vcVM4ADGZ33FdL38pWTYKdhuBnlKAn7do5ADDW9PT9Xt/uPiA2dSHeBfbz
         OcsWVYr9as38GUTPgSDmhDkJkcpgv3JtZEoSkN82lkLNjQiKxh5CrmscIZjRnAs42U44
         Gyt53Bwe+F4O56bw8Gv1IkKGH7FbcROv9UAwF6PkG1ouyYuIM9L36ep/fQK1AVfGtxui
         RG7ELfIAF7QaSYIYkd8GwuQsJ++vPHxeHncnNgEhXlJJevhr3wblW9bjLmZzzKHZhbtc
         Gn6oD3OdGDRrbs/6HrdVTYkqAxo/nWQ5ha+EzUij+/F7Fx+DXP/M1FwnfyBgu9FhM7Xg
         qlLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787440617; x=1788045417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zgLqb1lTxUJbGT6oFnyXxQM5ptly/RW2Zd+DDyDVvQA=;
        b=aVKwC5YaByUFg/gxa4+DyR4LI6QarlMl/r3TOYRajpVLijf/Dv1HztEM4JAdEc2c6W
         LQQ4I2znVp9rXHK59AZziKqNoUFW/nsMZByshxKnBWcmnkBfUz/aO9MzvxtCd2/44MQc
         RvjF4emDnFy6uqQbxqM7lez85B3U6MR95JPrxGEfSHvB51BcOpz8r3BJGL14PLwkPVpZ
         K6mGq43aeBSTs2aZvLBLAGTFnXRBxT3rSapyrtktqBXWpYRaHu3ZBqN1hcy2jtKoiC3y
         zklsWaS5FT/4L8LFQmvLK1DDyR1DImrGN2a/+WpD28UfxYxiSidpjVoHVjF+W4e1HLxS
         Hyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787440617; x=1788045417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgLqb1lTxUJbGT6oFnyXxQM5ptly/RW2Zd+DDyDVvQA=;
        b=D+200djVWrcajMuS/jOInhZeSR5mMG6MXV0xmKR6yO3RQEvGsynpzwHH8qdvbOS3RZ
         oCjSx4USyMntQoPSCjNags7CS1m5V/PwqHLaZeeL+EwQDwN3HFDBT9HIivSGG9sl12NS
         /VMhK12zGhVgQWs4m3PG/Aft6++5cz4ZkY23ROjGuJzR2ZPaxUZ99RtfoERIkLgiYlvX
         DoTAk0ydxqtLE/2tlMLjVqstzaNJ1d1BqZpeK91akOe7Ml7SDI0TeKGcnBf/zg7xdiyY
         Qj7otMSo8jIL+/EJFDg6eO8ETcGm/zWmKT5YhL9m8NA6wZW2jQngl2PKQsuk81Hrpgec
         ucaA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7agYN3KBjmpWKXCaOytJaC/c+qDHywf1s7pRzMUKBfEX2E3icUasjCtLGEKpZDv5hPSpRkj5NQR8=@vger.kernel.org
X-Gm-Message-State: AFuF++kxnt7SbzRfpGU7+07TXVEQNtV3ndNTff77XjnZQLEOyzr8a5Dl
	0Yh+GmH3HTb705ysjCz8Aa/XBu1yRT7zTBKoLdLvrtdX5zbhGf0SM3gzDJn+0gk4Fmuz8fBd0Oq
	RrMXo4xo6ryUhBfmRilMhGkySJjtGF6E=
X-Gm-Gg: AR+sD10Inehbsz/Na9Rb4lm2CkxvY7rggoBziJ2kmZ3/btbF3tfr1J/Y3/64RTtERcg
	jhSGfvLh650WKKZ3Ap/0Tri8UmCqk/vkyNyzZuECNm+frFHc4Rs9yBznglqCetb68gCE0k8/hwv
	72F1CB0PN8+D/tKn/GuuFwCuAxdBwGYquxQx5raW7AjoXmd0yGPPlkGtw9PRi87oWUxkvSpxXx/
	fHLLx+xf0FpK+WwQWPymLioLE7JRT4sFgtAsl6FukKXDDaVmzl2YLKmirtYLSQcUaprw/ipuDRv
	csA4s+IUeabW31aLUVqoBHabD/oS1YYjRyHrXKwRVsQLwqxvnDNtJJR5ls6kJVJu63OdIftyoeX
	Z4Kf82oQyLg==
X-Received: by 2002:a05:6a20:7293:b0:3cc:3d08:da39 with SMTP id
 adf61e73a8af0-3cd2f9e3e47mr29078630637.0.1787440616607; Sat, 22 Aug 2026
 16:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062621.769921-1-rafad900@gmail.com> <20260822085155.1409-1-hdanton@sina.com>
 <CALp66yH7QzvGmo+N7BWykYjoaGT-yAezwRv0Pc_ir6qDRTsKvw@mail.gmail.com>
 <CALp66yFrutQ2h8SNyBZn04+LMPMnSEtWxW_Dr0vzfoHvEahSsQ@mail.gmail.com> <CALp66yHBUOH6R55KXP9kS4-XYZiOF6xb3CC6jcVjiUJ5mGQCKg@mail.gmail.com>
In-Reply-To: <CALp66yHBUOH6R55KXP9kS4-XYZiOF6xb3CC6jcVjiUJ5mGQCKg@mail.gmail.com>
From: =?UTF-8?Q?Rafael_Alejandro_D=C3=ADaz_Cruz?= <rafad900@gmail.com>
Date: Sat, 22 Aug 2026 16:16:43 -0700
X-Gm-Features: AcwNN1Wv1AT71vykQR_j3f33P_fL1VfoUhIReM3drx-3UBXDm84uGkicYdxHH4U
Message-ID: <CALp66yHXAF8M2YmFi_czHWOU_EgsEEog__Ga13m_=TZmL0ctsA@mail.gmail.com>
Subject: Re: [PATCH i2c-fixes v1] i2c: core: Fix use-after-free during i2c
 device removal
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com, 
	Andi Shyti <andi.shyti@kernel.org>, syzkaller-bugs@googlegroups.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Sat, Aug 22, 2026 at 12:37=E2=80=AFPM Rafael Alejandro D=C3=ADaz Cruz
<rafad900@gmail.com> wrote:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it
> 48a5a7ab8d6ab7090564339e039c421f315de912
>
>
> On Sat, Aug 22, 2026 at 11:26=E2=80=AFAM Rafael Alejandro D=C3=ADaz Cruz
> <rafad900@gmail.com> wrote:
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git 48a5a7ab8d6ab7090564339e039c421f315de912
> >
> > On Sat, Aug 22, 2026 at 11:13=E2=80=AFAM Rafael Alejandro D=C3=ADaz Cru=
z <rafad900@gmail.com> wrote:
> >>
> >> I see syzkaller failed to test the patch due to some VKMS/DRM
> >> issue. It's unrelated to my patch.
> >>
> >> I have tested on my own local x86 QEMU instance with proper
> >> .config and C reproducer. The error does not persist after my
> >> patch.
