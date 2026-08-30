Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5457C9F;
	Sun, 30 Aug 2026 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788065759; cv=none; b=Jx//Dqa01GekkAwJ+nBswmf4IizzEiVlpD7BqGWQQU2HDfhAaOq97dEtC/XQIphBBaFtqJvuv+O19oi1vbxwyQO8MVzF59ohqV/vPHDtwPX3453oubXHqtyi+YGz/CM4ubQRG2/78row/psnKyqv/SgO8UxmeSKOXNZi+rzWVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788065759; c=relaxed/simple;
	bh=vwG3ABwS/raQIcS/TkWs1L7CD1G0QFFA00S8295M+Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIPiEHj01mHouTmWyyJGV8BunftDHZn6KqXIKT1c16kjwNxn2+3QYfVMvXk1J//bdYJmP6TKQ3jV55lPFfGhsbUbeF4TV23nQANzzIeCJnONEObOvO1gj4rsICHvjKqKQa6V4mRiQfdJ0/yYsVwhlcgB24XV4iORcn51IktAeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=t89OxvEy; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=MeCdeHqn; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="t89OxvEy";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="MeCdeHqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788065753;
	bh=vwG3ABwS/raQIcS/TkWs1L7CD1G0QFFA00S8295M+Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t89OxvEy+kmAHAx0vTWLimTRsjieWBrnG5e2+sTN07Dfzynd9gzq4OZt1fOXpgqmY
	 0RwNhVOijKqvByGV5aLh5mHBcH+3pM60GYPKvi8VExSYJC/uXP4NuP/5dUDhf9YtQH
	 cyOfADRwYTNLS79UWDDtLKfg/QvH2OMUsOSiZruV15czS4pFXq/dOdfxTkdt1rMuIQ
	 06CSDi7idwiBORbOtVSZ7R936ZKA0JkApcC/1GEig8nWs8w9cXG+xynWkO0v86Tvp9
	 c0WqV68zoAULX+LrmPg6NHWJhX3KeOAic1Qq7IGAqJrGuo06vN31wdY0zlPAOsjLkW
	 1KfFWDpZpoY8w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 194A29D91;
	Sun, 30 Aug 2026 06:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788065752;
	bh=vwG3ABwS/raQIcS/TkWs1L7CD1G0QFFA00S8295M+Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeCdeHqnilcbOEX//H8YLKr6VgGzGs7F0B/sE0P96ijArZqO6VaoBDN7bxuxFHT8Z
	 iUPL8rYCEm9AsK5+FfAVwcI/EvvsfqoKnKd5gbca7hQl1PHYx+lJJBRCP5wmls7OQU
	 E4Orq98bKPIa8FF6abUoe2JNEnvb6EHnnNUoKYJLshJ4++/MeVqYtxf8FxouEnBG8f
	 NA/thR6Z9I/rkLIG7n6X9fXum8QIQ1Jf0pFgo5Ek66bUUVy0F1xljfWGTWEvfc1kcy
	 cwNmy07r/EpsyZOBZpsUHQAGI6jWwbbaUFp3k1mx8foCT7lmzIMhs+AOXg1DiwUFFn
	 1N3Ob/zrqMBdg==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id BAEC99C55;
	Sun, 30 Aug 2026 06:55:52 +0200 (CEST)
Date: Sun, 30 Aug 2026 06:55:51 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ahmad Byagowi <ahmadexp@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <apO31ydKoiqWCEKo@gryt>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt>
 <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
 <ao_VE0W-FohWqPPt@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ao_VE0W-FohWqPPt@ashevche-desk.local>
X-Virus-Scanned: ClamAV using ClamSMTP

Den Thu, Aug 27, 2026 at 09:11:31AM +0300, skrev Andy Shevchenko:
> On Wed, Aug 26, 2026 at 08:29:47AM -0700, Ahmad Byagowi wrote:
> > Hi Peter, Andy,
> > 
> > Yes, software-node handling is needed for the ptp_ocp use case.
> 
> That driver is a mess. I'm surprised nobody told to the authors of
> the respective changes to look at the auxiliary implementation.
> 
> > ptp_ocp is a PCI driver. It creates its board-specific I2C topology at
> > runtime with software nodes: the mux, its channel nodes, sensors, and LED
> > controller. Firmware does not provide ACPI nodes for this topology.
> > 
> > The existing acpi_preset_companion() path only associates a mux adapter
> > with an existing ACPI child. It does not associate the adapter with one of
> > these dynamically created software-node channel nodes. Without that
> > association, i2c_get_adapter_by_fwnode() cannot find the channel adapter by
> > the channel software node, so ptp_ocp cannot instantiate the downstream I2C
> > devices on the correct channel.
> > 
> > Does this address the concern, or would you prefer a different way to
> > represent this dynamically created topology?
> 
> Wouldn't it be possible to use some kind of DT overlay to have that?

For me, the above is a bit unrelated to this patch series, which is
about converting i2c-mux from of-only properties to device properties.
That seems like a change that stands on its own.

I probably wasn't clear enough with my original question, but what I
wondered about was what regression risk that conversion might have
for the ACPI case. Specifically, there might be ACPI properties that
match what the code is now looking for. It seems unlikely that such
properties are actually deployed, but I know next to nothing about
ACPI...

TL;DR

My original question should have been: Is it safe to simply remove
these lines from the patch:
> +	if (!is_of_node(dev_node) && !is_software_node(dev_node))
> +		return NULL;
and let the code trawl all kinds of device properties?

Sorry for the confusion...

Cheers,
Peter

> > Thanks, Andi, for taking the first patch into i2c/i2c-fixes. I will drop it
> > from the next revision and rebase the remaining two patches once this
> > question is resolved.
> 
> > On Mon, Aug 24, 2026 at 10:50 PM Peter Rosin <peda@lysator.liu.se> wrote:
> > > Den Sun, Aug 23, 2026 at 09:34:38AM -0700, skrev Ahmad Byagowi:
> > > > Device Tree channel nodes are associated with the adapters created by
> > > > i2c-mux, but equivalent software-node descriptions are not.
> > > >
> > > > Use generic firmware-node operations for the existing channel lookup and
> > > > accept either an OF node or a software node. Associate the returned node
> > > > with the adapter so child I2C devices can be instantiated from
> > > > software-node properties.
> > > >
> > > > Save the adapter firmware node before adapter deletion and release the
> > > > reference afterwards, following the lifetime pattern in i2c-atr.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
