Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910B3E63B5;
	Wed,  1 Apr 2026 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084850; cv=none; b=up9zUUQ0pF7bOgDFWq0dTJrFZSkSQteZm9jtViyuEpjCl4EnYT7Srw5hBJmgLqsmbg/q8t+FT9ORRh/MD9rcIjhxH74Mi1FnRu+u0q/hLwQt7kiCLPKGkdAUw8zdtLsNz0S0So+c3KWy6gJvqay2/O00HhuwD0oiGwil2hERNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084850; c=relaxed/simple;
	bh=GJGxNd27t4qfUN+zztohBucOSFYzC2YEFe1sFsuSnog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOA86C5IRyLGEVJFy+xhsqE4FPPFqOh05or2M72Eo+teRgQIvdhwCS/A3wHzP/BGZ0oJVTE3gbftGSGMKDpB/G16XZW8ODeAwJe2ek2kedV6SyyOnNDJzmPPqKxTWC/HWOO47UEdYKPdYS5XYd9Tm3VTbNGZWg74CVYIcetaSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnEOStUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnEOStUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B20AC4CEF7;
	Wed,  1 Apr 2026 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084850;
	bh=GJGxNd27t4qfUN+zztohBucOSFYzC2YEFe1sFsuSnog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnEOStUuH9A5A+uADk9xLdsZHxK68/fhFd165erKu5V/WdxtOApdMw9kJuQkPgMvM
	 7elTbok5HrEdfnszQaBywP5WsZIYBeIS6qAp6N3yQ12NXIIry/JVpy6Z64YJKEK+M9
	 v1MTgKtWUVa/qQXMAkoCaB6vVr9lRfZXkaRjkrdnqSWJMfwVBJ59tixqMHD7kUxKFg
	 anfmWb8lnz1wS+MgDNzOu/Xwhk3b7bgm7365V5RtIP579r59dfeWVBEACYLilDIFjD
	 yIqSdvigcx8xqM0z8Ef8/37IjTTf7bHEUG3YeEekhGKyaVDAr4zT7Jp2tUBlPZk2yR
	 v7kYFlf21FtDQ==
Date: Thu, 2 Apr 2026 01:07:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Message-ID: <ac2lF06QTokpq0-B@zenone.zhora.eu>
References: <20260401180648.337834-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401180648.337834-1-adilov@disroot.org>

Hi Rustam,

> Rustam Adilov (8):
>   i2c: rtl9300: split data_reg into read and write reg
>   i2c: rtl9300: introduce max length property to driver data
>   i2c: rtl9300: introduce F_BUSY to the reg_fields struct
>   i2c: rtl9300: introduce a property for 8 bit width reg address
>   dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C
>     support
>   i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
>   i2c: rtl9300: introduce new function properties to driver data
>   i2c: rtl9300: add RTL9607C i2c controller support

merged to i2c/i2c-host.

Thanks,
Andi
