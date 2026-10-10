Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7573C09F7;
	Sat, 10 Oct 2026 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626242; cv=none; b=A577EeoBuEXG88GpX8UnDrvD1xHy0lePjYf7uNFyG/hVmBRpP3Jiib2cRrkIUebpO2ltX9abqDtkpnscYMRc4AkREtmmGopRccUp/g1f3ICbB8kp5PECSd/w/xJmtuqU42xbjXTuWt0qRDnkN4xmntG03gdDPCTwCKxEJrS4BIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626242; c=relaxed/simple;
	bh=SXVYINtkvHcGhb3vqFd+r8uDe5ceSn6GLfycaV8wTP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV2x/5GGMl0E95jpO7qghDJGFsi9MdYSE6ruCPpD+uGcY5zO74uevmn5yBehiegM4fjkm8Qa9Z1oxCHuoFgBsZjmjw0Dg3sMujxmulO3CEB6YAVTW/On2bDyZRcytXyIIC1LevVnbr/Thuzpk7lY4gfFSUicrDn0x9KGVZcohg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HveIqGCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HveIqGCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019CF1F000FF;
	Sat, 10 Oct 2026 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626240;
	bh=yvebjpyu9ax24FS+7bm/ztnPPj14eDGozuki2cnVMi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HveIqGCop93WTiJ6RCW3ATU/7YhmgxCw6V9brDZB7l81GNiWEwy1f+YFIjv8wV97w
	 XCcuUuPcwAz6AtKE8Q6MYy3eA+5/H9JUi3vAdztaMmoyBVz8YdmgqHqlYobxwlMUKV
	 rpKR2VHV01qRmBGAtIOwNXqOaiRlgtG626xuHOctS47Q0vrY6xSKn0DqKO8W65EN3T
	 1QoCmnxz1tlg5ySsS4H4WEP4NQvyJcC681EefIYeJuziSmRR38aquljRhnZNhSgkQQ
	 SLXhErmtzfvw726i63Xg8sbxJhcsyAwSVPvCWrbdJxvnJvLpfhlbhnPHAq6bMhNSmW
	 tl0tFh9cfF8zQ==
Date: Sat, 10 Oct 2026 11:57:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Johan Hovold <johan@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: core: document preference for
 i2c_get_adapter_by_fwnode()
Message-ID: <asoLqKvJsHhkEgqi@zenone.zhora.eu>
References: <20260716133029.1565853-1-johan@kernel.org>
 <am5dvgXS09CA3ohj@shikoro>
 <asjvTCazRMSNMojQ@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asjvTCazRMSNMojQ@shikoro>

Hi Johan and Wolfram,

On Fri, Oct 09, 2026 at 03:42:36PM +0200, Wolfram Sang wrote:
> On Sat, Aug 01, 2026 at 10:57:34PM +0200, Wolfram Sang wrote:
> > On Thu, Jul 16, 2026 at 03:30:29PM +0200, Johan Hovold wrote:
> > > The i2c subsystem currently blocks during adapter deregistration
> > > whenever there are consumers holding a reference.
> > > 
> > > Document that i2c_get_adapter_by_fwnode(), which also takes a module
> > > reference, should almost always be preferred over
> > > i2c_find_adapter_by_fwnode() so that an attempt to unload the adapter
> > > module while in use fails gracefully instead of blocking
> > > uninterruptibly.
> > > 
> > > Note that by implication of_get_i2c_adapter_by_node() is also generally
> > > preferred over of_find_i2c_adapter_by_node().
> > > 
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > 
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Andi, can we have that in 7.4 pretty please?

I was just pushing this and thanks for pinging me here last
night.

Now it's in i2c/i2c.

Thanks,
Andi
