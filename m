Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994613;
	b=Hkw2SITJ13wEWprBDAuGMZVW4Fue+SFi3BiNuskHsaIvRBQ3XiDtmtzmFeWYP/MzaXrY
	 U22I6hVRaL+gaAHjoxdqU2SGKPRvQth0dXAFWB70cWTk4Zz3jhhxZhZ1GL4d3WoYuA/q6
	 DWvhFhLSPTPl0KGD2oG/JdDSL8IIgjDwLbKbJODssCob3QRjc8WXmVBOVcTcxtWzhMYHm
	 f5EZAQldIQEo55znY1As+6kC4RujDeBlpml8HJutF3sxLijKWmdfvyymdrTMBzVp6poTm
	 ii2s3mt9P2nn1hpRPJhC/A4MHoAivmUo+CoFqtWy6gETLPeiF2Aw2xPrU64p3SocO4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994613;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kbRmNI2E1W6sUc3AbI7TqK+tU8lljpg50Qb3VML0+KY=;
	b=oj4jwaEdJP6LeErc1u15GMWehrSMarPwuseZe++LTqvVbB6w323k88All1gm7zoSY2rE
	 xitGkAZeCgDLV6bk2OZCyOcrM7b/rkaDipFgjpPiRSeEop6Ir4cfo7Wf8na6s+DbCtO32
	 R55B8vsXfzdVdQVz/pNqXb4l02hYAZmZYU1Qpapn54yq7S2YE/rbfQd8WtSCpTnnHklhb
	 p9Eaa5NSLPl0qTlT5qJbRUs54hPADHYb/8SHTdxGVrvhVym621jPcyxbravbkdPQmsX3p
	 3IlxrKgFuwFGbvjcGaoY/G+PaicspkSnu+ArtzW9s/JSGQ+ChRRAvK4vo174ArDqCjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7exoyp5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3651606A31C;
	Wed, 18 Nov 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7exoyp5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F441F000C4;
	Wed, 18 Nov 2026 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994613;
	bh=kbRmNI2E1W6sUc3AbI7TqK+tU8lljpg50Qb3VML0+KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B7exoyp5tC6yZqy2topR/b99Vx/7SenWATSGXKY5QUcmlaP/9F8zaKPwSmoR56VPN
	 l2bVW4/X6ZdIZSAGS060gb+0A4GhDFzlGfV8HW9pS5CrPi6KrQqHI/WcWpIIO77Pnw
	 4LqAibbSttkK6+jx3M24lqoTt/fi4C+dnLDDYW6BqGG7Y+T4M69kyR6/eFsCffyNoK
	 zTLKCKEOkPu+E9kVbXb5HqTEXzyfRREWpXIe61Gp089n7v9ReTKIWTlpYXGpKBP647
	 TQDDNvlXQpopXHrGbWCrMiyZF16OdfTsJ7I8WCu/ISZy2ffCfkkO77CsJtGWx1T42I
	 /+SHtfCkUT2kA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTc5y-00000004XAs-20zL;
	Wed, 18 Nov 2026 10:36:50 +0100
Date: Wed, 18 Nov 2026 10:36:50 +0100
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
Message-ID: <av1xsrv8zNIEOtxg@hovoldconsulting.com>
References: <20261117101336.980216-1-johan@kernel.org>
 <20261117101336.980216-5-johan@kernel.org>
 <avxeTnaEG_FnBhck@ashevche-desk.local>
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
In-Reply-To: <avxeTnaEG_FnBhck@ashevche-desk.local>

On Tue, Nov 17, 2026 at 04:01:50PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2026 at 11:13:32AM +0100, Johan Hovold wrote:
> > device_remove_software_node() should only be used to remove secondary
> > firmware nodes added by device_add_software_node() but will currently
> > drop a reference also if a device has a primary software node.
> > 
> > Bail out early if device_remove_software_node() is called for a device
> > whose primary firmware node is a software node and fix up the two
> > callers that currently work around this themselves.
> 
> ...
> 
> > +++ b/drivers/i2c/i2c-core-base.c
> 
> >  void i2c_unregister_device(struct i2c_client *client)
> >  {
> >  	struct fwnode_handle *fwnode;
> > -	bool fwnode_is_software_node;
> >  
> >  	if (IS_ERR_OR_NULL(client))
> >  		return;
> 
> > -	fwnode_is_software_node = is_software_node(fwnode);
> >  	device_remove_software_node(&client->dev);
> >  	/*
> > -	 * If the firmware node is a software node, its reference count
> > -	 * was decremented by device_remove_software_node().
> > +	 * Must be done after device_remove_software_node() which may have
> > +	 * freed a secondary firmware node and cleared the fwnode pointer.
> >  	 */
> > -	if (!fwnode_is_software_node)
> > -		fwnode_handle_put(fwnode);
> > +	fwnode_handle_put(client->dev.fwnode);
> 
> We have fwnode getter, so better use it
> 
> 	fwnode_handle_put(dev_fwnode(&client->dev));

I used the fwnode pointer directly here on purpose since that is the
pointer that gets cleared by device_remove_software_node() and which the
comment refers to.

This hopefully also reduces the risk of anyone introducing a UAF by
reusing the fwnode variable (or the compiler doing something silly since
dev_fwnode() returns the dev->of_node->fwnode when CONFIG_OF is
enabled).

Johan
