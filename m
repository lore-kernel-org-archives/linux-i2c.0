Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333A340A43;
	Thu, 22 Jan 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088694; cv=none; b=XsL6k0LFhYv5VXKrG8N2MluTV5V2MQ7/ugZSHawKtE1Kb39I5ErtcJvBcRlCfgsqsqudurHuK3OUUSWnHT5Oqv7xF22iPUxeuc8RiJmeSICFrrRreLxmxfTBGZiFuUubD0dys6K6w58e1v1R1wFCP/faFX6rR44vWIBr7oXSY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088694; c=relaxed/simple;
	bh=pnAE7GDMlby7Gm1AzAGF0cUKw5rcSVbPX5j2p/Y76M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn2IDOO0/76PfuvfGNVz8Xa1UIRlhykoK/0Kipj3hXpGTpAbbzzXFhtr8E3Tv6HNv5HEf/bVV4Vir6YFoTM3Xmp8km3xeWOiMrizweUZmLZ6zeHk6Tm8tJPZASTbN+qI3GKf9lZOL7ui0DF0MC0tFm5H0zcRP9Jd2QsFri3MVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSulR5X4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSulR5X4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C00C19423;
	Thu, 22 Jan 2026 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088693;
	bh=pnAE7GDMlby7Gm1AzAGF0cUKw5rcSVbPX5j2p/Y76M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSulR5X4aK+H6l8HlpQzr15r3yGo/pInTjx9Edi8zTNSbzC/aE/C/f4DS/C6VD8sz
	 7C4YoXXc3Lr2ROrGJEwhpka8p3WVvd2INHJX7K+SR1GvDue0o185p7+6h/5M7m6mRt
	 rmbYfNWFalq2bLoC7po7nH6OolhI3dHmP3NhZ52NlMZagVWeNvQlt2F9uKiTQAN7l+
	 6B60kgZQjN2LdiN7MH5XCnKURqXZiBiKjQKx7junm8tJ98vZ1T40XyaDkZFqfPi/v4
	 secxUdwyRYhivJ+NYgDSdg7RoMNaHD49o1OGlsj9AINjX0Tq/MCdL0v9oD+Rp8KWrp
	 Y2BMQvvqI+h+A==
Date: Thu, 22 Jan 2026 14:31:30 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 3/6] i2c: designware: Add dedicated algorithm for AMD
 NAVI
Message-ID: <aXImglYjurMu-_7G@zenone.zhora.eu>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-3-0e34d6d9455c@bootlin.com>
 <aW9NYkADDRju1cgJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aW9NYkADDRju1cgJ@smile.fi.intel.com>

Hi Benoit,

On Tue, Jan 20, 2026 at 11:39:46AM +0200, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 10:28:03AM +0100, Benoît Monin wrote:
> > Apart from runtime PM, there is nothing in common between i2c_dw_xfer()
> > and amd_i2c_dw_xfer_quirk(), so give AMD NAVI controller its own algorithm
> > instead of calling the quirk from i2c_dw_xfer().
> > 
> > Add runtime PM handling to amd_i2c_dw_xfer_quirk() and a dedicated
> > i2c_algorithm for AMD NAVI controllers. The adapter algorithm is set
> > during probe based on the device model.
> > 
> > This way we avoid checking for the device model at the start of every
> > transfer.
> 
> ...
> 
> > +	ACQUIRE(pm_runtime_active_auto_try, pm)(dev->dev);
> > +	if (ACQUIRE_ERR(pm_runtime_active_auto_try, &pm))
> > +		return -ENXIO;
> 
> There are PM_ACQUIRE_*() macros available now.

I already applied this patch. You could eventually send a new one
using the PM_ACQUIRE_*() as suggested by Andy.

Thanks,
Andi
