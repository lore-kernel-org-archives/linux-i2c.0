Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423393;
	b=dSBTUwZNIflcEv5vUPtCt0Z6ZGkC4PUYWI7hO68Yh+yLFGyC45oIvuqEiBgwUS0TNRPy
	 F09xwihIH3fP0XqzvNau9BSiOEj0uP7bOwO9N0t4cHq/s2sSWvNJRQEAbzh/UkDD0ZbCL
	 J/e76F7LvRwwFHXIkFhhDFWcjWGNpQ14fkvqNg3wOaGO0k0HmrbGUWd2yHFot1I8lW0uK
	 phBmQRjAG+BJMwAShXSa10kbmPXrHRO9KVoX2T2Mw6eQWXaz4NBcZDA0eTliyAvzTYEgO
	 L9ECHt/8voe24meTMVScIwnvIFgwk440uHdvN/U4hsHFJ82q/bpsTD3b2Td13+vr9Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423393;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rVUv/a91H2ubbfQJaXbwvWbI3OP4PfmSmlSUg7GAVY4=;
	b=NT4cdGUehDZcnmK0mjUfxpaC4Fz/BD1y/Pp87qs5SuN8aTlwynEXvSwng74mux7eRqge
	 QKLFyq8zL/8zgILf/35rcoHzJadhNp7hAREAPNexoS4YQFeET0BoYjmRJ+ZKLAsTA0ZHY
	 qPYqxGbo/wcoHqzAhaxDqNM3kYYTjyyLeYnkDkHFVSjPNgEYOXGztgMGcq5jdovsVJZEV
	 B+GK5fqcPgywdjtz6xAc3OUvkNBa/TgM/eDqjuAxdLWMJaYCkrS0G9242qdaLuOQCopUY
	 9QOG4ci3oV5A90IVF8kDT1qW1BtUWL3RC55sDpzfmBEVuE/DbAf0aeydA11IR727G4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LonkdIl1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CC606A68F;
	Mon, 23 Nov 2026 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LonkdIl1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6571F000EF;
	Mon, 23 Nov 2026 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423393;
	bh=rVUv/a91H2ubbfQJaXbwvWbI3OP4PfmSmlSUg7GAVY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LonkdIl1udPhFwOvRcmtz3GmzDwpG5Vh/cHIF9Mu+DzOkJW8ceOvua+c6cCyEw1Ct
	 zAM8RVmuSfmPb31Mo6iTZV23qmrZ6BXqVqSXPXY7q0HzMtkxg+OLTQXKrceNQCqb9n
	 MlcKP0tXbiKb3tgzhw8uNAwb6+TQzExVPZxk11zRPYsC1w8I1czjkDuSKU9bS3symE
	 G5PjyYXakRgwLSvqy9mwY3jxpdbz5EvUehpCBnzbomacjyA0aiiOgTPB8d8lzSwbaM
	 qP9yAk1gnVNLQoIsEzte+xIMqi3NRwvqRGHYdwzvDSgTHjgDBeHUvzDKGbhh1p0AIR
	 NhLuhB5lYVsDQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xVPdm-00000007bo5-1P66;
	Mon, 23 Nov 2026 09:43:10 +0100
Date: Mon, 23 Nov 2026 09:43:10 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] driver core: platform: fix swnode use-after-free
 on device release
Message-ID: <awP8nm3bs3dndsRW@hovoldconsulting.com>
References: <20261117101336.980216-1-johan@kernel.org>
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
In-Reply-To: <20261117101336.980216-1-johan@kernel.org>

On Tue, Nov 17, 2026 at 11:13:28AM +0100, Johan Hovold wrote:
> When fixing a use-after-free regression in 7.3, I noticed that the
> software node implementation is internally inconsistent.
> 
> Specifically, the firmware node pointer of a struct device may point to
> either a primary or secondary firmware node, but in several places
> kernel-doc and comments suggests that the firmware node pointer always
> points to a primary node (cf. [1][2]).
> 
> This series fixes the 7.3 regression along with a similar issue in i2c
> core due which are both stem from the fact that
> device_remove_software_node() happens to drop a reference to a primary
> software node that was never added by device_add_software_node().
> 
> The next two patches clarify that device_remove_software_node() should
> only be used to remove nodes added by device_add_software_node() and
> stops touching primary nodes.
> 
> The rest of the series addresses further inconsistencies.
> 
> The first two fixes could go into 7.4 and the rest (which depends on the
> fixes) into 7.5. And preferably with an ack from the i2c maintainer for
> patches 2/8 and 4/8.

> Johan Hovold (8):
>   driver core: platform: fix swnode use-after-free on device release
>   i2c: core: fix swnode use-after-free on client deregistration
>   software node: fix device_add_software_node() kernel doc
>   software node: ignore primary nodes in device_remove_software_node()
>   driver core: platform: warn on bad fwnode assignment
>   driver core: platform: tests: fix swnode reuse test description
>   software node: fix software_node_notify() primary node comment
>   device property: fix fwnode_get_next_child_node() comments

Since we're now at rc4 and the platform device UAF would mostly affect
module unload, the first two fixes can also wait for 7.5.

Series applied to driver-core-testing.

Johan
