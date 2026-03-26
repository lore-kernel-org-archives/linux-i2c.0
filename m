Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81115322A00;
	Thu, 26 Mar 2026 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564117; cv=none; b=ND0uGVxHG1K/T1CI6Rmde82qd/Q7YM5yOJzfBuHdD3OUjoENYueAYLov+6S2C8HHRghLkOVpu1W3kkMJOOG1SUUnDPYTwbfM/hBgwLxJPkioxLejrbHWTMNk0J3jPZRdxvRp0mCezoSSjzVxcvi3uBvXW6uvq5Oh/LHTb3eeADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564117; c=relaxed/simple;
	bh=4gZcZUjzK1nptPDjqxf5FRALWYV3UOJkeX8BT/yrYBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC0K+JcjiT1K7muozasupGJpKlRRCSzdSNXreyrocDFYtDYXJLwX0c4vgkRk16layUNJsXJR+qsxYDazZfO25yQgLiiKbgM3YLmu6EMG9whtB7TrFKRSk8tuW396lSyJrXvdbgMZYCx0XJj99Pzh4KaT62TxduJ3Q6dAhA8IKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXhrbzh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXhrbzh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C19C116C6;
	Thu, 26 Mar 2026 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774564117;
	bh=4gZcZUjzK1nptPDjqxf5FRALWYV3UOJkeX8BT/yrYBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXhrbzh7YidpgRyjfk3N0Rngay6NJJjRfk4J/ccbQz1Np+vXwJjsFndefuKZYO5vL
	 OhAzvcyNKPKCSboD7lhLYMRTtPwLoOe2GfuDWNjMJ3bW5MVSEV03/DnELLrkHZrQ/f
	 gLKTnrVcx112WgTHOGYxQg2OTJaCXfvKAnEhSpPCWdeTjiNuyho0Og/uacbfFYGGPd
	 RI0hzJpuRmVggdznQnAyzGC5VCHnjUsUOt0WZ8CuxNjahGSTCbwG8h+VNjluqmfkw2
	 dKCyEZt7iPw/Lkt8P9rOong63klmwfBTPwzRMfjkAHntXGokPSlk0Pk3+O0tZ1bP11
	 wyzaniIHiCjUw==
Date: Thu, 26 Mar 2026 23:28:33 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
Message-ID: <acWy_QTLt4U292ub@zenone.zhora.eu>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>

Hi Yixun,

On Wed, Mar 25, 2026 at 09:49:24AM +0000, Yixun Lan wrote:
> Add a compatible string for the I2C controller found in SpacemiT K3 SoC
> which use same I2C IP as K1, so make it fallback to K1 compatible.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>

merged to i2c/i2c-host.

Thanks,
Andi
