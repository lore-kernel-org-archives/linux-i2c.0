Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416476;
	b=3DhjndKnKoeNCBeB0n4mQCxTyB/+7eIenrposfcryRWAYcCfp2OxY2stVp5jIRSU0FeJ
	 AB0WSqoiIh+7xOA1LEq7NkQJu1K65h4froaFNXaZNAfoz9zOlTWSjvG12mKPpSd2c8d4U
	 eU+UQSGq+DIF4dxmlUtKta4svyRV2iXcGWRWTmepijpu7IfeNieB+Bz0FAyD9seuQBQpX
	 IFmWyaVMZYC3exf6aHGQKX5WSeYC7aY7M4WnpMe/NB9uLnOAFcNV2ADexqACOskk3MdE4
	 tNiaCqXLMYdo3iAXrThQXImhZCwJ6PiVZyfGvYIibtfKStXzots1DqX1YsS4hDKr7mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
	b=HeSFu6N00lW6Iioq5dDTZftgdMo8Ql5nvMPdmloGkTz3tZmzdjp15R2+QVvHe15CUG3C
	 pS1j2Ji3lvw28U+jlulDiCmyVlj4/eLvdm+ndLMn63zbT9N1HTQDGmqhtENHpZDTZzXFF
	 oaV6XDeBPpuHWp+wIcWkKqODAFPOtOPFdpDeuOJQ2kJkSP87LZYZmJSCS5VQ/v+XNqqXH
	 Pa8xGFMiX4HgET9/SOKmqSZ2nirz68bRhjnDunrQNLqmPo2QO0bwtNtIrJoP9tghsy/h9
	 rZb7R4IZ38DPANx6tbfOgK6alTQoSBp+2vx3OnyF4AFwUn+Yyfjngg1bZrIYy85zw4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 48E27606A31E
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 06:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E27606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1322798b3a.0
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416475; x=1796021275; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=sui00Ob749YP/4E0URw2ubSzDUQP9KyBjfsmmDw9AzxIDxTYS6M49S1JibeFvPEBVc
         qxmPMlLkjqeHtjjaN7HvIH7fHwsh4z3btvPa519DONCM3a8F31p3NAmeMGSbIBAqhVXw
         5txmr4OBG91xAg91dxl180zBYNgs2sAiXvTgDE7cFJeajijmCEsby493dgeu2NU9qZIe
         AOvHl8i6VREYiO1AJs8bd9Y+u3Wd8mtajSfG6AMj9CMP8bF0uqYgd4Y9TA7w5AXW8uDK
         YQ+QuR6/yknUWT84taqMCfSyX7b6XxC7IIgRv2PGwskSgwLDtlasV+5SLJy7c7g+qSd2
         P3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416476; x=1796021276;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=s+YkD+98bXNFkYGJubniScNK52RGYszWtSredQKgVN12FduUa4AVQStAwZtWZ8Yv2S
         lJGLq9DWExjOXRLa6j1cfvygMDXS8ivGZDnagYtM61oOM2jG/yvB8o8WacUU0hE2IRWo
         0bspe0cgl453p/QtclVRCbzyD1forRendPEzBPs4kYfNhdgNglYdoBDVirHG6+6w6XnV
         l8iKo705nD/j9joFPla6R+Pp67emIaISEa0uk6iyN+GmpoEA8ZBDI2L6xDeQDbTANTJO
         igThOJOopKoWiBsEY7zKl5Hdf1d2J/c+dLKalwNEREJdF4k3EPPRIQn79W268Qq5vWRY
         kjXg==
X-Forwarded-Encrypted: i=1; AL+hErG5UtVkA+WCoLEWwu9fgrgrFpZDtFn5APQ2box9bLVqydH72F6x2ls2RclctKXVb88migAbvS568p4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mU1blUAmSPt5iBl9NqhHUYJoAVA7spR99KVaZbGdSXZSfgYNW
	eizY245FLpOtQ6pYYioiOS21WXD8wgPK46xBAFh1HJnxcNMy7RPh66aF
X-Gm-Gg: AZFdTZerktblkY5XQAJKKvsYT3k6XhtFa6js17oJXBO8eZqFqcLm3KZ5a+jJhSxRWZC
	kPGo1MQIqvfenkbNMa7H7SQ6T4LODt914Z/NehZijPt8Xy8Wp8MgEcts/GsXx2YF8xy7nYTSdBD
	aDuClZXqk0T2PXCoZNAlzbKOSekBg+kbHkWcirP4mLobyaszJ6cWc6YEVo0p/3zxq23bnYXFeFI
	Hg+YbaNzIZEy7B2nuHpICvXzyqs25ajUF63hSRwRq8/amJ0SxZzNK2SW/3YzC6yvkGxNZ4aqsSQ
	sFX/XpyQXh95d78bEY9AWBzv7u1mMRruKdOfbkzh4Vq5IkXFIrSf2SMna+5Ekmrl3+KFsTzMYoX
	eIAAURiwV0wFrEJM8ojM3+9tve5E9OQjVcJUL+BcgSjVT0vsYx68TphX4TtzAUnN6q3qOJezthV
	5s6RlJVDWr3cDA3DwBVvhJk5VIbLv6Yd4iLACfx1q1EjR0gSbrCUBwHqQ0SsVQe9iDgR4rW1919
	qNIU6gfw+sb5cfzC0q20e4ZLQFWzcD6NFcNt/OMhCfy3ZRlouHYq88LDNpTCjI6LMatZ3hSiR57
	DqzX2ukyAxX5lChiWM/2MJgio6bF4wYiY3M4aEZjdAPuDk+i3xcrvLGeteu8aFtCiBO8Jg==
X-Received: by 2002:a05:6a00:2196:b0:878:3538:8f77 with SMTP id d2e1a72fcca58-8c87c6701c8mr9415691b3a.37.1795416475541;
        Sun, 22 Nov 2026 22:47:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm5152686b3a.4.2026.11.22.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:54 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:54 -0800
Message-ID: <5ec374e9acccdbb5422291d106bd9ea9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
In-Reply-To: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com> <auI4Qq1KUo7YYVtG@zenone.zhora.eu> <auo-JCn9VES7OwX5@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andi,

On Tue, Nov 03, 2026 at 12:04:29PM -0800, Dmitry Torokhov wrote:
> On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> > On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > > protocol function table to include the length parameter.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>
> Andi, so will you be picking up the patches affecting drivers/i2c?

Gentle ping on patches 1/8 and 2/8. Will you be applying them to the i2c
tree, or do you expect me to queue them through my tree?

Thanks.

-- 
Dmitry
