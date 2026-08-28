Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D93033DE;
	Fri, 28 Aug 2026 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877752; cv=none; b=d0w5CH29XGSKRCV817TX9QevsoIwfkZpmtsxycd5x6gQkYVoNMLg/tAokNWB/zg6vGdoCoiKpt5nJ2VWQNOjj6MChY6tTvdTwAjXN8VPM2hgcHLtrwhNmen8ubMxN5j/4n/7eXuGB1ivMreZuhx0/gtJPa+xmFo2uFr8viHFMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877752; c=relaxed/simple;
	bh=Evdd4PjUNNW/3oME6/eo4yofaEwlFsQBDHwIsZ1zj5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDubn3d6whoAEZHMhEL59No8r6Z3TapIDzAS5lrY8oezcVLZF+dLR7SRLCQ19eJ2dgxUWa7RikzjSJanUoKzF2PB3UL1b4S//JyVq43udivTSl9c6RvJ6QiW9S626/VbSj9g9j9TepGRsDuoN2Bo0zYPMkh80DXUGs/8RopxTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhQo9+wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhQo9+wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6EC1F000E9;
	Fri, 28 Aug 2026 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787877751;
	bh=UcqbGk9d6SDu4x8AGaJmmx3o96nRQb0AmZrxv6dTatM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NhQo9+wmf+lLIF77jOUiJOeSuq9moUzUbJO+22e3twcBjhQ7Xd4XUiuNpmCAk/cwL
	 82ca3LrmB8sdYmmBeh65bUid/CmMwijtKwX+1IE3+4QZPgXG+gbFDiloyHay9imaSN
	 vnyOr6R+qoaGsNIPOxnC9nYgDuvZ/THK377FvR1DbI0fmSNyemZmaH653nSbM+YqAy
	 w91Igx2UUfY7uPD85+FoneTf4KF8GRdSclXE7giyRYuRkv9TgP2kSz9NvEC0HEQJfj
	 vomTmAIPj8VaLPm51ym7393eSGHTAZAGWSDBVjzNmUPj8vIwwsHJmfryAjesNqzzA1
	 O346oIxuIqafw==
Date: Fri, 28 Aug 2026 02:42:28 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: xlnx,xps-iic-2.00.a: Drop bouncing
 mocean-labs.com
Message-ID: <apDZYXYKUwzSfFoP@zenone.zhora.eu>
References: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

On Wed, Aug 26, 2026 at 12:30:43PM +0200, Krzysztof Kozlowski wrote:
> Address info@mocean-labs.com bounces permanently (reason: 550 Host
> unknown), so switch the maintainer to Michal Simek.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

merged to i2c/i2c.

Thanks,
Andi
