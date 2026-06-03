Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C129E110
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492763; cv=none; b=ZpxptIv20+2RJhcg9oGOilYa6R1rzkPYyV6SU5Bcok3NDD/2nvuOzYW1VL7j97faTMkkb3ZL4IMgU2/gPtO8Hzsr+K7UGXjl4eC5zIW/mFRMflGGcHviDmJUXVTcoOokOFRc+n6XP70eCIrgMf7WJGUjZnlpyJ7rgPa0rEmzbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492763; c=relaxed/simple;
	bh=FFwecxhDmtdEkfTir4smAHIjUmZW/uwEvg4rdS5p9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0dWCo8wJelevh3XKAcAOU1L1Egt9DqphROEK5vqjB3tju7VIU1NUvxvR8g7+PbtFdeVlZJIH+0wkJo8zbhj4gTZTy13A2xYCmWigFJkWcg+cfIwa5Cz1KukVrshCKpoElt6ueqLMVaKlBsthSfTKtQhs5GMZoTcCNhjFkzzpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=B3wfvdZM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="B3wfvdZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nH32
	4JlR8c3C22dShlv9VPRniIDc+RFtrFDKP9m1oU4=; b=B3wfvdZM6bLDC03I8vi5
	r6oq3+mPTx7flYk+6grips8Br40wSttQzusiYejtyQxmyW4CmDOLIm9tfUF5jDhH
	ATvpKAnzqV1VvalPAosGBs7q1lRsMECrOIhjI5qr9P9e8LGXpueikBSiNplpTSGG
	w0I+ncQQfeRCAcI6p+sdgiSxgbLjRHVebkBkRugQIsSDXJhTB8XPDkNQX3ncaWJU
	uIlc4k81kDY+RvGQjQV49woRCLTMsOt+Mc3/SDher/9NbMr+1mgU0wu0xSD9pYNN
	j68Eo5w0u67gNcdnCAYz72PZt6Aj126++XZRLfs7sS5X2yNX9i9iB6PBTeqZZEb4
	Aw==
Received: (qmail 3290627 invoked from network); 3 Jun 2026 15:19:18 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 15:19:18 +0200
X-UD-Smtp-Session: l3s3148p1@ipliRllTurUujnsK
Date: Wed, 3 Jun 2026 15:19:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v3 06/10] i2c: core: disable runtime PM on adapter
 registration failure
Message-ID: <aiAp1fTxxTntDmUk@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-7-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-7-johan@kernel.org>

On Mon, May 11, 2026 at 04:37:11PM +0200, Johan Hovold wrote:
> Runtime PM is disabled by driver core when deregistering a device (and
> on registration failure) but add an explicit disable to balance the
> enable call when adapter registration fails for symmetry.
> 
> Fixes: 23a698fe65ec ("i2c: core: treat EPROBE_DEFER when acquiring SCL/SDA GPIOs")
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Yes, we do the same when removing, too.

