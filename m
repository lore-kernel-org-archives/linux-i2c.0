Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9D39185E
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624872; cv=none; b=h8BAasmd9Xy1R1JquQhc4iKxFDFyW9dYY2mT9mLfAcX6x7Vv/wG3CLt76T7naXb5CysKo3FJLBJy82aEDlssLNwwHztNchBDG4yveW9Oj1352E21qRNNTOwUWipRbT+F2NFQvM3m0CVCyTQTuylVa+Vso1qdNrZVLi0YNTJ2NSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624872; c=relaxed/simple;
	bh=9/xsdc53uAUjjTYpBMMPkEX3TVheiEcOLlJDhx1rKG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxr1q6Oo7MKofTW1IZFc/Uyp4LbkuLgSbKb4HhL8LryhhPsRmzJkTAxnwK821xXRY6KpupLzqjXjoROvFF++rY6kI6r2JKhL0TZxwZPNHHyTaJsKMPXoYgxKE1sM2ZbWcYnkvVRGALYiq2rq9kFNShIZAMfD2wN/eaTDq+cdvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AIrh7uBl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AIrh7uBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=yDpb
	rY0VpTE6Ew90R4jAWRR9lECDV1tKRX/X7Sriof8=; b=AIrh7uBl8dE/5BsVs8Ve
	Hz21Djr9jSYuswALJ4PvGx2UlmlcF5F01K1/U38kUmTiMo5454M/OFEHA901K6wA
	980H5vrrXZZKQTl2BJTHpnUvJ4WnUVRNECKLriB6y4MixnKdUhq3dcCiPjz9CC03
	+YxKpkMO354LmzmILNQNFdBHcRuDgh3GsaT/99DXLq6KJp26TRu9Xvzo1NQj391p
	DBnk4yNuUfOFb/LTaYLbKPxQ/3pfVgOJisE0uMeGPh21NO70cDAFMuKmkxR6t3cd
	nboRIHaa4TD2v6Q8KUz9NAAoqtL4Es2zl8UaCzuGE0ldCYSvWEWeOOYARU9afll8
	yw==
Received: (qmail 719675 invoked from network); 4 Mar 2026 12:47:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Mar 2026 12:47:45 +0100
X-UD-Smtp-Session: l3s3148p1@cYZjYzFMbTptKXG7
Date: Wed, 4 Mar 2026 12:47:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Charles Haithcock <chaithco@redhat.com>
Cc: jdelvare@suse.com, andi.shyti@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: i801: Revert "i2c: i801: replace acpi_lock with I2C
 bus lock"
Message-ID: <aagb4JyCv0IOCp32@shikoro>
References: <20260228014124.1884412-1-chaithco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228014124.1884412-1-chaithco@redhat.com>

