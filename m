Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833653B47D7;
	Tue, 14 Jul 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049590; cv=none; b=hIeBUUZqWbvITX+/qMITwqXIidQsekoqjegfwmBAH9CvrwVHimsL27gSnQWZCMlup02eHG/u2uy+pQui92OEAv0zwWLpx4CLCRIyhYtcuDAgBbsXULxOCVJ6AfSBMY193Jpp3zQ2NrJ09ETPRTAfOPDf97mxpDz5YC+3jjsw0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049590; c=relaxed/simple;
	bh=sxIwEuYWc3RlleyJdrQ4o26TwkASynwIhP60O70hHmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsFyHYGyzLP/rpRHn8FvDPdSn44JFgt3i6xXALRw20FzleSFckuR6X3tySJa+mN68Pt/S6zJyzBaTMlHc1n9uP/FE3QgKFe5YM7HxaLuY2wnvJsw+d2zxCRN6WsOMUpM7nxZ24UvF7sp5huLUhe5iejYcblH7JTbk4hxUyMAoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJqOaedK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJqOaedK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6251F00A3D;
	Tue, 14 Jul 2026 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049589;
	bh=Q6USvoTXBFFHxgzXspxaaDau+LCZNuY+4ZI83XUqiII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJqOaedKsInact5HfkdGY2PEb02kf+JP3O5HveQqAhy9DlWS7ChifvUYw17XUKkEh
	 KOJfEZnnWl8Lp83M5h40L04L2Db9HFWYGj4+/RlwCpUHC8WuUz3XnSRD9+kqjdIK7G
	 /i6ynCyb9GtUtFD9nJBg7+BZzG4BApYJwEaCLsjz8m/kfw6OwMtsLlVe/jMrr+kpar
	 T8VuxZgnx7PDkmxc1tTQoOIX/Qi4GqmH8IbtbiQ5cLypALztY3QBDPvZXtrr0CworM
	 vSPSGezUM6v/ZayTh2hh47qzYVdfx8tyRL/6Gm3JwncR1AHcdOHC/iZjvywXW38Kz2
	 CBOAV4ORMQoJA==
Date: Tue, 14 Jul 2026 19:19:44 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, troy.mitchell@linux.spacemit.com
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
Message-ID: <alZvn3D1JXiAz_IK@zenone.zhora.eu>
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
 <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>

Hi Pei,

On Fri, Jul 10, 2026 at 03:21:13PM +0800, Pei Xiao wrote:
> When the interrupt status register reads zero, the handler should
> return IRQ_NONE instead of IRQ_HANDLED. What the return value
> actually feeds into is the spurious interrupt accounting in
> note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
> nobody cared" detection, so a stuck interrupt source would never be
> caught.
> 
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

merged to i2c/i2c-fixes.

Thanks,
Andi
