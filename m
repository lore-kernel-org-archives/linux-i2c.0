Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80E37AA8E;
	Thu, 19 Mar 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960550; cv=none; b=iT827F9ZX9GPVeLjC/JDoSCf1zVNhWfOU9FopEc3hSZBfvhJS0K3/lL15pRfwJVpk8DvdBQGeIa2qjz1/UbRAC96xf8cyqmP2gGgAB1FQvTRjNb2pioOX2NvtBOlIdbyztf8/SScSeJU78Q06cieStRohBKMd4CA/wTLLAlkNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960550; c=relaxed/simple;
	bh=+KQ9l/0fKSkXlJr4dq5Lw/z2OMO4oTL9bBT0gqKkj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8NJmaGBAsn8ykcDv0bKKdTpvrwyrhZCxvEBe1dXiJdZXMouGw5g83Ad17NqMP4m1lkbRN1bFM0/Mx0rLNdJ3NFg12mP7UnqUhi+X1GpcKIaEOsWVLfVwZDMKRZ1/mLroqk4NSyAyA4zMqPYl4SIBJnOuYJhuzTEutqZpR1qtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjo3mK12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjo3mK12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE52C19424;
	Thu, 19 Mar 2026 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773960549;
	bh=+KQ9l/0fKSkXlJr4dq5Lw/z2OMO4oTL9bBT0gqKkj8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rjo3mK12gW3axC6wJOCI+uhqCqE9aifc06DNdZCIsdYS1y6UcOc2XSgn/QMRcY/l2
	 /1YTeiw8TeL9o+Y9tnn5Y4uOhdXqN4xMMmSnN2tlfhT1M5g2hzNKUznP6DSiLIUvrP
	 pOU5YMsy9RZQQ+JjzN/pnuiT5cN9BdXPfmuq2LXbTFt3d1/WlBD4XXyNxgjllUHtvo
	 f6GZy89lmU6/rL5FSvSHuRv1QwidOjHAecpNmYvBNleWHJ0ZkuaXusKkvmCSC1XdJY
	 JeEkSdV/kRzxAR/k4Fc3/fR9VqIhDQl/gdIT/G98qQIkuzWpW3Glr2DuNGgRwIFTqk
	 hH3dSXEWJls1Q==
Date: Thu, 19 Mar 2026 23:49:04 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Eddie James <eajames@linux.ibm.com>, Wolfram Sang <wsa@kernel.org>, 
	Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH] i2c: fsi: Fix a potential leak in fsi_i2c_probe()
Message-ID: <abx8qZLy4oeiiSqn@zenone.zhora.eu>
References: <fd805c39f8de51edf303856103d782138a1633c8.1772382022.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd805c39f8de51edf303856103d782138a1633c8.1772382022.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

On Sun, Mar 01, 2026 at 05:21:01PM +0100, Christophe JAILLET wrote:
> In the commit in Fixes:, when the code has been updated to use an explicit
> for loop, instead of for_each_available_child_of_node(), the assumption
> that a reference to a device_node structure would be released at each
> iteration has been broken.
> 
> Now, an explicit of_node_put() is needed to release the reference.
> 
> Fixes: 095561f476ab ("i2c: fsi: Create busses for all ports")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
