Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332C4AF17A;
	Wed, 16 Sep 2026 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596470; cv=none; b=S5y9gXNG7v73EMl9oOaWwb8FzhF27xZ/RJsm/KJKspxuNFvvayJyrlFjpzVYJswH7Bo3QpLBSA7tTL8kcfHh0KvdbkEDT2/VWUjpvEpHqA4TIrb1Au3lxy1hiWolFe+RgIViD1ow2XISxaRTWQWVtHnl1E70AJXiLyCXZpQGorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596470; c=relaxed/simple;
	bh=K4K5DbbpVUkk4zQrf9OGDxhxN8UxMIXxwzU7lMbDSco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWyqYpGUfHXnWLxqqCsUTTcgzarJQ+3Uun38udvuAdsoKuVqYUvXTdTQbjmkFjTMZfr6l+XVlv5Ds05g3g6f56LvMM88ZzroiAFQhL1wt2Hp7ypMl5XXy4f6xv7ioKNjZvsdvkM3K8aib27G2YP1QuJGZzBRGNIKE2f2CzAOoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsx+Ucs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsx+Ucs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA901F00893;
	Wed, 16 Sep 2026 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596463;
	bh=4GPWWyKv94s0Wg6Ls4K2tXl+vU9EF+kEnxWMjrF9pdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zsx+Ucs35/ajTMUl8In5OB6EULyHXKZRJ2S9X+PTEOWwItSvNbI2DC1sn4AcF1w5m
	 /s9+dJ8T7C9yvljQSf3nhLMeaASXOrM+QgTDdGpswhnqa8Yc1vuiMY2LpTBXcx92BH
	 qt2wHOzC2ua6qq8Hln+aAlFdqy6GqlX/CKQWrXgXB2zm40u5HpQiIqytXr8vqFfL+f
	 FeHcZ2UWBu4TvgLEk5LQa4dvi92cbgA+i4D2TMSw9ixTUqpRLJlrjZXDrA5/xlu4z+
	 bew1F5U596YwoGCiEgesdAnQj/h9da/hg0LblrqGGvnYiz6Itdq3HjaZCs3rh3uloM
	 Tlk6ux39i4/Vw==
Date: Thu, 17 Sep 2026 00:07:39 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Peter Rosin <peda@lysator.liu.se>, Andy Shevchenko <andy@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] i2c: mux: Propagate firmware nodes to channel
 adapters
Message-ID: <aqsTESr7MN9K8X5E@zenone.zhora.eu>
References: <cover.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788623619.git.ahmadexp@gmail.com>

Hi Ahmad,

> Ahmad Byagowi (2):
>   i2c: mux: Factor out channel node lookup
>   i2c: mux: Propagate firmware nodes to channel adapters

pushed to i2c/i2c.

Thanks,
Andi
