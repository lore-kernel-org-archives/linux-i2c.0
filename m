From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Date: Mon, 1 Apr 2019 12:47:56 +0200
Message-ID: <20190401104756.GK11158@hirez.programming.kicks-ass.net>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 27, 2019 at 10:12:56PM +0100, Wolfram Sang wrote:
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit message says
> explicitly it was added "for cases where I2C transactions have to occur
> at times interrups are disabled". So, the intention was 'disabled
> interrupts'. This matches the use cases for atomic I2C transfers I have
> seen so far: very late communication (mostly to a PMIC) to powerdown or
> reboot the system. For those cases, interrupts are disabled then. It
> doesn't seem that in_atomic() adds value.
> 
> Note that only ~10 out of ~120 bus master drivers support atomic
> transfers, mostly by polling always when no irq is supplied. A generic
> I2C client driver cannot assume support for atomic transfers. This is
> currently a platform-dependent corner case.
> 
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). Because I don't want to
> add more in_atomic() to the I2C core, this patch simply removes it.
> 
> [1] https://lwn.net/Articles/274695/
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> So, I had to dive into this in_atomic() topic and this is what I
> concluded. I don't see any reasonable constellation where this could
> cause a regression, but I am all open for missing something and being
> pointed to it. This is why the patch is RFC. I'd really welcome
> comments. Thanks!
> 
> 
>  drivers/i2c/i2c-core-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..943bebeec3ed 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	 *    one (discarding status on the second message) or errno
>  	 *    (discarding status on the first one).
>  	 */
> -	if (in_atomic() || irqs_disabled()) {
> +	if (irqs_disabled()) {
>  		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
>  		if (!ret)
>  			/* I2C activity is ongoing. */

So I know absolutely nothing about i2c, except that it is supposedly
fsck all slow.

In that context, busy-spinning for i2c completions seems like a terrible
idea, _esp_ in atomic contexts.

I did a quick grep for trylock_bus() and found i2c_mux_trylock_bus()
which uses rt_mutex_trylock and therefore the calling context must
already exclude IRQs and NMIs and the like.

That leaves task context with preemption/IRQs disabled. Of that, you
retain the IRQs disabled test, which is by far the worst possible
condition to spin-wait in.

Why must we allow i2c usage with IRQs disabled? Just say NO?
