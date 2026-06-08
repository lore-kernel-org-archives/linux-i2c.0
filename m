Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBB3D6CA6
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939362; cv=none; b=bq4UrD4hTWrytnlYMKFN8ykeU4k841mk3Nq9zOFjet847Sj0t1vHbSJje3/gNFdyHw+udAkZpcO0/TG1LkGIkbkXzvmyFA2nbqyUF2yV7cJgD0l4hUW03dHAu4fGv/I3HSCQvUxUnOXSmV2BeDdN0xKEh0F+LVwRQ/CESBWsApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939362; c=relaxed/simple;
	bh=3rXzaizjrONgbcqevDrYPCwS1sHhJNHtsUBjjyC1p9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miOdMUrb7ogVbtKuhVf69voIdU3qDV72bcw7Dquu9wp5FyAZYqvgUOdKT1I3mR5b5iD7ytFckHvR9udzWkCL6+H/jQmrg5ic/RCjwZPq8Fl2hcsjCOoNzU2qg0m5b9jJ/03NZjOl8DFH7HoTInoubQLtcDel9jbUTg54oYSCZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3auvNpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3auvNpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBED1F00893;
	Mon,  8 Jun 2026 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939361;
	bh=3rXzaizjrONgbcqevDrYPCwS1sHhJNHtsUBjjyC1p9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3auvNpGC0sgsQxph+qt627kQpmj+LHEQ2nmHc6/5YRnvxkYqt7Pbl0HeWERUPl6e
	 2HxpglbnBW9PfjT02CWpkO3ggAR460/hKJvCJRaXZQaAoeH4aNIVFTK05gm1XY3uP+
	 OhCwoKAAIKncgAV4azTyC1toZgSin2cOg276oZuCL/Ab+JRC9bXusyAsGDjh30O3sA
	 U5Ukh/XCdnMAqZuxKp635QGhl7OdNcwM8HqN4oVkuJFzoHsB7qrXXRQlVPbBDK66v/
	 7V7xGpbeIyi/leHRpVCWTLDnPTvyIzyFlI2m9RBXqh9Iqek/bxl+8zv6Y/ZPbQMqjE
	 M0ATbKG47mRLA==
Date: Mon, 8 Jun 2026 19:22:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, brgl@kernel.org, 
	linux-i2c@vger.kernel.org
Subject: Re: [GIT PULL] at24 updates for v7.2-rc1
Message-ID: <aib6P9jvkFhmd-LI@zenone.zhora.eu>
References: <20260601122923.3714-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601122923.3714-1-bartosz.golaszewski@oss.qualcomm.com>

Hi Bartosz,

> Please pull the following at24 changes for v7.2-rc1.

merged to i2c/i2c-host.

Thanks,
Andi
