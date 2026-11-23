Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422685;
	b=vzUZ42aua7bcoA0p9n4w69lKCAuy31Q/IPiC6CzKL1oqvI3DyU2rW2wudIA68tsfdcW+
	 2vpaJTFrs5g2kGFWD2dVuC/REymEJ72m500RefkC4W7B2gR1YYqM4CA+K82MLig1vt7xI
	 B5hXx3T5gmjr8QRNSDHdc26Gc2Q4rxq5Q5V6eus5U0aRZN0Z+oGOwC41+zS0JDBj/d3jj
	 dJqv9FlW4yvJQP1iZ1RP5uwdPwN+yg1O9FgVbA457MH3QhwtDMLYPown1HVWlozDsWSwu
	 Qe0r20T9Gp0V70vvL2WlzRz8FC5aRo9iO4eMkxfHzNn1QzOmpXgJUw47LWYTO3GJhlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422685;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=huZFMXPlEFAERYY4QoxHcKSDEDN3CIy/5c365Kws/FY=;
	b=t4NxsZyAPMq/DTEqgz+4shtlVUjsoeNQ5KyIasfGoCmm5e6xcyUcpaQ3W7KkXjnhAFFh
	 BSEBmubC6KyFXR6m+rLr1+KqQqEs1AO2KfjI/s22cMUVIvVGTZa3CTjwIafynZMH8wIUp
	 ljBKnbD4fxIwlaTGaJOaBbLvcCSp+uGsybNYYeXJBgzalBhRwyELDqCpGVn2ownm98TJB
	 IMq+r/5bIjUqL6PdC05/zRp54DXxypdeh8ERHxSRgazXkt47/55sq+KH55nhxLFb95i/V
	 pvNNtHCWjmxJfx3sFpOBRPIX/Q1f+RCZQAphAG7JhDVz4eglm+q3Bbfmnt5elFLsrNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMKkUOxD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A22606A330;
	Mon, 23 Nov 2026 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OMKkUOxD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97181F000C4;
	Mon, 23 Nov 2026 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422684;
	bh=huZFMXPlEFAERYY4QoxHcKSDEDN3CIy/5c365Kws/FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OMKkUOxD7Y5XB3+u8VLbDvgi8U7JMR+kKyCuaSmaHfKq5qoOT+vdjceWw9LsjgjNN
	 Xbr634gBhOrkwggxpzc394B4yECU9qLC33jsoMQwAOH4pbcojAeKUl32OCWSyvKO3U
	 SlthnkpBRHRXWBdiEG/DeGCDiITsB8ugk3V46pltXxMOkDKn0ipazTD0jdgvv7Krzn
	 uoFx8axdEYPNIBMMZl4B6bBCOtaRGJjLiH+v0Y9UqK4YmvczDwameo6D4LbQZBdcO3
	 Ybl19dC0yVTy/3R7ROGrHrHUTZ6IYD35n3FkgGjFAOQFCW3CcFWZ/B9z0LnjPQ6DpR
	 jH6nOivqj0lyA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xVPSL-00000007bVd-3SGf;
	Mon, 23 Nov 2026 09:31:21 +0100
Date: Mon, 23 Nov 2026 09:31:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] software node: ignore primary nodes in
 device_remove_software_node()
Message-ID: <awP52WO7xlzhOMf6@hovoldconsulting.com>
References: <20261117101336.980216-1-johan@kernel.org>
 <20261117101336.980216-5-johan@kernel.org>
 <avxeTnaEG_FnBhck@ashevche-desk.local>
 <av1xsrv8zNIEOtxg@hovoldconsulting.com>
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
In-Reply-To: <av1xsrv8zNIEOtxg@hovoldconsulting.com>

On Wed, Nov 18, 2026 at 10:36:50AM +0100, Johan Hovold wrote:
> On Tue, Nov 17, 2026 at 04:01:50PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 17, 2026 at 11:13:32AM +0100, Johan Hovold wrote:

> > >  void i2c_unregister_device(struct i2c_client *client)
> > >  {
> > >  	struct fwnode_handle *fwnode;
> > > -	bool fwnode_is_software_node;
> > >  
> > >  	if (IS_ERR_OR_NULL(client))
> > >  		return;
> > 
> > > -	fwnode_is_software_node = is_software_node(fwnode);
> > >  	device_remove_software_node(&client->dev);
> > >  	/*
> > > -	 * If the firmware node is a software node, its reference count
> > > -	 * was decremented by device_remove_software_node().
> > > +	 * Must be done after device_remove_software_node() which may have
> > > +	 * freed a secondary firmware node and cleared the fwnode pointer.
> > >  	 */
> > > -	if (!fwnode_is_software_node)
> > > -		fwnode_handle_put(fwnode);
> > > +	fwnode_handle_put(client->dev.fwnode);
> > 
> > We have fwnode getter, so better use it
> > 
> > 	fwnode_handle_put(dev_fwnode(&client->dev));
> 
> I used the fwnode pointer directly here on purpose since that is the
> pointer that gets cleared by device_remove_software_node() and which the
> comment refers to.
> 
> This hopefully also reduces the risk of anyone introducing a UAF by
> reusing the fwnode variable (or the compiler doing something silly since
> dev_fwnode() returns the dev->of_node->fwnode when CONFIG_OF is
> enabled).

I've convinced myself that the compiler can't mess this up so I'll
switch to dev_fwnode() in both places when applying.

Johan
