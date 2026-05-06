Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418744BCAE;
	Wed,  6 May 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070905; cv=none; b=VyiNZLnVNDMwvPRe1pMBrytSKJ08WWvA8O2ntSpa/RvJu3tnlTD0A6Fz4LqyLzxtAU74qO+Igz5bJvOC1dsdRg1JiQ2d6oBWpJPhRzKMKZqBoh3ELbLTf06eAAZ8CLyZgLBKpmiGZFt5Lws1mkVFrWZHz3iHy2LqFYhrkk83yoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070905; c=relaxed/simple;
	bh=3u09moz3KpKYdM9NuF13xoGw2kqPphVjKjaYLxVLOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4Ll18CnW5wSd/0LnZcxnNpEpH6bLoJZB/dCCNT3Gt5tmRok7lGhHOTwcWMKdTnkeziSWhTbJvo1c48Ejkxs079+dPWEDAf/BEWwjf8EdUX+1SRepMjhxhEGSRp5de/0rWS+eemnZGWUFSLPBHxwrDSpkMq9zaRu4FYLIdTiwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG0wuScy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG0wuScy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC2FC2BCB8;
	Wed,  6 May 2026 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778070905;
	bh=3u09moz3KpKYdM9NuF13xoGw2kqPphVjKjaYLxVLOIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vG0wuScyrhBUp6PyZb2rCvsEmNZqYnJTTdCFMdfh0AydDi+3XLEY/zjRtgU9Alqeh
	 bal+cfDuKVssJzzjuaaCnl/uVUK3f3Bx8fSgbP1Px8E86PKS4GStUtNTToMx58abF1
	 AYeX7CpEe+VtOjFPZnIbiYmiH1K96Kd/3ZoW5ev6sJA2PYL5CFvppiE6Moubnv2bJC
	 ccl2MU19EyVmUdNLG2klK3ZPyt11pKkRWFZr2NGgUv8ix+u9Ggmlu8uTpELHCajfvv
	 TwVkiW2AuE8GQobpykjphQrUl+ZfJHwzAlwiBwCcF/DDz4jtRtn7PhbG4+1aVLfIb6
	 AjnzAZV8oR0wg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKbSw-00000000mPZ-36Ou;
	Wed, 06 May 2026 14:35:02 +0200
Date: Wed, 6 May 2026 14:35:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] i2c: core: clean up bus id allocation
Message-ID: <afs1dhyUDr3SN1Mt@hovoldconsulting.com>
References: <20260505142547.795054-1-johan@kernel.org>
 <20260505142547.795054-8-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505142547.795054-8-johan@kernel.org>

On Tue, May 05, 2026 at 04:25:46PM +0200, Johan Hovold wrote:
> Clean up bus id allocation by using a common helper and deferring it
> until it is needed during adapter registration.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

> @@ -1665,17 +1675,8 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
>  	int id;
>  
>  	id = of_alias_get_id(dev->of_node, "i2c");
> -	if (id >= 0) {
> -		adapter->nr = id;
> -		return __i2c_add_numbered_adapter(adapter);
> -	}
> -
> -	mutex_lock(&core_lock);
> -	id = idr_alloc(&i2c_adapter_idr, NULL,
> -		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
> -	mutex_unlock(&core_lock);
> -	if (WARN(id < 0, "couldn't get idr"))
> -		return id;
> +	if (id < 0)
> +		id = -1;
>  
>  	adapter->nr = id;
>  
> @@ -1708,10 +1709,7 @@ EXPORT_SYMBOL(i2c_add_adapter);
>   */
>  int i2c_add_numbered_adapter(struct i2c_adapter *adap)
>  {
> -	if (adap->nr == -1) /* -1 means dynamically assign bus id */
> -		return i2c_add_adapter(adap);

Sashiko also flagged this a potential issue -- needs to be kept for the
alias lookup.

> -
> -	return __i2c_add_numbered_adapter(adap);
> +	return i2c_register_adapter(adap);

Johan
