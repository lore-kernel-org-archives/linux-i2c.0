Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757E3783AC;
	Fri, 27 Mar 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617780; cv=none; b=EnmByMmsAFtlGlmjII/ja/KYYxsZAAyruuJskb3q/uNcpRD3d0mp5R3F8rMNSCmWcPzdp7IXdS5JX1++lRvHaLxCE6brmP642hYMld9K5PpMxE9bTyCaEg/jjatzInHClfdmPiHW9dP4YbMfx1btzxuH0uxcqlV/qzNDT39Hqts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617780; c=relaxed/simple;
	bh=R6/WA93yojRsTK7ntKiPoTzkIXktKx8ntCQIEdECMf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYxjc0B019Dp6/nwJlE/vZLBWT1/Hw10LE49zSgLg4x9l8mFg7P6EdTlvialRy9k/1vp2+72nA59qe3roJHLvTLcapdoFon3W6m7NfB/44sWMDdwoSylBhgVLvalSLjAtDlxublyYeEUnq1hhWfPhjkm2OgXj8fWgBSyITOIoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBJp0hQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBJp0hQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35766C19423;
	Fri, 27 Mar 2026 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617779;
	bh=R6/WA93yojRsTK7ntKiPoTzkIXktKx8ntCQIEdECMf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBJp0hQZM1yieoIOC+vzmO+4j9BSrlETWZ9QydZt77mBiMXd0vWyd3iRb1om1w676
	 QWa1034l7yEsp31zXDpgIApT1TmETtbUktsPq4KApyVpVWPX1zrU/vMt521yN7xSN8
	 mTvL5/2jaSou78dzAMwZ3M1bmjabuiHxNUmgBOFEw0w9kSIC9URPJVxYmhpvg/W0ME
	 vTTl8hEFvfzZOtikFHdipdM6jwe8yzHyEr3Ac9SZIx+khZhvJFYTAMDaU1XY2hxlGB
	 zrhVN+Yvdkg9FxmZ+CkMbUnc5JLhNfzd1RjIpyvYmdWGLlpL2lbSW4lmcN2li0WxwE
	 /b1LqzJ5OfFxA==
Date: Fri, 27 Mar 2026 14:22:55 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Moritz Fischer <moritzf@google.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mdf@kernel.org, ovt@google.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH v2] i2c: designware: Add a new ACPI HID for GOOG5000 I2C
 controller
Message-ID: <acaEl1Dj0CHGWWv8@zenone.zhora.eu>
References: <20260326200451.2904375-1-moritzf@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326200451.2904375-1-moritzf@google.com>

Hi Moritz,

On Thu, Mar 26, 2026 at 08:04:51PM +0000, Moritz Fischer wrote:
> Define a new ACPI HID for GOOG5000 as used on Google Axion.
> 
> This has been validated on Silicon.
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Moritz Fischer <moritzf@google.com>

merged to i2c/i2c-host.

Thanks,
Andi
