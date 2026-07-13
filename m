Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918E3DBD57;
	Mon, 13 Jul 2026 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933345; cv=none; b=KXh6uL20CDBl4b8kz4UueDM5c3iF7iWyqOmn1GUdQ3ePm1r2bG6vatladyezqA/HO3+cSj496R7svoCykJfZuFgWmFdQ+Cp00vIcpECxiy/m4UXQY6b/3khNM7aT2z/IAPSinOmeLweLTFyQHRN67AtPwgjbCMkSzTTvSlagCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933345; c=relaxed/simple;
	bh=NEnR0/uhPeqIpCCQVfQvUN1cbbziqbsKeCUGGhwo/YU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PPxQyPW031VFrKoRQlsPQ33LQGMD+B6+plv/yG5sTgy5qgOkLSzIPKSFwgmgkZgZ7FmUghO8xNXH3LRGYAk87KqNRdpIYaby7OY4vTqBq/Ry+EOKjLY5bVxxLDVmVtwW2FpSZ8CvOUDFuJ7VPc/onubGMT+27Ak4nPIdYdj103Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vhcE8S4a; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vhcE8S4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1783933291;
	bh=rfDq6XPlv8R4XIJ1/9itc+1o8grDKU8S7i/xorOHrq8=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=vhcE8S4aZ1b1Gfj5eZ5STO6ok2DGOdR5gXFNXhXlD1+fvk9j5dJ1LkRxp/3m1eTB/
	 vnmNL1fhNoPt72dHy92JcMEh0O6/UY1JDhE4Hpp03GFetgzrrlZVyVtQfWxEWYi7cc
	 ihEqkEdDjDn5a54C70E3ket81RqH2qiHDlj9VqZA=
X-QQ-mid: esmtpgz13t1783933289t8710c04f
X-QQ-Originating-IP: uYeZvJY1YPz9m9I2VRUZhVLMDbWxBVchNNwN8t2JL+0=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 17:01:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12062326101475102107
EX-QQ-RecipientCnt: 7
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 02:01:27 -0700
Message-Id: <DJXBKMGB3NLZ.1NH7HSR669XF0@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn> <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn> <DJUQ3TZHM7OO.34ULEC76Z2BDY@linux.spacemit.com> <e453a825-4d73-4d35-a699-a495b0ca1058@kylinos.cn>
In-Reply-To: <e453a825-4d73-4d35-a699-a495b0ca1058@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NVu/uN2EcufQ2/Vo4zOzxog+GCp25ZAKLkVyCAD0xt5o3OyOPeBT+7uQ
	V0eHXCPXv19kK1QXZU8RB/mBaK/+TZYD88T+6uJjQnQrEqc4GPObqF26TIPrNF2rt0Orjff
	5I920LXehgsPFU6+UIrKBlZjsSjuOVaqed6wMBGZUKnds+/4I9Q8vLJdC0uS1m//YYnFv18
	L8RFyFHeh2zD4MYO/XWLL6gAjzZrqSLyjPIYHVmcG9KjWQHUCFfG/d+yEgBjOxFNo1G95DR
	OoIECL/gnlGWW7BQNxjQo6d9Qm7dDrS8ZFEPzabn01/EAjB6vu8GWDHNA/drLqt7th299gr
	Wu1YoNqFbN6mP1plYw0KY2xCPeflLe9bgS6jM2SKNhup5VQHG6DE6L98Z2J6xa0hadwJU5q
	ExEFRKL6U9RuyOzDEoSW7Y4rXpcfUIhIR1o2h8NmHU2v3T99znvwrVVx3jQY0ss4j9zwrvn
	7i66MfXV28UEJgBUNAI4TechIp84cgAKSkhpM0OX45WVnDw15pLKnx7QvmdtJuAvuKr/ns3
	l104MfE24rN2FpD1trdK4c4ojvKRbDe+H6EPRJzUofLc/TgK3yXwQoe8uWiUzbSrkx0MHhS
	DBJPP6rBwRIvK4t9e++xwur95tiJax6iwD2w3sqMKcIQ77bS4IbNg3wT2XhMlEBcnRgpH1L
	Uojh824Wzq4Y538zR/vmcnEgXU/DwKBykUW2t2VMQbhbBw7FHHZp889OZSAB66CCe0B1ViR
	LSBgtblOwQg9JdRVzL54KuQGCgvoKzeF9JJ16LPnEfqJrpvf0zEcLlRx0ji+EZ9Pga1gewk
	uR+K5wNhYC+/2oSdoQBFLV2Z5dxNSa+2yySIDd4t/0r6QneUrdI6FBLzTrKy3xIWbwlLY8B
	9c6nMvok/N/YXiyzgKMEI7ORiz24LHK0B3HphWhY+D7nmPip9kMEwnmD6JvrhGsCfmVfOdQ
	u/hIdLanVA9CROX/aLcQ23pk9WzqNJyaIPXddwiMJ9a+WCUccA+S8CbfmQ7fZ2Fs6x0eKtW
	V3sH75HfaOmpKJdr2t7yYUXUWbhA/UwXlU9dl5cHmomtUdrQ/kdm2MKQnRqnCV7d3MfxPru
	jUj0fqXywKN34oqjZodXsQ=
X-QQ-XMRINFO: OD9hHCdaPRBw6CmXJi6UaqSbLUGYIq/CyA==
X-QQ-RECHKSPAM: 0

On Fri Jul 10, 2026 at 2:18 AM PDT, Pei Xiao wrote:
>
>
> =E5=9C=A8 2026/7/10 15:46, Troy Mitchell =E5=86=99=E9=81=93:
>> On Fri Jul 10, 2026 at 12:21 AM PDT, Pei Xiao wrote:
>>> When the interrupt status register reads zero, the handler should
>>> return IRQ_NONE instead of IRQ_HANDLED. What the return value
>>> actually feeds into is the spurious interrupt accounting in
>>> note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
>>> nobody cared" detection, so a stuck interrupt source would never be
>>> caught.
>>>
>>> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> The commit message now describes the actual mechanism correctly,
>> thanks for reworking it:
>>
>> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>>
>> One process note, though: please don't repost new versions this
>> quickly. v2 followed the review comments almost immediately, which
>> means other reviewers who were still looking at v1 never got a
>> chance to chime in before the thread moved on, and the discussion
>> gets fragmented across versions.
> Because I noticed a simple mistake right after sending v1
> =E2=80=94I forgot to include the version number and changelog for v2=E2=
=80=94
> so I thought that by fixing it without waiting for reviewers to point it
> out,=C2=A0
> I could save reviewers' time and get the patch merged more quickly.
> =C2=A0I may have been wrong about that. Sorry.
>
I'm not referring to this thread. You posted an earlier version [1],
and then sent the patches in this thread just one day later (I know that
one was sent by mistake, without a changelog).

Link: https://lore.kernel.org/all/aaba8ba228a99f580050004c5b7e262d855de44c.=
1783590752.git.xiaopei01@kylinos.cn/ [1]

                                          - Troy
