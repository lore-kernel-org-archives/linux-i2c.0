Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513538B147
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779084758; cv=none; b=Z+m3OtttpLV99erYlsQWCSKsxAVJldVapDbbNvSAJuziDyDd30JFc7IRZlaX2kO+Y2l/ATEAMCggOzxp8SsguSU5XYtCVuAsBfGgWhhkN/zg8QeZhxANb7eGWTfnnDNEUnC/71VdnK4GXEzImJ8xp2hdoHcvPrKETbfBBM0rttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779084758; c=relaxed/simple;
	bh=+eyhZYLFXjriNSuFiE3KUwIxuu3Ps0W1pT9VSYaKLB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQNtblCnWG1rqdomAdujqIVpylfGCoU3YzaWpCyZ6HbJM8yImUdkZH+DcLF6ce1oN9XMsk7qyhnkvTXt3c9itcMHGW0Oh29Si3ZvXpFWrKpLgf4d90KvAfkyE7WNi5O1oC9bX0BSFVi0j8SXjwIK9G45BHkTHDtkXFKLLR43c7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WReZxNKk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WReZxNKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=SmMk
	8488kma2vg6rM358kqSHlM9+aSEIwcIKImVwW5s=; b=WReZxNKkxvs569oNbsTD
	MQWESRQOoIh1F6MtfJE2Z7YAQQtP1hYr651XXT8hB/2RdQjMmEJllJKQi9r6xEem
	OP4Eoe8QY47G1XpjBJ2DIA1CbOuvhfOod8ypFwStNdpDU7hOAuAYjCbSzaiMxylE
	jL1cqZ9H/1R/iOrWD4tFgo2BVoFLXuGd+6x4IxltwofNd1kKZxo63PkEdK+27ebT
	5VoyM90Lro1iZw2Q3nQ2IDChTUAtMHjnOJrTNMnVZG8M/Di8mK/a9XbwADly58ht
	yT1sZ4qDdHlStcTLXLALavv2z7snqv8+eaOna6eAZ8r6/MSNUcxjyQE7wGcLxVOe
	1A==
Received: (qmail 883345 invoked from network); 18 May 2026 08:12:33 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 May 2026 08:12:33 +0200
X-UD-Smtp-Session: l3s3148p1@wW66chFSdokujnuR
Date: Mon, 18 May 2026 08:12:32 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: i2c-host-fixes for v7.1-rc4
Message-ID: <agqt0C_MhBeCcNLc@ninjato>
References: <agby5qiVRXNQGvky@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agby5qiVRXNQGvky@zenone.zhora.eu>

Hi Andi,

> Two Tegra fixes in this pull request.

Pulled now. Sorry for the delay. I was on the road this weekend with
less net access than expected. Will send it for -rc5!

Thanks and happy hacking,

   Wolfram

