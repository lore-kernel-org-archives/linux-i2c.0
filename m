Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D272D73BD;
	Fri, 23 Jan 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196248; cv=none; b=inS7FbZ/1aCv8mM2f6aEd9GXCXcXALXxifvaLHrcU7yB/D2xz6rBcYZRRtn5ukP+mDEx5BX3OkILAJbBVqrS1OtNu0exs/30pohRK9hP35f3/zFJWB1vOzUTvhvlzP7ZzwKB1EMi3+YutWdOxzw8aYd9cbfB0Na97V3kKFty1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196248; c=relaxed/simple;
	bh=YArN0NF1IlErXQGz8X6IZHLMdfKaTfVKHrxtF2szcec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/XWUcfC94dCirpU+QINdyn0/QAdAKvHMUXkra34FKc+rW3zarnCs0XvDo8P4MTSrTfD8WAFwk++Lvh1YuW9mft4CHVWQ8T+r0zufLG0Z8h5+8+lxpoVIh7n+qM0e25ivJ09J2sk1+GJ7iVyLcd8X1AOMA+DmwSmzlXYDhuED8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4p86Atou; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4p86Atou"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DvXfZlOozy6AmZQMM6N9RD72xpgXTKLHQJoVq/ukbsM=; b=4p86AtouThwVJkVgaeajvN+sjT
	dBY779R8W1pYQJgiYMpAdNCUQAajUSfw9VfxG1LOP/8y+cd+wrPTo9W3jvAW3815Pkr5cqlxLNKoG
	jEKPuSPqTxUJeU2Ve0hyivbPB7kQmd8/sVxlU6/FzL5OTQqzzmh5FBM6bXGLAVqEdvzQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjMkz-004J8k-7J; Fri, 23 Jan 2026 20:23:45 +0100
Date: Fri, 23 Jan 2026 20:23:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] i2c: xiic: remove duplicate error message
Message-ID: <76bcf983-30e0-4bbb-aaf8-a1763373484a@lunn.ch>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-3-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-3-eb7cd4254dfb@nexthop.ai>

On Fri, Jan 23, 2026 at 08:02:46AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> The devm_request_threaded_irq() already prints an error message. Remove
> the duplicate.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
