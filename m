Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BD3C1D70;
	Fri, 11 Sep 2026 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112038; cv=none; b=ISZBC0CY+NXkwsjaHrjAR9f0LygZjkYfsfle8M76rYXh+P1tUTdn0aLt73thiKxpRWHz0nbzqA6JzKI7Rs5VD50KbfgBd9i7Z93Wjbe1u00e+0RqX21qGOBshIZaPc6KnEG8SV0mGEbWXAxuYy2OoOqeWgsSKTr29f/U+1itNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112038; c=relaxed/simple;
	bh=wYxGW2biQlSU+fVO5rTSiQjPhwyBhi1wt+v8FMIEwBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h55xam5nCN8PHSrqQzIEmv2I9ZwUA4cf2A7Ce/pgEAexvQPr7aYvpwPR/CAUoKBD2nbw/BvaGFFo9YPsWVu+I+CpkLNPzLKqw0jynDbeaJvnnDeLxSawx4qe1Xfc09hp5s3rzzOw8q7qtcEFAIIYaSGdidT9eXCESGuwYoj8TGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYSuNLAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYSuNLAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6711F000FF;
	Fri, 11 Sep 2026 07:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789112037;
	bh=PGYcDbSWMJV/NrRnhhlid7hqAqaE59zJzzMDthrRUKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KYSuNLAuBpI9EdH6m8wWw5Avbp3bUk7wGFJL5+qut3SVIdxCvpHLgncPG++hqzt8u
	 xj6YkqpjdUCFreSckLUmSYwqpkse4K6V6xU0PmEga9trtUMQUhEpBAODoNtIE3aKaC
	 lPuaRLKeAvIhzn7y7gcXIKhpNZHNb0Y476U+GrXndZirpZrV0JImWPxCgn/60jXfvF
	 K74jgIm2Mulq3NEHRYLQmsxlXDBpVtlO+7VexPolk8Bp1OP3Dm9/8JtJYqVmLhFtmG
	 Hen5vzoKuymxzEl58JGSXnP8DT5mC4KTxFupSbseKGVlKpcRwBNdZce9IxfUJ7nikN
	 6LcPqa2Gjd0SA==
Date: Fri, 11 Sep 2026 09:33:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA
 channels
Message-ID: <20260911-rare-screeching-earwig-c40abd@quoll>
References: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>

On Wed, Sep 09, 2026 at 08:35:32PM +0200, Wolfram Sang wrote:
> R-Car Gen5 can make use of it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

