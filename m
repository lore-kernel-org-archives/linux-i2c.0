Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8718EFD1;
	Wed,  8 Apr 2026 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616597; cv=none; b=qrevyvaMdJzL7VyHiY97aCQja0R2+ZAxFkyzrtx7moO8JXQnTxO8MY3eMbxp/tUIiSiQfHAKrAM7eN2XZHAqML5lBNj5jIntk1hWYMAJpu/l2o7m/kbbuPuYZ720rbhGzxovetRZkOgqZcIvfkNECYqUSz/8kMxh0bsV4L2dYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616597; c=relaxed/simple;
	bh=+UuM4q1vgiatpeERAXklQJO9UrZQ54OE+RX5pK9GpGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=q3/wgpdw/mAKr5hLfMTSd2NLINlAHgd/qPx3F++XcuqXwFhFUey7YP+7nbNByNP++Y8yh/dzt3IvwMoshXMBHls0qJNEGy4f1RHq/xhuMozr/DLTbd+lsmusDgi/NhsAceDZVmzaBccOAcG1jRNI0CDC1MbYaK0OkwPFONp5qEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=atl3iZzk; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="atl3iZzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1775616502;
	bh=yidXhTBb2zJgYkyCk0CYWabO2JRCWHqEgQlmxubluYo=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=atl3iZzki/j71RL0gSmeLB+ZGLs6QOJDHAzrbfmcNL5awRN+UokYdbdjqL+PBttms
	 EeHqSySVR+D+7rannCfXEUEUfU1t3WOvuZiR3dyDLxl0YLIKhAblIt7gvFVkOT6vAy
	 KI8u84YCQbYDVGFhBkxDtwle+hKirFTOvWV0Skcw=
X-QQ-mid: zesmtpsz4t1775616493t5df3e19c
X-QQ-Originating-IP: UWGoQnXfI+aa6PWQBmbxd+UL7yVcZdzn5VqUhKeqiMo=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 10:48:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8140302945074531097
EX-QQ-RecipientCnt: 11
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 10:48:11 +0800
Message-Id: <DHNFIJBTZQI8.C1RI1XWDRL3Q@linux.spacemit.com>
Subject: Re: [RESEND][PATCH v5] mfd: simple-mfd-i2c: add a reboot cell for
 the SpacemiT P1 chip
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Vincent Legoll" <legoll@online.fr>, <linux-kernel@vger.kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Yixun Lan" <dlan@kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
Cc: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Yixun Lan" <dlan@gentoo.org>,
 <linux-i2c@vger.kernel.org>, "Aurelien Jarno" <aurelien@aurel32.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401165437.1048786-3-aurelien@aurel32.net>
 <b7e182f9-8bd8-40e6-acaa-dc6e556f2a53@online.fr>
 <adPUTRAlzGBs2wQG@aurel32.net>
 <bbd2e57f-3107-46cc-a8a7-ee717e577d6e@online.fr>
