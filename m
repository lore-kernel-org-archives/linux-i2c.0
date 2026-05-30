Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C7351C2D;
	Sat, 30 May 2026 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780114286; cv=none; b=HaXREuBBxnZup6YFbVLrOrYW1mdfqSG743Yv6X8tLgCeLIsl7lxoNUUbpma3NjJnJw2K0FSY8sqGEfV3S5GNqbNTaBHCG0yI/kCK14WGM2YS5rVskwDBvq42+INsOBPVuvP1e/0loaUFUk4NWOXmI5wkujyRHEvoqj7r/t86EoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780114286; c=relaxed/simple;
	bh=M/sa3DTPOozxKeP5EKq207hQK+fU3B+/VaB9xa4z+m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OOtX0tvpHaRH7bVlFrnZhU6DcFdxEIznCvKwCJUQOIDSJjTi5+8LTp8sk7EH1VJhDH+F5oyUArMm2qCChzTircXCBhf3ZETzwGSfaFirzDGwM93aUP/p+13mqbaQESBB9UwVKOFDofUi8X4l+99YaECoGK6QwnKEW42CY151a3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEInYLw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEInYLw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F51F00893;
	Sat, 30 May 2026 04:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780114285;
	bh=M/sa3DTPOozxKeP5EKq207hQK+fU3B+/VaB9xa4z+m0=;
	h=Date:From:To:Cc:Subject;
	b=GEInYLw3JawgfGh5ty0UqZdlwWUYJ5p3+696/PP9+IdyBbmtSFXMu8s02nyYWUyo/
	 Pn96wgTJqEqFGBQvxaKZpi3HKElzNmUz/qP9UAnfp1mw737b2sV8ErokqKphZKlFrb
	 zwXDz/5W7wF1kOd0XMg8HrMdfNm6yVmW3TPdUWG9MlMlDrauCfCBBbERdo7WGgR/we
	 sTAyNJxF7uQ5P5GXm/O1UMQalcwtOfFa1xjljtBoMiLt34n/EVGXdwoLqhwiJ4wIsH
	 vYy+WSi0xiCnv39Yi8Oa6Nuw7RD0CpThkUerMCML68ZiWSnxMfG+r9+v4CDtybiSnh
	 YOERnwmO3frBw==
Date: Sat, 30 May 2026 06:11:19 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v7.1-rc6
Message-ID: <ahpi6WYWZumbtfa5@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here's the fixes pull request for v7.1-rc6.

Thanks and I wish you a great weekend,
Andi
