Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDE23392C
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 03:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785556345; cv=none; b=AFqvwl//AFDDVUf9yJqgOGIdkJTzssW4A3syDG7L5zEi3l8TsaJDH6pgFEi7p/RNlq9EPPZ/5zCCPMJnjKt6v68EEKWNZFryoOOkQj1Fj7T6TVUeCfLhQ39eot/krT+rGaWfAd9HFTwMDPb03wKlsSb0dIvh21mh2tS85gvi4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785556345; c=relaxed/simple;
	bh=uIxGnwmADKYTvi+KebdVMx07EkHCx2IOcWSPvxu935g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnPsXObKXYcfTOmVIp1io/IeFlncFcCmgeJdPgwfQFL5tbSlk+VS7neCHrxRb82NjhxlO652H21JuMlQasE71UuYy17vU7IAgYjYoC6OOFlb/p16Q5eNHNjYULtJ5EWyeI8COpQLXhd1yxm3OD8eXcXUf2uVX8Ya7ug/TdvhaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lHdye4Vj; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lHdye4Vj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1785556340;
	bh=2doaNvaeSdHY84NS/SmssotANpbcwyRDapzhfic2WKM=;
	h=From:Subject:Date:Message-ID;
	b=lHdye4VjnHKGLhLQkwfGvNGAvaOV6I9FUkoRHwamJXE2rfGaNWA8v/LuekhIvdMh/
	 aipWZbbEFpwpSXJskMUG6P4QPYGGMEh/WMsUlF5NFFQ7m1Qmxcmch6jvgF9xLWuIPK
	 BWGu1OZvSKhgxRllTCphrU2DZn+aazugdTKxViJk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.34) with ESMTP
	id 6A6D6CDD00005A1B; Sat, 1 Aug 2026 11:49:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 596876291689
X-SMAIL-UIID: 9D8C631DEF40449496BF22CAF745D165-20260801-114952-1
From: Hillf Danton <hdanton@sina.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Yun Zhou <yun.zhou@windriver.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: fix use-after-free in debugfs directory during adapter removal
Date: Sat,  1 Aug 2026 11:49:38 +0800
Message-ID: <20260801034940.813-1-hdanton@sina.com>
In-Reply-To: <am0YZFhbzuze-rd8@zenone.zhora.eu>
References: 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 31 Jul 2026 23:55:47 +0200 Andi Shyti wrote:
> Hi Yun,
> 
> On Wed, Jul 29, 2026 at 04:58:53PM +0800, Yun Zhou wrote:
> > Move debugfs_remove_recursive() after device_unregister() in
> > i2c_del_adapter() to fix a race condition where a new i2c device probe
> > can access the adapter's already-freed debugfs dentry.
> > 
> > The race occurs when:
> > 1. i2c_del_adapter() calls debugfs_remove_recursive(adap->debugfs),
> >    freeing the debugfs dentry.
> > 2. Before device_unregister() completes, another thread writes to the
> >    sysfs 'new_device' attribute, triggering i2c_device_probe().
> > 3. i2c_device_probe() calls debugfs_create_dir() with the stale
> >    adapter->debugfs pointer, causing a GPF in start_dirop() when
> >    trying to lock the freed inode.
> > 
> > Reported-by: syzbot+1e3d934ee3cff1ac188b@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=1e3d934ee3cff1ac188b
> > Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> 
> This is the third patch of this kind I've reviewed, starting from
> the latest. I'm sorry, but I don't need AI to send me patches; I
> can do that myself. I don't need intermediaries.
> 
> If your goal is to be replaced by AI, you're doing a pretty good
> job.
> 
> I'm NAKing this patch on principle. Read your second patch to
> understand why; read your own patches and understand them before
> sending.
> 
Given no version info in the subject line, can you show links to the
first and second patches to double check AI.

Hillf

> Andi
