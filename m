Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134281;
	b=eDp4YQ9S0uvlroO1XbHRIhr6J5yw8grKFAK7miN8dlvyjTk2Vkj0STp0qT02lIce0eFh
	 pgJpsosoGC9xV9iZcG733lStwjPnag74v/d03S7RQfbdPWu6mwsTWJOxZ99G4/WpfFBhs
	 vB83IxJUncw95vjKFRCgA1qplbVUZprzwopvy+Yiv5+8uKvCeOG5kAdV2c5w7BTauBIp8
	 HKLwPpfpqathMGTdMgsGFInpHIcsdHZQTCJdFFGp2bWEdn5l0Z+ictH6n+CgUHJAMBWJW
	 F++XU5lQg5dhWmM6YxTvP82JKnG7j1X3G+2c9xM/5jC2S/A2BFH6/6ngens/bx+crpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134281;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FcBOjOq7ejbonHUCPKTPqD9hNhihUnWssu8YyJCjPOY=;
	b=vrS9mSPx/ag2vSat2vvngX/7GeFcENqeVWAd0uwLHxEYUlgsEoWe1ko8QQ86Jf1Tu2v5
	 88a6Vu+plCF640fPUmJ4WY6yhQWuESqHAyh8Vrb7eIa3eVUTQFJh+2ToZ5rYtUQktBXZg
	 pzcyZC/g2bu+JwJ9jxf97PlHAG1dT7nAycTzkNx+uMhpGvpoGlOfZwgh5nMnlmjJ2x9h6
	 A6r054ELiZ+Zny//tUY0Ixk8b+T2eXuRUyyg6OhFbRh7W5QdlVVtXxZSn/S8FNbxEYkvq
	 vxRK7nOejjBdzdq3NM5HNGlqeRDAWUJG1o+4Q1uAPGw8wKtxQkrbu/C9DtF7lF5sLoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bAI11p8Y;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560B606A31C
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 10:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E560B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bAI11p8Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FcBO
	jOq7ejbonHUCPKTPqD9hNhihUnWssu8YyJCjPOY=; b=bAI11p8YWebYE+sg5VSm
	pNa7AAdhbUaHnx8YhdOpH5GJCrKEG0HRieAZrAflg94egScyR5ZFf+gTED1doVFV
	OS5Cu6N+e+hMviRDrM5d7Q8HBNz1ZKC+WsySbY2fpNk+ToPLOXKrybcjFYb8RIGP
	0//9jdqxIqW1XwkR9iNXWANPjlC/EpUdUXOEWEDSyRXSGgDz3xgpP8UKQWAZqala
	2l/yF/DYDYWjpetGqHUkCpNAwTK8AxSIGo7faj0tCNXzGvZMzIj0lut0bf416uK/
	PfD1hyhJSTkYBB8za+PZAxaGMFYNLgDO3O/c+8TCT0dXFIvJHOnNU51vOYncV5oz
	kw==
Received: (qmail 2813821 invoked from network); 8 Nov 2026 11:37:57 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:37:57 +0100
X-UD-Smtp-Session: l3s3148p1@cTJGcMFfSONe20rG
Date: Sun, 8 Nov 2026 11:37:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: return proper fault codes
Message-ID: <avBRBOkA-06F0tiB@shikoro>
References: <20261103-i2c-designware-fixes-v1-1-f83dd71f988c@mobileye.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-i2c-designware-fixes-v1-1-f83dd71f988c@mobileye.com>

On Tue, Nov 03, 2026 at 06:12:16PM +0200, Dmitry Guzman wrote:
> I2C documentation Documentation/i2c/fault-codes.rst defines fault codes
> for different negative results in I2C transmittion. Previously,
> i2c-designware driver didn't implement them properly - it returned
> EREMOTEIO on NACK either on address or data phase instead of ENXIO and
> EIO respectively, and EINVAL instead of EOPNOTSUPP if a message cannot be
> sent due to controller hardware limitations.
> 
> To comply with the documentation, return the proper fault codes for
> different conditions, namely:
> 
> - EOPNOTSUPP if the controller cannot transfer the message sequence
>   requested (for example, target address change without STOP condition)
> - ENXIO if target address is not acknowledged
> - EIO on other faults detected by controller (for example, NACK on data)
> 
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Cool, thanks for making error codes more consistent.

Applied to for-andi.

