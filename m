Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92E1397;
	Sat, 27 Dec 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766863588; cv=none; b=dTepqiUPfW+BkPl2TTplXfsKUqVHUgOvPdrcgV92MMaeNYkdTsJ/iazB2OG+2c1jhxh2eQkPSFVewCRC6g1cDUocNABBo4nPY6rejdmBKf9LQZVCkyrPPEigWqKaewxYf8H0OWGzVsoUGjCsFIG4dz4SfZgACHX8Dya+q77Ox5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766863588; c=relaxed/simple;
	bh=g6XM4F8uz0727eTzV4+CObVOUm/jIwZfW3Pg+ZtYyqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N730m/YdRbgq0KwjwiQKV/w1CKou61V/0Q6oktJ+xO7cNPfr8E5qfUh5vNFqb0yVsF1443i6A2HcVCwkY8LQwcioCrPsThQ/Om/JVc01wtwU/BLCmTVf5S1bff3hNKto3lYfEUAmrNpYnEwx3etgLi56AeSKClYMUN3dpK7uiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlOUttL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlOUttL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A4BC4CEF1;
	Sat, 27 Dec 2025 19:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766863587;
	bh=g6XM4F8uz0727eTzV4+CObVOUm/jIwZfW3Pg+ZtYyqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlOUttL+vXbzz9KSbTnp6sMpeWUu4zX1iCBTZ5zfLx/SuhKrgfxW3fQg9qzMX4A5q
	 U8PNbnNtxJr3AfJ3S2j0G7Ux3naYZMFitjcriQdkVamRTzpsBum2s7d4es1aXno1q7
	 OcpI/MWNclC8ExQ3QRQWhWtZJxFJ7mTfnCMXc9IHv4Uq36atnXXDc89lztcMGByIHR
	 XbtMBELD6KiwpKHZcWfz1VZCaoFDbn+o9TpMB2NB8o7soDB9D6NpiI5op8PgDKUApS
	 oDhwCTjbLJTLi1RlQ/F60v+KvMlEzdLJDX/+/V597F5E3Z0/0XI86GtAq7Gt6kQsXQ
	 OX1NcdFeUUOtw==
Date: Sat, 27 Dec 2025 20:26:14 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Encrow Thorne <jyc0019@gmail.com>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Troy Mitchell <troymitchell988@gmail.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] i2c: k1: add reset support
Message-ID: <zjrd3dgvcg3pxmn4455iljtugbufr4igyokdycusyhpykbzyl5@nrwgz366wm67>
References: <20251219-i2c-reset-v2-0-ad201a602e74@gmail.com>
 <20251219-i2c-reset-v2-2-ad201a602e74@gmail.com>
 <2dmrli7yzznpurg74wet4oidhljjf3csdjly2dwpyvyndhrec3@uc6ke7mep6fv>
 <CAH1PCMbGbe6MQtAucf-4W+H_G0LrvPNGyaB_OUyxqf5TF=jixg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMbGbe6MQtAucf-4W+H_G0LrvPNGyaB_OUyxqf5TF=jixg@mail.gmail.com>

Hi Guodong,

On Fri, Dec 26, 2025 at 07:38:22AM +0800, Guodong Xu wrote:
> On Fri, Dec 26, 2025 at 5:01 AM Andi Shyti <andi.shyti@kernel.org> wrote:
> > > +     rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> > > +     if (IS_ERR(rst))
> > > +             return dev_err_probe(dev, PTR_ERR(rst),
> > > +                                  "failed to acquire deasserted reset\n");
> >
> > If this is optional, why are we returning with error?
> >
> 
> According to include/linux/reset.h, if the requested reset is not
> specified in the device tree, this function returns NULL instead of
> an error. Therefore, IS_ERR(rst) will only be true for actual
> errors (e.g probe deferral).

And this is quite obvious, but you haven't answered my qestion.

Why do we care of internal failures in reset? If reset fails on
an optional reset control function why should we kill our driver?
Just ignore the error and move forward as we have done until now.

If the kernel is suffering from internal failures (say ENOMEM),
it will fail anyway or, with some luck, recover.

Andi
