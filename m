Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188808;
	b=FY023y8wUeGrDvUD//R6LulDjCvXY72+NyPGq2kYy6c+tEc2PKWRKjENEaZeCSr35+fc
	 JQ8M7CoTU0dmuyKwTmFDCd1iLJZdZaGJ7HkakAsRUvPFk2EL9ys36KpLKydpsQ/UiKzsu
	 XhERTAit5AmU0kLi1D4yU/xeFbkzDDN6QWBsdgSwUJhho5+4PP6Mrj6TanAodL5ofUfIv
	 mZtyuXVS23azGjzhF3j0pZcKpMIDLfZ5BS0g0sUThXEXE8RTbdFGj/gaAGGX26qAgY5OL
	 ZeBDfIGXaK+4omH+4ivZOpjlQB1aKgjp2zFlHKNczGe9Rr8IM/nCFWWkngoARnHrvKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188808;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3Mz6w7UeEL+7CGNi0VN6+DRD/NzemXmTCBXkDh4Qctc=;
	b=5Qk6nNSEqtSDBjUAxoW8/nllT160jAe/G1iHjy4Coj0PcdO1JvGEBRbIhx6Gx0NBMAE1
	 vBhu+Wfqr6MzKLpOpQV/6UUD4GdQV+Q4udysW8YHwQe8fmkdX63i91a4bNHnlTSF2h2he
	 tdVTdHoAhsfB4HIZdFPcilsT720OlAJwNg9oB7ZUgAoCR1vRTmO2cqOLE+Z9iOy6il9XV
	 f/Lgavu7E9Ubi96hPHGlDHMaq6pPNEUC10DdvZ3CGmdPfqflBtSawOBMgXqsXXdeRk2WM
	 jl/L3RQhRbXx0U5bV/p5COU7SfmAIgkKgBsIQlgUfeoSpNDSMCUHNWNjTEXTZ5wgVdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZHo8SXu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF148606A320;
	Fri, 20 Nov 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZHo8SXu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163B21F000CF;
	Fri, 20 Nov 2026 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188808;
	bh=3Mz6w7UeEL+7CGNi0VN6+DRD/NzemXmTCBXkDh4Qctc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZHo8SXuAGTP5QeLNm50UO1x70lqFU/S83DZrh1r7zKX7lQ0VsKlAZuhxJ5/E5sdY
	 rOovFk0GrYpls6/011L/LKbvSGn2+U0PlHnpEUYT8/p47xTbLAybxHSayb6qGg4xMJ
	 EApoBYHjR9gYbxY+o9wHymgFWFwOnuJn/72SVxRCgzLggIghTzkMxRGPBNy0cuqnV+
	 1LJFvT0wAQFIU6tW9KiQT1G0DqCMqNbixZqIOlLaL07Qea/Pl2ljW5g5lB0nqw2InL
	 RDU3zeHz9PWRZV+MpQ0hJxVYIpHbJ0iQGgpF+JrxUj/90W7mTM60AHYAROF/T+JU+3
	 LPAg5rdod2EdA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xUQc9-00000006S7K-0u9O;
	Fri, 20 Nov 2026 16:33:25 +0100
Date: Fri, 20 Nov 2026 16:33:25 +0100
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
Message-ID: <awBoRYvZEdI40B_R@hovoldconsulting.com>
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

I have applied these two for 7.4 now.

>   software node: fix device_add_software_node() kernel doc
>   software node: ignore primary nodes in device_remove_software_node()
>   driver core: platform: warn on bad fwnode assignment
>   driver core: platform: tests: fix swnode reuse test description
>   software node: fix software_node_notify() primary node comment
>   device property: fix fwnode_get_next_child_node() comments

Johan
