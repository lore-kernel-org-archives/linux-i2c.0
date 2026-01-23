Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925092853EE;
	Fri, 23 Jan 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191946; cv=none; b=T6mnXKCoirUklAw7cScsQ/kufnLsP3nS5MWZ3Errx6LCJGjTzenjO2gga68ke+Lp6ebsPi0q62alrfOynneeOYarzj1O5y/ha5tzpY6jSRDQTdDmIKC8RfTS3f5fTwN04YqGIDoAu3xtwY5ed+8lIEtVyXOgr4RJuxDLvm3WJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191946; c=relaxed/simple;
	bh=O9l1jnqIpHtohrFeoVZWBi1YBCtujHSrLLewdSng+JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdCqe6c8OJzBFjNOxHmsnaVGBn3MhUQ5lGbz2BawRt6r8t5hf9tlALJHHCrn1AobmrqhBxtADQisv4SJh/AS1cvlCNl5YcV1SydvaGAEYbVRjXgOzmnqJbd/NG1wLCNSjf/3VjPruKJBOxyLdChGLydUivUDx2JN3QMpKRoBjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbVGd4tg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbVGd4tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FBCC4CEF1;
	Fri, 23 Jan 2026 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191946;
	bh=O9l1jnqIpHtohrFeoVZWBi1YBCtujHSrLLewdSng+JQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DbVGd4tgJ0d4gQtTSeU3zXhF4nPDiFIHEbOmelxDABDr7WTVRBBpr/V5pj6/0SdOK
	 +7lNLmpEfa6tFKbq7a5F4a6cIpjMwe2e/JWLQYYAY1qox5qp66xmONo8DzrNhhDEQJ
	 QYMedCnBlkkZL1Kdn0ar/2ecTzp0le+5O5Vg4k3ZzFchrvQc4wURivHTkKDRyfhjdt
	 Sgf2r4OImgmgvlFHff1WACVh6LNjQHHdEA7uaAd+NoWxC/iVhGDXth00lpWXtbPeQi
	 mIHAndsrBBx2Hor3Q/ZYn8yBDvvXzDHxioUDGBuBDftl7fgi6IJZm5PSfnfwVpU90/
	 SnGgrDEHmiCVw==
Date: Fri, 23 Jan 2026 10:12:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Matt Johnston
 <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
Message-ID: <20260123101224.350a5017@kernel.org>
In-Reply-To: <aXM1WKi6L8PAAN2F@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
	<20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
	<d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
	<20260122080526.4fe83a3a@kernel.org>
	<9fa316a1a4b16e9f4e1601beeebc5a5e42232dca.camel@codeconstruct.com.au>
	<aXM1WKi6L8PAAN2F@kuha>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 10:46:38 +0200 Heikki Krogerus wrote:
> > > +1 I don't wanna speak for Jeremy and Matt but with their Ack, and
> > > assuming there's no dependency in net-next I think i2c tree may
> > > be the easiest path?  
> > 
> > Yes, given this is more i2c- than net-related, I would be fine for the
> > changes to go via the i2c tree there. Staging the core via i2c and then
> > (subsequently) this one via net would also work, but seems to be
> > overkill for a minor change to the net driver.  
> 
> OK. I'll drop this one from v3 and send it separately later as a
> follow-up, once we have the i2c side ready.

FWIW my reading of Jeremy's reply was that we're okay with these
patches going via i2c, so:

Acked-by: Jakub Kicinski <kuba@kernel.org>

and no need to drop this from the series.
