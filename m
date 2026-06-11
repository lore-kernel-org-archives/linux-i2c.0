Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1663451C6
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162573; cv=none; b=P4BEh7Xs/Bs4vVXbowmO9H4VwL6ynMoGQfBkpvoAUvZldTYbtZxiHKF7iqOsJhIlEGgUGA7YKgTfeQx+jqptGfRuf4RlcwiCU9SSTuSwM7+K7a5iz33fKekxkGsTGP7SjvFFo3MUNkAVRg3gY3BtDfX8XsVq40V/E5sfgiUbIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162573; c=relaxed/simple;
	bh=pcTfJkhmFKigijut9YsI3JFcvbnUhH7R/4uPGDexrW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGAEUh93AEBJ/isz0f4Yl6cn9diycodHDXuz+n5g4Y9QjiLTOn2c85wF02NrZd/9e+syejzteKsgc7EHL2qmJeSuS450tZ2okjPf8RPxwGGWe3O2ZMAYRMlUBjrN3N+G4+TM279/YsdcPa44azZuQ7y/9MarAAELHcYqm9uXCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TTVxMHzK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TTVxMHzK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 358C84E4180D;
	Thu, 11 Jun 2026 07:22:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B6245FF03;
	Thu, 11 Jun 2026 07:22:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0011C106B9E27;
	Thu, 11 Jun 2026 09:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781162570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pcTfJkhmFKigijut9YsI3JFcvbnUhH7R/4uPGDexrW8=;
	b=TTVxMHzK1KieUxxtw3zaJXmgv/7Oal7JoudHKGoIy5a9mGurS5Je0Mp0PmXXk0joaQbj5Z
	909YGi8NU+opEIjuZF4naBjHBCrNaat8SjhuK4dl9iB2H8dEJQr+76lozYFHQbr2vyrXBP
	O71GaJMF7axEKgFEKUd3nGCk7bFsP0qRBvpem/scjwBjuKeFmfY7CB01t1kbC6pbbxBVCR
	14dUIH5WJpwkCZAEec/CeoSfmO+Nk56fGDsVCJ+aj1dhcixfqmcjzSVxekx5k0TmK7G4J1
	/4nb31RjlNDquIZI6rJfbvi3/VOtZBMHNeu7nHxywQpAB9IIE8xpP8MBi6F+FA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject:
 Re: [PATCH i2c-tools v5] i2ctransfer: Add optional message modifier flags
Date: Thu, 11 Jun 2026 09:22:48 +0200
Message-ID: <yDXWsGBGQIaWcanmDL5Elw@bootlin.com>
In-Reply-To: <ainNlID05qsaaCD-@shikoro>
References:
 <20260610-msg-flags-v5-1-0814fcd44693@bootlin.com> <ainNlID05qsaaCD-@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Wolfram,

On Wednesday, 10 June 2026 at 22:48:20 CEST, Wolfram Sang wrote:
> Applied, thank you!
>=20
Thanks!

> It would be awesome if the PRINT_HEADER part could be extended to
> display to the user the flags used per message, if any. As an
> incremental patch. I don't know if you have time for that?
>=20
I was thinking about that, I'll add it to my todo list.
No ETA :)

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



