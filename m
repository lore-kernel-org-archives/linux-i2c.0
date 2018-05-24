From: Peter Rosin <peda@axentia.se>
Subject: Re: Problem: lockdep warning with nested instances of i2c-mux
Date: Thu, 24 May 2018 09:32:53 +0200
Message-ID: <20180524073255.22495-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-05-24 04:25, John Sperbeck wrote:
> If an i2c topology has instances of nested muxes, then a lockdep splat
> is produced when when i2c_parent_lock_bus() is called.  Here is an
> example:
> 
> ============================================
> WARNING: possible recursive locking detected
> --------------------------------------------
> insmod/68159 is trying to acquire lock:
>   (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
> but task is already holding lock:
>   (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(i2c_register_adapter#2);
>    lock(i2c_register_adapter#2);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 1 lock held by insmod/68159:
>   #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50
> [i2c_mux]
> 
> stack backtrace:
> CPU: 13 PID: 68159 Comm: insmod Tainted: G           O
> Call Trace:
>   dump_stack+0x67/0x98
>   __lock_acquire+0x162e/0x1780
>   lock_acquire+0xba/0x200
>   rt_mutex_lock+0x44/0x60
>   i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
>   i2c_parent_lock_bus+0x3e/0x50 [i2c_mux]
>   i2c_smbus_xfer+0xf0/0x700
>   i2c_smbus_read_byte+0x42/0x70
>   my2c_init+0xa2/0x1000 [my2c]
>   do_one_initcall+0x51/0x192
>   do_init_module+0x62/0x216
>   load_module+0x20f9/0x2b50
>   SYSC_init_module+0x19a/0x1c0
>   SyS_init_module+0xe/0x10
>   do_syscall_64+0x6c/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> 
> The warning makes sense from the lockdep detector's point-of-view because
> we are locking two instances of a single lock class.  Normally, this would
> be addressed by using 'nested' variants of locks.  But rt_mutex doesn't
> expose an API for that, and it's not clear how i2c-mux can know what level
> of nesting it's at anyway.

Yes, when I modified the i2c-mux locking a couple of years ago, I also
noted the absense, and even tried to implement it, but eventually gave
up. However, that was before lockdep could even track rt_mutexes. Now
it looks easy, and I will follow up with a couple of patches (only
compile-tested, please test).

> In short, I don't have an easy patch to suggest.  But I'm not very
> familiar with the i2c code, and maybe I'm overlooking something that
> would help?
> 
> I have code for a module that emulates a chain of an i2c adapter, two
> muxes, and a slave device to show the problem.  On my system, with a
> kernel compiled with lockdep enabled, loading the module produces the
> splat.  I can post it, if the issue isn't clear from my description.

Not needed, the issue is known, I just wasn't aware that lockdep had
grown knowledge of rt-mutexes.

Thanks for the report!

Cheers,
Peter

Peter Rosin (2):
  rtmutex: allow specifying a subclass for nested locking
  i2c: mux: annotate the nested rt_mutex usage

 drivers/i2c/i2c-core-base.c |  2 +-
 drivers/i2c/i2c-mux.c       |  4 ++--
 include/linux/rtmutex.h     |  6 ++++++
 kernel/locking/rtmutex.c    | 29 +++++++++++++++++++++++++----
 4 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.11.0
