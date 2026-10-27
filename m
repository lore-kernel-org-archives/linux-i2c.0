Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118763;
	b=pSs1nzlxhen0b9Ve+3QH6uoO3ig3vzDLhVAOznjMrEnSMZbRC3ooStOUcW7WNAS7c1Fx
	 QRIEmLXBJ+d5ggOXXpXGI6sCZYZrOuDX4Ux3ADBiGgzOkcDekGKvmuVUrX19GbbGtfGJU
	 5sfWrM6hM2S5maa7eAlwFivoyA2yH97VDabl/DZJxC2yIOiVjQoEXcP+fI1iYMvRrO6RN
	 2gZA1IrMixAiz42WX+3NQdTuGqpvD6BpxbfUqUDuDRiDeMekT/796/d3cYViMzM8gbGge
	 xT3/T5bdBJAkwrR3xPtco34TEIfJv57o785U8l/WJIUgcs0ceAWxvkbac8n9Iovxq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118763;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Y3XAQtLddDAhYd+riD51P6ZqyglOvncFYFffZW+ntOQ=;
	b=whMTdKkMzDJM+9DVgBVKfrm1zUZkRb21fEIdBgedXUzUYTxWfBzw+AeIzUZV/SXQ2Kj9
	 6wu3QmMjJn33a2xjEAkIWlJNukVBQAjGSxQWMSHqtnM+6JBiGERK1ZK3aufSe4l+NE9Zf
	 Q3iDDiO378mr4LKoWfiDxCohrJVNu3aw4dMvgNzJ+H/M3GILsXF0SDBPmQGjcvvIsJMuc
	 fPSxzCFsRGAN/YiTGkFYTPldElkdacZmdUvt882NyhTHNP7UsDWOjN3ch9n5ByOu7mnKS
	 4+C8Nizz45sgsyptgN4IFOb1vGFCKbAWX9CsNEqgeVwZmBCy2cM2eLxuWCrWLV+gRYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOTy+L7E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B1606A321;
	Tue, 27 Oct 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOTy+L7E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90F21F01828;
	Tue, 27 Oct 2026 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118762;
	bh=Y3XAQtLddDAhYd+riD51P6ZqyglOvncFYFffZW+ntOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOTy+L7EqN9ulmfjWpyNd5uIEjyLC5B/Qz7mmRkZBoL5C6+ShCBCl/vqckiHkUn9Z
	 X5vc9pWyWEz11CNi8Ey98g+HmzyL/eBLFt09QLrgHKOpINar8daODoNc50mRTpIgLG
	 4xdsP7FvG3d6L9zFJCzS1Eep271+fOYWq2zod/P9gGtiN1tawY/fs5t4ZKHaY4pNu+
	 GuBdssoY27TkIinvmpyI8syIayu3ZJO/XeWSC3YdtDCI3pf7KMEiM9Lcbk2o0/+ze0
	 +sqDxCG4sFwyZ4u3KBqDtzgAuMhxNJw63CtMJmM6SpgDEfq1zhHOsNtP1m3n7k21H3
	 I9pHVd69c6J4Q==
Date: Tue, 27 Oct 2026 16:32:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lianfeng.ouyang@starfivetech.com
Subject: Re: [PATCH v4 2/2] i2c: Add Synopsys Advanced I2C (DWC_i2c) driver
Message-ID: <8e393ecc-9955-4686-8689-5c8e4a105a28@sirena.org.uk>
References: <20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com>
 <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SZlr0S9wj254kLdR"
Content-Disposition: inline
In-Reply-To: <20261027-tda54-upstream-i2c-v4-2-ebeeaf87d181@ti.com>
X-Cookie: Mother is the invention of necessity.


--SZlr0S9wj254kLdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 05:00:36PM +0530, Aniket Limaye wrote:
> Add a new platform driver for the Synopsys Advanced I2C (DWC_i2c),
> controller mode only.

> The register offsets are defined with respect to header registers for
> each block. These header registers are discovered at runtime by walking
> the block header chain.

This mostly makes sense to me, I've not tested yet and will dig in a bit
more as part of that but a few minor comments below - I'll let you know
how my testing goes hopefully later this week.

> +config I2C_DWC_ADV
> +	tristate "Synopsys Advanced I2C (DWC_i2c) driver"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	help

The dependency is there due to the whole sadness with being unable to
discover the FIFO depths so not having a fallback, but as soon as we add
ACPI bindings we'll have to either drop it or broaden it to be on
CONFIG_ACPI which gets so broad as to be meaningless.  There's a
reasonable chance the dependency list will end up unwieldy for the DT
platforms too.

Since I believe we're always working with configurable trigger levels
for the FIFOs I think it might be better to have a fallback compatible
that uses the IP minimum of two entries in each of the FIFOs, that ought
to work even if the FIFOs are in reality bigger.  Performance would
suffer but slow and functional beats not working at all.

It's really unfortunate that we can't enumerate this from the IP
directly.

> +static void dwc_adv_i2c_read(struct dwc_adv_i2c_dev *dev)
> +{

> +			if (msgs[dev->msg_read_idx].flags & I2C_M_RECV_LEN) {
> +				/*
> +				 * STOP is only set after receiving the block
> +				 * data response length. When that length is
> +				 * invalid, read one more byte with STOP set to
> +				 * complete the transaction.
> +				 */
> +				if (!data || data > I2C_SMBUS_BLOCK_MAX)
> +					data = 1;
> +
> +				len = dwc_adv_i2c_recv_len(dev, data);
> +			}

It feels off to silently fix up an invalid length, but possibly that's
the most sensible thing - I didn't cross check what's idiomatic for I2C
in general.

> +static irqreturn_t dwc_adv_i2c_handle_irq(struct dwc_adv_i2c_dev *dev)
> +{
> +	u32 enabled, stat;
> +
> +	enabled = dwc_adv_reg_read(dev, dev->regs.enable);
> +	stat = dwc_adv_reg_read(dev, dev->regs.raw_intr_stat);
> +
> +	if (!enabled || !(stat & ~DWC_ADV_I2C_INTR_ACTIVITY))
> +		return IRQ_NONE;

Should we check for enabled before we read the status register
(microoptimisation is fun!)?

--SZlr0S9wj254kLdR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrg0iUACgkQJNaLcl1U
h9AVBgf+NZ9SzwHg3GyXk/xMPJ8XzCO9EiL2XBp6pi12ABojYnvJuhUGfAbDdbU5
qUlzx3ykdIIe071iyQI8ThKgtgehnJ26lxEIAQoY/GvKI5VgYnhcvID69tQScE0t
aQtmldYUE9DNzyMaCb7c3Ll8NDW5qAgayb9201X+LaLyHVpmds/L8+UOVmWOrWlM
lGqYxZIBmg5izLyxfwU1c8DRNdxBD7GkcfMaDq4AkiOHLG03eD7/TtlJzO1N03Jt
VRh6+u07uMW7WYpjVmxHc5/iQS7t+WHuw2ZHCPjTNSIcUEhUgWXoFFgE56wPEPW5
im23ucSOWsCK+RtueRTkePvHCstCkQ==
=FIvN
-----END PGP SIGNATURE-----

--SZlr0S9wj254kLdR--
