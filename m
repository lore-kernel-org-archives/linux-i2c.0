Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8326159E;
	Tue, 14 Apr 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205866; cv=none; b=YojvMPIFSQsPEmf7zogJc9WjtX6nrvt/E6B86Y8NUwnFXc8FxujtR4vOsp7pdyxVrgtV5tKAD5QFc7eY2yVWl0eeKsAzHCDyTs9Cqx9xRYid9Dlge3GHoIt1GQqzG0q25O00zbPmugURpM2lZhhxBdh36VlyYN1h68kEEKRXA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205866; c=relaxed/simple;
	bh=AkRX6lFvw+vBbWM+Ue7xbI60L8oEbK8fmEUWgjj7nGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cprW06adlwbrVoDk65INQgRZ0ohci0J3AbK7VzqOO9Sv9k9sZN8pbQIFYA/snZ2y3Dk4hK8IuWil0Oc8cKdtWlJwQEFUGxgkwxqlHTY7SHLuem0Gox311Gz58Wa6O5Ddskwn7STFNhtWjCTN/2GPbAss5AlCEcPqlX295EXTxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt56wbkj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt56wbkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1430C19425;
	Tue, 14 Apr 2026 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776205866;
	bh=AkRX6lFvw+vBbWM+Ue7xbI60L8oEbK8fmEUWgjj7nGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gt56wbkjnHSZqxV2hfGHifPQAp5RV9SbIlLrZo+8c3syYMaP9W1xCPrPXZX4UEAoK
	 kzvNRa6oAKsLN55uVq8eJ69ENsqq2SfxVdAqkrXdna+R4SYWYcKl7WdCsQsMpaeNnT
	 A16eDlEyffeBlrmEsk2r0NwKdrMwgc31f2Q3pDWTWi8AjegATFnLCPIPWk/POv35n6
	 zLAGwahTO4Vq5MrfrR00g9CuYTsiznD0aoFJeXDy7TL5iq5Hcu/0Fd3ACYLskhJ50v
	 N42ssAVaPddtoUv400O9JwUHlr5i5q/1tWkuRMvBQvGE4hDUPKcpC2n656/zOtyZS2
	 zx+Tvfwz8FsOg==
Date: Wed, 15 Apr 2026 00:31:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 0/2] i2c: Add Loongson-2K0300 I2C controller support
Message-ID: <ad6_-5NQv_Q6vxAE@zenone.zhora.eu>
References: <cover.1776135865.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776135865.git.zhoubinbin@loongson.cn>

Hi Binbin,

> Binbin Zhou (2):
>   dt-bindings: i2c: loongson,ls2x: Add ls2k0300-i2c compatible
>   i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller

merged to i2c/i2c-host-v7.1

Thanks,
Andi