In-Reply-To: <bbd2e57f-3107-46cc-a8a7-ee717e577d6e@online.fr>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MXdazUCb/CBOkLJDmIC8M8bgAvWpoDUUVwSBSDgEz8pGQhMdR25Q2gZN
	X492gJrHD4HOyPINe/n+qPincr25l65Z/vtZbQ/XQA/1Jeb7mIE+Rm51JYJ7K2co9IOqI3S
	lSMmIpJh4WWRrmv7AN1fkZ9IfItmVccXaAXDPgHVsJeNqn2G1QM11JbicweYhPhWHNUX5NP
	AhwI1o8yuxBgKEmc+ZlhjGBAXyXLOC+QWbeqp5cMIfKjwDWSAR+SYoQ6jN5w/Xzfb/AgEMd
	Zuic+v0npbf9pD3K9/qa3u+5FqP8DdVc7QJSOaMo7JPYY3P6ubL94r6otFwQsJ1pBC8r4Io
	3PKB7TuA37S43JG/1K5gV1roM01/+vsI3eluNfPNbiQdtOaIu13CVcSkJqHHEyqOluXyO4V
	GiQVbYFzt+KS0+JROdI0dmsPHENSya1sRifZ0gicDRnhR0g4imN02Cuu2CjvTZxLbcMs0hh
	eLSn8bmJ22c8Ko6B8/vvreL3lUWedAq1YBzop+LPD5iFmnd1p6v1/J84lufW3o2nLnwomQF
	egFSw+vg/Tuw1MKqfn1UuspYFaY1lwxBsgLbNxP9YMPby/to3aJLZtUM6bxs7x5g00/VQNq
	c1C6+1tYYH/C5YcynNWTiNnBmb+PwQ4e66LkyzZlEMr4XYjUVut1MPKRtN4S6XyHq6Ei7X4
	bt0G83eDUB2O6E1ahqXkTTA97EobVHFZXF67BDat+Ui1HO5bTUm6preW3dqAjI5Y+Q/D7bO
	rwE0rrgprxD4tPFdnOam8ALoX82+TrX5OQBebsTemLtVxXLDb/UCQpz+2M8FbuYEgKZ4qoJ
	MxWmco3ZrBfF9Fgeubnwh6R8KPYVoJSJ9oLd5XbLFEhmrfxi+mLJJgR/z4EiO4if9rZqx1n
	fKkTduRhaYC7zjjMqTpUnKSSVk3e121A9sJhT7uvzyudzKVVvRe1EZOw2GQVqIIp8hBTYwy
	CfyVcKg9WrrjTRpo6R5H2eoiawG+GtxUjaEYhKA0VRU+LjmE8855aNMx55Y1VzVquDxH2qI
	yYqFr5cnsZEjzYwUAGUz0/O7I6YfJlm12oUQ7aGH/+V7ULvxfvJGQu2BBlsSDyr7yv3IiYp
	+wlVrSzw+wKZlrzfrNOTAq6vzYOouMpB8n3WCcEsM05h/5/U6WuCrZ8Vo3aMppjTg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Tue Apr 7, 2026 at 5:55 AM CST, Vincent Legoll wrote:
> Hi Aurelien,
>
> On 4/6/26 17:42, Aurelien Jarno wrote:
>> On 2026-04-06 11:46, Vincent Legoll wrote:
>>> Tell me if there's a new iteration to test, and/or if you want me testi=
ng it
>>> in a different way.
>> Yes, as written in the original mail, this patchset depends on PIO
>> support in the spacemit I2C driver:
>> https://lore.kernel.org/lkml/20260207-b4-k3-i2c-pio-v7-2-626942d94d91@li=
nux.spacemit.com/
>>
>> Without it, you might get this warning message and reboot is not 100%
>> reliable. I still believe it's better than no reboot support at all.
>
>
> OK, I tested a new stack: next-20260406, PIO patchset, reset=C2=A0patchse=
t=C2=A0&=20
> USB=C2=A0patchset:
>
>
> $ git log --oneline
> 5030369b32c4 (HEAD -> opirv2-pio-reset-usb) riscv: dts: spacemit: Enable=
=20
> USB3.0/PCIe on OrangePi RV2
> 73274ce37441 riscv: dts: spacemit: Define the P1 PMIC regulators for=20
> OrangePi RV2
> cda12b8bdbfe riscv: dts: spacemit: Enable i2c8 adapter for OrangePi RV2
> 68ce409351c6 (opirv2-pio-reset) mfd: simple-mfd-i2c: add a reboot cell=20
> for the SpacemiT P1 chip
> 245e0b8e8a91 i2c: spacemit: introduce pio for k1
> a588d756621d i2c: spacemit: move i2c_xfer_msg()
> 816f193dd0d9 (tag: next-20260406, next/master, next/HEAD) Add linux-next=
=20
> specific files for 20260406
>
> This boots and reset properly without the previous WARN.
>
> So if any of those those series need added T-Bs, then here's mine:
>
> Tested-by: Vincent Legoll<legoll@online.fr> # OrangePi-RV2
I'll take this tag to my PIO patchset. Thanks!

                                - Troy
