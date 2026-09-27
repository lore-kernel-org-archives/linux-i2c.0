Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42D3B7B7B;
	Sun, 27 Sep 2026 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509745; cv=none; b=HH49t0NPbBYllH3RwLxElEnVctpkDXkRjjcto8MVstcl36DqvpnkNUyzYN2SuAnWIYf6Q9x6BDZ0aP2Q7/Q5p8T93Y7gtbQ1mYKk3VARytNlxr6wjwqt0woP+jyUZ291hmXwb/NbIKGt1IkXipxZmxByDbATqILr6Bk7e51gQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509745; c=relaxed/simple;
	bh=J2EK++o8yyraYRZ4KDkkR9/F6zDQOclM5p83gBAJe1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0gASLhE3i79RIhX3D3nW2dtNnJVaHOpj9jCbS7CinDXpP3WtD0gjGg3omo0lnPAWCneqV/k8UVIe6EcnOofnnflYaP1LeUqCnEj5TUwriC41p9xvN0mdmqcNNqR8zXLvsTB5xvmAh1frHdOY6nrLNFj4b4K91PvJJUdrDvcBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2JoQCJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2JoQCJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F281F000FF;
	Sun, 27 Sep 2026 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790509743;
	bh=83jjFbsFUosVtEhtwuG8dnoSIByiVw2r0FAPXIo7YlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A2JoQCJQxYUVCG0hBhans7whsL7Ya5kdv5kY+efQtCLR1XYPAAHPwHKF6ij+Y+e0z
	 2ndbTVhgVoPr5HBnL1v6QHtdTyv89FBUGzRBsQBPIb8uNA5gLGYDnEW6rb4UV2QTH0
	 saxY2Flr4dU2uzejndPqHjrA1gZaiP0L+a7YZaHlxxAsXNh5AnYiFwuOtNEmu9KsLp
	 4ghYJ5dO2ojNO6nq39sJvZ4crpTYZw0fz6/kkvDHjy9nM+uCQbcu2XyoZ0v4lwePkx
	 ALS+FAnrK8a4D/qhrDKmu6ltV/TzysOJNwgnSrWyBvrKZ/tUA7OK9PipURkaU4EJ8U
	 71SFrzELjOUFg==
Date: Sun, 27 Sep 2026 13:49:00 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2] dt-bindings: i2c: mv64xxx: Add Allwinner A733
 compatible string
Message-ID: <arkCnX2mqH_qZ1kP@zenone.zhora.eu>
References: <20260924-allwinner-a733-i2c-compatible-v2-1-0f5f1e9af969@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-allwinner-a733-i2c-compatible-v2-1-0f5f1e9af969@baylibre.com>

Hi Jerome,

On Thu, Sep 24, 2026 at 06:05:50PM +0200, Jerome Brunet wrote:
> The I2C controller IP used in the Allwinner A733 SoC is
> compatible with the ones used in the other recent Allwinner SoCs.
> 
> Add the A733 specific compatible string to the list of existing names
> falling back to the allwinner,sun8i-v536-i2c string.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

pushed to i2c/i2c.

Thanks,
Andi
