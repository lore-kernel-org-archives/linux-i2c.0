Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314551;
	b=TJVb+xrbIFX4ZGD/Pw6MIt81mwxRuD1amfdJqqWSiSYHTunWk+e/6kBBTnHTi1uD0JBD
	 4F62AZEXKMmKN0fbumcpKMfnTB646/u9oI6OYquhjR8KvVqvT6Ql3RCx7p2VB6i1l6T/B
	 do1XpnTK585dASs+4EJzUf7HfSnjGyVZoSK6UwP+IMt6pKbWluOCMN/qFTwwzIXbNQtE6
	 o1UDSJ9s3bkCRshX5XQolE13qKPKlgsfDsMRTTyEb4DxpkNybk6oRFfyhizYVRzsWJnZ+
	 O4xJtv6zoKGUBs6bEzVrMbncLB+xixaY3CCGVHNMnxuO8P/4PJDr1YslFLNJkXUDRBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314551;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VvGa/vNgW0rJ7zFWoIOl85EbUBmvssYymFcRLlY1920=;
	b=GBYtJOCY8w1oGtwS2cRIWEV760K0fCMrqGPf2p5HddvtagANZgLhzTJWlf5SmCcxm95Z
	 bU8gCxC/TjqwfF6rD7HhJbY7s4kivcFewHNU2Z3iqbJnurGPeFr4x8yCi8tgie8yI8bFZ
	 ST7R7VNOVL3ROEEjNE7H4hK4V4SKpsUiHeayzF1x71h48n+dUyWnc1pd3iSdLUfzhsG1Y
	 wX+r4mHfQeuFGXohqaorEuDjSpEErdGB17ZfKOuXX9qgULUZTIosTj0Cu9e/gJM/xx5H0
	 VDDg3nNttP3JQVQbELuprFxZt98GJw14V4vWS5GUHyzQcKpWDPFrZhmbB1YY60e5LSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S55fLCHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841FA606A32E;
	Tue, 10 Nov 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S55fLCHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6874A1F0089F;
	Tue, 10 Nov 2026 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314551;
	bh=VvGa/vNgW0rJ7zFWoIOl85EbUBmvssYymFcRLlY1920=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S55fLCHLaYAuVJX3vKHpeG6EnPqhnsESYfgKNKbQ9+HXC9FKsEBneyhp3NVjvFZwQ
	 1wbcvihFn1iMwXozty+rTci29N93Fr+t54CbMzZKfLwELR38xGeoHrycf4r2NsT5gX
	 2x64WHx8fmD52UbzEaOI39Au08IiHI9MnnjxE76tTxTjLtRmq4hkeu1LqXtoqQOUI3
	 gGfslI4DcGYD2CEG4av40+ApARwkJ93bLid1z/t12iGlVQYR6sAFzDqK5Ye08qnmtn
	 Ck7x6cFKXyid7MJM3c8sXQ/13S4hRm7Mm7MX361tyHBDI+CAOanBy1e/4WLsNHVzyl
	 DPtJsRi64TZGw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQlBF-0000000Avoq-0WcT;
	Tue, 10 Nov 2026 13:42:29 +0100
Date: Tue, 10 Nov 2026 13:42:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c: dev: clean up registration
Message-ID: <avMRNeDGriRh6D1N@hovoldconsulting.com>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-4-johan@kernel.org>
 <avMFCwqx2X6pl4hP@shikoro>
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
In-Reply-To: <avMFCwqx2X6pl4hP@shikoro>

On Tue, Nov 10, 2026 at 12:50:35PM +0100, Wolfram Sang wrote:
> On Thu, Aug 27, 2026 at 12:20:43PM +0200, Johan Hovold wrote:
> > Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all setup
> > and teardown directly in i2cdev_attach_adapter() and
> > i2cdev_detach_adapter() for consistency and to make the logic clearer.
> > 
> > Note that the device list is only used at detach so the i2c-dev can be
> > added after registering the class device.
> 
> Can we have the last sentence as a comment in the code, too, please?

Sure.
 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Other than that, I think this patch is an improvement. The logic is more
> explicit. I didn't like 'put_i2c_dev' having a bool parameter, for
> example.
> 
> So, only patch 1 needs a bigger update, it seems. Rest is looking good
> to me.

I had rejected that Sashiko finding as being too outlandish for us to
have to worry about. As I just in a reply to Bartosz:

	If a malicious actor has physical access to the machine, we have
	bigger problems than worrying about them going out of their way
	to cause a USB hub worker thread to hang. :)

Limiting the critical section can possibly be done as a follow-up, but
it may not even be worth the effort doing that.

Johan
