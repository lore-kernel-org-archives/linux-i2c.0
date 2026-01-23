Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769E226CF6;
	Fri, 23 Jan 2026 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171704; cv=none; b=DcCAQbisWizejykWr0CzYpbjz+pXbnHIfNgkebBsB43tef8qFUJ1sA/+rXiRFtIQhhqikIjJVbyDVzFcblfVw7t7gS0FfgzXK0f5R/hoQ2263c3U/1qi5BjkKkW2Y8adBOfQT0bkrpdngfPUAkWbSw1QSp6dL4ljpaNoF6HlXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171704; c=relaxed/simple;
	bh=qmI7V101Cm/mGNwRBjAE6kN7lHe9kgNlUfPyPmrCydU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UtOIKn9TVJPmE+l0yQNKKxMPveBWDlx2TZsj/9yqPIp3RMhSfDrunpQUFmc/zO+94kfFmEj97a3MsIwmUSF3xWGnroEstW/L5IPf9vOpyjp2lrWXjhDjx5d/t1PKjl76do3p5JQyokHe8GWowfxUxEn14Eo6mugM1+XUcXDWN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loZLWsPM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loZLWsPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA0C4CEF1;
	Fri, 23 Jan 2026 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769171703;
	bh=qmI7V101Cm/mGNwRBjAE6kN7lHe9kgNlUfPyPmrCydU=;
	h=Date:From:To:Cc:Subject:From;
	b=loZLWsPMYhXNVI2/88a61fN4y9C+/i9vZV44NFOnkGf966VsWRJa7rs5VEGey/5h6
	 etVpESfDhBzVNSo0ErebBhKEo+yaGEyMxeDz5L7dDyUr+IXhUqmBCAHd76ky53ZYU0
	 bNwWAslwITbnLl95YBgdYR/96fK5CFcsMB4JXp6mW3KhALiLvqFKXg5eM/5OYd/f3K
	 vf+5Ngygz5LLnr+pI3yR5Lw0c9DdHJ1NUHo+Z0whyt5vqfzOD8/I0EemyFTL/Oi47l
	 CLw6aOVVmk4fEmSqVrHcX2zmbYRkmVf3phwhkE2VptaxoF96cD1O0KclBJvvhZ5nXN
	 Qd16I3hUNF83w==
Date: Fri, 23 Jan 2026 13:34:59 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host-fixes for v6.19-rc7
Message-ID: <aXNqakUtNhWJdgLW@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

one fix for this week. It addresses a genirq warning in the
SpacemiT K1 driver by dropping the IRQF_ONESHOT flag, which is
not supposed to be used without a threaded handler.

Thank you and I wish you a great weekend,
Andi

The following changes since commit ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1:

  Merge tag 'nfsd-6.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2025-12-24 09:23:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-fixes-6.19-rc7

for you to fetch changes up to e351836a54e3b0b4483f896abcd6a0dc71097693:

  i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request (2026-01-22 14:07:58 +0100)

----------------------------------------------------------------
i2c-host-fixes for v6.19-rc7

k1: drop IRQF_ONESHOT from IRQ request to fix genirq warning.

----------------------------------------------------------------
Yixun Lan (1):
      i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request

 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