On Fri, Feb 27, 2026 at 06:41:15PM -0700, Charles Haithcock wrote:
> This reverts commit f707d6b9e7c18f669adfdb443906d46cfbaaa0c1.
> 
> Under rare circumstances, multiple udev threads can collect i801 device
> info on boot and walk i801_acpi_io_handler somewhat concurrently. The
> first will note the area is reserved by acpi to prevent further touches.
> This ultimately causes the area to be deregistered. The second will
> enter i801_acpi_io_handler after the area is unregistered but before a
> check can be made that the area is unregistered. i2c_lock_bus relies on
> the now unregistered area containing lock_ops to lock the bus. The end
> result is a kernel panic on boot with the following backtrace;
> 
> [   14.971872] ioatdma 0000:09:00.2: enabling device (0100 -> 0102)
> [   14.971873] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   14.971880] #PF: supervisor read access in kernel mode
> [   14.971884] #PF: error_code(0x0000) - not-present page
> [   14.971887] PGD 0 P4D 0
> [   14.971894] Oops: 0000 [#1] PREEMPT SMP PTI
> [   14.971900] CPU: 5 PID: 956 Comm: systemd-udevd Not tainted 5.14.0-611.5.1.el9_7.x86_64 #1
> [   14.971905] Hardware name: XXXXXXXXXXXXXXXXXXXXXXX BIOS 1.20.10.SV91 01/30/2023
> [   14.971908] RIP: 0010:i801_acpi_io_handler+0x2d/0xb0 [i2c_i801]
> [   14.971929] Code: 00 00 49 8b 40 20 41 57 41 56 4d 8b b8 30 04 00 00 49 89 ce 41 55 41 89 d5 41 54 49 89 f4 be 02 00 00 00 55 4c 89 c5 53 89 fb <48> 8b 00 4c 89 c7 e8 18 61 54 e9 80 bd 80 04 00 00 00 75 09 4c 3b
> [   14.971933] RSP: 0018:ffffbaa841483838 EFLAGS: 00010282
> [   14.971938] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9685e01ba568
> [   14.971941] RDX: 0000000000000008 RSI: 0000000000000002 RDI: 0000000000000000
> [   14.971944] RBP: ffff9685ca22f028 R08: ffff9685ca22f028 R09: ffff9685ca22f028
> [   14.971948] R10: 000000000000000b R11: 0000000000000580 R12: 0000000000000580
> [   14.971951] R13: 0000000000000008 R14: ffff9685e01ba568 R15: ffff9685c222f000
> [   14.971954] FS:  00007f8287c0ab40(0000) GS:ffff96a47f940000(0000) knlGS:0000000000000000
> [   14.971959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   14.971963] CR2: 0000000000000000 CR3: 0000000168090001 CR4: 00000000003706f0
> [   14.971966] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   14.971968] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   14.971972] Call Trace:
> [   14.971977]  <TASK>
> [   14.971981]  ? show_trace_log_lvl+0x1c4/0x2df
> [   14.971994]  ? show_trace_log_lvl+0x1c4/0x2df
> [   14.972003]  ? acpi_ev_address_space_dispatch+0x16e/0x3c0
> [   14.972014]  ? __die_body.cold+0x8/0xd
> [   14.972021]  ? page_fault_oops+0x132/0x170
> [   14.972028]  ? exc_page_fault+0x61/0x150
> [   14.972036]  ? asm_exc_page_fault+0x22/0x30
> [   14.972045]  ? i801_acpi_io_handler+0x2d/0xb0 [i2c_i801]
> [   14.972061]  acpi_ev_address_space_dispatch+0x16e/0x3c0
> [   14.972069]  ? __pfx_i801_acpi_io_handler+0x10/0x10 [i2c_i801]
> [   14.972085]  acpi_ex_access_region+0x5b/0xd0
> [   14.972093]  acpi_ex_field_datum_io+0x73/0x2e0
> [   14.972100]  acpi_ex_read_data_from_field+0x8e/0x230
> [   14.972106]  acpi_ex_resolve_node_to_value+0x23d/0x310
> [   14.972114]  acpi_ds_evaluate_name_path+0xad/0x110
> [   14.972121]  acpi_ds_exec_end_op+0x321/0x510
> [   14.972127]  acpi_ps_parse_loop+0xf7/0x680
> [   14.972136]  acpi_ps_parse_aml+0x17a/0x3d0
> [   14.972143]  acpi_ps_execute_method+0x137/0x270
> [   14.972150]  acpi_ns_evaluate+0x1f4/0x2e0
> [   14.972158]  acpi_evaluate_object+0x134/0x2f0
> [   14.972164]  acpi_evaluate_integer+0x50/0xe0
> [   14.972173]  ? vsnprintf+0x24b/0x570
> [   14.972181]  acpi_ac_get_state.part.0+0x23/0x70
> [   14.972189]  get_ac_property+0x4e/0x60
> [   14.972195]  power_supply_show_property+0x90/0x1f0
> [   14.972205]  add_prop_uevent+0x29/0x90
> [   14.972213]  power_supply_uevent+0x109/0x1d0
> [   14.972222]  dev_uevent+0x10e/0x2f0
> [   14.972228]  uevent_show+0x8e/0x100
> [   14.972236]  dev_attr_show+0x19/0x40
> [   14.972246]  sysfs_kf_seq_show+0x9b/0x100
> [   14.972253]  seq_read_iter+0x120/0x4b0
> [   14.972262]  ? selinux_file_permission+0x106/0x150
> [   14.972273]  vfs_read+0x24f/0x3a0
> [   14.972284]  ksys_read+0x5f/0xe0
> [   14.972291]  do_syscall_64+0x5f/0xe0
> ...
> 
> The kernel panic is mitigated by setting limiting the count of udev
> children to 1. Revert to using the acpi_lock to continue protecting
> marking the area as owned by firmware without relying on a lock in
> a potentially unmapped region of memory.
> 
> Signed-off-by: Charles Haithcock <chaithco@redhat.com>

Boy, this was probably a hard one, kudos for fixing it and sorry about
the regression. I added a fixes tag and improved the original comment to
emphasize the importance of the lock.

Applied to for-current, thanks!

