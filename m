Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307332;
	b=MC+cxRgQRYJ+KT9dK0D8etr8ntk5zyH+gMKMmM0kGQZUFHTadqeTnO3l5rhe8KvkXrUZ
	 oZc9Pu/cHzh537xw46FoOLv9nI2cyPtu1AHpbW89kjVJs9ALcdDKqlc8Mjq7MxWi6ztHb
	 0Tnkj4247+q0JneapocVsRvvOpcGdxMstB48iNEWFGDZTrYTAuEy/2wuJssbEsDlJCxyA
	 SDi8H6+u7dFp8fafYWXh/bUA8dSSZNDOJyB0k3tHPqQfhe20K6PA0euGRnLGPB5vMB7R1
	 Y6AzqLbL0GYySj7ZXyTXOuJbeFzgtzb7W54CJd5Jq/2zxtDGMoiT9yZHfimA9jU1E3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307332;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SqMVErT0RX3B9p3yGNJGtQhfVv+xf3ufJRjus6WWjU8=;
	b=kh5k5i84A/T9XR/QSBoepQZetzu6i79Rze3h31+Q+JtopdjtW0aBaVv2Jth0Retti8cd
	 6NMtKFuxsHKBYb3ZJmVFgs+o7GZuCOSvOrKQ+8ojnNlg0nLEtenG8E97aCNTfYK9MRIYB
	 tZPxtxhlKI6qSOpEgxy1Bwi6SDJzRzhzVjrZ86Muuqr+1Q/+hplRV52rS/uR0s3jSv8TZ
	 mfT+xy4cWQWTpFLqLmce/GH2Rc/GfodpFJN+80O1cCpSolDpgWF471bhvOM+cy+Y3yoHE
	 k1NwsN78nelAfVFlsArjm13DtA1cdYguaUr52MIEm0tVcLXRYFLowlwscHvXaJcCdqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML7va1sY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6A606A32E;
	Tue, 10 Nov 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ML7va1sY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06251F0089F;
	Tue, 10 Nov 2026 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307331;
	bh=SqMVErT0RX3B9p3yGNJGtQhfVv+xf3ufJRjus6WWjU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ML7va1sYZb31nR4ymQtKjfOAVeRNJ+rt92Pz23nfvoYb5vZampC7XjUWAGAA5PAFS
	 ux6URa8ArMSsZ20kVCKCp8XsSH12qza9fRuOfpLe+6qgpTEoXZNw8UdXkMZ/MnGvRc
	 O3eaL2PAlY/ZQ2R1zhqZAj9/2SocTH1leC+ljZUoCezqoiZpYvcXi1TXV4uaGNNEX8
	 fijAnlGG17ZLCz5VfM9x9xHTy+xkELzJRPOwS2IHo4IEJ0hAYtMzGGh1Rh/XlrCIgv
	 TVgqrd/qm3RWLn53a59ko4zn7DxNqu2om9ofJbNSEnwFzs335FAgN+K6VSVD/FQXVL
	 AgBHJnfliXlEQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQjIn-0000000AmcJ-0cLA;
	Tue, 10 Nov 2026 11:42:09 +0100
Date: Tue, 10 Nov 2026 11:42:09 +0100
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] swnode: fix device_add_of_node() kernel doc
Message-ID: <avL1AQr1XkFhEU1K@hovoldconsulting.com>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-4-johan@kernel.org>
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
In-Reply-To: <20261110085125.2535508-4-johan@kernel.org>

On Tue, Nov 10, 2026 at 09:51:19AM +0100, Johan Hovold wrote:
> Software nodes added to a device by device_add_software_node() are
> always secondary firmware nodes even if they may be stored in the
> dev->fwnode pointer.
> 
> Fix the kernel doc which incorrectly claims that a software node added
> using this interface "could become the primary node".

Subject was supposed to refer to device_add_software_node() (as noted by
Sashiko).

Johan
