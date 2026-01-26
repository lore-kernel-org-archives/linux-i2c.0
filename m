Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AC45BE3;
	Mon, 26 Jan 2026 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401311; cv=none; b=RE8uEqW9X/i4re2xIONXqlHoPIF50/lkPu4UKf00eKBfzqLSF5vID8yjPrqBJPy6mszPzORTV3vmKtY6eCPPMWz0nFsIkcvRyMQnDJJzTrkk4WM6/orBYWcq803G4h8cJoV1Ad8t4C5S7Tv15KtohRdeb67Zebs3y4VC8YkJbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401311; c=relaxed/simple;
	bh=/vXTBfeE725mECzMswPlT8VIsWW85GRiOqx6wcOhv/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=denxm5qgzZo5sIN8m2/qeFzTLNRdCcvB1+rbUqj4E4uRqbmCqDTvV5f4mIWuLpNFx29Cjr4YIuqVU2YVEaBnEK/YI+h9XTlgz/Hrr6vFg3duM/+1dy3h9aubjR+9T7ySNNk21zUEGbGKC+sY0yth1kJcVe/arsCFDVJ8bGt5wCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjoDNyQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjoDNyQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FF1C19422;
	Mon, 26 Jan 2026 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769401310;
	bh=/vXTBfeE725mECzMswPlT8VIsWW85GRiOqx6wcOhv/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NjoDNyQPCOhKTyr7GfI6wYkhJo3a5jfDCB9kKoG4YIQ4c7VUjLLf65hh6C4oRd4s0
	 SDwNhZ77jGdDiSOiNahHqsGHTdPlwzqcWdNjRtauNPz39RNgNEyBdDSBf0c4LNAZmQ
	 cEzB5OlJ4FBLGK+qkxrZXgCDIUlVC9ZoFlFFZd82nvEhiC9l0gn7g+KkpRY3ju3jyx
	 z4u65YJeqAMvkGN037DCwCiqRHfIjlVXXsJEH8dwH283gzABIKRywyu0aQCQmNJO2u
	 4fihUj0CFvOh4IhAPoo0rwTOQWPmykEy8XR6Ss1rfCFnubj/DK6AP4xsemQjYWhwte
	 B8zgWtpOZSRJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8EDB3809A22;
	Mon, 26 Jan 2026 04:21:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176940130560.4057692.15383272493073261611.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 04:21:45 +0000
References: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
In-Reply-To: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: linux-riscv@lists.infradead.org, andi.shyti@kernel.org,
 troy.mitchell@linux.spacemit.com, elder@riscstar.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andi Shyti <andi.shyti@kernel.org>:

On Thu, 22 Jan 2026 07:52:00 +0800 you wrote:
> In commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
> threaded handler")[1], it will check IRQF_ONESHOT flag in IRQ request,
> and gives a warning if there is no threaded handler. Drop this flag to
> fix this warning.
> 
> Link: https://lore.kernel.org/r/20260112134013.eQWyReHR@linutronix.de/ [1]
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> 
> [...]

Here is the summary with links:
  - i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
    https://git.kernel.org/riscv/c/e351836a54e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


