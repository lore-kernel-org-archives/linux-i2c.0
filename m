Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BF2F25F5;
	Thu,  4 Jun 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616138; cv=none; b=BpFoGDjTuYM7Uto2VMwcBwhCy/Q57AUoH9fstPjGiNQFbLXs0XvE677rgSfLzu14jMx00KKYc4DDtOHKo/wvl3ckXzpa+5WSOePRXzv1CoGC2lGtwhoOTnPMVGmBZiRF510/TGkni1VspafAiWVQtEMDpKpZGSQ8PlkiOiL1CEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616138; c=relaxed/simple;
	bh=kcmbUUQt4BZt0uesSoVm+Pv3y6LHWcZIVRaA6cPYT0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW4quTnkxEwXxSQ++4iKp26+EC5kGM/iuiXCmW8XBQ5EwUa0vFOcJeniOlunCGFJi/1ktJwVTyVWOfBymhLZ8sfSZlp9GQQlXo2LiPzNMuqrytPX6VOZB0iekdrkEasEUvO1eiHjYc0g3wTlapTJbYe86HyS+xbytW0URwRQcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnPUUZvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnPUUZvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C41C1F00893;
	Thu,  4 Jun 2026 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616137;
	bh=GX9Dt9GjAP6eNPPMRBtrg8dIeU9S0cqBZSKz7Ku6Obg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YnPUUZvsjHSg4oE4fEQvMBqaBgCQHUVdO4S3P6oUxp3mFnyJrQLsAbFjeB13RxR4/
	 8pixl+SZZi/rEZXYIDuZwdAe7aAATCkqrVuWosYLM/uet37SYc4XVKtsPc45B5u+nZ
	 xIDVBsWqUOUrfGBUva4MCBcgYnMGmVij+QlG0MmzZT/2xH0b1bAMhVX7igYUYyc/Ep
	 CF1pTpaT3jrh5tE0jDNQY/iuGCI/v4JRsJaXJMqkV4HS/2nh+s5OryZv4bPj8QimIN
	 5BoPfBLU2xoMUKnrFyVAe3+CzkOHmwoZw9Eu3Iwtv1q5/dEoPl0xo3KE2hVdiVq9gR
	 qkkfxJ6nS4stw==
Date: Fri, 5 Jun 2026 01:35:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Rosin <peda@axentia.se>, Michael Hennerich <michael.hennerich@analog.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: Use named initializers for arrays of
 i2c_device_data
Message-ID: <aiILpzN5Zu-ckZVJ@zenone.zhora.eu>
References: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>

Hi Uwe,

On Mon, May 18, 2026 at 06:45:09PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> While touching all these arrays, unify usage of whitespace in the list
> terminator.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> Forwarded: id:20260518134035.644762-2-u.kleine-koenig@baylibre.com

merged in i2c/i2c-host.

Thanks,
Andi
