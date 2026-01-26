Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318C30C35F;
	Mon, 26 Jan 2026 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401312; cv=none; b=k1TvNc/vuO+t5+z87uGQRVLWrAbESIOf3EFFsmeu1PHmWrEt0fm5LSogUkS+tCTmX0JJWr6qMmIE6BdQwxyEJr5jlVf8I3+CPeT/Eb+trvPf7HFg7znhSXZILdjJao/76S1s9hB8lFkN7IcuySRP4c2p0Zau8GDCe6Z7/u4YTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401312; c=relaxed/simple;
	bh=O0Chq8FOwcKLbBZ6GgKrruLCkSBIdndz2GCwD70Bmn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUQMJb34yvz5mIIn+9jI/kbZvY7F1ZI4/7m47wevebrYao3PnH2cmh1O5STIIeQtgijSoTTWNlTfcjDaJsxtuC2SRiF4CjddhiIi21h9QksMrpKewZAqwe0FQamSWuWQw9E+haBt/ScN+m9cM/5xIcMaUkTrRR9rKdtOU55RiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaugFFuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaugFFuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC6C19425;
	Mon, 26 Jan 2026 04:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769401312;
	bh=O0Chq8FOwcKLbBZ6GgKrruLCkSBIdndz2GCwD70Bmn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AaugFFuUyWDMrG0RBi0+t/mFV/TECAGxCNW/Xu1Bmy1HggS4k1oszf5b1CTFJkL7n
	 plVJXS37a/bz+oRkMg+vPrEw9XI4sHC3xB8OFG0PioyPHsqtLqg09CEva07c6QRMwj
	 24wX0YlE+Oo/+IfsdCy29FfUwxMOvyXG62zCq6WPvxB1FfEy4aJBqxs2Q9czXo2WJo
	 CM4Z1Kmrcj9BWS4sPA6y1+T9r4WWM/zJuuDb94Po0dcJhqsVz6fUrxJCpGQBDo/I5N
	 Qo0W4/3hJNgVX41JM4SsKIWB6KLjHWlRmnz9I1jlYAry8IBo+1GGPbWCNQcneA+W/w
	 jWRlGN5q9SqwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBF83809A22;
	Mon, 26 Jan 2026 04:21:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 11/21] i2c: spacemit: Remove IRQF_ONESHOT
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176940130684.4057692.5555017535441416202.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 04:21:46 +0000
References: <20260123113708.416727-12-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-12-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, tglx@kernel.org,
 troy.mitchell@linux.spacemit.com, andi.shyti@kernel.org, dlan@gentoo.org,
 linux-i2c@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andi Shyti <andi.shyti@kernel.org>:

On Fri, 23 Jan 2026 12:36:57 +0100 you wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> [...]

Here is the summary with links:
  - [11/21] i2c: spacemit: Remove IRQF_ONESHOT
    https://git.kernel.org/riscv/c/e351836a54e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


