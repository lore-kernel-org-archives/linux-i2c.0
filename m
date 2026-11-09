Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245162;
	b=1cuvoHC0UGletUGNrNlNrKBZ0d4kQo+Jg/R5xtayCLQd3safpDbqZxDQwdVZOrFqo1FK
	 yuKO8rY15UvNmMTTLgRrhnmURIA8UIQoiRWltZLbF+blFWs7Zn2NNmgViIorbglsuYTHw
	 Q7jYcU9B286prjdFhsB/vuvQPRRGfTQDM9IzqOVsD50WeG1B6KgKTj8RdotiAL1vTPwDf
	 YqswihIA0+qMqiSBuz6Y2iiXEmn/hWlq2n0xERqUVkV1LeyCe0UyPgCtQS601FKTHNHYs
	 Jk2oY2UvZEf2NaXEHqVDypxzxCBfvh6AUUrWYAh2jXNOCWzfNgTJgqEkBmoPA07WnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245162;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=prHiXuru41hVkUX5fnZU03et/s/IGkiTy36rSJ7ufsI=;
	b=zG8KGO3FfXgaq9d8WTFFcqEyKH5zA/y6LPoF5nEuoWuo7zc+jVkRgCtzTQYttRskFwzl
	 8r0nm1I5mLvuiYrRd/ZVQ6iTpqWGuFMZ1aRJoHhOzqpMTZm5mA8h0oi62pH31DphnveHj
	 jWbDPeq7yUrJHWpNRZT8X3zefZETkT3ygQNZSdhPGPzrCZvOJxMLjL/GFc54IYDNOHPjH
	 H7iSRg5ofouC4lZJVEjq7mER8bBeoCoF+punvO0tdEA66niE5GIHXCpCw4b3VQDr6veNZ
	 CTq8FVh5JUZrvcghvxPz8KF4HZWy1XsrJIJK7+FkApAj59gs0M3vfL7bp49Jrbhvx3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A0606A321
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 17:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 234A0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=prHi
	Xuru41hVkUX5fnZU03et/s/IGkiTy36rSJ7ufsI=; b=Q/+hLAi9A/0VV+uNQhBK
	n0bPmntU30t/U0COCCzqZMSC/rlitJlFKFG2SXYrHqU2jgKsxlQtfWCyKxcJWE4Y
	xu7Qggw59mp+WLvm05LwlnsjtYRrSBqftBr2jTOc0/K61EE4ioRHaLW+XTajzU2Y
	5IXRaBlZ5AwdKluqquJXc7jQ0ry7UJaQjmSPgZM32XTgaNDV9+NwqroM6qumwaIV
	7z3V4nj5vsV//4dbfA6MLR6b7odTv6kTRlPnqArBBNv2aBrrbLJlBMt0lPJaXVpF
	hagmWLe0TN8ZNMx+SpwOBTPP8tsOsMs4IkdwEKSs0D+4QECy+QnKJGTDz49y2OXH
	Bg==
Received: (qmail 3345140 invoked from network); 9 Nov 2026 18:25:42 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Nov 2026 18:25:42 +0100
X-UD-Smtp-Session: l3s3148p1@xY5UQNtf4OUujntg
Date: Mon, 9 Nov 2026 18:25:40 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
Message-ID: <avICFAh07d7XrAIY@shikoro>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
 <avFwLctRcnJHtINQ@ninjato>
 <avFzEaxgam-UuZH0@ninjato>
 <20261109100606.493ca48095bcc3527be18573@mobileye.com>
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
In-Reply-To: <20261109100606.493ca48095bcc3527be18573@mobileye.com>


> This solves both the positive return code issue and the usage counter leak.
> 
> Do you agree?

Having a leak less and cleaner code? Yes, I am sold :)

