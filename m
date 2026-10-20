Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532065;
	b=TAR1NaEwEXS2fmH+j3vLkrFxrQaZbq63VvT/zbWeEGdO+2sY4/BKgNJH8r7NnsGv8FdG
	 dnvcmhIoQz+H97bmrgu0dmzM4PJ1kqbWVVX9a8y1jlcZm2TEbTaENw1/cGMGGUX4EnESm
	 DjVXR+Mn12Nk0zNuwvqE2HKcfONwR5ndwlViWcZFlyj6IeyTnTqQtl814dvJos5hX24QG
	 XjR5xgKDfp9NWWvIcVowu+NkJdWyA4/w6viYv0GNyvgrEjNISOoYVv10tnPrxidAH5/Ay
	 K2mzyroR2dQbWtyXqXF0fESVN20YXPpOWlUIcc1U0SLKHVch7KC2qRY1YyckRkG3VTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532065;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eXCSxIeNuj1XxueOjAqYwXIeEGw6teY+0ARfhV5OJIs=;
	b=VZBOda8F8Wee6Lvg3R/cdoNqSrY1Gwi2xUXT6hTRR6OAmW4wuYKqqMHLXjRU3noNwOO8
	 bRzFbxiYvd7r9rdcVqqY8wafSUzEGeqNXZWmp7gGPP9copuI88Ww/iiZ0bTUt0DfD6+Oe
	 0mWGx9bHKgDvWt8S+fikVdItMIzC553tIYE4eLba6TFA0xfDWNfZOdKkR1y6zkBDWY/yG
	 d0FxLXol9xf04353SWGTFm2Is1bUT2/WiImDkqd8V3ffoPFKpOvWAv+OW1MjWr68526kV
	 rqYXgGdRZ0yu9PkSu6bOGgLjaT+XaQ3Z5VxcEoLWtp+jKYt4VfWd4vI0/tWSDQS7KIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+sD58V3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F5606A319;
	Tue, 20 Oct 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+sD58V3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FBE1F000C9;
	Tue, 20 Oct 2026 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792532064;
	bh=eXCSxIeNuj1XxueOjAqYwXIeEGw6teY+0ARfhV5OJIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e+sD58V3KoOt+eZDA/exh6+pwnqQG3k3deiZ+eYpWuYJ/2zXSg2AT2/7izipm3jwP
	 ml0T2dc3P4an/VfBbj4eOUMjpQEuE8shvOrNhs5i27QCYsU1EIBCW0BxuB3H9q00F9
	 8Qwx2myaABAXgO/d5iKU68LbubosxiPYZW2kk5nZVLngYRZnR2QIwV6EtqFDw66+hi
	 DbuoBxSzaXFsQSHt6XcSVrIiat3lCVi+qx6AFC+vUAcWiC/KYBR9/N6d5qp34QThlN
	 2zZGXuMucUSajUxXHUhOG9+Bzk5BqR5AnpfpLGkX1PKroh5YYN6oKCv7bt53XLpMRE
	 9K/qjXQgSaDzg==
Date: Tue, 20 Oct 2026 23:34:21 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <atfcU1FBIk3wpt_G@zenone.zhora.eu>
References: <20261007191911.502428-1-navonjohnlukose@gmail.com>
 <atfW-paFf_iyBhRE@zenone.zhora.eu>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atfW-paFf_iyBhRE@zenone.zhora.eu>

Hi Navon,

> please, don't forget to Cc the linux-i2c mailing list.
> 
> On Thu, Oct 08, 2026 at 03:52:31AM +0530, Navon John Lukose wrote:
> > i2c_dw_xfer_msg() leaves DW_IC_RX_TL at the 0 that i2c_dw_configure_mode()
> > writes, so the controller raises RX_FULL once per received byte. Program
> > RX_TL from the reads already queued, capped at half the FIFO until the last
> > message is queued, so there is room for the rest.
> > 
> > On an Arrow Lake-H LPSS core with rx_fifo_depth 32, a 22-byte HID input
> > report costs 2.00 interrupts instead of 21.43, and a 452-byte descriptor
> > 0.14 interrupts per byte instead of 1.64. Polling the touchpad with
> > HIDIOCGINPUT at 142 Hz draws 1.58 W less platform power (psys, 32 paired
> > runs).
> > 
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Assisted-by: LLM
> > Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
> 
> pushed to i2c/i2c-2.

sorry, I replied to the wrong email. I meant to reply to this
patch[*] that for some reason I can't find in lore.

Andi

[*] https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git/commit/?id=bdd0514241466ab1e5acce9f1a1b1daf26bff5a2
