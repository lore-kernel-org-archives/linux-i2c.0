Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C448366553;
	Sat, 10 Oct 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640268; cv=none; b=esWSFEt/LEXGfewYNQAYmyftsRZsv6gWCut7PZbe9TJ3Zc6BxYDlLR8OcPEB00roRjbThFh1qax6oGHkzIJoBZw1uP1ucprXviTU3jdg6aPbE0XHkGMFXh0yIzXJxgKK48MrRpHoNVNPHHVRni0cleaVoiQi6pG95j4vEaN3RPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640268; c=relaxed/simple;
	bh=NCJPYpyppy9ojAW/sKYU73ClvWaHCKLuszx4sumV6mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7OO5jCfZBdN+UJ/t8qK3neYmReBg/PzcbvIpyjKHnVeGUS2CUZ/HfChSa2SfvboILafpHYBpolcAKhlsi/qyhImnUU7gagHTfetTv6utMKmo2kdLcVkErwbe+SS3j7/B/wQ1MjN8rZM9igezVYgeF3kPNB8U0TLahuVBR6fAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+Gim6D6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+Gim6D6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4601F000FF;
	Sat, 10 Oct 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640267;
	bh=eL2Vfy/xTJl2R4hgRrn1CdL1jRsaF14eJuwV/eyf8Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+Gim6D6ZKwW/gkFkhMWt9ug1I/N65Y9L4hUjsnqOElVN5L9qRuvdSOsX9xoHkZ3H
	 96yuT01Hz1dEzHUg+QfXI38vLPDHXCyiKYqaEj4TbTGHTF8/PY3jtQxxDjWCx8QQWH
	 TwsaL4qQvIlqFmKZ0ygGlQINrAQynoAGE535FTO/WjSVWb7Dt1+WFUsfWCNZWozIY0
	 ydrSSXkd3mPYbaDoLqWYUVjaM48mQH2P+xWxI+azLV1zEbV0q3iqHMNrCClci/XA1w
	 61TTPWZnaqc33hRs67sPHZKbrMKsjc8RMILxyDkjrOgcVdlttwJ9iez45K6WQEnO/V
	 nSH4YB+84dW2Q==
Date: Sat, 10 Oct 2026 15:51:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] docs: i2c: writing-clients: Add missing end of
 command
Message-ID: <aspCticLoIV-GVCO@zenone.zhora.eu>
References: <20260916140752.329836-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916140752.329836-2-manuelebnerli@mailbox.org>

Hi Manuel,

On Wed, Sep 16, 2026 at 04:07:52PM +0200, Manuel Ebner wrote:
> Add missing ');'.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

pushed to i2c/i2c.

Thanks,
Andi
