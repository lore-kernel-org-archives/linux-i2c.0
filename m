Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79565451054;
	Tue, 31 Mar 2026 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996732; cv=none; b=hk3feOhkiGvgUWKuLxtFT/XbfPItZ0rta8tSXL8GycrgYaClzgaiWhSicoM1ei2OZdRBf/o+3lINUquG762tQzezuUeS54OQ8BdJFqPpri4QVUm2i0+Br16sXpsUX8X69uQM+IFezo6J8em0RyEmGgDWvfbrv2zwZu9cwAiThrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996732; c=relaxed/simple;
	bh=cN2uGtOY8lmBwWPA/21l9JKzzTYz0awsRS+Ef+cIPRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD4ixJ/pjiZafbVhqwsrYccaNio9DHpjOBgMvRTiiOpzs4x4jvlB0ZUt03ql1QbfszcultSXTmTqOBxSiZ9Blky0JZwI4o/1bwTrrqT3qDd4CjEBFVl/miD48XJ94DYcVy/NpExMN5wEAfKQICPzVRuTEfP/KZiOmoOEEbKx/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY8Pmrej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY8Pmrej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE5C19423;
	Tue, 31 Mar 2026 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774996732;
	bh=cN2uGtOY8lmBwWPA/21l9JKzzTYz0awsRS+Ef+cIPRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gY8PmrejuWoWP9cIVFF9P+ii5N+E8ndk0o06kgDO/rnmp989O+nEGMxfTcRbttFtZ
	 8vKTysGBjHbJQvHurFjOERjvQ/pBCgpT5BOjDjvtssFycxSQEhxJq5mtHIBBwh9Jxd
	 PnO8deD1tLYnIw18AdPcwLCvM71G8otHrcns4t8EJEoJbos8Nnalp+HS7VQPyPkFeb
	 yTS0ms7ARkTbGcPsoDtt+9J8sGpGoZ70RSlwU1D3yTpDvYkPdHWejKU7Pwnqj+oZEB
	 m1NsbO+xzOxT4okZr/LrLIwFfAqaeYKhtjMsDNf2COby8cmO1v6My4A3Da99s1pAJb
	 Ja/kczxSpYkmg==
Date: Wed, 1 Apr 2026 00:38:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Message-ID: <acxMeyVpRh9nts3d@zenone.zhora.eu>
References: <20260326152656.14030-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326152656.14030-1-adilov@disroot.org>

Hi Rustam,

> Rustam Adilov (8):
>   i2c: rtl9300: split data_reg into read and write reg
>   i2c: rtl9300: introduce max length property to driver data
>   i2c: rtl9300: introduce F_BUSY to the reg_fields struct
>   i2c: rtl9300: introduce a property for 8 bit width reg address
>   dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C
>     support
>   i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
>   i2c: rtl9300: intoduce new function properties to driver data

Patch 7 does not apply (not even in i2c-host-next, next,
mainline). Which branch are you on? Can you please
rebase on top of i2c/i2c-host, please?

Thanks,
Andi

>   i2c: rtl9300: add RTL9607C i2c controller support
