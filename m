Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837333;
	b=CS6buQvCBWpWOa+fvwE3nWvZ0kI5LFjQAnUzYXn4HftiXBoOfQrolGmv0FD1TykKkIFn
	 C8k/VnBe1dM3hI37uqGYFYZPCw7ygtu46+bRhAHJKb91lImjfrnHghdigXwWvi/TOKz2A
	 zdEMZ1ckiDCDw7wSKLeVXnilSog1WnSJ0VqfoYECRKG16laZTmmc38iuwOcgLQ9VxHnNd
	 GbOxoKTNz4EUtoowUEH+SRSbsbOnKn6CQFyCJDx5kyaqhDQR0/7F7bJFuBC02PZg03ljN
	 gKu7FsLAUII/56GCiDqh/F/GFn1h+98A7/WgAzzZ6WLK22Y70W7GOU5RIR+9tkUetog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837333;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MZh4/pjUJrlLflOCFgWTJgTXrPaS+o+7/yqR1yLHp+I=;
	b=h2U7a4gY5ZRlFpVzUrgeXm825qBB4w7JpSdXnvmp8Sj4ORAegMydevB46uo3VNtBHTnU
	 6C6CYjhJp64c/dUZ6e9xrssUW0jODwwFyNQCY6bnkPTW6KGwMUsuXTbPMH2JsjEWVsC2r
	 vSFD9INCS6MeUUqpikgGti0brqI2TMY4wO304mvUw/qcYBsd4O+2R0OXK3w7x3WPSsClY
	 pn7Witi9LxcBtodqW5mLX4aeGmK1nxv+upHd1knaZFy0JvB2rgmxYedG0AtiIuOXgtDcp
	 TbSDgtCQy02dK0JRGQ66t6SPZD6jxXyi4DJOD3qX5eCAFo3cNXiaLqqDW2u/zNXvIBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8XLfhfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0D606A8B4;
	Mon, 16 Nov 2026 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8XLfhfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDA01F000C4;
	Mon, 16 Nov 2026 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837333;
	bh=MZh4/pjUJrlLflOCFgWTJgTXrPaS+o+7/yqR1yLHp+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L8XLfhfCXlngIYKLLzcM3uDI3QzUP1Q4if6EfjndViiGOQP/GqSDlHdioEFKqmXhS
	 t1Pup16RC+v1Ic8iiDNMRvSPyu3mNm5D898VdN6UKq7VeS//tSIfAq3bMXFHdTfR/Y
	 sCFb6Hhl3DywEsyKW1qRGwOsxhLzcWA5g3aOqEfMReh0ceeXDyO5ria/LYWdEhe3qT
	 MLFuoMhWwHF48V8NB0Amalx0dda4dckelmzPxL+Ort4zwJAWmWMifEItbkj58najIH
	 RRInuB7AiUcq2Tr76yL9QbEjkenKUf8HUtqDCeF+hLx2bvLN8+GMHQXdVNtL3dYGGR
	 TWGduksf2jGoQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xSxBC-00000003NoG-3fD5;
	Mon, 16 Nov 2026 14:55:30 +0100
Date: Mon, 16 Nov 2026 14:55:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] swnode: fix device_add_of_node() kernel doc
Message-ID: <avsLUsKE333kAMiA@hovoldconsulting.com>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-4-johan@kernel.org>
 <avL5Mz5BiDRHUkMt@ashevche-desk.local>
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
In-Reply-To: <avL5Mz5BiDRHUkMt@ashevche-desk.local>

On Tue, Nov 10, 2026 at 01:00:03PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 10, 2026 at 09:51:19AM +0100, Johan Hovold wrote:
> > Software nodes added to a device by device_add_software_node() are
> > always secondary firmware nodes even if they may be stored in the
> > dev->fwnode pointer.
> > 
> > Fix the kernel doc which incorrectly claims that a software node added
> > using this interface "could become the primary node".
> > 
> > Also clarify that device_remove_software_node() should only be used to
> > remove software nodes added by device_add_software_node().
> 
> ...
> 
> >   * @dev: The device the software node is meant for.
> >   * @node: The software node.
> >   *
> > - * This function will make @node the secondary firmware node pointer of @dev. If
> > - * @dev has no primary node, then @node will become the primary node. The
> > - * function will register @node automatically if it wasn't already registered.
> > + * Register @node if it was not already registered and make it the secondary
> > + * firmware node of @dev.
> 
> While at it, please add a missing Return section (as kernel-doc complains about).

None of the swnode kernel-doc comments have a Return section so that is
better done separately for the whole file.

> >   */
> >  int device_add_software_node(struct device *dev, const struct software_node *node)
> >  {

Johan
