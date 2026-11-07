Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060009;
	b=GNPSSCKcFnkZtkyWLF6izM1xUSjcqk2YSS3vyrKxgqEbJPZmsYIkDL7xhJNkGg6GY7FJ
	 CQZrCfpmSnwyFfs/vv1ELnytyEe3ENaEFyX3S9yo7TVQM8ozzqL8ZEKPdql7XKs/3NX1N
	 bUbTP5runlr16AJFWNPiL7hXdOBxoySNNTo28I/44qXhgkrICp6jvjvwnsQ83Lf8+ab2Z
	 gQm9K+YRj4zFxdIzdX9mcA9fIL+hzyUVgAzH7vrV8+gzE5kCO0sw4GMQtzhK2TGQm5aH3
	 XLHuKpnYHda1y3u15GNZI5H9R278l2lE9zntnJM1WbmEkMj4GIQrsKmmTop3glkZNUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060009;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WXcTlxWH4qnX8oi9ZX69BAlVnoTYRMBFIYfdkKu3cX4=;
	b=cGNfL8CSRAAi0FLs6Zi9bHweHVgI9mBZ3Fs9WlBEtK3ekWlEUhclOLI2CtBd6QenZ0xQ
	 3APXX0n8apXnwl1AVZbvFVLVMI1NgzjW1LTi+ZoMtOenEXUCscOTEX9ucb+ZPVjGWLU1a
	 4cR5ASKT7A0gmhyRbVdDJLVDFXAvoAMAM5U7jABWCjZnuB1oL3+1Uhd3TUjm2Ot567u5U
	 XEAtz8pNFcrXVy9u0GoDJux3ash1TQsYipKGmo9TUe3mpcedsq8FznK4WJ4zEUxLSWJOa
	 j3EM66b+bi+oogWVTTrYHQVBpFFnY21r4oWqnkKR+a0+vilfnr5eY0snaU4Z3ZadTHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Gg2YvsR3;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F902606A335
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 14:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F902606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Gg2YvsR3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=WXcT
	lxWH4qnX8oi9ZX69BAlVnoTYRMBFIYfdkKu3cX4=; b=Gg2YvsR33DGzJN72X8qy
	CNy30T0OsdlC2V3QdKzLrxWCZxrgLQ3WXmpjul/Jp/9UjYgiupHoOxGuSFh2q+y4
	r85SE3TLVp4BroH+vipZ4z4ZYYyrnaAm5nW6uFGjt72OpMhIrdhcg5xAO+kqafxd
	KIr5rHlZ7l0w4PPpDvC/2IJZaB+k8ihGX5iNmSWu42B+PHin7lPFkr7R5cR+20dY
	JuhBuw9Q7xSbk8YYUgT0JqTQlMf0rJxD8UGoGomUxj4gk0wHphw+OvoEFWwmbRrp
	QP8b0tHkfIvV/y85LV7TQ8JfJbIOnWKKYqZGKMnnJLcT5S6ffYUb+o+I8v9lOEO2
	6g==
Received: (qmail 2523875 invoked from network); 7 Nov 2026 15:00:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 15:00:01 +0100
X-UD-Smtp-Session: l3s3148p1@i+zUJLBfUdQFFu4k
Date: Sat, 7 Nov 2026 15:59:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: i2c: apple,i2c: Add t8140-i2c compatible
Message-ID: <au8u3Ndnx3v6RV6p@shikoro>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
 <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-3-6c757966a99e@cyberchaos.dev>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-3-6c757966a99e@cyberchaos.dev>

On Mon, Oct 12, 2026 at 01:52:34PM +0200, Yureka Lilian wrote:
> The i2c block on the Apple Silicon T8140 (A18 Pro) SoC is compatible
> with t8103. Add "apple,t8140-i2c" as SoC specific compatible under
> "apple,t8103-i2c".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Andi, since there is no driver change associated, I guess it is easier
if this goes via the apple tree?

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

