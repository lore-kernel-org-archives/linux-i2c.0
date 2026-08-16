Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8F54774;
	Sun, 16 Aug 2026 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786918775; cv=none; b=ZYMvnFtynkKN2girGzCAQ+LVU0Jpn2aBTjMFfUP5Wfm5AAYuaqocRctplHSXEUiVUdoyoWTdWJT2SAya34/N9xr/9gkUx9+3djlxx+d73kFCAyKbB0QvomzJ/MK7A6JeLV1YmBp2sq/q4rQJ57NZ0zMDDcgkx5noPDAGftIjC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786918775; c=relaxed/simple;
	bh=S71GiMJtmhlcYLUbLWUoR+d4vahJ89p94ajqR9ch1aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmfPybbQeCsWJdyG/qZsVr3KrdAYxC8yPPhOX8bL0U0eGYCNaoWBKk8qw2wjFdqdNW+yy831LAp5wz7TEcFy6FmdheRRQDYsjJ0k+YlF3EPmFaOhs9/fAt2dqXrk9BtmGQsrw9I4cdF5Gkah1+TUwNEwB/NMUWmBhIgro1w6puQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOV93INU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOV93INU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFCD1F000E9;
	Sun, 16 Aug 2026 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786918773;
	bh=tUMv5XAEcmGnlgDsvglMXkhudMIMiALZoKjHU+5aCpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOV93INUmAM4JaYmXJliBvlj29HjYfbJfzEKyMWA/mbWHnfzZmDfJdg9d32fMuGBS
	 Wqt5Vncyxy44x+SYRntTA9Qc8X+saUWDIeDmb7G6FGVFgu2bI6JFxI/fIIwTpV4+QC
	 7/cvpL3bRVsT5TcdW6kmHeogTQCUyC6xak9Ot3LenPvkQITPsZwUweGYZdoaIOt7d8
	 yTOYem8Kd9IQAh+Xe2BZhltaeQ33iNfPHG14AHigYL2WIj9JMcWAaq+NnAMUdC2A12
	 lZU0/U4jc2WIzqVHP3ejeZKvCQVZjVp8ZEzUyXmtwimcQGobT9h4jxVUSlGcAk4pfH
	 cBq21t/LTb9JA==
Date: Mon, 17 Aug 2026 00:19:29 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Rosin <peda@lysator.liu.se>, Xiaoke Wang <xkernel.wang@foxmail.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: fix OF node leak on kstrdup
 failure
Message-ID: <aoI3QhFbfsRLEJD1@zenone.zhora.eu>
References: <20260813095617.2246320-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813095617.2246320-1-gonglinkai@kylinos.cn>

Hi Linkai,

On Thu, Aug 13, 2026 at 05:56:17PM +0800, Linkai Gong wrote:
> of_parse_phandle() takes a reference on the parent node. If a later
> devm_kstrdup() fails, err_rollback only releases nodes for indices
> 0..i-1, so the current node is leaked.
> 
> of_node_put() the current parent before rolling back.
> 
> Fixes: 7c0195fa9a9e ("i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

merged to i2c/i2c-2.

Thanks,
Andi
