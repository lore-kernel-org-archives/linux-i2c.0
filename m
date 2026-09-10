Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C576378D72;
	Thu, 10 Sep 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048058; cv=none; b=rvi9wgbTVN3z5RvGxW65je+rVds3lBEuR6fV5rhb8y3zGq/0e1LLf3NjSlug5Cvc/vs1Nl6DOX1ByKsN313DiZdeLdZ3e6DqC85kMyJY7xJjF0kFAhyN21ybo/SCzUO1ZLS27+nPJwe+M7wQMqMUF7JZm1PZKYvHbJ/VDOL5JgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048058; c=relaxed/simple;
	bh=5od/dlyb+kOp96iir0idx9mhSTAHf2cA1o63mUYRyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFJhJ1fhw68bm4g8Hs32FrWy7VxVmpeO7Hv+hlIqWflAfqy1jFCGTCPSEVuofEUuYsIT+QeATdIxzAbP//yrtgHdQ8P1rln0rVNzVXqEklokc+LSRfzlbCmDNPSnsbAy25nCNwcFH0cZptcl7RirIB/ijb4MO2AUw8ZG2X+8ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=WyJ9GZW3; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=WyJ9GZW3; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="WyJ9GZW3";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="WyJ9GZW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1789048054;
	bh=5od/dlyb+kOp96iir0idx9mhSTAHf2cA1o63mUYRyhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyJ9GZW3QkcUopEh6vawC7FhMuW04Vj3sclDIqMoygBq76NAORw19YEFXB4MdkGK+
	 7JStIiRcV+w38jI0BVECum6aTRd6RqTzACYN2zm0ZOd6mHxSLM2UkdKtmi6bb8Yint
	 v8eiipPvA962GCyPEFZcaWe20HZj8xp2q8S75WOculQs4VOG/fYpcYVYWuGAkgv5K6
	 cMDkZ7EPeP51KfDxJLgnu6UZ7XZMe6QrGpQIPM+t7+1QAlSppwJ9hzeuMZGoT7N1NA
	 /N2KZyPP+/NVqL5dp42Hs1CmN6VHq5zfd1XnutQY9Lo+E0anfgV0fIZH+/vhj07bjl
	 Vs0zrM1t4rV6g==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D3A7619329;
	Thu, 10 Sep 2026 15:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1789048054;
	bh=5od/dlyb+kOp96iir0idx9mhSTAHf2cA1o63mUYRyhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyJ9GZW3QkcUopEh6vawC7FhMuW04Vj3sclDIqMoygBq76NAORw19YEFXB4MdkGK+
	 7JStIiRcV+w38jI0BVECum6aTRd6RqTzACYN2zm0ZOd6mHxSLM2UkdKtmi6bb8Yint
	 v8eiipPvA962GCyPEFZcaWe20HZj8xp2q8S75WOculQs4VOG/fYpcYVYWuGAkgv5K6
	 cMDkZ7EPeP51KfDxJLgnu6UZ7XZMe6QrGpQIPM+t7+1QAlSppwJ9hzeuMZGoT7N1NA
	 /N2KZyPP+/NVqL5dp42Hs1CmN6VHq5zfd1XnutQY9Lo+E0anfgV0fIZH+/vhj07bjl
	 Vs0zrM1t4rV6g==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 88AA919278;
	Thu, 10 Sep 2026 15:47:34 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:47:33 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] i2c: mux: Propagate firmware nodes to channel
 adapters
Message-ID: <aqK09c9nrs1946HN@gryt>
References: <cover.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788623619.git.ahmadexp@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Sep 07, 2026 at 11:26:21PM -0700, Ahmad Byagowi wrote:
> Device Tree channel nodes are associated with the adapters created by
> i2c-mux, but equivalent firmware-node descriptions are not. Convert the
> existing lookup to generic firmware-node operations so software-node and
> ACPI descriptions can use the same property traversal.
> 
> This is the remaining I2C prerequisite split out of the Time Card series.
> The channel-node leak fix from v7 was applied to i2c-next as commit
> 385c7af4e3b9 ("i2c: mux: Fix channel node leak on adapter add failure"), so
> it is no longer included here. The first patch factors the Device Tree
> lookup into a helper without changing behavior. The second converts the
> helper and node lifetime handling to generic firmware-node operations.
> 
> The existing acpi_preset_companion() call remains in place after the generic
> lookup. A separate reference to the node returned by that lookup is retained
> because ACPI companion setup may replace the adapter's primary firmware
> node. The dependent ptp_ocp board profiles will be resent to net-next after
> the LED and I2C prerequisites land.
> 
> Changes since v9:
>   - Declare dev_node, mux_node, and child on separate lines in both patches,
>     as requested by Peter Rosin and agreed by Andy Shevchenko.
> 
> The broader __free(fwnode_handle) cleanup remains a separate follow-up.
> 
> Validation:
>   - git diff --check
>   - strict checkpatch with an 80-column limit
>   - x86-64 GCC W=1 object build of drivers/i2c/i2c-mux.o
>   - mailbox replay onto the declared base with an identical resulting tree
> 
> v9: https://lore.kernel.org/r/cover.1788298883.git.ahmadexp@gmail.com/
> 
> Ahmad Byagowi (2):
>   i2c: mux: Factor out channel node lookup
>   i2c: mux: Propagate firmware nodes to channel adapters
> 
>  drivers/i2c/i2c-mux.c | 98 +++++++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 46 deletions(-)

Thanks!

Andi, you can pick this series now, thanks.

Cheers,
Peter
