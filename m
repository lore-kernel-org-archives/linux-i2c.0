Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BF81724;
	Wed,  4 Feb 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168291; cv=none; b=qEyFp259AaDiX99buE6u28+Qk0VZWkd3iehVCVeVv7KzDiI5WIj5F13mZBEdljMFt7pIGT4UBEhvkrmj3ibANekLs/RlgVPzqgvy121UxTOEq2h0K9iqOopIprboQwI6r2HxZBCbcl9SZjDuzTqgkplN6jYmEKaobJSf+5ZYYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168291; c=relaxed/simple;
	bh=9NQ4pYJZzXZxB0prHhOgxU25gF7J+7dtfLyhZiTdkx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V24qYCKZCW8l8nvuvvqJUllmvcMBd5JbTQsoVzB/bZphUFPPa5+pe0pEIkY4n7L53swnHFJkRnBVDR9cq5+0y8bUy3uWHBYjK30pp3wHzEUdJ3pGkIIbBnPiHPhLNW7lubQE+fJ5jBvIsX2kugkZ2imxEGI0jRM0SUm8CN5bTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PufZMXuM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PufZMXuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D971C116D0;
	Wed,  4 Feb 2026 01:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770168290;
	bh=9NQ4pYJZzXZxB0prHhOgxU25gF7J+7dtfLyhZiTdkx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PufZMXuMRWm+sNOdFD6+ejHcKo2dRYQY2RN4H1hMoB3ViMYRxNonX2kFQQpH6c5Oz
	 Fj1DOR8EjesAIZZ2uFtLqMGglLYZwHxOzcFYJImLIJlFMlS7hW5r10qnKefzwD05rG
	 9VTfD7qg9r/rHXTv9x43AZryZaOgw6OYnZ56Jo7XUPErYMPc46P3yHh5jNMrZscVnh
	 Ke0YNCVaqXHaqSvYk7LXSWf5LgGJXwNfCQtOhuhtKUa0JLwePgWP4UMektVv6cDz1D
	 hgxJ+yB3oovL1HaT78F3PoXoed7k8qt7/uHYsF719BdbH8YrKavmYfeuIfIFKcQyRr
	 Nxc6/eooEmWAw==
Date: Wed, 4 Feb 2026 02:24:47 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6 0/3] i2c: designware: Improve support of
 multi-messages transfer
Message-ID: <aYKfnaQIgZT_odux@zenone.zhora.eu>
References: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>

Hi Benoit,

> Benoît Monin (3):
>       i2c: designware: Implement I2C_M_STOP support
>       i2c: designware: Use runtime PM macro for auto-cleanup
>       i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER disabled

merged to i2c/i2c-host-2 for the second part of the merge window
pull request.

Andi
