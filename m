Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311206;
	b=D5817jsggRa8PTeRGp8R2pvP6nHnhyeqWoEyzQzlZg/9HbD6laTeO0K0sKu/zQ8vMHrW
	 9pdCIrRhFzT+mmo9VlG2ZcU0P8zvEmydUQK9370dzBoBHaT0u+wxGWp9FbPJrkWW6d1A5
	 eYk0dBQfBTVUR+PufBYrFH7ot5EV5r9I0mOxb35+clAx8QMtukISjEWdiYpOkGUQ1e783
	 ZyauUkT2cVkJTyqkMX9b/31W4BdMqIZCHviXbokiO90IqJKjjMnIPeUFxH6sNlAiSwrjL
	 uFlPk678+17imdGXT1vLFsAgACbhp7+GuTu6RkcWy+PqSHz2qU4/XTypqpPz5olR+PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311206;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+mxNaERwxQq956ZCj9Y5CcIlxgzFYJgtWrJGQcrIJDY=;
	b=1Dvufw5oCoAshl7Ntt0Rg5FypYKJ7ctCgMBBd7OsJeTx9kV8mcsTtwxKK2PZP648i9oU
	 wORVCFUSd+QIFEJJI7JC7Y7tE6N9vACSrf6gbMpo2ufR5WrNaTTrMAQX5gHCn6UxBCL/t
	 ttuWgJogwmMXh/A1WrSrY9KZ934c6DMek45BHdT+uGJMQ7BE1OqfsUcqy/FFfoc6px/Vg
	 vDZMRe1/1fvhiLUa8ViZObeUgFWd/oIqWVX4AGGyvMiO1JpzCIWQ9y5G7o05bC5S8idgB
	 1eykWsngzFgwFbo3AdLI9ptHDfbk+O8JcMA9KltZGXmx/m4Y4ofJWRziGvtuFWrVbnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=boLWSXMu;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C8606A31C
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 880C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=boLWSXMu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+mxN
	aERwxQq956ZCj9Y5CcIlxgzFYJgtWrJGQcrIJDY=; b=boLWSXMuwS91DCg+uHyO
	Fu0C0fx99irHNc8zJj7ekPZ8psWctBUkyteJYXCXR9y6wlMA1I1+W9ipqVWJMp5/
	TU8psAcibhYxjYfTtrxz6xEX4WfQHiEmblNl0NwhXRsBfqiI/FLNbE9x3cnooV97
	I44pzuakGZiIK4dcDRBWcPv6M+PgIO+SOK5rkZM6irYks6Rcv1jT6ep+5CylG+I1
	iGwsiu8brTgop5u+/R1VyvJUMDSUosx3Cmj9JOxeeCnVLtDa1K623nozvps5w3hH
	WYESphYyvj+NDAYLXZYMZQJg1Bp8ICIK2NTc2Gy+YvtvBlp2krRJZ9UOL/1hjG8C
	6A==
Received: (qmail 216367 invoked from network); 10 Nov 2026 12:46:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 12:46:43 +0100
X-UD-Smtp-Session: l3s3148p1@xMHjoepfqogujnsO
Date: Tue, 10 Nov 2026 12:46:43 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] i2c: dev: drop unnecessary sysfs device lookup
Message-ID: <avMEI9UuWSnyV6uP@shikoro>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-3-johan@kernel.org>
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
In-Reply-To: <20260827102043.673273-3-johan@kernel.org>

On Thu, Aug 27, 2026 at 12:20:42PM +0200, Johan Hovold wrote:
> The sysfs lifetime rules guarantees that the i2c-dev class device is
> still valid while its attribute callbacks are executing so drop the
> unnecessary reverse lookup.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

