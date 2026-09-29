Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0114E3BE659;
	Tue, 29 Sep 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716493; cv=none; b=rT8tDnD/fd6R8atzCrOfnInVSHF5yXZwJpcTMyPkQ/lJbiHh7j0pG+Ts88bEchXD4helfI7wVTeES5tn0d82H+btrC7nUV9Mak1fKVA+W6EBJseh5zpBG9Sw00n/1W/iFyGhztofkqogGCzciL8Rj2uJpxmUXbVCwcByhTl/sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716493; c=relaxed/simple;
	bh=2MTAR3DrgoYtxImU/oQJj91+yxPA1kfRfUwVDE/1KtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjAqbuTuQg++WB7fnQGlk+5eLRLKZTT9hGCl9ToyXl1BEqJop6LMc5dw9DEiqkUTUeU8+nm3daZ5CajKSWUVoICpjAB04jAeWayTNsFmMqU8R+rkNUe0ww9vDZdV6kaWut1RErElt14Pg8CY/cdmx95yukEkbR1/HfcJCKxGvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRCk7L3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRCk7L3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277331F000FF;
	Tue, 29 Sep 2026 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716491;
	bh=B2wGLZWgk5NVUocM7YSAn64g+ZiOK7t24vigVO2FyDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nRCk7L3o+MJQ/oAuiSKZ+kUv21WIgSjmxPVcf/U+T/58Us7xzB1anoD8KX+lWvwrT
	 QhoPIF6mMte+yvd0aySmiT4DqTCrhPugxAGQQJvyA/0ZKEUjAGvp+9PNiBdLuvCDeS
	 l2AYYzhQBGhPupcSks8JnNKKAzGUWeTY3vxnBVgH0Q1CPuYn1yqwhm9ktWnn2JlXz0
	 8HmR1XvdzD9NKbOpHGmLKqwvLdaN4bsggUywRkblUV1B4cZR1w9WbWUA3rTjQfn/DM
	 f/dwcnslAMNOXqy0VLIDsrc4TlIfQnkeuEAGtuZe8o3Yx0RKLakbX9B0MT5rMnDVUr
	 cca7vCDo+BCJQ==
Date: Tue, 29 Sep 2026 23:14:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Simone Chifari <simone.chifari@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus
 adapter
Message-ID: <arwp1oCq48PBVmNx@zenone.zhora.eu>
References: <20260728122423.358416-2-simone.chifari@gmail.com>
 <202607291626.TnSyWh0f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607291626.TnSyWh0f-lkp@intel.com>

Hi Simone,

On Wed, Jul 29, 2026 at 04:22:57PM +0800, kernel test robot wrote:
> Hi Simone,
> 
> kernel test robot noticed the following build warnings:

Please, be aware that with a test robot failure or warning i
don't look at the driver, but I expect a new version coming.

Thanks,
Andi
