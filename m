Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790631F9BD;
	Fri, 31 Jul 2026 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534953; cv=none; b=u6pKj/+YVRAjIe10Bfo7gzycXF989y1GHzRMkrYy9Cif1dXFb6HqImsp2sT52gwDDURHeEu0fXsEmQ+NY+C4b0vwFv8bqFIo6pOoijpldRtIaA3vPe3XbBl1AsjX33z6WVzdk1TLOP6Kv6DATfWLPSRon9rMiMYYGO7mpZYhjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534953; c=relaxed/simple;
	bh=fYf1qlL9j9qyQCOrVi/D5QORIS35BCtc3xBzPK0cZl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVvMNPnn/4f/Br0ByQO/OXHCsG9GR6Lezgn6kY8t4vUdttl5Ve7LgeVpE5lA6H9zzBYjzmdMXxwdWmEE0fZ/UVdda+dtOy1ieB8+LUm0x67RYMvMjcNcN8TNRfAwKl4yOzhBb3O+UjLmf0pZ77sx425wkTbAMcmJPf4KKykvvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDYBXAiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDYBXAiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F341F00AC4;
	Fri, 31 Jul 2026 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534952;
	bh=cMSjTqdHknhfls9RT4vAyO+9IODQTaIP2vwd4ElelXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RDYBXAiQZes7pSarPogQTeWLkGXhEdvxQlEwasx0n6xxQz/GL+3UKx0BGsbB8PPAT
	 pjvn30hL0SZgbGo34CO/pkc6zv6kCiZ5B0EsmBbrwKxo2jlXjWfRAO2OY6y/bf+HlP
	 zSnbwjDUkDeqcVjikB0TUG1VyvmqNefe5VP//DkhR41qgJfCIKLX0lHCdqlfb+x67G
	 QiuUBzCUc18jaJF9vYNsWzFpLqHOsYwJkiyMgzDyn1pUeYavK7KUOxNn5z8m08U1Mr
	 ApU4mqYeRtHHsCDt9WQddzL+UFDG0UMZ8admYj/e32rtrZiHR0/jtn+pGY0Nh7rHur
	 vg16WGnx3aLmw==
Date: Fri, 31 Jul 2026 23:55:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: fix use-after-free in debugfs directory during
 adapter removal
Message-ID: <am0YZFhbzuze-rd8@zenone.zhora.eu>
References: <20260729085853.1624451-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729085853.1624451-1-yun.zhou@windriver.com>

Hi Yun,

On Wed, Jul 29, 2026 at 04:58:53PM +0800, Yun Zhou wrote:
> Move debugfs_remove_recursive() after device_unregister() in
> i2c_del_adapter() to fix a race condition where a new i2c device probe
> can access the adapter's already-freed debugfs dentry.
> 
> The race occurs when:
> 1. i2c_del_adapter() calls debugfs_remove_recursive(adap->debugfs),
>    freeing the debugfs dentry.
> 2. Before device_unregister() completes, another thread writes to the
>    sysfs 'new_device' attribute, triggering i2c_device_probe().
> 3. i2c_device_probe() calls debugfs_create_dir() with the stale
>    adapter->debugfs pointer, causing a GPF in start_dirop() when
>    trying to lock the freed inode.
> 
> Reported-by: syzbot+1e3d934ee3cff1ac188b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1e3d934ee3cff1ac188b
> Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

This is the third patch of this kind I've reviewed, starting from
the latest. I'm sorry, but I don't need AI to send me patches; I
can do that myself. I don't need intermediaries.

If your goal is to be replaced by AI, you're doing a pretty good
job.

I'm NAKing this patch on principle. Read your second patch to
understand why; read your own patches and understand them before
sending.

Andi
