Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547725;
	b=uDf8h7LibfIgD5CKAr56Kp/10mj5yDMtPI7CsydnaIjZGJNhtsZVCo0QJuAokGawEdQI
	 Of4MrYhYcN4EJnDaxn5U1aJfz+ormnUMmPc0aRZOUt41s1MrPBuaZ6RMzC4V8kCwWDMCB
	 ct3136l1rcLlxHGKt94ZZ2mG97VGY6reeRdRvib9e2QbNDMRrXwpxklw95ej09PVXo6HE
	 BcOxRoPxHMWjrxjL+g+nZUqaPnuHAlC20kYbyYoG+F2uwjDnMcGOTRIZynkZZojnKbAL6
	 l1wJhSYB1ghdJyiQWweATQxcdh5x9I5svg3+GYigGFBZb3lNgnqFlAS1OXPS/wkM/ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547725;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=5YJOISa85c8XY87lgejAtJgrxjDeC85yyty9hA0DTew=;
	b=SDK+Zt+W5O2tifoXbs3tyu0u7xFKizxTHWc9brvbiDulZD4UjbZ21TecNyoJQHBgbruR
	 KYZrfnQV+Z0w95EB+Ec7sArQh5cSGmLLusqnrtwiGjUGoP7PN2vC238CdrGGHPY9X5TW8
	 SMFoItjDheYecDe6aTQKG7yxq20Ec5SuIguFBfUYS2GbM0zZDqR4IS6nJdMd1YPd9jtsd
	 1pvzmYQ4xECE2qJ1zIEH+/ARmHYzYTGOolSUDONTSnqBkhc1U5oB7qiBrrFhf0QroxCKN
	 MFdS/Hg5x30FHvz35UdxWNgRtjh5rQDu8AJlrbCNx0KxLIrJeUE+E9C5eeibdSM5Ccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QydDIIie;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027B606A324;
	Sun,  1 Nov 2026 15:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B027B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QydDIIie
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5YJOISa85c8XY87lgejAtJgrxjDeC85yyty9hA0DTew=; b=QydDIIieE2+04feUam0hml1fSo
	1uAoPoaVuBM5jqCx/clrx+yTbfkX/HxbgpyvYkEp4tqEJCGnJ/BIQjvlQ+N0UcicWEtbDcRxBEWa+
	eS3w9j88Qq5xBCax6+UXdKwkjs5EfFKzndLbcIetCThrolfcEmUnFTJOk6zqft2LWmX0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNXh0-00De2D-Ix; Sun, 01 Nov 2026 16:41:58 +0100
Date: Sun, 1 Nov 2026 16:41:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Peter Korsgaard <peter@korsgaard.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: delete adapter before disabling controller
Message-ID: <2ebf2d74-4e2d-40a9-8dd0-81bfa5ac9cb0@lunn.ch>
References: <20261031033240.2491016-1-matthias.goergens@gmail.com>
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
In-Reply-To: <20261031033240.2491016-1-matthias.goergens@gmail.com>

On Sat, Oct 31, 2026 at 11:32:40AM +0800, Matthias Goergens wrote:
> i2c_del_adapter() unregisters child devices, and their removal
> callbacks may perform I2C. Delete the adapter before disabling the
> controller so those transactions still work.
> 
> Found by Sashiko AI review.
> 
> Link: https://sashiko.dev/#/patchset/20260813153155.3953577-1-ruoyuw560@gmail.com

Please take a read of:

https://docs.kernel.org/process/submitting-patches.html

This patch needs a Signed-off-by:

     Andrew
