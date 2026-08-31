Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F823C1F45;
	Mon, 31 Aug 2026 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160421; cv=none; b=IiPz8hxdgStkuJyI30T5W7UqwD3AeZSsWVe4MY04N+3dV70V2EOZQxhzVn9aWAfSxmqaB29JRirz35hG+h241CoruIj3apwk9gk4tKqMrm9rdo4p6H6CghsC1+Ly0W4/XoVHTZQ5BD7CZsPH5neeULIsTk3cuIFIFuiCDkHWQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160421; c=relaxed/simple;
	bh=81zt51gCWR1tyk2rnkv5sTc2enngcXrsEszby0tfe/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMOfhekKbNmv5H7CZBmvuqU+hgzxyVxqw4BOAqZMxlbirphWtDbeZYKT/VCyXzuWJhlzYGlQiY9iumA2vvwVUX8SdzxBe4WvFRG49oANqBBLuRlGyWlADxhCbsVhNU9Z+QK561vUaRIRVjkbsx2mRsr8S/qclxk5qICAqOwob1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=WSV21sN/; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=WSV21sN/; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="WSV21sN/";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="WSV21sN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788160415;
	bh=81zt51gCWR1tyk2rnkv5sTc2enngcXrsEszby0tfe/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSV21sN/JivHfsTG2BSAGE1hJnM/xM8FgxUB1xYhKIcItXatsZwGwg3a9oFvdBNgB
	 Yg16lFrZW1LkC6/bL1DiGgWyHOMR+9+21ATbmudj06sLhUcl2W8YuFeeNl8TM1Fqwm
	 t6ViST4lHQqAezq8gpXRh9K2mBRbOzwdSsoxQJhifeWtgEVqpam2RSQwoIbK23p9zn
	 cYx4t0yLYsbyVPmA1Opwc8Cua5CNrD4+aQ/fRHf555QbdkEKpGQ57CW6WGwrugNreo
	 AnmK8eH9Cnd9/yfdXflScOExixeNPvzvdyl8z82PT4xvsikO/6K1MI6WOqBZr4xxMd
	 CxvwRDre0Ldzw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 93285E4DC;
	Mon, 31 Aug 2026 09:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788160415;
	bh=81zt51gCWR1tyk2rnkv5sTc2enngcXrsEszby0tfe/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSV21sN/JivHfsTG2BSAGE1hJnM/xM8FgxUB1xYhKIcItXatsZwGwg3a9oFvdBNgB
	 Yg16lFrZW1LkC6/bL1DiGgWyHOMR+9+21ATbmudj06sLhUcl2W8YuFeeNl8TM1Fqwm
	 t6ViST4lHQqAezq8gpXRh9K2mBRbOzwdSsoxQJhifeWtgEVqpam2RSQwoIbK23p9zn
	 cYx4t0yLYsbyVPmA1Opwc8Cua5CNrD4+aQ/fRHf555QbdkEKpGQ57CW6WGwrugNreo
	 AnmK8eH9Cnd9/yfdXflScOExixeNPvzvdyl8z82PT4xvsikO/6K1MI6WOqBZr4xxMd
	 CxvwRDre0Ldzw==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 3736AE599;
	Mon, 31 Aug 2026 09:13:35 +0200 (CEST)
Date: Mon, 31 Aug 2026 09:13:34 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <apUpnqAQQfWaflS8@gryt>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt>
 <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
 <ao_VE0W-FohWqPPt@ashevche-desk.local>
 <apO31ydKoiqWCEKo@gryt>
 <CAOQiBWN5DgOcJ9Gg7s2GZmpQguJUh121Jn9yUzxxm=D530c8dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQiBWN5DgOcJ9Gg7s2GZmpQguJUh121Jn9yUzxxm=D530c8dA@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

Den Sat, Aug 29, 2026 at 10:10:40PM -0700, skrev Ahmad Byagowi:
> Peter, thanks for clarifying.
> 
> The check is intentional. Without it, the generic traversal would also
> inspect ACPI firmware nodes and could match _DSD child nodes carrying
> a "reg" property, while the existing ACPI path below uses
> acpi_preset_companion() to associate the adapter by channel address.

Yes, I got that. The question is if the precaution is really needed.
Are "reg" properties common in ACPI nodes?

