From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rtmutex: allow specifying a subclass for nested
 locking
Date: Mon, 10 Sep 2018 19:27:12 -0400
Message-ID: <20180910232712.fcpdfaagm4xdb24n@home.goodmis.org>
References: <20180720083914.1950-1-peda@axentia.se>
 <20180720083914.1950-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720083914.1950-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

I just noticed this patch because it conflicted with the PREEMPT_RT v4.14
patch.

On Fri, Jul 20, 2018 at 10:39:13AM +0200, Peter Rosin wrote:
> Needed for annotating rt_mutex locks.
> 
> Tested-by: John Sperbeck <jsperbeck@google.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  include/linux/rtmutex.h  |  7 +++++++
>  kernel/locking/rtmutex.c | 29 +++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
> index 1b92a28dd672..6fd615a0eea9 100644
> --- a/include/linux/rtmutex.h
> +++ b/include/linux/rtmutex.h
> @@ -106,7 +106,14 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
>  extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
>  extern void rt_mutex_destroy(struct rt_mutex *lock);
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
> +#define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
> +#else
>  extern void rt_mutex_lock(struct rt_mutex *lock);
> +#define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
> +#endif
> +
>  extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
>  extern int rt_mutex_timed_lock(struct rt_mutex *lock,
>  			       struct hrtimer_sleeper *timeout);
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 4f014be7a4b8..2823d4163a37 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1465,6 +1465,29 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
>  		rt_mutex_postunlock(&wake_q);
>  }
>  
> +static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
> +{
> +	might_sleep();
> +
> +	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
> +	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
> +}
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +/**
> + * rt_mutex_lock_nested - lock a rt_mutex
> + *
> + * @lock: the rt_mutex to be locked
> + * @subclass: the lockdep subclass
> + */
> +void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
> +{
> +	__rt_mutex_lock(lock, subclass);
> +}
> +EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);


> +#endif
> +
> +#ifndef CONFIG_DEBUG_LOCK_ALLOC

Why this:

#ifdef CONFIG_DEBUG_LOCK_ALLOC
[..]
#endif

#ifndef CONFIG_DEBUG_LOCK_ALLOC
[..]
#endif

???

This should use #else.

-- Steve


>  /**
>   * rt_mutex_lock - lock a rt_mutex
>   *
> @@ -1472,12 +1495,10 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
>   */
>  void __sched rt_mutex_lock(struct rt_mutex *lock)
>  {
> -	might_sleep();
> -
> -	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> -	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
> +	__rt_mutex_lock(lock, 0);
>  }
>  EXPORT_SYMBOL_GPL(rt_mutex_lock);
> +#endif
>  
>  /**
>   * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
> -- 
> 2.11.0
