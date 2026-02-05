Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51655284895;
	Thu,  5 Feb 2026 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289435; cv=none; b=ZgTYzO+K/Xmx01SIxMtyRHtCw/4x0hzdfhhVyXM3+P2waUkKHE7liC6pefo4SngLuN/lpJn2UlDZfFr9qgCG2Tx2jG2z+qmllJggQOtd+uoJRyndWAAW/b2yv8IMwxDAJZqs+GU0iVFf0cfRj30Jx7LtVmol2kiar97xCCJOMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289435; c=relaxed/simple;
	bh=+kNryjrNHlLZrNRQa5kMRjoz9lVXzk+2myT3yUHpcdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omdhkRlojSXDWWw6vutsLPO/3Eyqvr5oirIXKDQoYpbwvTD4l8dEY2RPddYXhszVbtYL0HuVHiEBp1OyxEBxT03Wx7q72c89n99z/TTzUUaf3GZeEbJ/IXG3998sw6El0AUG8W/3Csa5OkJgert3LV+OEv40OX31sOP8+eFNwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihcat0zW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihcat0zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F42C4CEF7;
	Thu,  5 Feb 2026 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770289435;
	bh=+kNryjrNHlLZrNRQa5kMRjoz9lVXzk+2myT3yUHpcdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihcat0zWGJ08L4dZe+iZLTZnQGZ9A+x3N9Lb2dLWeGld55OSiEmms0TmPSL09oZvH
	 UnqwLvgJANIHeFZ7I2HzU+iuHxs9D6Z2tK1GVaBOdTKeNjBXY7jBU5BBnS8t0Mg6tC
	 T9CmPDNL/HNRTaw000MzxhEYrwZJli57BQ76nxpv2GQiMt/rJ7zQvkUfUcayNcxHPU
	 Rof4oJ7jyonHmAGS9rzmnCI2jnKh3O9jH2hVpHhNYpn8v70KbM9rm3Bh8eEjajbyFo
	 or0QjbBvPkDXngwQHpTujV9ljtSXrqzD3DfzAuHMX8xAnRjOvDApjeVh3Bk57jn3An
	 lgKKtjlI5bcJw==
Date: Thu, 5 Feb 2026 12:03:51 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Filippo =?utf-8?B?TXVzY2hlcsOg?= <filippo.muschera@gmail.com>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: amd8111: switch to devm_ functions
Message-ID: <aYR4E9UmuQ4Wx_ro@zenone.zhora.eu>
References: <20260202131304.8524-1-filippo.muschera@gmail.com>
 <20260202131304.8524-2-filippo.muschera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202131304.8524-2-filippo.muschera@gmail.com>

Hi Filippo,

On Mon, Feb 02, 2026 at 02:13:04PM +0100, Filippo Muscherà wrote:
> Use devm_kzalloc() to manage the memory allocation of the smbus structure
> and devm_request_region() to manage the I/O port region.

Merged to i2c/i2c-host-2.

Just a few notes for the next time:

1. I prefer two different patches for devm_kzalloc() and
   devm_request_region().

2. For series with more than one patch, I'd like to have a cover
   letter to introduce the series.

Thanks,
Andi

> This simplifies the error handling paths in the probe function by removing
> manual cleanup and allows for the removal of the explicit cleanup in the
> remove function.
> 
> Signed-off-by: Filippo Muscherà <filippo.muschera@gmail.com>
