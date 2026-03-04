Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD1A2C0B;
	Wed,  4 Mar 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613340; cv=none; b=W6EZRfEOq4bRTBWHnetAUZa3p1mUbWoq56TKTzZOmqEGblCo9ZLklpiTdFxi9hh0eO0jSDo8NpFg28vJWpjL4dDmqQbdjCbOIxHTX1EC6D4kDM1us2Eur5NK4rSPzn6YxS+boac5X95hsMjTCTRQ7EuZvUFT6y2Hc1b9gHEnKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613340; c=relaxed/simple;
	bh=oWg/cg7kWlEES/qZchQJbpztQ2Tn1CAdFHkpToBc1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=morPEMXc9ZeQ1I/COKlK5J4xTTrjmz2vq5Q+Ir/PWwhO+c/muxdN0sPit4bBZAbhCpLZbAdLe8O3dzQSK8pqp+GiTwURcApIst5l3jWBhcRGNCYe7cEWc+/nC59JfaxLpIgDmqE0jZuXZJTFNQQMT9LXxnEyEgCa717JDRUbKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbDO9REZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbDO9REZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F715C19423;
	Wed,  4 Mar 2026 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772613340;
	bh=oWg/cg7kWlEES/qZchQJbpztQ2Tn1CAdFHkpToBc1HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbDO9REZow53raDLG6Ylx8rKhsJQX8kWtGz7KlNrZATvSPnmX8sDpV9Tq+my2eKvY
	 fxJqZ2FcA3QsALILV1TuSsnrTBrnRVWgb5tvTZ68Y1EyPOKMv4Dz+/lACKzqHTY2X+
	 1xoIDJ6XusXVNeZ++c8yjBO/fmwvYxk0Ho360/zfWqZQBTxfXe9F1YaKXPNhMk9xwH
	 3gCfDP4acMucgyzLN1qpWikFA5i0c0IdrgBnmw4riv5065a5oWxTHJYCTIOcGCW/yC
	 D/RR6oVtruJAhNNZpSMlo6xU3+68Lhsyr3sUyv+6OP/8sIperKgNYz8Km8c0NNllJg
	 HP7x24bA6QNNQ==
Date: Wed, 4 Mar 2026 09:35:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: i2c: microchip,corei2c: permit resets
Message-ID: <20260304-vivacious-congenial-bear-f47377@quoll>
References: <20260303-clang-earthling-8a4904cb8a7b@spud>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303-clang-earthling-8a4904cb8a7b@spud>

On Tue, Mar 03, 2026 at 04:34:54PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Both CoreI2C and the hardened versions of it on mpfs and pic64gx have a
> reset pin. For the former, usually this is wired to a common fabric
> reset not managed by software and for the latter two the platform
> firmware takes them out of reset on first-party boards (or those using
> modified versions of the vendor firmware), but not all boards may take
> this approach. Permit providing a reset in devicetree for Linux, or
> other devicetree-consuming software, to use.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Andi Shyti <andi.shyti@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: linux-i2c@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

