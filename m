Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E74A23;
	Fri, 23 Jan 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769204202; cv=none; b=okdBBmZpkivcIU1C6Jbj/ULYI0J7MbvgC8BjcTMqV5ea3Mhp+NVs5PwWig/yvEQCfusFoPIIkw+kunJqlVEsFY2lTCFEfPdV7703gWhXzGo7pCQGnKx8oWtT33IvZJfsexTkYd/SffDYBSaBMVxTA+DmOXRES9A4R2MYVDwEVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769204202; c=relaxed/simple;
	bh=x2LAiRqR6EDrqBuoKVi3HpedqQmMfCUH32g2lYbrQAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaZHnaBceNZQmr/hOUaj1O7E1PftPabbzR4SnAq9+Ln7nbLrr5u2mN/uuC8L4K+Z6NElxCLO65UaEf96o91+tYM8SUd0T4aNY7Q3UMq7Sq3vTvmabGyC7gjFSa9GQnlGqLInymy4zq0zDZW17UHFTmyQWuKouYQrFiVAl47r7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BX5mGMPB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BX5mGMPB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZDCZQ5Bx2m/hozseby+L8V6oMcAYkBTg1dTRmAtNL6w=; b=BX5mGMPB24nuL1NlQnNCF+KgZE
	kJDJeAQCHb8BUiRU68GCMzkd9PYMnlLDptisUqwewAs0pE7w2v2T1sypz92eiYIkyVXvL5D591jyH
	dY/qsa30rnwS+CpFT9UAZITj7uYjTbVcep+R7xcqoN0Jazo335f7zlyhZlXsGcQyBiPQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjOpS-004LEM-Hs; Fri, 23 Jan 2026 22:36:30 +0100
Date: Fri, 23 Jan 2026 22:36:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] i2c: xiic: switch to managed version of mutex_init
Message-ID: <df4e0611-ce76-464c-be01-e3802b04877f@lunn.ch>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai>
 <efe4e155-e307-481f-8332-783cca8a098a@lunn.ch>
 <CAGYn4vz3YuJ251JZFk7M=wsJr=bMY0Wq7x4Er=mjS_spyT5jLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGYn4vz3YuJ251JZFk7M=wsJr=bMY0Wq7x4Er=mjS_spyT5jLA@mail.gmail.com>

On Fri, Jan 23, 2026 at 12:20:54PM -0800, Abdurrahman Hussain wrote:
> On Fri Jan 23, 2026 at 7:22 PM UTC, Andrew Lunn wrote:
> > On Fri, Jan 23, 2026 at 08:02:45AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> >> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> >>
> >> Simplify the error path by switching to a managed version of mutex_init.
> >
> > How does this simplify the error path? You don't remove anything from
> > the error path.
> >
> >     Andrew
> 
> 
> Thank you for the feedback. In v4, as suggested by Andy, I introduced managed
> versions of the pm_runtime_ functions which do simplify the error handling.

But this patch is not about pm_runtime_, it is about a mutex. How does
this patch make the error path simpler? Please make sure your commit
messages are accurate.

     Andrew
