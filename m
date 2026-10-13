Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437523E63AA;
	Tue, 13 Oct 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874965; cv=none; b=lGOv+GzNapUwOJkMsTqaeVv+Zuj5KFnesDk0G2WP6qN0DuLxOa4eJ5wwa9MgQbzdSVh6/w5tG2X9+dcHk/KLlOchCoXVroEJ54Heh1U/T8lJUq0xvwY6kRjSXmd0gB7VSDfyCNeCoBpVgFpNb49JkX1EHKuE0kWVTzAuiiCwyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874965; c=relaxed/simple;
	bh=5hIfBAw685lw1tMOzgMVigGeKsztlWESs12MQE+kgcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+boPZYJckqvhYwTvQa/HJJ0MODS15IXuS8o+JMWG3R5OsQXJbyNJ4STK6IB+yoslCSbUNQYm7kDEXRR530S0gM/y66U1FeUZ/qgAv/n8dB1/CoAoA9Eq0dTtvlCWu2Rqd4d9o7FyuMTMCKHbpk3QId15KrBrPtYTF80Ya54LqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OvXDGkbC; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OvXDGkbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791874955;
	bh=5hIfBAw685lw1tMOzgMVigGeKsztlWESs12MQE+kgcc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OvXDGkbCskt1ciKFaJVdv+dXRPRPNVLywhTHJrCyni30rT4N3cK8Z1eNZypIABjDK
	 ZyZkD4E4tMqfOb5IgLcnkSpJTRQQtpJdAxKLhy7XH9I9uPvnjNNegxLHUoWHSYAoLk
	 ycKjLL+t6wT9fiPNL4dIMz0utLWA7srCJ7DefJzOwFMUI2size5/JnKw+AQ2G/eSNh
	 mtkXDsbEseUxS4is/OXDJLpeHr1y6UlAmZRR4HmljcME3P2w3yma0+5RvnNe4fVSuj
	 nLAEquUsWo9EBiXafOfB1jJyBu4SWFLtPZyBMSWePKheRceTGx1eYt8cqCw5WvudHb
	 J3siW2+W84Kqg==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1F4146E74B;
	Tue, 13 Oct 2026 15:02:30 +0800 (AWST)
Message-ID: <20853c96b17ea29815ccc34fcc6556032df8291d.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] mctp i2c: add sysfs control for mux child
 netdevs
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Kenny Hsieh <kenny_hsieh@jabil.com>, netdev@vger.kernel.org, Matt
 Johnston	 <matt@codeconstruct.com.au>, Andi Shyti <andi.shyti@kernel.org>,
 Peter Rosin	 <peda@lysator.liu.se>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet	
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 15:02:30 +0800
In-Reply-To: <20261002073156.759005-1-kenny_hsieh@jabil.com>
References: <20261002073156.759005-1-kenny_hsieh@jabil.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kenny,

> An MCTP netdev is created for an I2C bus that carries an
> "mctp-controller" property in the devicetree. A bus instantiated at
> runtime through the I2C sysfs interface has no devicetree node on which
> to set that property, so it can never get a netdev.
>=20
> This matters for a mux topology that is only known at runtime. A BMC
> that ships one firmware image across several chassis cannot describe
> every chassis's mux tree in its devicetree. Userspace creates the muxes
> it finds over i2c sysfs instead, and the channels below them have no
> node of their own.
>=20
> Add a writable "mctp_controller" attribute on mux child adapters below
> a bus that has an mctp-i2c-controller device bound to it. A mux tree
> with no such device is untouched. Writing 1 creates the netdev for that
> bus, writing 0 removes it, and reading reports whether one exists.
> Userspace can then enable MCTP per channel once it has created the
> muxes.

More a request than a review: since you're going to the trouble of
allowing dynamic MCTP devices on mux subordinates, would it be possible
to also allow this for the root controllers as well?

The use-case I have is dynamic I2C devices - say USB-attached - that do
not have any facility for DT configuration. The proposed sysfs property
could allow runtime configuration for those too.

Cheers,


Jeremy
