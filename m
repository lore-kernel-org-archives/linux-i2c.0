Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044283F106C;
	Fri, 28 Aug 2026 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879738; cv=none; b=uShOoK9ryRDih5w5LyAJcdXBaN9rzbQX1bTsgzxBAlBgLE7AECEZdjjTsl8D6KRzL+mW8/6mTVz5QMIu2EirssWN7tHlYUlZFEdTJOpmV7knOTcxniq9of+4K5PgTy+20u6qI7PIv7fzZF4lsFISxbGAbugYtnqMiouPKqGMV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879738; c=relaxed/simple;
	bh=6OPrenRNBbBJ04B6CdDMSyKxVeV5yNN8vFLnHY3h2oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5jleidZd2P4CJ0YaYhY+isg8smkDSgmvmPdITi626RNQRFx1QkDnwmeRDzGIQfmakyY0UPwpREFrfM5oNQgbGwFGzEL+ZLMXiyO/8phXVHgEtDdf3SwGnHXZYcWV6WF0T1mqrtbJqNOseKDYjfrhUINBbZLKLaVqj9S43gCSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCMR+bXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCMR+bXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EA21F000E9;
	Fri, 28 Aug 2026 01:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787879736;
	bh=tjtoVAfP+dy1C6cmXhievDxvscmoNznP9eEEGaFxNJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCMR+bXuUeDi3NB/19GMtpMFAxV8tERSqd1ngbyWp5HCokgKyI6hsXedl6jrp6/lt
	 Kv0tVAeZY2E7XQmPeUxYEn5ZXqsm/qJtVV0nOK1VY1yjD0WhpFmXAJuFkqKp0wsHCj
	 gZE3GnHogKAZKqIPxGxOWcOvKvs6h2i00H7urdAS0LPb8LOrunJaN4iYHLh0Lt9kG5
	 aj3pWV2D5C3HNb5OsrsETn4RylSAAJ4VaFTi4xcELaMMVCe4zoqR0BcgIPCyV6dPlo
	 7B1y4mVHduQdkYHn7UnRJ1VvqZFNLp6H2EZSbbwEY2fyQeqSI7l82YuC7f5l3tmuxr
	 CJJPzWWkydX7g==
Date: Fri, 28 Aug 2026 03:15:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] i2c: core: fix debugfs UAF on adapter removal
Message-ID: <apDhEq3fe6JWXVTE@zenone.zhora.eu>
References: <20260812-i2c-v2-1-5efaab4c3334@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-i2c-v2-1-5efaab4c3334@gmail.com>

Hi Vasileios,

On Wed, Aug 12, 2026 at 11:14:48AM +0200, Vasileios Almpanis wrote:
> i2c_del_adapter() frees the adapter's debugfs directory before it
> unregisters the adapter device, but the new_device sysfs attribute
> stays writable until device_del(). A write racing with removal still
> reaches i2c_device_probe(), which passes the freed adap->debugfs to
> debugfs_create_dir() as the new client's parent:
> 
>   BUG: KASAN: slab-use-after-free in lookup_noperm_common+0x407/0x430
>   Read of size 4 at addr ffff88803ef87810 by task syz.0.61/6090
>    lookup_noperm_common+0x407/0x430
>    simple_start_creating+0x9c/0x110
>    debugfs_start_creating+0xdb/0x1a0
>    debugfs_create_dir+0x24/0x350
>    i2c_device_probe+0x814/0xbf0
> 
> Its technically possible to create a client after i2c_deregister_clients
> has run. That client will never be unregistered and making
> wait_for_completion hang.
> 
> Close the window by removing the new_device attribute at the start of
> i2c_del_adapter(). device_remove_file() will drain any clients left.
> 
> Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
> Reported-by: syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=23ad911c819b923238b7
> Tested-by: syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
> Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>

with a few fixes in the commit messages, I pushed your patch to
i2c/i2c-fixes.

Thanks,
Andi
