Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013127703C;
	Fri, 23 Jan 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196169; cv=none; b=W3acm/IBQ1rfpE7QC/wHpKSBe0KMn6wTyqL2WtNhUPsNnNBaPflmXsU/6TbLARKXxsqAzDPexGPi0J9HXTAt7SUzVpIZ8YkT9VevdDv6Tbu3WcJBccD4M7MuFgpjEbW+lnxW/5hIvFKYcz48QXo0j0xprMO7dHbvLNengNORHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196169; c=relaxed/simple;
	bh=A9h4IebXuXmXugYEt77mCEpTli752uofMKz0qMtX9WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFa90/3Qne4YrY35/wFPiErubKIIz/5jFA+rnobT4Tq33XyQPnwfOosg2xzu0d3/MXcpgsm4jDArDQU9CyBQxEcM6xymlXUtwQf4K1AntoW5/PI0WCrCd2nxglKkztHT9VlYA4uTFeXj+fOpT/ut73vA6AWYktpvKe6BInKPPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MXxG5OYT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MXxG5OYT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vfdAr6yiQHzT/EvQk5HAzn01nEaiq1Hdxokp7g8SKi4=; b=MXxG5OYTPAyb0MSLh6PnTi/iE0
	s/kfOiHMNI9zKzvXFHWpLQdcYmebVWcq3salrptoxTXZW5td2+th+8qnqJDB33QPboR9antKCW8Uv
	hy+p7i6aZKozpDy3u8ryqyqBTl1pCtgbEA2VClck671Cow9HpsmwW5ahYx6jEHc6OCPE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjMjv-004J6B-20; Fri, 23 Jan 2026 20:22:39 +0100
Date: Fri, 23 Jan 2026 20:22:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] i2c: xiic: switch to managed version of mutex_init
Message-ID: <efe4e155-e307-481f-8332-783cca8a098a@lunn.ch>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai>

On Fri, Jan 23, 2026 at 08:02:45AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> Simplify the error path by switching to a managed version of mutex_init.

How does this simplify the error path? You don't remove anything from
the error path.

    Andrew
