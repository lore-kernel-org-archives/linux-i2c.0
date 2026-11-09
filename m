Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236510;
	b=AhkVd/5g5cPWyBUggpJdl0OTsAQkVs6hP2mYzUvVRTd5d1sqmSmmlONHgGu+xfp3rIFy
	 NEsKdmsMzGb54ZnBJa4KFA1+S27kFvdED+lhVNFMg/wTwYLZ0goFrTuYaAoGbmC+pv5FR
	 YJVmCcjftOBlN3MbQrk2BPjHxJqgXeEBQqtcPsKS7ML1qyWOPopLG54PUNQzuVshkbh0/
	 TYX/tu/PAl9NThlCbBqBGQG1+siGQTECG+lxN6mJreJhFKLTMqtwpa/0agzQIGlhtuyXt
	 C9nyx1vvVQvXnWX7Nv4AlzApE3Q63qw5BVWhS9pA6OdjjGdX6yRDts9AtnKH4UGv61g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236510;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zo3kYRJSlRGuTZ5CpeHbTUSBx6SE2tm3h5GWMGmC5c0=;
	b=g/D3XtH8galR4ZWTXPhIxt115spEtImsGSyg4U2NmexOlEchxBuWltF7VQ01W06oPBDn
	 Lc2b33gPYVxRSofUphtKVC6tqDsZQQEpmngIpk0hZRNDyQ0qkWuJov1+aFeHnSZf5A9H5
	 bdaXRKvwWrgNt5SVuaLUEd+uA88FxmxIRqhFr4QhTdwWAqk+pGc0n+l3b04iItgHdn+I/
	 2rDYmVF2hTvd8OqvGxHIXnw/ZevOmaAA6DLk/4KYjrnZTeTMDjyuZLfFziyiCFeFc/sDo
	 nEQ4J+0/Ch/jmZ+7pN+tY2e1XGv0vs9Xa8tpgXjp8V3jx/m4sQ77B3vLVTznYoLMXKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl9eIS1N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8A62B606A31C;
	Mon,  9 Nov 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl9eIS1N
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 36F421F008A1;
	Mon,  9 Nov 2026 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236510;
	bh=zo3kYRJSlRGuTZ5CpeHbTUSBx6SE2tm3h5GWMGmC5c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pl9eIS1NEm/UHxB1eCJiuO/AvkGu9qlAY5busb5Tfv1e6IODAOpmznZc/AGK9oxIb
	 wpdopI0cXb44DIGSH/eUX3kf/9OsAp9uvjFJJ96u6vo9dmjvWE17NfOpE2AGq3HvOG
	 5boCcF8CHt1efdfInyJdZqDBpkh5lb/yb2gyHkOoJD8WipHyvaKEn88YA4qgClH/Rw
	 3Ljykbdo7pgZKbZBmhFWhJNXxFyOUoCA5O/chhYjK9PiKZzQQuzYCDBzaURb+MmWbE
	 cRS+plnuoED0RmAZOnvNybuiuW23bJKunMGoOG2ml/yAlYaS5cJtMncwWsVF40PflJ
	 mWN3g3OBBe65w==
Date: Mon, 9 Nov 2026 16:01:46 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c: dev: clean up registration
Message-ID: <ethl2akoucm65ls6xrosrlbnds5jn3penfa4nhvngwajgfizt7@vbialge2ixse>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-4-johan@kernel.org>
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
In-Reply-To: <20260827102043.673273-4-johan@kernel.org>

On Thu, Aug 27, 2026 at 12:20:43PM +0200, Johan Hovold wrote:
> Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all setup
> and teardown directly in i2cdev_attach_adapter() and
> i2cdev_detach_adapter() for consistency and to make the logic clearer.
> 
> Note that the device list is only used at detach so the i2c-dev can be
> added after registering the class device.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
 
I'm not convinced this results in better or cleaner code but I'll let
Wolfram be the judge here.

FWIW:
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Bartosz
