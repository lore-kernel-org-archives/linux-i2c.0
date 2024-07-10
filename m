Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC0376E6;
	Wed, 10 Jul 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598688; cv=none; b=TdPqZlnBfNLf+lmenOmgRzHBTtscI9id7FqJhp+WFu1OpFX9dVRMzG7pEkKPWGxo1Pa3E95/4+6G6trpJMjmJ3VRGOiNvsIyGmOu18iGHskHOLX7/TjjxJuXi1iw7Jjg4JZ1a7ZOI73y2S1/NSW9CAbAqXBP4UNNXrb7hFg8H2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598688; c=relaxed/simple;
	bh=BJg6AAqAaLG487nMFMyfpWvkBKbMe2h/kk4L+Lunf9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyfRJJJYWojba3TjF36dSZAIKuheSQ53S06rIOyc9A58MLqRPKcu/rRULMPo/RGrDGCdqU5hZ3hXaHJ8+o+rWHr8tqv86wVm4ivJsm9IpPRkPj0Q6aYBsaRn3C3wt7HHeEoSpIwawPsIG58gwHCtg/nSK9QdAQ9nw3dBRSjJoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKiGCQUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKiGCQUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF4C32781;
	Wed, 10 Jul 2024 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720598687;
	bh=BJg6AAqAaLG487nMFMyfpWvkBKbMe2h/kk4L+Lunf9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKiGCQUAPUKnkSSFD/Hg19QfjHCMRER0KEQXn9I0aCNEaVnLGepcfor+0yJffZBWZ
	 tpQq+fYSXACbVysTNq9XBmc1uKsl4dn7dUm+TSTwpUZPjX0H/QU0YgJ0z0QLxiu1s1
	 Tq1UtNKxNPrk3VwsHgvihUQInCuBR3S3in2AhJ3vgl4httpfdq78kwg5BdXn7BPmEz
	 Y99uOQpE8dnV03PXjd73BpiaTzQXDIa0Skbd/EuVtPBrBGAwPcW3KtoXcR4JmmnZV6
	 v90JFhoMOxkpqc/cgB2a1cQAxyRmeFjp1grfSjDi+3ladf7X/OqSpQWixIUguiTKJZ
	 SQRppL4E/nJAQ==
Date: Wed, 10 Jul 2024 10:04:43 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/60] i2c: davinci: reword according to newest
 specification
Message-ID: <baxrjwxgt6yx75bpbnlsbj3wrg5g3ce3dnhrojcox2etrq36gl@nd4m6ehw6yxc>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
 <20240706112116.24543-12-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706112116.24543-12-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On Sat, Jul 06, 2024 at 01:20:11PM GMT, Wolfram Sang wrote:
> Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
> specifications and replace "master/slave" with more appropriate terms.
> Remove and reword comments while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
