Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E417559CA7;
	Wed,  9 Sep 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971478; cv=none; b=nD7CJOiD3BmFzzxtFKE0zgG/+Oqvl4WAV0YOTxUtlIL+ycAyfzypb6/s4DdoyZlD3lgMjvS0Iz2wQPrapM7U32Ukbkvl5LyipAeDkIrAD7cYPb/6IrJANoKwVXr3fm+EbcVvotlwD/4kwK2bJeTfDwkZcE4oLwmMuoG/icVoo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971478; c=relaxed/simple;
	bh=aMSTshQtnuYIEN4IBAw2H4Fxfs1452IAAn4R1mC3SA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQL37G5/KTpf4ZhHytHpOpDLhsw1nOa5J7bwKEQAgRjkO1aAZ8SK7NUoS/BJODrIkLnzgttvPTI+X37EFVI1NAQGUqQl3ADgIjk+VJ8H7LE6Upomt/3QjuYnynWnDHv04fqi4Fc9iTaJOSXfdc6yhNzTRSIKY39eCchawVY3iog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezmx5Sj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezmx5Sj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805E21F000FF;
	Wed,  9 Sep 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971477;
	bh=5AGuxk4NOSjylwN/H1HVAPyUMG8ab4mJRPOrw/h76dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ezmx5Sj4iZpRyvFvONIMSK8qwap7uPWV53sHlTW1LpudJCnQ727mdRKcmYDi+2zkV
	 p6OxbHMV9UE5Kkp4L/GSQLIyGO4Xj7+Nz+v+17X0WSLEnV0XlWWBE7TiKJAsOB7wkF
	 m+6TfRQFYNppDPqouCT2zZUsXJygoi0bAqqg6kwvWsQ02bq56nfwX1jukiNmPFzP0R
	 vuglA6z0UrkbaJbpkFgs3pC1SUdAZzPDs5dYiAa4KO6T85rwhfv7YzUGqbHmeBUfpE
	 YwoL+zPsNN3xkaBCwQiCcAbIDVSioNWgMN4dRLl4wiVrGCCCKbEKizqsMLv0qSLlhD
	 J5XWsCK+NCo4A==
Date: Wed, 9 Sep 2026 18:31:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: Re: [PATCH RESEND 2/2] i2c: Change return type to bool for
 i2c_check_functionality()
Message-ID: <aqGJd9ph6Kz279GV@zenone.zhora.eu>
References: <20260909082053.410739-4-blum@kernel.org>
 <20260909082053.410739-5-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909082053.410739-5-blum@kernel.org>

Hi Thorsten,

On Wed, Sep 09, 2026 at 10:20:56AM +0200, Thorsten Blum wrote:
> i2c_check_functionality() returns a bool - change the return type from
> int to bool and update the comment accordingly.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

both patches merged to i2c/i2c.

For some reason I don't see anywhere in my mailbox your patch
1/1, I had to fish it out from patchwork.

Thanks,
Andi
