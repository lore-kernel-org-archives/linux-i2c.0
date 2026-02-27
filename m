Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6063AEF2B;
	Fri, 27 Feb 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182747; cv=none; b=mxVg5UjcFLQeXL6uBNyM0FAhDDEbhbe+JfvrG6k477W1Su7oVvNAInt2okQMIIsyqUo0uLrphEy72+8OGnhSfDVqLlDlO8Bj/yTD3UowH38mZKCcgdFRDR8KFb0tLGSTzVVeBEHIK/sibJ6PlWRaQ2102l8b4G6rHwswb20b7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182747; c=relaxed/simple;
	bh=VzY/ze97VjQJB6pusfmZwjsA+pOGa2Ehm/PhEEoeuXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW1LsdBpOebAKFLrhPauML+GxNp2wDicWXva2BSOQegSM0hYbwjSn5V0+QKvU+DH/nAT8xJBPzZjaDfC2gM+jEYZF+3y8KjCAE683mG1qi/TpkarcaCywvzRqkgf3QXhAeiIMi7HopJ7GGJCoO0iAzAQOLkDi/DQsm2MEbMtA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAEhKUUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAEhKUUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3918C2BCB0;
	Fri, 27 Feb 2026 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772182746;
	bh=VzY/ze97VjQJB6pusfmZwjsA+pOGa2Ehm/PhEEoeuXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAEhKUUK1BXG9J99lnYRvccU7OFWmcACPC8G9rjuzLEiFAB2pFKgNDr54l7D9w7aY
	 xSx557fMzTqXOTN8Kd/9smGEiItjVaMfSsC/FVg+l0Ja7O5Y5AFFDboPmD3blrTLBc
	 qCpF0Whlvi8V/CSgBZSgfiu2Wu+JrwNu+N6eY65JcwI3csJVwuRyHs/glM0nZ0lbRv
	 1WyAUrwiutxoCbarTjTNR2oXy2mPIL5AwjVCagk1Hpn5C+PSAovHSd+tXGxkLdH9ju
	 ePuzH2Ur7TfopAXlAuB1pO5xVPa1dQecHrZr/EP44S+wpOCuPcj249WAdenNAENoJ+
	 vi95mzuN0VLqg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vvtg3-000000001ZV-3EUL;
	Fri, 27 Feb 2026 09:58:27 +0100
Date: Fri, 27 Feb 2026 09:58:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFcs1miP88QWmtH@hovoldconsulting.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>

On Mon, Feb 23, 2026 at 09:59:29AM +0100, Bartosz Golaszewski wrote:
> It's been another year of discussing the object life-time problems at
> conferences. I2C is one of the offenders and its problems are more
> complex than those of some other subsystems. It seems the revocable[1]
> API may make its way into the kernel this year but even with it in
> place, I2C won't be able to use it as there's currently nothing to
> *revoke*. The struct device is embedded within the i2c_adapter struct
> whose lifetime is tied to the provider device being bound to its driver.
> 
> Fixing this won't be fast and easy but nothing's going to happen if we
> don't start chipping away at it. The ultimate goal in order to be able
> to use an SRCU-based solution (revocable or otherwise) is to convert the
> embedded struct device in struct i2c_adapter into an __rcu pointer that
> can be *revoked*. To that end we need to hide all dereferences of
> adap->dev in drivers.

Again, this is not the way to do this. You don't need to wrap every
access to struct device in random subsystem specific helpers to address
the lifetime issues. You're just creating a big mess here for no good
reason.

I asked you to show where you think you're going with this because none
of this looks right. Same comment applies to your other series.

Wolfram, I noticed you merged these last night. Please think again and
let's discuss the end result here. There's no question that there are
lifetime issues in i2c, but this is not the way to solve it.

Johan
