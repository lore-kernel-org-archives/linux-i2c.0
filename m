Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120D3346B4;
	Tue, 14 Apr 2026 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208420; cv=none; b=IbNapBxFmYid2SYqos6yaqaw1NgWH7p2otb90xW/TcVVYarsOYKKLPARGjJMYHKjUa4IMewcqM2QYk/zmfjyGyB2RySFRv5QAAJK5qzczs6ryUnFrEK6OPyalKo/p228L969o58IUElezcNr1xsmo0T6qaPyAZ8JoSsD1dxi7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208420; c=relaxed/simple;
	bh=wjuwjrLxn7V4lXqXCUI+TcdVe9kF6Gea3yLFB5P2cmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcZy3UC+yzlC0jl5Nb8ncTyhKjecHblNpcjV1fWaxjQ3xUAo68y8+H6WsdcGIrADOXM68qfWocY8v8Zm75E9GXapMPd4DZaSevdve5nrqT441MvmB4SHBAtejAfXM9+hHVxLAjAOgY4oA990VeMdFgZTHTKCcruA1bNPcvzj0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj5l4u7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj5l4u7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2F3C19425;
	Tue, 14 Apr 2026 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776208420;
	bh=wjuwjrLxn7V4lXqXCUI+TcdVe9kF6Gea3yLFB5P2cmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aj5l4u7Tw5kX97/tsvcKhh3CgGiaUnvG5QtKgNiDAs9MB896+NSnBVN06xPFOvQxJ
	 BnNlwHG1Lp2yBcUlSGgEMM5fIF/pNC9mczRFDEPZa1QqiUS93BJ1HFVbZBgI+oYvxs
	 2NknsAnEU8oczAJItZVPL+NhQAWeY171HY6L5T4/Pu0mmG4wCaHbZ0dyASUMxqB4lH
	 xuWi2ollQtKYkXemMoW7s7y3cEHCw3rco6XLAPztcsDASiY8ef1SKOWaLw0HJBF1np
	 GVtoHb9H7RbX8v8vNULsNl8PWj++RKutIcLDoZrg2crCEFiGrl6qhVYFISopviHtD7
	 LEtCCp0GBdMeg==
Date: Wed, 15 Apr 2026 01:13:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Filippo =?utf-8?B?TXVzY2hlcsOg?= <filippo.muschera@gmail.com>
Cc: jdelvare@suse.com, andriy.shevchenko@intel.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: amd8111: Switch to pcim_enable_device() and
 pcim_request_region()
Message-ID: <ad7JtwVqSMU0rPBT@zenone.zhora.eu>
References: <aZx_Yvo_an2_13Lq@black.igk.intel.com>
 <20260224102216.17606-1-filippo.muschera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224102216.17606-1-filippo.muschera@gmail.com>

Hi Filippo,

On Tue, Feb 24, 2026 at 11:22:16AM +0100, Filippo Muscherà wrote:
> Following the conversion to managed devm_* APIs, update the driver to use
> the PCI-specific managed APIs.
> 
> Use pcim_enable_device() to properly enable the PCI device and
> pcim_request_region() to manage the I/O port region.
> 
> Switching to pcim_enable_device() also addresses the fact that
> pci_disable_device() was  missing in the driver lifecycle, as the
> managed API now automatically handles the disablement when the driver
> unbinds.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Filippo Muscherà <filippo.muschera@gmail.com>

Please, don't send a new patch as a in-reply-to to a different
patch. I personally don't like patches sent as reply to a
different thread, it makes my work as reviewer more difficult.

Said that, I would ask Jean to give an ack here.

Thanks,
Andi