> I have not established that changing the ACPI lookup behavior is safe,
> and that change is not needed for software-node support. With the
> check retained, OF and software nodes use the generic lookup, while
> ACPI continues to use the existing acpi_preset_companion() path
> exclusively.

Yes, I figured as much, which is why I directed the question at Andy.

> That said, I will clarify this in the commit message for the next revision.

I'd rather tweak the check to exclude ACPI (instead of including OF and
SW) with a code comment about why ACPI is excluded. That is, if it can
be determined that ACPI actually needs to be excluded. If it is hard to
get an answer to that question, I'm inclined to just attempt to not
exclude ACPI, and then be prepared to exclude ACPI in a follow-up if
there is any fallout.

Cheers,
Peter

> 
> Regards,
> Ahmad
> 
> 
> On Sat, Aug 29, 2026 at 9:55 PM Peter Rosin <peda@lysator.liu.se> wrote:
> >
> > Den Thu, Aug 27, 2026 at 09:11:31AM +0300, skrev Andy Shevchenko:
> > > On Wed, Aug 26, 2026 at 08:29:47AM -0700, Ahmad Byagowi wrote:
> > > > Hi Peter, Andy,
> > > >
> > > > Yes, software-node handling is needed for the ptp_ocp use case.
> > >
> > > That driver is a mess. I'm surprised nobody told to the authors of
> > > the respective changes to look at the auxiliary implementation.
> > >
> > > > ptp_ocp is a PCI driver. It creates its board-specific I2C topology at
> > > > runtime with software nodes: the mux, its channel nodes, sensors, and LED
> > > > controller. Firmware does not provide ACPI nodes for this topology.
> > > >
> > > > The existing acpi_preset_companion() path only associates a mux adapter
> > > > with an existing ACPI child. It does not associate the adapter with one of
> > > > these dynamically created software-node channel nodes. Without that
> > > > association, i2c_get_adapter_by_fwnode() cannot find the channel adapter by
> > > > the channel software node, so ptp_ocp cannot instantiate the downstream I2C
> > > > devices on the correct channel.
> > > >
> > > > Does this address the concern, or would you prefer a different way to
> > > > represent this dynamically created topology?
> > >
> > > Wouldn't it be possible to use some kind of DT overlay to have that?
> >
> > For me, the above is a bit unrelated to this patch series, which is
> > about converting i2c-mux from of-only properties to device properties.
> > That seems like a change that stands on its own.
> >
> > I probably wasn't clear enough with my original question, but what I
> > wondered about was what regression risk that conversion might have
> > for the ACPI case. Specifically, there might be ACPI properties that
> > match what the code is now looking for. It seems unlikely that such
> > properties are actually deployed, but I know next to nothing about
> > ACPI...
> >
> > TL;DR
> >
> > My original question should have been: Is it safe to simply remove
> > these lines from the patch:
> > > +     if (!is_of_node(dev_node) && !is_software_node(dev_node))
> > > +             return NULL;
> > and let the code trawl all kinds of device properties?
> >
> > Sorry for the confusion...
> >
> > Cheers,
> > Peter
> >
> > > > Thanks, Andi, for taking the first patch into i2c/i2c-fixes. I will drop it
> > > > from the next revision and rebase the remaining two patches once this
> > > > question is resolved.
> > >
> > > > On Mon, Aug 24, 2026 at 10:50 PM Peter Rosin <peda@lysator.liu.se> wrote:
> > > > > Den Sun, Aug 23, 2026 at 09:34:38AM -0700, skrev Ahmad Byagowi:
> > > > > > Device Tree channel nodes are associated with the adapters created by
> > > > > > i2c-mux, but equivalent software-node descriptions are not.
> > > > > >
> > > > > > Use generic firmware-node operations for the existing channel lookup and
> > > > > > accept either an OF node or a software node. Associate the returned node
> > > > > > with the adapter so child I2C devices can be instantiated from
> > > > > > software-node properties.
> > > > > >
> > > > > > Save the adapter firmware node before adapter deletion and release the
> > > > > > reference afterwards, following the lifetime pattern in i2c-atr.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> 
> 
> 
> -- 
> 73
> With best wishes / Mit herzlichsten Grüßen
> Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
> Phone: +1 (650) 924 6653
> 
>  Please consider the environment before printing this e-mail.
