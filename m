Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CDE30F803;
	Sun, 23 Aug 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480798; cv=none; b=fXK+h5BZ+b2+yWsALXl+GOTO7CG9quVXcfmMecGP/Dn3O2ecnQrli7GePcL5iFDQXTw2b1r5scQb1z73NkoGdAqX6aty+9N3FvBg4DwoHIvIin0pzYe66j+O7jjIILS6B4csvRHguQWYe1hlrFyzACaKigcXx5I7vM30GGTHM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480798; c=relaxed/simple;
	bh=q7eoKWW2RWr6lz0ZeHGq38onPPYMLfvDJB7C56APrEI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AxqFvPQJ8z6kl6+sKh7y5h6RHVNemNpp8PaeFVz3prJcMSTOMU58ouD5O2FqlHZWOVp02EBdbg+GQj6gRG3fvXkQA+acUzuOHbLqkRvVAYfquk+MvSiK5YrfV8b+crkrzmGxKKLyMITHb8/9IlfxDps5XJ+3X72fAEHq/Q1Ve4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=FARz5A9A; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=FARz5A9A; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=hvopnE0i; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="FARz5A9A";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="FARz5A9A";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="hvopnE0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787480792;
	bh=q7eoKWW2RWr6lz0ZeHGq38onPPYMLfvDJB7C56APrEI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FARz5A9ArcMKobxL8mS4ZqB+Txwe5PbLSYPZ5fnMqPmIibAubuS2bMfaP/G7XDtLE
	 LTLV1f5w7uY4gdpnlkCz8CLkmtvTU6e/jPpKVVcs1pHT4du+TuYQ0+X0mTwHsEfhqJ
	 msrfRDRdUoLM0XW+bnl5wWgl1qNnT0Cuj1kccgLsFqk0qcsA8PMmHhMkIaTn1F6WGK
	 eA0PK1jhQ0ylSt+b3ggT7eF9hahKelW8eqHvjbM8jPMr9URNTbI6X9XeC0BQlRExE6
	 fHByDg/paPGhTWy43wobZx49UelwaSYN7WzW56+GEWY0dvz3zuL+UjwuTeINEk2btZ
	 O4lo1E0Xrxt5A==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 28A6FD8CB;
	Sun, 23 Aug 2026 12:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787480792;
	bh=q7eoKWW2RWr6lz0ZeHGq38onPPYMLfvDJB7C56APrEI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FARz5A9ArcMKobxL8mS4ZqB+Txwe5PbLSYPZ5fnMqPmIibAubuS2bMfaP/G7XDtLE
	 LTLV1f5w7uY4gdpnlkCz8CLkmtvTU6e/jPpKVVcs1pHT4du+TuYQ0+X0mTwHsEfhqJ
	 msrfRDRdUoLM0XW+bnl5wWgl1qNnT0Cuj1kccgLsFqk0qcsA8PMmHhMkIaTn1F6WGK
	 eA0PK1jhQ0ylSt+b3ggT7eF9hahKelW8eqHvjbM8jPMr9URNTbI6X9XeC0BQlRExE6
	 fHByDg/paPGhTWy43wobZx49UelwaSYN7WzW56+GEWY0dvz3zuL+UjwuTeINEk2btZ
	 O4lo1E0Xrxt5A==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 0DAADD8CA; Sun, 23 Aug 2026 12:26:32 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787480789;
	bh=q7eoKWW2RWr6lz0ZeHGq38onPPYMLfvDJB7C56APrEI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hvopnE0igZf9oy4qlOcSeAP97uvuBWMr6mn5YARWTIUBa19iZKItsanEKHh/fcDde
	 GMOWgzo8ORizUltDfQfyKQkofc+RcXRr6poYC+YRTgrze60MFruYTRGmEhrBIVt2jr
	 xPQRZokDAKjWeYYPrA68DsFZajHLkfGXLvbHmCi0hVFswErZbBA90KhVIKJSk18TCe
	 8UEaVeY/ySWjikGjNBtCDqoZNWA5gqaDWe6+PBFXLnw15p6ZwJZnQV5PmYwUAMe9vK
	 9LCRiLDbwKFNpEGPhqafvbuPxCjzgEWTYWTKnw2/j9VAYFhB0WRRXr5/obuzMm50QL
	 QbvinyXvwgXOA==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 9A9E1D9B3;
	Sun, 23 Aug 2026 12:26:29 +0200 (CEST)
Message-ID: <0854b719-bf60-4281-9832-9ea29bcfe7ef@lysator.liu.se>
Date: Sun, 23 Aug 2026 12:26:29 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i2c: mux: Propagate software nodes to channel adapters
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <eb4a8ab1eedd8a01ca34c6a7e0685639d0498423.1787247467.git.ahmadexp@gmail.com>
 <2e5328d0-c1d3-4a2e-ac17-2b5f8da5150a@lysator.liu.se>
Content-Language: en-US, sv-SE
In-Reply-To: <2e5328d0-c1d3-4a2e-ac17-2b5f8da5150a@lysator.liu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

On 2026-08-23 12:21, Peter Rosin wrote:
> ...is changed to
> 	fwnode_handle_put(dev_fwnode(&chan->adap.dev));

Bzzt, this is a copy-paste bug from the ATR code. The
ATR "chan" is "priv" here in the mux code.

The above should be:

	fwnode_handle_put(dev_fwnode(&priv->adap.dev));

Sorry for the noise.

Cheers,
Peter
