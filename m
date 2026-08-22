Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746127B340
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427442; cv=pass; b=WZYGKybphgwY4QQdnodQJbWT57zdKVJC/g+2/yD33O8WyO/9F8cN4ldrK9zGpTQcpFTepfwdb7WyFmzM+pJrwNrdmXzDsz+qjn8JWywL2l3RdXTWaQK+haUH6V0eANq2+gaonbD0xrRc7XyXLy+6FMGdxGw69y+zcCm2iy3AGfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427442; c=relaxed/simple;
	bh=OQ1MjC6uTf2uRG0SwGllDIjs6ixVWx4BqlzU+5RZVXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y276Q2ygHWVuYdCazh204JRn+YA/rgk94fLMb7Sb/9jfV2Rl6CUIeVn6S0ZhTN6EKCdEtFcgV29/GGmXp289mOXM19qECGC/U4UiaTc077ZdEe/Rc2pHNaqKqkCr5kqSq3MbjECEjH96mi3t5kzZbTwA/NXgQntvGhue7CweEbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsfqIwM2; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsfqIwM2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caf228a910so16817005ad.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 12:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787427441; cv=none;
        d=google.com; s=arc-20260327;
        b=IR5wE9NUo+4Vx3hjWeMcZBsvhyEu043S7j4V7a6ZxTZmDzAZDa/pnZHR+WrRpeeFFR
         c5yNi0mDPuisqB+mbDomF38H31dG5PlgiOh6QdJmfiekVmzBHK2jCCOkeudISWAN94to
         p7f8d3x9h8EiAgv8aXua+K3P0YkK0A6Uxsinb1OdAQPD43OKVjQYECro+FZ7yEILei/v
         udcWGZGrIAhXaSsmwNhilOU2q9QSdyAfWrHzUSTBjzuMGdLSSurTRCAWKbLmps1BQJhs
         xJu4PwaHlB91VUGPG1lXKpZK5bwPzXCEQrwAmIYjQ6qavxNqNMs+x7etnzg7Kx7jTE7U
         PvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQ1MjC6uTf2uRG0SwGllDIjs6ixVWx4BqlzU+5RZVXc=;
        fh=mbgSSfXGDRfSbY/gpk22QFAdnI760b6Gb0hgFLGfw6I=;
        b=JpngaQfOs7Qj1SQrmK59SauoQUCebWwbW8aM0xwTxsNKYV/jDmU/cE6+qzwSwJmOyT
         tEg3d/23mBSz93spxtQMhz964t7TMZpLI8/Oo1suLishEKrgt61JaKHyYZa+E+UD2KiQ
         1bqKp5bsu5G1+CtCPiQmkam6Cq2Lz4i3oHCuRHpLIXEosqRh0G8PhEnMtBKtD/2hDsfR
         mifphDVvbfpEoGRwH/g4B7eY2NNWZC/tee9Xyd8EW87Nk0cXG/S73FcG0rTmqa5Rddp1
         2GOcr9ffcLX3L7yyk9eXbwXN/eOG8xJ7fxILdOBHv6K3qYwk5EdHtWZDL8dY6gf7M+TD
         +FAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787427441; x=1788032241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQ1MjC6uTf2uRG0SwGllDIjs6ixVWx4BqlzU+5RZVXc=;
        b=MsfqIwM2HWmQndOpKuqmKM4dFJRiCb+3JNt4hnb3R/GU/3HOIJz5g1nm53NUwV/Ijs
         A5OTA1yH0d+P+AG0qdGxLPs5pHLDnmLqiD1rDx6MaELOGJ1AmRae2T8eLvZDfYrvyf4u
         WBVRFsKChRcqSmmYOw31OO0o/tPYtZf51CUyquGm3rIULgoaJ1SSV1/aSk5q8j+wJYF9
         4diyPSTWd9jSWVuQUatGpf7k0uB5jSNRYybwvyvoOKOPPJlyydxj5HZelZxS0EgYv1OK
         FjFvJsVKmQKAeUhuGyjj1LcI51m4nxDLCjcFt0IjJU811vpRBLtz1Y0vjXwfCS/2RlR3
         59rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787427441; x=1788032241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQ1MjC6uTf2uRG0SwGllDIjs6ixVWx4BqlzU+5RZVXc=;
        b=NCQ6WDs6qNUaYKvMsvumxdJI5uNx5taRX5g2It+WwtkPa4e8aN0XHB04em1Mk33c1P
         5XeuEAp328lWfw1PUxR07R8y/quIvLMo9122O4up8kLiqXXDgp8UsrSwvFhGfd/7q63U
         T7AFXneFVQG4nvjxv5XmwpCXDWSQwj5hfZMXcKXyfqWDnokupxuTb+VzWkxDzCpm0w3P
         a+cjweidisdOw9CFFxVx47yEe8wrh5cwEvzMzilBOU/Is+hWp7wJLGMWGYWxcTYkgeHr
         dU/TiBnX6kY5X26H7ZMLwTVwRf03dThIrk2W7FPPorOOERoznDe7M+6wUkR284y6vHjX
         nkKA==
