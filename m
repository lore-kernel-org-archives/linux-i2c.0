Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F544780D;
	Wed, 16 Sep 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546299; cv=none; b=YIKDQgPbaSJ/NTseaKcg5FUIwJqVcU5/Kq2b6rIEON+gy04Bm/XjDq4cZypKJAECUvPgPGn7j2poWN5xoP1j1MQrxi91tSJ1lml+AID8+obZxVztLjM+mrDR+imXxxMNRZBp31KMbXLO/6o3w2cI9E4n9f2QVxnVDSlTYIVBEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546299; c=relaxed/simple;
	bh=RUejghjPbr02S5+cpPUYLw7IxGapGF+ZUyxVBDBYdFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjzBHAdwjX+ndbR9b04IBoJzFikYGIuNUYeSMuj06FrYX0+YxEuMyaNbpPwGRaHiSlUa/d3fHPgPYk+a8DfvUTtUlrHwJ4jnwqQ878leJr4rWRwj7dwjSAkUqFjA8bfWNrCd3sq0XQ4osgfQIYaE+mTiuQxYLuKrN4gdLG7JVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG6Db7E/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG6Db7E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168241F00893;
	Wed, 16 Sep 2026 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546285;
	bh=Y6ZAD0WuakXinu24nKN12JZMCuEpJfsfvTW2eCpYiow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iG6Db7E/KGtqeR9+2XGzIs8zr6PH3eWyjv7zw/yq4aLeg199mKZytaTW6soPEz20h
	 Ki38R2Ak6kdU6eHIJ30e75RPXB7V514vHXyHwrTpuk2R5HXvVCCLDnf3MIgUZTFBp5
	 1BIQlcSvkzchjd/C4jXlGf2mrh9vwuOSCr80OVUELslngZih8/ZSmneOmp3MhZ3QJD
	 xkYJi2dGoW52AwpV4oTnSrRAhHHFnjXF2rQJAidETgovGN8bM0xqFb/8ijhBkk2g/3
	 Jb7XgAz224ZgB1XJ1g9nf1YLf7cTnbY0gMOY/XUZxaANCweywcVpqkcn5004o81Xux
	 CElwEnLQjaqAw==
Date: Wed, 16 Sep 2026 10:11:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: soc@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>, 
	Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v2 12/14] ARM: versatile: remove mps2 support
Message-ID: <aqpPENWA2jWytxL4@zenone.zhora.eu>
References: <20260914140821.1805449-1-arnd@kernel.org>
 <20260914140821.1805449-13-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914140821.1805449-13-arnd@kernel.org>

Hi Arnd,

On Mon, Sep 14, 2026 at 04:08:14PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Arm mps2 platform is the reference implementation for Arm
> microcontrollers and is useful for testing but not expected to be used
> as a production device.
> 
> With all the Cortex-M based products gone, there is no longer a need
> for a reference platform either, so remove it as well.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Acked-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
