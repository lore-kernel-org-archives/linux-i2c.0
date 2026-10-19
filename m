Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393139A802;
	Mon, 19 Oct 2026 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411546; cv=none; b=prhMLX3cbpAnlHdL4cTef0vWDoJVPYVr8lfap/Ckx+qzEeGBaBMSVMxzvLw6AKxlF4a4CTHbWDV+ySX8mshUX3a6JT/zbezHVlWHmxvVAc6ilG22Xjw5VCAh6qFXaCEvrIrJANAS5CYroyF2IeKv8+8dG8lE0bmcOcee4M/KlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411546; c=relaxed/simple;
	bh=nYSS2IYw13pyhnbJO1ErGYRo3CUonH00oT9u7bgla48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNx5OCLqmkp0GpIXnUypTn2gwLpq/+l7806SA55mHr9m6z3Vdd/xbHHz4BQYV7zykagfytCMkBaIMuWG5YEHc5OyDIsAshqzYWntvm+UyKfnYL6MLe1tHNEo4U2VmnK3l9jbvFQZQ+6PruKcmc1wJLXzAzM1DE3gmYdvnpMXMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtwM4OgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtwM4OgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9E21F000C4;
	Mon, 19 Oct 2026 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411544;
	bh=k5Yyj8vCsAnzHeWLL+PbRQWwWPbgPOmrW/W5BOPg2O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dtwM4OgVnuqvtO7MIC0pbZanCORHJ1GRv65XygtPNe42XGU/H0uMvVWb9U/LUmuvb
	 kpag6MBtDnmnpIJ4ZhMVeB/mOpBe+OcFoFFzg0hPvUSprvWDvIIeaPnRF3IBfn0q2l
	 aGXv3vY2IJgEzOypJglAJ7VXXNqwhzoaE0kcgEeeCqFtpVMqNLy8aDkRdO8yOCRuX+
	 bWjQEu/f7CYFnl3Eq+XuC0pDz6El/vFXOH5MSMsXj8qd7IAkMQmiH6IsL7UzHS8B/K
	 aD69AgcoNwqX8rkNNX/5uqOZUaMZglecUNgdqY2kqKO8a33vQ5xXz+u1nWzPB4dIHx
	 j/2veTfOf/MyQ==
Date: Mon, 19 Oct 2026 14:05:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+ed3ada41c4eb1c4ab78e@syzkaller.appspotmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-i2c@vger.kernel.org
Subject: Re: [syzbot] [usb?] WARNING in ec168_ctrl_msg/usb_submit_urb
Message-ID: <atYHEIRoE_I-EenD@zenone.zhora.eu>
References: <6ad4f154.a6d1a155.34a93f.00b5.GAE@google.com>
 <0a758fb7-6c71-4e59-a9df-0d2a71649f1e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a758fb7-6c71-4e59-a9df-0d2a71649f1e@rowland.harvard.edu>

Hi,

On Sun, Oct 18, 2026 at 12:30:24PM -0400, Alan Stern wrote:
> On Sun, Oct 18, 2026 at 09:18:28AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    4056b3c9d3c9 Merge tag 'nios2_update_for_v7.4' of git://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11370ce1580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ed3ada41c4eb1c4ab78e
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114faaea580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154faaea580000
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4056b3c9.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/811a43c89106/vmlinux-4056b3c9.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2bb4f3abea76/bzImage-4056b3c9.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ed3ada41c4eb1c4ab78e@syzkaller.appspotmail.com
> 
> This looks like another example of a 0-length I2C-over-USB read.  It 
> would be nice if we could rule out these things at all at once, instead 
> of going after them piecemeal.
> 
> Alternatively, this WARN() in the USB core could be reduced to something 
> less severe in the case of length-0 control reads.  We haven't been 
> seeing very many instances of it apart from I2C, and those have only 
> occurred during fuzzing.

I am about to send a patch for it, we just need to disallow size
'0' read messages:

@@ -115,7 +115,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
-				if (msg[i].len < 1) {
+				if (msg[i].len < 1 || msg[i+1].len < 1) {
 					i = -EOPNOTSUPP;
 					break;
 				}

Thanks,
Andi
