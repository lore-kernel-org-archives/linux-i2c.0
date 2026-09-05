Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21D61FCE;
	Sat,  5 Sep 2026 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788587212; cv=none; b=H7rLl+rW2R0gM+i4v/fumvvQOTmdTFAr+P1/EM9HcS8c92sEL5oBCvB1NFQ0LQQy9o5zUWOVwnBcyLGmBdxului8qfWVV07o00oEGaLkvYTHqwhIc4KZQj0kRhirsOd6IbfsH6QtyxkaUTksscWSMmr/0NNdcpxmL/9Ti56pGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788587212; c=relaxed/simple;
	bh=vzirXV3YRTUsE9Pet37gIC9ZEJyZc/pn+LekQDQJDGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8PW2H55/UIiulf2al+KPPb2PhIAro8MdbHkkDjKWd+GzO2cVU6Cg0ZpL7DZcF2EMcPrA5IwWSOb6b9TxjgV4pcIF5XcTecG2Hql8XdJsc/b/lLlQbTiyUQY6dUW0s3WQfYiqXzZw0+J0PJpq7bFv4G4oC7SM/etixMtmCcGXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=uee/Ekt5; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=uee/Ekt5; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="uee/Ekt5";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="uee/Ekt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788587198;
	bh=vzirXV3YRTUsE9Pet37gIC9ZEJyZc/pn+LekQDQJDGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uee/Ekt5am6ThNvkulDNjzTZ6dr5tEFuy2T0CaGKwanKxoid0Vo2HpguHyKcU8yy9
	 Wr4QCAMKTT5bPKTHTKrM8w6BhLayipI4m/onE12HywF5s7D4DQ703Xc6VvSvv8AIY8
	 mSSArDKG2LOW5yqlWweO3mfsswggxPbrtyKSBlCTw6eJ94bvqzwHl1zik3wYfuZg4M
	 CmQ2DfqK1fqS09BRj+Z/H6Sr1B9NnW802wF8Pe39F1zLZkgr7kjzXhezjAMX66yWqo
	 usiQymq2lHKYovasi+KBnIn0WotYbVwVdWUl4PaTaczllVT6Xzcxa3A1I1qs4ef7QK
	 /qhfOCinj9ttw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A00523557;
	Sat,  5 Sep 2026 07:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788587198;
	bh=vzirXV3YRTUsE9Pet37gIC9ZEJyZc/pn+LekQDQJDGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uee/Ekt5am6ThNvkulDNjzTZ6dr5tEFuy2T0CaGKwanKxoid0Vo2HpguHyKcU8yy9
	 Wr4QCAMKTT5bPKTHTKrM8w6BhLayipI4m/onE12HywF5s7D4DQ703Xc6VvSvv8AIY8
	 mSSArDKG2LOW5yqlWweO3mfsswggxPbrtyKSBlCTw6eJ94bvqzwHl1zik3wYfuZg4M
	 CmQ2DfqK1fqS09BRj+Z/H6Sr1B9NnW802wF8Pe39F1zLZkgr7kjzXhezjAMX66yWqo
	 usiQymq2lHKYovasi+KBnIn0WotYbVwVdWUl4PaTaczllVT6Xzcxa3A1I1qs4ef7QK
	 /qhfOCinj9ttw==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 585E835D8;
	Sat,  5 Sep 2026 07:46:38 +0200 (CEST)
Date: Sat, 5 Sep 2026 07:46:36 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ahmad Byagowi <ahmadexp@gmail.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] i2c: mux: Factor out channel node lookup
Message-ID: <apusvKc2PnSShaoI@gryt>
References: <cover.1788298883.git.ahmadexp@gmail.com>
 <89780f7db207c7fe7adbd45e1f38f0a041794c8f.1788298883.git.ahmadexp@gmail.com>
 <apnRfWVAiXj1fRXs@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apnRfWVAiXj1fRXs@ashevche-desk.local>
X-Virus-Scanned: ClamAV using ClamSMTP

Den Thu, Sep 03, 2026 at 10:58:53PM +0300, skrev Andy Shevchenko:
> On Thu, Sep 03, 2026 at 12:40:55PM -0700, Ahmad Byagowi wrote:
> > Move the existing Device Tree channel-node lookup into a helper in
> > preparation for using generic firmware-node operations.
> > 
> > This is a pure refactoring with no functional change.
> 
> ...
> 
> > +static struct device_node *
> > +i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
> > +{
> > +	struct device_node *dev_node;
> > +	struct device_node *mux_node, *child;
> 
> Now all three can be defined in a single line.

They could, but three is a crowd. So, if you bother to send an update,
please use one declaration per line instead to make future diffs
clearer.

Cheers,
Peter
