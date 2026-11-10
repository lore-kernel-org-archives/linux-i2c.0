Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293457;
	b=1YsZ1aoW/Jd7wpAUxlpTpdUqZsO+XOwsAJnUghQpFLvGEgVbNCUB6zTHmcuERdYT8BY0
	 cnlv/bwRak19H4+fvpeVEQktT0wc0VClhxAdgnE+/w72m08tDysEnwx8voL+69n25GH+s
	 o8eeABX6sKMt/xsoSo5BTZ4XulyHvFeq5pyX1m5OHgi92ZZAvORe2+NOtFBY2J6mmyZJv
	 S4hqVdlUsFOXYXp5UuijJdM4ihI4GBBJSjrwX0/GgEMfAU4ZROzFtEMKbHeQudBwdOgjh
	 US2T14fcQ/3eq5HeGVa1VLNIjP2RxfKE8Hsi1h3ilbyv4XYaXb5o04DhcIynq0O8/ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293457;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=/w5jL5vyA9upjdnw5WddL4HeRqRVj2qfta9DH6HupIw=;
	b=NLdms9NhbVB98KmQMwwTtj1kq4p0N5ejvg7Rw7npnrVySFkesn3p2qB7rWMHXQ5Xwr+m
	 cXKJZjMYPz9wIezK4f00lY+0pCBYQEzi5ZnCFzOTl81e5gd+Td6x6bOjffHJU0h8+qoXT
	 Ye7NLsHTdV9Oecc+BQtUHYx4KXcyj8GzgnnvMh0ygvM8vwTN1oZqjYLxbTNaUTgeTMleS
	 KEc3mLw8LEdLVK09QAOu3ZSwB3Ip2OH0WIqRifURIJrHAFJJcWX4HtnSX6gFAU6F0HLqx
	 IH6BXpMPZMxqqSqw9U9GbbQuI9lNonUte57y5gP8VAqooYtFUUpGQS9vOiGPHMoX0nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=uB1g4tXl;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B4606A31C;
	Tue, 10 Nov 2026 06:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 374B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=uB1g4tXl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794293378;
	bh=/w5jL5vyA9upjdnw5WddL4HeRqRVj2qfta9DH6HupIw=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=uB1g4tXlDMNofQmaN4I4jIg7gmJ03AUnk5YUdQvy2CnsHntCb9Ge4czCH84OSR45c
	 A4juJcWRrj7XHhVj2HOhXqMYElcpu/gldwOXCVx3TNawb9Df2xMVw0hANHR2U/SKQ6
	 zjXMqkjgfaYu8nEPTos3AyTavjmYf8hfjtvmn/FE=
X-QQ-mid: zesmtpsz4t1794293371ta564256b
X-QQ-Originating-IP: FdOqUzZJzmmhkbZlIxz+KiVbEzGEuHwXiZl6I0gqZv0=
Received: from = ( [183.48.247.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 14:49:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14734344013771177668
EX-QQ-RecipientCnt: 12
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 10 Nov 2026 06:49:28 +0000
Message-Id: <DMRBWY2S42EN.1CNW1DNHJOKKD@linux.spacemit.com>
Cc: "Alex Elder" <elder@riscstar.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset
 in atomic context
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Anand Moon" <linux.amoon@gmail.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Yixun Lan" <dlan@kernel.org>,
 "Aurelien Jarno" <aurelien@aurel32.net>, "open list:I2C SUBSYSTEM HOST
 DRIVERS" <linux-i2c@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:SYSTEM RESET/SHUTDOWN DRIVERS"
 <linux-pm@vger.kernel.org>, "open list:RISC-V SPACEMIT SoC Support"
 <linux-riscv@lists.infradead.org>, "open list:RISC-V SPACEMIT SoC Support"
 <spacemit@lists.linux.dev>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261110061429.2036-1-linux.amoon@gmail.com>
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OAHLEV5KK0ozoH9/EFcv2XP7SqQJgHnczDhCiuw/ZfP1Mw6LrY2OWrpO
	HpbQkU2OqdbZSFxP/0uyeTx9HxmTQT6Yjsjf2/xxf98xAswq7la0KCdmZagnPoIe0ERvhHn
	iP44ybOHog0hj/KyspHL0ZzvmTDvDQTjSRspzCN7y6LJylkKIl6htCJTs5MEvM/IftQj3M7
	hob9moKn0uDu8D9d8rRbzCjRYT6Igzk+UewAdG3W2huL0QJvTw74fcITTPZ+VqGl4Xdp2N9
	jLCtjZSraANL6r3jy2ulILdEVOjWSGS/i1llC+hFB5AGunzdLWsqMKNwHPHrFPnR3ABZaLT
	/Y6MffxtTC97wk9qvwEKdpoCg/6FHRxa8UGAfHGz/RKr4nJ1F9kw4UgNIGwsQkUG1RsK47K
	TgqJB1ATuUROmRcpIp4dUPU1ZjLhFniHntJfb/rISHbFmcUhNfaFplpd7af4lypsCuhfE2J
	T4NQp4HXGQ1u5m5okgeWepjdKxzO3slg+J/rv2eqz+w0Zdj0/VpQCT1iV4AKygg7XAUplVk
	w9FKyxUrdT6sfDOlAS2HKdVnBqDrV4WWSEHUhQ+j11D4OaKtyCSO6RBoEcxqUHNioRGuCYe
	b1dAuTpahEJrHeqbpGPOw+YCzg17CYtzrHArfnZBrACSF7AtANAGriBna7bRLBl1OnPD1nS
	yPyuBmXT/261Qq1AbPDX1Z8Tf3BMLFZUtll0nwqwGIKH0NfF1sd5p8YV51QfE/kFWThSZhO
	Ark4k6lw4k3WPGnholYAxUK5DgntuAcdCkXx/fWR14T/xN+NATnm47DWlhmnj2DFj89/6rP
	cNl0/cX7Eoqwf8IOrFYvSvI7UBTexhy41bGFiAPeb4iE1iprw3FVZ9m7WZAfvNzC0lz+HcG
	fqlwZHgCNJKoO7aict8IGFHC7S1cpFW4x7lcpPVVzP+3+RVNq5Z43E/Mx4wvlz5m3vHGjux
	uBXSBKqieTSdbUQq5CNMqVWO0tInnZXMhsHk5BIwPBQYpBqJfMQ/DB9F/8qm1cLesnUw1pc
	lZ83OMrAOBc2LuwNWmLNOxB+s/EfrBjDbar4pJE2vaM/LU1EUNFCjSf3vZp6GfYTnoJfiT7
	UZ9l09B0KaNURMiC52qyb58f23/byhYGg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

--73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 10, 2026 at 6:14 AM GMT, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
>
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
>
> Assisted-by: LLM
Also, please drop this tag. The same applies to patch 2.
See commit 1e035297ffda.

--=20
Troy Mitchell


--73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavK+eCEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC8WuwEAp7T345IGTixk
luS0mGzMpY26JPDPOjGWsAUNq6ZoV1gA/RWwn34/Jxu8vWe3risrvjxT8VoYL1gt
bpegaV9zkQME
=3GOU
-----END PGP SIGNATURE-----

--73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645--
