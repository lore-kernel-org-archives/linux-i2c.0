Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2738F653;
	Tue,  4 Aug 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826127; cv=none; b=G/2m/6Zh6Kwkx/7n0rpsYy+0+uAowb3nm9LtvasThRt4DPQHLk4ZMGFdcpn9vSYk8i9WzJvvV6533nCCfvHttS+MS3161mWvBCRZ+vLHgOlW3vmCI4OTsNVARu0dM+J9V0mRjvOSdd44g2ZdM/q4R0KlC9yxY7ZrfBn/NPB4JOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826127; c=relaxed/simple;
	bh=oqJZhF7QK/ArFkYjGjd1YdTb3cGZQvtiDZAbvoAvy14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPLfZXIO/rUg/YAjoRkDD2EonneXiOLScXqrL/63XcRndYoPbZPqX8CFWjUbG3jtwmochQ7kNxYA/U4S438zw8iJECIFsbc1A7kVc71DWHpxErHFn5fUjS+2vRk9Y8n3GYEu1xqNIgiwIizmBfwMQBcpYKYwD0CMITvM74iyff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOWuiMPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOWuiMPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344761F000E9;
	Tue,  4 Aug 2026 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826126;
	bh=BXean03lz/QUL/roppvZreRug1yrm+pYsGzPv11gQC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOWuiMPZag+l6Cltm9+TGhv6e1xqqjmTz8qikS3Zr8bLYMf0BHsOw0Kik6Hjd13EC
	 jrYwuZh6AObgP+u1/SqDGUW5C5j1ILGrP6Po5mqxN3iNFsQd30f0Sae4mpY19DJSvF
	 Q4Ee/RvNwIPqnSf8+1GW0Nz9NZyDa8Zib1oEfnFfxKo6/POQVyex1QvlSw5UFp0kOf
	 MkvZ7Hud6O58Nry5HXKKNY9F7yszqPRG9ClqHpyZB3sCBy1LEiQqe8QW9HIOI6N+/M
	 6tY++XJQbaxS0bE+z/FiczoIn6odJrOY3WdECeSxgXkCfXctFQZ4Qt52WYOotR5Bxn
	 TmVmwhKzp2cCg==
Date: Tue, 4 Aug 2026 08:48:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: nina_kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw, toby_chui@novatek.com.tw, 
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v5 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C
 controller
Message-ID: <20260804-uppish-abstract-starfish-32e1da@quoll>
References: <20260804033419.693819-1-nina_kuo@novatek.com.tw>
 <20260804033419.693819-2-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804033419.693819-2-nina_kuo@novatek.com.tw>

On Tue, Aug 04, 2026 at 11:34:17AM +0800, nina_kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add Devicetree binding documentation for Novatek NT72676 I2C
> controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
> ---
>  .../bindings/i2c/novatek,nt72676-i2c.yaml     | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

