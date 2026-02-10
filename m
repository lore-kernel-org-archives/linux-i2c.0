Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B4318BAF
	for <linux-i2c@vger.kernel.org>; Tue, 10 Feb 2026 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723606; cv=none; b=SUIStxivSBmKJDo8lgFMczekEhOKjC5gtv+lUfyLUkVZDpH+/b11i4p9Ep8FvViqfNKUTaBlmcY+yc9L9LzB2CAdlKV+rO505F4eJF9LTWIoxCwtosw1P7miz5Pu8HxFL8Fs3ToGN4i9V0Ii6OTm+smiAlFGHyt2fWMjU6Im/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723606; c=relaxed/simple;
	bh=dqKxOobFcJBqPyepQzrqKnD+LxxtZE+dlRRofbhfCcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOfYV7adLtpF//HEmYHxL7qI+dXL1YHdswVOR2EExGIweA/cCuuPxMIoApNz0f9q9jSZh+70B0I99X0BiSnfmJcMwfSkD4gxGmBPerghZ4CPF1ta+TySRIN1AUKR/fhW65r7/oV6/yktHY3TjbXPZLmBZHWWs1KIMVkcYXuw5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BY+ugDEN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BY+ugDEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3owP
	HeRA/CYaNIOo1gP+9CE62ZAMUeKpNDjPPeZoat4=; b=BY+ugDEN4WmOuJBKq/dK
	b2dJ8L9pf4obK2MYpLyt+fG1pENsAmsuLiTgf0NkxeKuysAoXAfKtgCtswnQ+S/w
	6es+KMICiIZppj/5VaEygS75yUWtV56wEeEybc8AW8Mj2sHdYrO+DD9ZEPRAqlLd
	htVJ8xtQRuekfsjnE3KcV3I0XznxCJ54Fie3R1G/pp7xm9oiHyU84giFTBxrcBjF
	umOl8upFNkAnTrXBN0SDigG8zTtNoB3/7IuR9jSEZnqOqDzEKw/ePlO8EIQzCKEj
	uY9XIylAWmvEDIXLRsiW07Yh9u6z1LMERi+rHelr0v8iC4/XpwOg3RkKtmX+vEoN
	Vw==
Received: (qmail 375243 invoked from network); 10 Feb 2026 12:40:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Feb 2026 12:40:03 +0100
X-UD-Smtp-Session: l3s3148p1@ky1Wt3ZKgMEujnuT
Date: Tue, 10 Feb 2026 12:40:02 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: i2c-host-fixes for v6.19-rc9
Message-ID: <aYsZEqnyKRzP2wCZ@shikoro>
References: <aYZ-AZcfwfG1poEH@zenone.zhora.eu>
 <aYjE1N-_26RNg6os@ninjato>
 <aYsWFSABsDeu4C7V@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsWFSABsDeu4C7V@zenone.zhora.eu>

Hi Andi,

> > Well, this is a bit too intrusive for an after-rc8 pull request. I will
> > add it to for-mergewindow. With the tags in here, it will be backported
> > nonetheless.
> 
> don't worry, I will include it in the pull request I will send on
> Friday.

Please don't. I have it already in my pushed-out for-mergewindow branch.

> Meantime, you still have this one[*] in the queue for this week's
> merge window.

Yeah, thanks. It is also in the pushed-out branch.

Happy hacking,

   Wolfram

