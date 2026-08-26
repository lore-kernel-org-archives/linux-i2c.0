Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18F2EC0B0;
	Wed, 26 Aug 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751948; cv=none; b=rK/cmBEN4rm/ULJ3ezed3XngthOGi6J71FuOQpeNyDrpezZVAr98ZbM9qS8IKItu7s6JxQ5DqFUjPv7eOEWymcz6Pqrq91m8xbyxvpQ8Uj+3RvMEV7bYeOXuMOzwngFSMjBNU7f1rJngbsbSfhc7/kKBcUcGmkjpVrQelJsPuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751948; c=relaxed/simple;
	bh=1jaQPpxWrEtK5AeTk9mCVYqOF/JVYi2TaIMe2DLWj04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5nHqdZufhDkjqfql3xMpAo3x5DSfBtN6yKafH23BijdEPeU2hRZnvYWKAx/IeNARHdHT3G0WZPG/0WheblL4hYTJvGIWBR/F4IOtuFcMDdWV2gE5VMgm/rtlimR6eb3i6UTJ1BMBe64vizuaz1J3xkJlcKe9lZ9SZilMEWH4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+1aEmsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+1aEmsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B831F00A3A;
	Wed, 26 Aug 2026 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787751944;
	bh=cLESUp7svdxbIGCSEt2bmyc8iG6vu/lNL9eAsgtgkAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+1aEmsbI/4ElXR/0xZWOPx5I8kfvVUXAZsn6yZJZLvY+KdktfA4SJT1hWZOtMy5K
	 6izKuQIfafT8mgkTuuUvX2HkyRnLuc4I1M9YhR77Bz8JWcztcxwmU0/rZwp6MXc+Qh
	 qf8A5+j4D8ExeVVOJW0PoKXYVr1yhVUD0QtvnsPoTsc2kQkSC6LkA9aeQ0di1efsvs
	 U555s5u6UExxb/hfL2GAD39QftI8W7N4nxiiI9SbVyr0V6ZaQ4qXuhdCh/h94NgFiL
	 7c8mx8nl+mXddOw/tpcPQSL6V/RJMrLnNm5NDyGKlajmAvajIL/aJr6PYymcQT58WE
	 PfkEmQsm131aA==
Date: Wed, 26 Aug 2026 15:45:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Peter Rosin <peda@lysator.liu.se>, Jakub Kicinski <kuba@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <ao7ttmXomH373XuK@zenone.zhora.eu>
References: <cover.1787502619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787502619.git.ahmadexp@gmail.com>

Hi Ahmad,

> Ahmad Byagowi (3):
>   i2c: mux: Fix channel node leak on adapter add failure

I merged this first patch into i2c/i2c-fixes, while...

>   i2c: mux: Factor out channel node lookup
>   i2c: mux: Propagate software nodes to channel adapters

... I left these out because there are some pending comments.

Thanks,
Andi
