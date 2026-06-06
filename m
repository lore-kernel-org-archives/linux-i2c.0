Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04718264A86
	for <linux-i2c@vger.kernel.org>; Sat,  6 Jun 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783961; cv=none; b=lEysq72mkt7+LyocPqcAbRzIBye5cl83x/dOCnfoHMmY7/gzjP2JaVc1Q10EpWSQoHBG78u+4VYhwurxSSr900WlXQtlaEsqLlHOTrrWB/MKi0OuzfheQ4VlrlJnEFufCZ060B9of0PILrRDJiLIlS1YijHdz0nKSlsmEiqcRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783961; c=relaxed/simple;
	bh=6ouIglN1dYGLH3ysVCe4+WX5jGN+S8ZgysvlxN1jYwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAenPMjYY6eq8clWPWPVo87vH3SWC2HhoSE0GHVf5Ji1LNZuRtrjAP0JUWWsJ0flb2p33ZmDTFbJbhwCZkSC+/ozwEEHQxw6a1EBn5pjAE6gp4J4h3IAqvoCsKasfIQquxdOb6mg1MQ0volqNtm/HqVdAecMDTq710IfmRdgLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cAiwwYwJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cAiwwYwJ"
Date: Sun, 7 Jun 2026 00:12:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780783948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbFXk2aZ4jZwA7SF4tzAan7+rfchQ2otTlI3Ov4PpgE=;
	b=cAiwwYwJOUG2EG3jSsHA+Zz7BMC0lrJHBcH76S9G85JwielLFdCWHoX62rsUvmaQaAemmV
	zbdwe70+IR1Qf0pPk7SVlvRwLj7WxqWz3mgLZXKqWiGieeIqencjukHQZzwcq0f1gHpBDZ
	FEHHBCzADBNB1gCZl2YFYkLYr2NJMbE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] i2c: change return type to bool for
 i2c_check_functionality
Message-ID: <aiSbQ20F0GsQJqir@linux.dev>
References: <20260421161607.61314-3-thorsten.blum@linux.dev>
 <afhjp_ib0padlv5z@ninjato>
 <aiSRJups6bcEtb3U@linux.dev>
 <0b13ebc9-8781-46ba-9a55-cb4d54afcf1a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b13ebc9-8781-46ba-9a55-cb4d54afcf1a@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 06, 2026 at 11:58:03PM +0200, Christophe JAILLET wrote:
> Le 06/06/2026 à 23:29, Thorsten Blum a écrit :
> > Hi Wolfram,
> > 
> > On Mon, May 04, 2026 at 11:15:19AM +0200, Wolfram Sang wrote:
> > > On Tue, Apr 21, 2026 at 06:16:09PM +0200, Thorsten Blum wrote:
> > > > i2c_check_functionality() returns a bool - change the return type from
> > > > int to bool and update the comment accordingly.
> > > > 
> > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > 
> > > Basically OK but you need to fix the in-tree user first using the 'int'
> > > behaviour [1]. I'd think you can send it with this patch as one series
> > > and have it go in via the I2C tree, but Lee has to agree then.
> > > 
> > > [1] $ git grep 'i2c_check_functionality.*='
> 
> I think it should be git grep '=.*i2c_check_functionality'.
> 
> > 
> > In linux-next [1] shows no more results and I believe all have been
> > converted.
> 
> Looks like:
>    drivers/gpu/drm/bridge/sii902x.c:       ret =
> i2c_check_functionality(client->adapter,
>    drivers/media/i2c/isl7998x.c:   ret = i2c_check_functionality(adapter,
> I2C_FUNC_SMBUS_WORD_DATA);
> 
> need care.

Those have also been taken care of with some Reviewed-by: tags, but they
aren't in linux-next yet:

https://lore.kernel.org/lkml/20260517172136.3321-2-thorsten.blum@linux.dev/
https://lore.kernel.org/lkml/20260517172034.3033-2-thorsten.blum@linux.dev/

And the conversions are not strictly necessary since 0 == false.

Thanks,
Thorsten
