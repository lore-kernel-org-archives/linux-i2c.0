Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C973A7186;
	Tue, 16 Jun 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652939; cv=none; b=Yjkqwobz6qUI4CZBYVVAO6RapLyPSIrVgeGom01GQyEnTmlkKO1NChTSD8ynTOSnIXTxv4YxdQvars7uvRcOo10choSKjlfKOaA5oym9bWZ3GPcUkhXjoHE10XqwB/d5aSTvSLj684RSrziQDaLq4hI8zGdBJKtr6boS7lUCsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652939; c=relaxed/simple;
	bh=jYwc9ZpSH6RUOWI07PSAPJNIx4nMvftvr/rnKqeE5Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/6UtU+Q1vWjhm9aD/D/l1JlPu8GyAe7ixSblYP893rA0ReOiGEFQlHhZd3H7oe89/DBHEWWhLC009roqhX4Zjd9F+EVSmSAlfCnH27uuSOIUzgJSMp3asqcId8IEFNNwG2Fqc4gdx1rw/WZVdtgDFggVFLv/9LaQHByvZVs4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXxENTVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXxENTVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203D61F000E9;
	Tue, 16 Jun 2026 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781652938;
	bh=SjoNDv7W8Yg5iI322q7S6PIYbtYq8yxuevLSVsuupfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YXxENTVg/qfC3xCHZHuVmQZWVgP/72dAzdKQOJHX3d3CMCfaouNEtc03GcG0Qfewm
	 It3bxXW4ptc/Gv5ga41Q+10yIbSW4NpBA861fG7nGu2RDkpPg9QAvWIxOVs6sANSeS
	 bP6DyeSQAdrc9M8AuCt/AFCbsbuV4MmO6fWxZju45r2jrlmn5hJ/2BIzA+u2UBzHis
	 tlgZEoD3r7ZD9nRkDLGYl3XxmUIVFYXtojqPQTRZJPhrcLjR8a0On+P9rbkE4RGd1y
	 s71EXXRaBT83zOVQMfVeZToXWOB9lH41MLKgXwjuXhHt5jKNJjBoZMJp5KNH2l7evk
	 4FOfmq8MvdfFw==
Date: Wed, 17 Jun 2026 01:35:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: wsa@kernel.org, anders.berg@lsi.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: convert axxia i2c to dt-schema
Message-ID: <ajHdow8d1-w5KT1y@zenone.zhora.eu>
References: <20260505100854.5258-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505100854.5258-1-chaitanya.msabnis@gmail.com>

Hi Chaitanya,

On Tue, May 05, 2026 at 03:38:54PM +0530, Chaitanya Sabnis wrote:
> Convert the LSI Axxia I2C Controller bindings from legacy text
> format to modern dt-schema (YAML).
> 
> During the conversion, the obsolete `device_type = "i2c"` property
> was dropped from the example, as it is deprecated and not utilized
> by the driver. The `clock-names` property is enforced as required
> matching the driver probe behavior. The example node address was
> also updated to a standard 32-bit address.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>

Sorry for the delay, merged to i2c/i2c-for-7.2.

Thanks,
Andi
