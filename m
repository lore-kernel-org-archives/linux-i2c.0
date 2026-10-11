Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9F1C2324;
	Sun, 11 Oct 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697182; cv=none; b=ZeUpp6ss/Rq7Og04yB65xRVfyuMjD18USSw3tnokA7GSGeSMAvyt+Nb3pTTtMLa0bo5VT2TeFc4DRquzqU5njm7dIO+zizfM0fsJkGHYq1QZ9niCAciegzu6hAb7a3n33nXzyivbre/RJCvgN9szhHdyweC5NRyugPK3TCaWfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697182; c=relaxed/simple;
	bh=36vHwUG3k3xUN+2RzJxHtp8ZAHm4sZbIFWGKecMdqhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka5aaYqFI3FG/MXHZZomlcodAgS9Bbd38/DmM8zKvDFI8T3juGlVYO+3J64HifBcGbd/JhX+i12Pj8tiz7qS2UAR4fP3Fs2Riu36xUmZvqqDOM/qTBPYuNrFDO1Mwndx+xsB9+9GnELGGHunkS9bNDI7MD4r53Kfi53GBWkK1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxxhEbN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxxhEbN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D321F0089B;
	Sun, 11 Oct 2026 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791697180;
	bh=ZKMQU6XEmcUy4ixkaBXMRiZ7Ldlzsu7npbQrSJzCOVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jxxhEbN/QmLgMyPsUKIC/vx7tUkxyOcxVYxwPshgqmhmRVa9O5WhO4whAhri/hFzQ
	 IbEfL1GqksGIztGPZb4+3wdpgASLN+Jp1mFQYuUf0swRM+zp2j2+eStJoJmc4ToJ7y
	 1kZI5DpPrbixylt7hYK05YHOAeinK1gjIZAh6Lq5amXcWfBstmg7OmLlJRiU4FOYpv
	 Zkm9OqIzJ2B9vSoLaUdAnPBkmW9DtHg6fWQsx3tENcnwT6gQQDmT2ICCwl05R/8Bpm
	 r4/OrS+0m13UHW8zUFRHebdMaJTWeKcjG/MgWaXZVQG9zUj0FU5nVFMpsJaj0bqcnq
	 OA9MCIQAfiWXg==
Date: Sun, 11 Oct 2026 07:39:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: a0282524688@gmail.com
Cc: lee@kernel.org, Ming Yu <tmyu0@nuvoton.com>, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v8 11/13] mfd: nct6694: Introduce regmap-based transport
 abstraction
Message-ID: <asshAYcQxlUVJoxU@zenone.zhora.eu>
References: <20261007092102.3768818-1-a0282524688@gmail.com>
 <20261007092102.3768818-12-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007092102.3768818-12-a0282524688@gmail.com>

Hi Ming,

On Wed, Oct 07, 2026 at 05:21:00PM +0800, a0282524688@gmail.com wrote:
> From: Ming Yu <a0282524688@gmail.com>
> 
> Sub-device drivers call into the USB transport directly, so a second
> transport cannot be added without touching all of them.
> 
> Wrap the transport behind a regmap bus. The command header is mapped
> onto a single 32-bit register by packing the host control byte, the
> module id and the 16-bit offset, so that the sub-device drivers can use
> the regmap bulk accessors. The access_lock is dropped as regmap already
> serialises the bus accesses.
> 
> Add nct6694_write_read_msg() for the commands that send a request and
> read the reply back in the same firmware message, and use it for the
> I2C deliver command.
> 
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Andi
