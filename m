Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375983E95BF
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526251; cv=none; b=Ky6S7WRHRXHq+3L5crn2NbvAopCpOz3/FOE1LZwxYXDEsPaWIYO2f3Z9nZtfu5sdJEcyPS0k2l72Uq4nXI8g/ieiE3JqNsBHij5Px2XnLB31qdteqCmWVkZmsZ0J4Y/QLrtSKqzcH9dVMPlqS6TVCmrNkefhhg/zphd6J13N3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526251; c=relaxed/simple;
	bh=fDKDIbRI6VFBNSqcLvsNNCda/9zyO9Rik34Yu35n3Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcEhYtIL03IwWzuXVp3DtlPjyjBwlGvdVzGyyc+aNS5jS2fT3LwKoCrCg6GBdD6mWJ0RSzYc7oeVYwoWOCuSGWEy+fChjUsdw9dgRzw/1I8RojI+xlYj2Sv3SYudhamVEl3zCPo1n3Tia3K2qzC1JdtmDczzz60DTfh9VSDxpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4CyHR9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4CyHR9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99391F000E9
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781526249;
	bh=fDKDIbRI6VFBNSqcLvsNNCda/9zyO9Rik34Yu35n3Eo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W4CyHR9EFCbPvEvW6x/sRF8AEWL//J/tYbv41cnZNO4ie/WItvXhdccAkD/fqVlLo
	 Qy1i5q0h0iK9AdSlM7E9oCMxxgQXxvS6uGqCUcOVsg0djpROU2nKPtWKI0YccuvOv+
	 tsj/DnCDeCquTUCmM+pjsC4HBnmXk2mN9kYif0ziD+HYJ+uGQYXdGzeEgicHOxsBQa
	 OUM9IgNF4PviVle1MzdJWt2QAMCnrgqXhDPssDfRwBEAM40DOtW7X1gTijBReS4vOS
	 La21eYgwrgB9zMEbsAWYJ6u1IYnggphiHxY+dcDvUiJ9bI1FQUOnT1vB3x9Gl7WuIr
	 sISJ6Af54zLaA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso3123185e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 05:24:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+sFbegC3celGrLibFmpREKuGeoP+1z6zFQ3eNadaKzaneT5Jncj3MkMIvOgr4t2smCHL9sPYjEc24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfIur3oZVJ6J8aDP+mxrK9mq5vZDzC5wtBRwE2/LKz5cortq9
	5DITnXh3CBgkQPtYbYJeyeFyyGejYghk4Q4HtrUprFlggMyC9Kg5cwAQddQEnx0unVywFCwT0PP
	AeVH2KSPzlCaUtJoEST7uV9iRIfhge20=
X-Received: by 2002:a05:6512:12cc:b0:5ad:3035:b355 with SMTP id
 2adb3069b0e04-5ad3035b409mr3672367e87.51.1781526248636; Mon, 15 Jun 2026
 05:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610083701.18663-1-hardikprakash.official@gmail.com>
 <ai8jhK9hUGHpojB5@zenone.zhora.eu> <ai_PwNWnMZB01AYU@ashevche-desk.local>
 <ai_cAd41W3iX1ic-@zenone.zhora.eu> <ai_d4eIId8Ml9g7I@ninjato>
In-Reply-To: <ai_d4eIId8Ml9g7I@ninjato>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 15 Jun 2026 14:23:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLkdSLdVwyHPQO_Gd0LxOQFkGg_BbR3eaN=wK8NfwyBshA@mail.gmail.com>
X-Gm-Features: AVVi8CenT0lElz7kWDZ7uYPZwz8DrIaXZfHVKMycL0kDDYu1zMAnWS--4lBrxMs
Message-ID: <CAD++jLkdSLdVwyHPQO_Gd0LxOQFkGg_BbR3eaN=wK8NfwyBshA@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Hardik Prakash <hardikprakash.official@gmail.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, mario.limonciello@amd.com, 
	brgl@bgdev.pl, basavaraj.natikar@amd.com, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 1:11=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> > > $ git tag --contains ef76a3a28c79b6288
> > > next-20260601
> > > next-20260602
> > > next-20260603
> > > next-20260604
> > > next-20260605
> > > next-20260608
> > > next-20260609
> > > next-20260610
> > > next-20260611
> >
> > Yes, but I'm not finding out how it got there. I only see it in
> > one of Wolfram's branches, but I don't think it came in that way.
>
> IIRC I asked Linus Walleij to handle this via the GPIO tree because the
> proper fix landed there and the I2C addition was a mere cleanup from a
> previous attempt to fix the issue.

So this revert is not in my tree because it isn't needed: I never
sent the patch it is reverting to Torvalds to begin with. I even mentioned
this in my pull request to him: by being so lazy in sending my fixes
upstream I avoided the whole ordeal. Maybe I should always be lazy.

Yours,
Linus Walleij
