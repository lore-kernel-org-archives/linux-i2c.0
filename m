Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307674;
	b=Mms9nhuyyz+yog4L9eLj4BCljzQtWzlYp/BQIO9dBf5Nk5Ofk9WxBSYFAJ2inZJ2ixLc
	 Ba+1ScTMDiJO9oWIxjdt/uhvEuMNyJd3MTMG9Ia39iqoy3aJREESNgvQQF+2GQqCmqIv/
	 B+Zo85/mpW8v40aqGN25Zz8WLrssOHxaSVKZXQkumBjlJFgJ2aTcMgzYnORhSdZQIv/2d
	 cSx26YWhs05JyjLYZYHhwn/DMGrBZFlBl2CIjIJAUwoq0UWQE3qS9QqVI0QBbyDxJaN94
	 uINr7Au8fLJgCK9m28D1HQgu8buGA5LHj00UGPV/dehZIp7s5WYrJVDZZ0GGmkmN8RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307674;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZWIVM6tG5A2WF1SayFxe4exG8xdz+gKhA6LhjdeSoRs=;
	b=U898BVd8K+bh8xRXs3ujq3nJZA77WmTMesN4XYSubeDGFzdblZ5LrGT411WxPTw9wXlR
	 DhtkuqlIL+bsJ1/BO0dMqrSNduUA4DyhGDIoIppdPmKXWkbo4SHEiFpq8kZ0swDE42Zm2
	 6VEhgTbBgin1fJgK4EB45TJNp7zXYbPyUaXOl/+D46fHo0rT47bRkKRDtcFgi0C0ZEHDx
	 vlwA1RzeoJCgP0yTbe7jz8Iuky6oDvgh4OLXlu5z9rnHIcJMHst4s9cwl2gxUFiTRMq7g
	 84T9YlSVXxoQ8zVv66A+eWlW47nsUbPGU3IN8YMB+U7X+6VuAJ8DKoLQojzoWpqQkJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoA6wm8G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A7606A333;
	Tue, 10 Nov 2026 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoA6wm8G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFA51F0089F;
	Tue, 10 Nov 2026 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307673;
	bh=ZWIVM6tG5A2WF1SayFxe4exG8xdz+gKhA6LhjdeSoRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LoA6wm8GUyWUL3HEjZWsX3/jKbn25d+HXkJZVESkJ0+AIHov+TIc12Rw4I3CwtfFi
	 cWXpC5xrjAP8JjV5HfehbYSXFkoIlnyzwzQgcMkGP/72BOHlJyXspzTzZJz1INEmVg
	 1MjtvDfDFrPDdLRw9WXDVx+CrjRLGeYV0X1Z00+k43MC/7dSns7J9NKa3l8e+tghi6
	 6++3BXO05Ja/hP3nDFDOaqP1HOkapUuv2pp4myjbNaAuZLafpAtX/SHlUzyA6XN92O
	 kBtp/f20AJOuJhn3QidohgrcKcRCUcaNSZJTfCustsoPVJVuRaDtymTP3KAxSBD1rQ
	 JjmHWlQKpt2fQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQjOJ-0000000AmhB-0u4b;
	Tue, 10 Nov 2026 11:47:51 +0100
Date: Tue, 10 Nov 2026 11:47:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/8] driver core: platform: warn on bad fwnode
 assignment
Message-ID: <avL2Vxi7PADCNio2@hovoldconsulting.com>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-6-johan@kernel.org>
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
In-Reply-To: <20261110085125.2535508-6-johan@kernel.org>

On Tue, Nov 10, 2026 at 09:51:21AM +0100, Johan Hovold wrote:
> Commit e6054f410c97 ("driver core: platform: amend the API contract for
> fwnode setters") added a warning to platform_device_set_fwnode() in case
> the current firmware node pointer points to a software node as that may
> prevent software_node_notify_remove() from being called.
> 
> This is only an issue if the platform device has been registered however
> as software_node_notify() is only called for registered devices. A
> bigger issue is that a secondary firmware node assigned before the call
> may be silently lost (and leaked in case of software nodes) as these
> helpers do not use set_primary_fwnode().
> 
> Replace the current software node check with a warning in case the
> device already has a primary or secondary firmware node assigned to
> catch any (hard-to-debug) issues due to a secondary node being assigned
> before the call.
> 
> Note that this also avoids making claims about the device firmware node
> pointing to the primary firmware node, which is not the case when the
> device only has a secondary node.
> 
> Fixes: e6054f410c97 ("driver core: platform: amend the API contract for fwnode setters")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/platform.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

>  void platform_device_set_fwnode(struct platform_device *pdev,
>  				struct fwnode_handle *fwnode)
>  {
>  	/*
> -	 * If we call this function for a platform device whose primary
> -	 * firmware node is a software node, we'll never end up calling the
> -	 * symmetric software_node_notify_remove(). There are no users for this
> -	 * right now in the tree so just disallow it.
> +	 * A secondary firmware node may be lost as set_primary_fwnode() is
> +	 * not used here, warn for now if a node has already been set.
>  	 */
> -	WARN_ON(is_software_node(dev_fwnode(&pdev->dev)));
> +	WARN_ON(dev_fwnode(&pdev->dev));

Sashiko points out that this may trigger a warning on probe deferral in
an ASoC driver due to a new user of platform_device_set_of_node()
currently in linux-next.

Will revisit.

Johan
