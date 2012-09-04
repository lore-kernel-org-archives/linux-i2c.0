From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: i2c-core multiplexer handling triggers dep-lock validator
Date: Tue, 04 Sep 2012 14:19:47 +0200
Message-ID: <5045F1E3.10407@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean, *

our local kernel maintainers decided to switch on lock dependency check
(CONFIG_PROVE_LOCKING) and this got a hit when multiplexer is removed
while sub devices to its ports are registered:
> hpd_i2c_disconn/15357 is trying to acquire lock:
>  (&adap->userspace_clients_lock){+.+.+.}, at: [<ffffffff80417a14>] i2c_del_adapter+0xe4/0x350
> 
> but task is already holding lock:
>  (&adap->userspace_clients_lock){+.+.+.}, at: [<ffffffff804174cc>] i2c_sysfs_delete_device+0x74/0x218
> 
> other info that might help us debug this:
> 2 locks held by hpd_i2c_disconn/15357:
>  #0:  (&buffer->mutex){+.+.+.}, at: [<ffffffff80276d4c>] sysfs_write_file+0x4c/0x208
>  #1:  (&adap->userspace_clients_lock){+.+.+.}, at: [<ffffffff804174cc>] i2c_sysfs_delete_device+0x74/0x218

Looking into matters I found that all is ok, this is a false positive.
lockdep-design.txt handles this situation on a hard-disc example and
recommends usage of mutex_lock_nested().

Are you already aware of the problem, even have already a patch in queue
or is this waiting for a volunteer?

-- 
KR
Michael
