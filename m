Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315262;
	b=gEkIZJoY88ctouSS3SBInwJoQJ4bjM3vWxhw2zzk3O2yE+iSedwT41Lnk14EdpNngUl8
	 kj4ewMGkkFzwnw505IVJ6D+Xc/l9KKxq2vxJowrVIRHUT0UdyUFGXXqc4lxOiVMXlhq/o
	 G7ZkWdzjMCyeYLGriPO6GCBHv4EFb424QepFDqZZK2bIpVSdz81O2Jt/9vz2Ra5cq/Ll6
	 DsgBrJIEZxWkkazLjRSlQE8ceVMep0XsCr0MX07Eof/NtIyPlrE/xTK16N6I4zQpswKpM
	 Snj/ne+07COASSNKSU5mqIZe6d+oQBSQQw7ypMoNZzhUPiC2z3bZQu0M1o+mv/1wz3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315262;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gdlRbU9d0gBhiGaPO0uJWjSekUNlXVanvnqdG+KJHPE=;
	b=cP62fd4eUHi7hWMrM+rzyO2e+WiO0yU4lZAGIfJ11Yq/D6oMrcR4IncNguRNsDNoDRMi
	 v6yG1rQ+o/cX4JYmVMI1PKPqfSBnkoFtAUtPD3M04ZHsPohWIZWEo2Xd1BaEVqlvgkRGZ
	 /qMtFJdtUewUC7tZ71aBMPoXAkeW46oF1dYYhLbLQ+KtdXcmYKLvCZ1mTH7ywlfX78T6N
	 qgjhI9BQdFyUpM/XbzeBy+k4/rmDKj1aQ0rsxs0mgO7iBRgF7VA4Z5xzGSUsD1LmZ5YOu
	 GcHzaajphwkAeZ2MPjt/XcBmwMzcFs1ww3PgeP0uy5bTvtIbP39298V7Yyxup0UTYiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TZX/eUlM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A0BC2606A31C;
	Tue, 10 Nov 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZX/eUlM
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9FFEC1F0089F;
	Tue, 10 Nov 2026 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315262;
	bh=gdlRbU9d0gBhiGaPO0uJWjSekUNlXVanvnqdG+KJHPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TZX/eUlMQVPPIPpqHTUo9QJ/c84i0Ys8WcRBHmoQi+xK8mR599Q6+nA/i3Jatif0D
	 RO+7oKm6Hzck+nsFFpZv+CLjJerqkusOI9oFVRsUy16BXAAHwwEOL6y4j+ie9jlSnu
	 xLnZcwlEOkunl2Is/DVrObht5qhVvinKTrdY/wBLntinbM3SGaulD1i3UuYGtNM0+y
	 uvqi1fvGv90oZix4b7wdVANlK1/DbrHOFf+Ad8v45+SSYLFOIWGPIbBchiTfPDLNeA
	 K/4Fp5707ghJzjWna4cDY+00zViyscjggxk9rtZRfQikzXfLGa26G8+rGnTo0lH4Cl
	 5moo5ZkLjLJnw==
Date: Tue, 10 Nov 2026 13:54:18 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c: dev: clean up registration
Message-ID: <r7a57zw5h253lhdecxdoagdcok4lobodiouutxxq3t237imdhy@n4t46uvgvf22>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-4-johan@kernel.org>
 <avMFCwqx2X6pl4hP@shikoro>
 <avMRNeDGriRh6D1N@hovoldconsulting.com>
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
In-Reply-To: <avMRNeDGriRh6D1N@hovoldconsulting.com>

On Tue, Nov 10, 2026 at 01:42:29PM +0100, Johan Hovold wrote:
> On Tue, Nov 10, 2026 at 12:50:35PM +0100, Wolfram Sang wrote:
> > On Thu, Aug 27, 2026 at 12:20:43PM +0200, Johan Hovold wrote:
> > > Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all setup
> > > and teardown directly in i2cdev_attach_adapter() and
> > > i2cdev_detach_adapter() for consistency and to make the logic clearer.
> > > 
> > > Note that the device list is only used at detach so the i2c-dev can be
> > > added after registering the class device.
> > 
> > Can we have the last sentence as a comment in the code, too, please?
> 
> Sure.
>  
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > 
> > Other than that, I think this patch is an improvement. The logic is more
> > explicit. I didn't like 'put_i2c_dev' having a bool parameter, for
> > example.
> > 
> > So, only patch 1 needs a bigger update, it seems. Rest is looking good
> > to me.
> 
> I had rejected that Sashiko finding as being too outlandish for us to
> have to worry about. As I just in a reply to Bartosz:
> 
> 	If a malicious actor has physical access to the machine, we have
> 	bigger problems than worrying about them going out of their way
> 	to cause a USB hub worker thread to hang. :)
> 
> Limiting the critical section can possibly be done as a follow-up, but
> it may not even be worth the effort doing that.
>

Why is limiting the scope of the semaphore such a big deal though? It's
not a big change, literally just use scoped_guard() instead. Why would
we commit incorrect code if we can correct it in a v3 with not much
effort? You're fixing a use-case where user-space can hang a kernel
thread, why not do it for corner-cases too?

Bart
