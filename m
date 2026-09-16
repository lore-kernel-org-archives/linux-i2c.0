Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFD443E31;
	Wed, 16 Sep 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543722; cv=none; b=dXVEPMzW1LirdxOW7hnYsN3wP53J/j5k0W1swkZHVfH/Ef92f/E5IrUTv2yf3kmILbzPQ5CW3rHH1Oh9rI4dlq4yZbDuUzTUyBFIk8cZR6soJOTVB6b22y5FakJgT6BVvWMKfKGj4TNDgimzrFLgzqJmQbna8ZIQIQr0AFuGZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543722; c=relaxed/simple;
	bh=zMEN06QrmYmpWffkGBo9xVTR4JDj/SGG+EmebBvAHkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOlmG00f5jez8W3r/sRV7+DYwLYgMgFWai1wipXrk5nNv8hHryamtv6/TW+Lhki9xi2O3vauPZglL807lB2YigHREISuxbRRR2EZnpSKDqSsnXZ7yW6/ddHbSELrEwFHDB0Re0T/ZWtFU6iSygfEY9yQvrUR0vDtijdj+gq2GRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk9ojKd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk9ojKd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD311F000FF;
	Wed, 16 Sep 2026 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543710;
	bh=OO5vRGGGgYVkb3OhDCySnWfO8oJAaUW28xMX4NtGPmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dk9ojKd3YB1vh1sBFfOOv3d9U96JQEolOEXu+qe1GB/NoLLPbbr5P/MGka9yHPiiW
	 +Z1JRGB1P8I6j71g/GF8Cl6XQxFDS5HSZNTMrY5FuH4eF1C5da1BpBcUagBB6x57JI
	 9b94qzhAqaFHfvyU0WVGY4VTNMvnt4nIp/v/V3dYMfEwLiBhU/m3efn5h8sj6FqJR+
	 lnw67MrBDCQa2w6OZZ1JFNN2Ba0cqjMeOY0CPKdbHeXlTskjp73tAG1DKQnwRTAbrb
	 1wvU89k+yTIy1htF+C7PUcwR7apFYR77Tl8zujL9UBPg/7byAYotnIbFJ1OeprxvQ7
	 RuL3NdiLlMJoA==
Date: Wed, 16 Sep 2026 09:28:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ljca: drop redundant explicit adapter deletion
Message-ID: <aqpFB_OJ6aE-_RuU@zenone.zhora.eu>
References: <20260905-ljca-v1-1-9109616ff1c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905-ljca-v1-1-9109616ff1c6@gmail.com>

Hi Felix,

On Sat, Sep 05, 2026 at 09:25:15PM +0800, Felix Gu wrote:
> This driver uses devm_i2c_add_adapter(), so manual i2c_del_adapter()
> in remove() is unnecessary.
> 
> Remove ljca_i2c_remove() along with the now unneeded
> auxiliary_setdrvdata().
> 
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

merged to i2c/i2c-fixes.

Thanks,
Andi
