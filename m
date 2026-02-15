Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72DB28EA56;
	Sun, 15 Feb 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771159354; cv=none; b=iOafktdbxHc6R38zCDbHuGHVCqMQikmSPObHIoXL3yamBY3hICKqJjQj1KwMwkDXfFvP/t1VuDjq2t9y9domxlgdv+4RxPl6nvKbiDJtRDtz2AktnIMvC5RY2Lkoai9NkzSuwMP3PnCQtND6a8O/StXPLCnAN6NcjxIKo4qMO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771159354; c=relaxed/simple;
	bh=X7pfNpY9UNuUCe0f8VCFQgNXEAPXZmQnpI9wn2/fh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkItiUHPPiA8CbKu1xxap2m8ye9MF2zbvjTRiOwSLi5Wfawfa432MvtX96EEIRhTwjJeXqHEWNGSlExjNPpYNC3TDAhEDdoBdEA0MFNEqzVGed8nosU0yLLiesB/fNe2kzypTpB7nZsGRcAg89oxJgnM/Us+tMLs7xDQEbRI+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4cbGAak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4cbGAak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF56C4CEF7;
	Sun, 15 Feb 2026 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771159354;
	bh=X7pfNpY9UNuUCe0f8VCFQgNXEAPXZmQnpI9wn2/fh2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4cbGAak/g3QUTvSnjkDr1ZZ/LrCtsQFgj8lhi4QhJInTCKMQ9HHIYSxI7JBpRbUl
	 cbxCacBaZoMLnhfAg84VVXjeRiT3cyXaFbu5YJdfB3BtZ74QUdp1E+A6Sv7+xJ404U
	 GTnnvykR42H9p9IZpuh2FqS4daDZqvtb2JfUMrW23n6mad6SdpBHUIW3kfDIFgACFl
	 LD3YtZItDhmYl3qtSVldC9ikM39nGAPwzWLbTh597YG9NZbd9KCQhvvhBmbL1UzcYb
	 vdSEZ16LhPrAKWtEuDeOYqEZnx3qibp/PNmahcGqoHWyoY0VBqH7I3hOoFJHEcKSmh
	 PHzUarmewtT4g==
Date: Sun, 15 Feb 2026 13:42:30 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host for v6.20, part 2
Message-ID: <aZG-2rIlH45C1yFI@zenone.zhora.eu>
References: <aZD9aby8PsJHlq5T@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZD9aby8PsJHlq5T@zenone.zhora.eu>

Hi Wolfram,

> Danny Kaehn (1):
>       dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge

I forgot to mention that you might find a little merge conflict
here, easy to fix. This is because my branch is based on 4.19-rc1
and in the fixes branch there was a patch conflicting.

Let me know if you prefer to rebase everything on top of your
branch, instead.

Andi