X-Forwarded-Encrypted: i=1; AHgh+Rqjle3ZpsXAIYEiFxVq+8cgKEUKH7dxFYO8naigNEk0lKkF+ugOrsEuAbP2PMg9z/OsRLtO1kPOXCI=@vger.kernel.org
X-Gm-Message-State: AFuF++lbjOeR+E4D9T2YBZiLL87vVsv9TkvCqBO2n+MN4xYLTodkaLn3
	gxHtPOBbRusZB+ciSW//o/TrbfafoicfpgzcODyW0RgE2X48a03D9/h0WwubGxEVT5dFUgGEkTj
	GtTKGwX2q75KL486widG9r0DNveFmTWA=
X-Gm-Gg: AR+sD12+WsOwycn4Zz2Km58urNDD/aXkswg4dwxgyzXubBrdEBpLwr7c2qv4inN3Rrj
	BodOUpBTAocoyki9flLHnCYKWR82VCdnwgVDpku9IXDXhPNMgvcuGVBYv0Pmpww6klSrnxS3ohN
	za0AXflheXcZa9iu4KiWHR4v2JaqvochJTAWNxX+0x4i2ZD7O7OpGTIUuYqXh8qCRY5TpH0ALyC
	LK9tEjixl/tG0RiqjvV8yzOvyxRyeHjPJUC64C3ARNN9Rih1nhtnxLEBL3r3s+8VT0S4IG1AAhJ
	bjbFuwF3SRyFuKvU+PBUgX4mBLw5PU2G6do/l0I2UNANancBIDQoDF1YhD+j3Q5THJhKhTACrUw
	=
X-Received: by 2002:a17:902:d552:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2d670b85ea7mr148431905ad.5.1787427440947; Sat, 22 Aug 2026
 12:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062621.769921-1-rafad900@gmail.com> <20260822085155.1409-1-hdanton@sina.com>
 <CALp66yH7QzvGmo+N7BWykYjoaGT-yAezwRv0Pc_ir6qDRTsKvw@mail.gmail.com> <CALp66yFrutQ2h8SNyBZn04+LMPMnSEtWxW_Dr0vzfoHvEahSsQ@mail.gmail.com>
In-Reply-To: <CALp66yFrutQ2h8SNyBZn04+LMPMnSEtWxW_Dr0vzfoHvEahSsQ@mail.gmail.com>
From: =?UTF-8?Q?Rafael_Alejandro_D=C3=ADaz_Cruz?= <rafad900@gmail.com>
Date: Sat, 22 Aug 2026 12:37:08 -0700
X-Gm-Features: AcwNN1UbRv4mwCRmZINIlX1P2BO3CwxZ2OwXXpiXCpszeqyGlMqj4shl9Wluz8w
Message-ID: <CALp66yHBUOH6R55KXP9kS4-XYZiOF6xb3CC6jcVjiUJ5mGQCKg@mail.gmail.com>
Subject: Re: [PATCH i2c-fixes v1] i2c: core: Fix use-after-free during i2c
 device removal
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com, 
	Andi Shyti <andi.shyti@kernel.org>, syzkaller-bugs@googlegroups.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
48a5a7ab8d6ab7090564339e039c421f315de912


On Sat, Aug 22, 2026 at 11:26=E2=80=AFAM Rafael Alejandro D=C3=ADaz Cruz
<rafad900@gmail.com> wrote:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it 48a5a7ab8d6ab7090564339e039c421f315de912
>
> On Sat, Aug 22, 2026 at 11:13=E2=80=AFAM Rafael Alejandro D=C3=ADaz Cruz =
<rafad900@gmail.com> wrote:
>>
>> I see syzkaller failed to test the patch due to some VKMS/DRM
>> issue. It's unrelated to my patch.
>>
>> I have tested on my own local x86 QEMU instance with proper
>> .config and C reproducer. The error does not persist after my
>> patch.
