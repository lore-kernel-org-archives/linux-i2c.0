Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837917;
	b=uPIxg3JMoVErTG+mZHnP/503sgv7xnWXp0+uRLVlCv29kLatMP6c8aPcNy0p9vTN/xZJ
	 ulheHP4JEmcLIxDydVRnxYnQp6AKPA5F2hO6noBKWZXHSiC9PIjQLEm+IdhPRe4kwzNrU
	 izsLPONyTGybOmnnuDaRC+7qfY/0eu7makbIzBqqwOtmVLOKlMQVp5mJF+K+6AyUVyexh
	 xpsMyYcWLp/oSLr5SxdOmJLEKIcZwiP2WfayyUFfDEIeSxCrQ/YB22piC7pv2lWxpGS4C
	 EAAhZjUsB+HKw8J7exA2hYBLEkUySkXZCiB1a3V+ndqq8h/avTLW/PeDPMtaGH+VcEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837917;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Byvh61MN0MbiLvUlZBmzTzm7zuau0rQaTUqOwJ377E8=;
	b=rJ98qzzoTQu5kI/MYTE5crk/pelmoAx2yk6h+6hoeBoenDZHSZnQ6SDlls72CSTxeZ3n
	 O7t6HA20LaMj4nF+04VusYB80irV9nh9OUFZwupdamYKFBexEd2LddKJrdCSYyrSvvDiK
	 MoLCOwSI6lMLVLb5Qp0dEn6YCAksUv/hyCpSTvEWiByjK/3xbc+QuBcSmIxpymjIg4sIG
	 DUXIWzZvPR4x6lRL2B1pxbMRZUXlvFrSkNGawpEEgY0diWJp0zSzB0uSHB43TRwEXVSwX
	 VCnX+4Q8rFPFWz7oJOPEuHJhPR+EJp67SJAmcdnINPJCmChw9EJNn9BUxOGIkYJIA2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQfgaZyH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D821606A330;
	Mon, 16 Nov 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQfgaZyH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC141F000C4;
	Mon, 16 Nov 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837916;
	bh=Byvh61MN0MbiLvUlZBmzTzm7zuau0rQaTUqOwJ377E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQfgaZyHlEu1c7IL+votGEDox83/s1BWmI+iI09vqvBd15+aaOLhvqfUlSx+GW63K
	 yl+LYiBLFsuYhqteu8S/ZPaeuXO1kn+CM5ZIMbuwRkfXmGMV2se8yLiVpuPRzKQTf4
	 uIvf8CLT+Hc4fmMpxeWTbsHj0n438IS4Mb08mPvj6Ye3UC141mWBcYq490Bb4+tRO+
	 bzo6gsBF+Zl6fGiDqEtZOqP5cudS5/EcZk5icLbTvcGnq9nXr1rcbIjYpC1IpKWS6S
	 gN0WQy47Lz2yNvK3mFkWKP8n79zRysyfMIMkYr0RqURKmecpmbLPahcw6Rh/cYZqUN
	 bSfvkrzkutj8g==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xSxKc-00000003UZw-1GNK;
	Mon, 16 Nov 2026 15:05:14 +0100
Date: Mon, 16 Nov 2026 15:05:14 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] swnode: ignore primary nodes in
 device_remove_software_node()
Message-ID: <avsNmv-BQ_BkLMuP@hovoldconsulting.com>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-5-johan@kernel.org>
 <CAJZ5v0gjPPrHOy6iwWt_BubH+QvekgWQYrA+Y7GkvittHU10DA@mail.gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gjPPrHOy6iwWt_BubH+QvekgWQYrA+Y7GkvittHU10DA@mail.gmail.com>

On Fri, Nov 13, 2026 at 06:29:41PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 10, 2026 at 9:52 AM Johan Hovold <johan@kernel.org> wrote:

> > -static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> > +bool fwnode_is_primary(struct fwnode_handle *fwnode)
> >  {
> >         return fwnode && !IS_ERR(fwnode->secondary);
> >  }
> > +EXPORT_SYMBOL_GPL(fwnode_is_primary);
> 
> Not used in modules as Andy said, so need not be exported AFAICS.

Yes, I'll drop this and move the declaration to base.h as you suggested.

Johan
