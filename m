Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874F2E7635;
	Fri, 27 Feb 2026 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186764; cv=none; b=cjOQF2qa4gcs5uBQ88Hm1B8jIXXWDgxCe2C6OV/ob7ZTSJhQKCba9UkomTdM+as9cBer3sefmx0vtslf9B7r3sjPESlYem2Kou4SFqOjDCEvhblpugbJHa3IHC3fGHbHdlO4S2KkGL80sEgQntucLy2pCVtwn9dhV5Q1bSZisBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186764; c=relaxed/simple;
	bh=g8f6lyvqvkopdOsANRzZGlHrXaOkJBu0JPpZhwX5M7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2JeFJ2+Kyv1aGBK8wRBjPMQOq5TL25EcZfEOzbQbyW09uS2LN3DOUVwAXFYH71eEeVb2Rl2YRaxYF3FGhaydSbdsOb7dIldseL0lb2deKvJn+VVuEJN9T5hs3sUkTA5qE1LizYZn/p2quaQA5X9I64qcSEFeGmEkro4/DUSCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA6BpxXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA6BpxXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59527C116C6;
	Fri, 27 Feb 2026 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772186764;
	bh=g8f6lyvqvkopdOsANRzZGlHrXaOkJBu0JPpZhwX5M7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KA6BpxXqIQtvhRJQdxeyUdvh8qnuCG2MwP7HMeafULwbKoZynqIvEQBkLHp9aZGK0
	 2oLKsaZ1WAC1gSwDjpwlGilTDG17yKZ26o1IppOdmKcABFxAjpIXVOJIynO7C2axOH
	 YxoBp2vE+TGq6f7+/hhaKae3sDsCZppNsiskCFDz73pp8KIaqjcHkHMaqA0q5sY1ou
	 exQVqox+NTjea/w0RSIXOSix0uh70nSe4nBxuW16ckfJVRMzQGZyB70JK0Z8+LH3/K
	 0ZKBjpmAdcl0WLsvRezNg53bkP8AVI2HOmeJbmpWThnBUWOaQpN4A9DebRoY4Y2x0J
	 GomXPlN8wjOuA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vvuir-000000004gQ-242t;
	Fri, 27 Feb 2026 11:05:25 +0100
Date: Fri, 27 Feb 2026 11:05:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
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
Message-ID: <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com>
 <aaFfEsfh0xTh0b1y@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaFfEsfh0xTh0b1y@shikoro>

On Fri, Feb 27, 2026 at 10:08:34AM +0100, Wolfram Sang wrote:

> > Wolfram, I noticed you merged these last night. Please think again and
> > let's discuss the end result here. There's no question that there are
> > lifetime issues in i2c, but this is not the way to solve it.
> 
> I did think again and do not see a way how the life cycle problems can
> be solved while drivers happily access the device struct of the adapter.

There's nothing special about the struct device. What matters is that
drivers don't free memory that's still in use by the core.

> Whatever the solution to the core problem is (revocable, custom SRCU,
> something else), I still think this step is needed in any case. If I am
> wrong with this opinion, please enlighten me. Pointer to some existing
> thread is OK, too. I didn't have the bandwidth to read the revocable
> mail threads.

It's not even about revocable or SRCU, that's just an implementation
detail.

It seems all that is needed is to decouple the struct i2c_adapter from
the driver data and have core manage the lifetime of the former using
the reference count of the embedded struct device.

Then you can use an rwsem, SRCU, revocable or something else to handle
devices going away while they are in use.

Johan
