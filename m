Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A34361DBA;
	Wed,  9 Sep 2026 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931555; cv=none; b=EyYi6fMYSlIfH5uxTzbDD6zNUj9Z7quHg/MZ1oeowmVU7F/WdXyhogWwjcvCjt1Lk8awtC8iNDCWc05E6h1ZTj7YLJJx0N9CYO2fZ3Ne1e6teDNlZtAHBvpwlrXDfaEs4OUoIIrz5NYkHmeleMbyCTAzSsqTRSLT65IszhfSoR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931555; c=relaxed/simple;
	bh=TBSjd0wHBttYMB73JiVfFTcNAzvAyF40gt/CVFr51bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4h47yNMHiKjDKnjZptAGtf+uGl+iOh7fa3xAmxAyfHf+60AQ7F/nzabQy2i5PEgOqpG/8fD3LFD+BEQooDi8GOz3tJuZb15nNgvrWtgkXwmVBC2nzOm1pQxIolssqLbuIA9JvYAgcrrdidgHSaSC1obKYurxSsW4MsgviRl/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=IE33cti3; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=IE33cti3; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="IE33cti3";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="IE33cti3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788931540;
	bh=TBSjd0wHBttYMB73JiVfFTcNAzvAyF40gt/CVFr51bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IE33cti3TPZUSWoD9ir4u8uMBs5ntrvqHwpU94eORjuIRa6vN4MFFMqH8FGEytXlo
	 9swva8XvWcrjKNImhEyeS/6lQGCB3o4EG+SFt73Kin6KtWcJpdtVWTP4KLCoREFeqF
	 vG/fCoti0X0FVx6GGUoMQa8VWYup5chiRZpRvMhy0Ddkh6L+llkIr4jOGvWDdoer8n
	 7FJkegfNVsS8oMGtItbFW+Hs1J1REWAv7oxC8zXCWhe7HSfmLeTe2eq+Q+G1wprqgi
	 Tpg77084L6HBhTrxK4rghFsGF0UUGIL7lsDVfGjxVlmAuvsKvXaOFU25xcq/Cky2df
	 n3n3yrdABlEuQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1E2F8134E5;
	Wed,  9 Sep 2026 07:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788931540;
	bh=TBSjd0wHBttYMB73JiVfFTcNAzvAyF40gt/CVFr51bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IE33cti3TPZUSWoD9ir4u8uMBs5ntrvqHwpU94eORjuIRa6vN4MFFMqH8FGEytXlo
	 9swva8XvWcrjKNImhEyeS/6lQGCB3o4EG+SFt73Kin6KtWcJpdtVWTP4KLCoREFeqF
	 vG/fCoti0X0FVx6GGUoMQa8VWYup5chiRZpRvMhy0Ddkh6L+llkIr4jOGvWDdoer8n
	 7FJkegfNVsS8oMGtItbFW+Hs1J1REWAv7oxC8zXCWhe7HSfmLeTe2eq+Q+G1wprqgi
	 Tpg77084L6HBhTrxK4rghFsGF0UUGIL7lsDVfGjxVlmAuvsKvXaOFU25xcq/Cky2df
	 n3n3yrdABlEuQ==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id ADD5B13531;
	Wed,  9 Sep 2026 07:25:39 +0200 (CEST)
Date: Wed, 9 Sep 2026 07:25:38 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Conor Dooley <conor@kernel.org>
Cc: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>, andi.shyti@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: i2c: Add NXP PCA9641 I2C bus master
 arbiter
Message-ID: <aqDt0uC7FNRmsv9S@gryt>
References: <20260908123146.1839854-1-shivprakash.gupta@nxp.com>
 <20260908123146.1839854-2-shivprakash.gupta@nxp.com>
 <20260908-skirt-makeshift-2050f3bcbb22@spud>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-skirt-makeshift-2050f3bcbb22@spud>
X-Virus-Scanned: ClamAV using ClamSMTP

Den Tue, Sep 08, 2026 at 06:47:01PM +0100, skrev Conor Dooley:
> On Tue, Sep 08, 2026 at 06:01:45PM +0530, Shiv Prakash Gupta wrote:
> > Add device tree binding schema for the NXP PCA9641 2-to-1 I2C bus
> > master arbiter.
> > 
> > The PCA9641 arbitrates between two upstream I2C masters competing for a
> > single downstream slave bus using a lock/grant ownership model. The
> > binding supports an optional 'interrupts' property for interrupt-assisted
> > arbitration.
> > 
> > Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
> > ---

...

> > +  i2c-arb:
> > +    type: object
> > +    $ref: /schemas/i2c/i2c-controller.yaml
> > +    unevaluatedProperties: false
> > +    description:
> > +      I2C bus node representing the downstream slave bus controlled by the
> > +      PCA9641. Downstream slave devices are declared as child nodes here.
> 
> Why does this node need to exist? Can't the i2c-arbiter node itself
> contain the child devices?

For symmetry with the pre-existing I2C arbs, which all have the extra
node for historical implementation reasons? I don't know if that's
considered a valid reason? I prefer to have all arbs follow the same
structure...

The "documentation" describing common I2C arbitration details went missing
here:

https://lore.kernel.org/all/20230731163833.319258-1-krzysztof.kozlowski@linaro.org/

Cheers,
Peter
