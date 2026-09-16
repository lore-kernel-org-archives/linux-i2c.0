Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2740B11B;
	Wed, 16 Sep 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553138; cv=none; b=oJWExAtwIf5w0501Dy7tTCge34YVI4ncgCjZ66nQv50I7MLOOMfX4g5funxjRaEcV6JVUqoerD+klrXNuqlS0eKGqxkpFZSkiadrW/Csj3w2Y86Wvy7NXpQW6OMaEsUZTlLz57bva2GBqqod9XcHQ+uQNTyns8cYGm+mUC6aUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553138; c=relaxed/simple;
	bh=dwoz3Fs3dILagQbEX8XA1D1oUsVK1MB5fEJUuiT05/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx536cVNjdDYbTGAUDkBKVB24BRv58Kr6BzrR+dbxZFpkZY8PMYOUtpxK7xQY0nFY1btACto986a+OXvkAQbf42qiJQrf0yY/E1neJWKZtuEV67xnWKSmTUGv0+y07Q1NuJHjQnNOGXoijqvusLjFTQm4T+uwgs/H68xNR+6NpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Cl+vCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Cl+vCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB7E1F000FF;
	Wed, 16 Sep 2026 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789553123;
	bh=SIrswBEKjvCahBhBDYV/KjaS7T/gmu6ZCkRCQ0/C6gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C9Cl+vCLMMQYcLw6a56qj2Cug2HwTT6C16xyQTzyweeCLdHbgMEIePT6BVfohimvn
	 kJ2JgCw5R8oNecMy+PdQ1uIh64KPEgjQbIIm68kIm257CYjPCTDQRqS3RFoJh7PXBa
	 5igGQOPvegnLlPg7UPGrcWex82s2T0PWx9p09ukCPDHgIhTr3vVd0m+zWSAEg2rFlo
	 2OjdI4/6Aro2N3K/lFZcJTGdorNN6YTCi9R3i/E+CCq1Tb80MMg7H1tbeSOdrbhmr7
	 chSZF+aczY5dmXRAoZ07O/SxGmyhSQz5+c/6ic+ioJ3xotW2jVtnqAsBoPbBsBi9So
	 WNnpg7Uvxa4NQ==
Date: Wed, 16 Sep 2026 12:05:19 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	Dmitry Guzman <Dmitry.Guzman@mobileye.com>, naresh.maramaina@oss.qualcomm.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/2] i2c: Add dynamic transfer timeout based on
 message length and frequency
Message-ID: <aqppo9OvQ8b_bvTg@zenone.zhora.eu>
References: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>

Hi Aniket,

On Fri, Sep 11, 2026 at 12:29:50PM +0530, Aniket Randive wrote:
> The I2C core and many controller drivers currently rely on a fixed
> timeout value that does not account for transfer characteristics such as
> message length or bus frequency. This can make the timeout unnecessarily
> large for short transfers, while longer transfers at lower bus
> frequencies may require a timeout that better matches the expected
> transfer duration.
> 
> Introduce a generic helper API in the I2C core to calculate a
> transfer-specific timeout from the expected wire time of a transaction.
> Store the computed value in adap->timeout so that both the I2C core retry
> logic and controller drivers use a timeout value that reflects the
> current transfer.
> 
> Keep timeout policy decisions within individual controller drivers. Let
> drivers provide their own safety margins and minimum timeout floors, and
> avoid exposing those driver-specific policy values as part of the
> generic API.
> 
> Convert the Qualcomm GENI I2C driver to use the helper while preserving
> its existing timeout policy. Preserve the static timeout behaviour when
> CONFIG_I2C_DYNAMIC_TIMEOUT is disabled, and let a userspace-configured
> I2C_TIMEOUT value take precedence over the computed timeout.
> 
> Suggested-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Pushed to i2c/i2c.

Thanks,
Andi
