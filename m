Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01C23D2B1;
	Tue, 23 Jun 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227455; cv=none; b=Db2uZaF7Bf7rXXtfXyl1KDabO/PosFcn29fiHpasgNDWgIOs0eYMg9B7uujzSmhcaNwUGtg5xiuzF3UMmm+H5CLI2QS6iFABldu21QCLb/0XOdVlSaIk+0q/Kmf6vjVpUztqNp9GpkWstn4kjHJnkEDAD+Zv1BWkAdvPDS7afdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227455; c=relaxed/simple;
	bh=mn3DlF/LXAHCxjv+gbLI3ceA6d4LDYRRiy2qQ+aQi+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKIJL/I61G6MpiBckquNR/yNUIwVhZCxO1v+dV9snXEYE0tShLXYAEnkExFxWGM2WzdKF1iPSfhroRTzdMEqTS3BaOb1ch5pgI7nxssyaaZNcOvS1Iq4213SFJ+Jz/WFRz1U0v28wPDtzJzkbbzMY9DsUuwDA8hyQTmOTxLFOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkbylmSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkbylmSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DCD1F00A3A;
	Tue, 23 Jun 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227454;
	bh=+XXHX9ulRrInrv2cZN+5ZOGw2UyhQQkLHAaUeyYPVW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BkbylmSsHIq6b0B50aHb0ytiNy6rOyM0dCXKoVqQDhSL5zzyuSrMQ0R1Os10ta34D
	 p+tRR0vOOaId9GfWDojuRZO4hubwWFI6ncEeBA84IK87vHmShMnSOYgfesDyDTIT+i
	 wAJHTP+MtNhnEO6MzoyIzdxmn04bnU+A6LSiapQNwTOoPyZq/XWnEXY7Cmc5VePRLd
	 DJA5xcRL8HT/kUKpyxSmqwBYWU1GgBHiMxWP8g04vw1mTw2Bnm8SnV+EUNQkQFRCtQ
	 +irNFZfk2Eieu5mAQQ0G7OmsNkok196jgFEIO3Ir7qfjItRt+/5a36BxVTci6jAUCs
	 uibbYvD/MjJ7g==
Date: Tue, 23 Jun 2026 17:10:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v1 1/1] i2c: nomadik: Use generic definitions for bus
 frequencies
Message-ID: <ajqh47hJVAvXIrZa@zenone.zhora.eu>
References: <20260618141730.3243303-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618141730.3243303-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Jun 18, 2026 at 04:17:30PM +0200, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I merged all this seriesin i2c/i2c.

Thanks,
Andi
