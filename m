From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Fri, 17 Oct 2008 13:16:00 +0200
Message-ID: <20081017131600.44fa99a1@hyperion.delvare>
References: <20080821.024322.35962617.davem@davemloft.net>
	<20081015141914.7d6c3dd5@hyperion.delvare>
	<48F662A5.4050303@linuxtv.org>
	<20081016181707.4878bf31@hyperion.delvare>
	<48F788C0.10300@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48F788C0.10300-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Thu, 16 Oct 2008 14:32:32 -0400, Michael Krufky wrote:
> Jean Delvare wrote:
> > Can you clarify your requirements? I'm not sure I understand exactly
> > what you need. Do you need exclusive access to the I2C bus for a number
> > of transactions? Or do you need exclusive access to the I2C bus for an
> > arbitrary period of time? Or do you need to block access to the I2C bus
> > entirely? How do you know when to start the blackout period, and when
> > to end it?
> >
> > We have to design a new mechanism so I would like to make sure that
> > whatever I come up with, fits at least your needs and those of David.
> I need to block access to the i2c bus for the duration of a long series 
> of i2c_transfer calls from anybody other than the client module 
> currently being initialized.
> 
> Basically, I have an i2c client that must not be interrupted during 
> initialization of the part.  I need to be able to implement the 
> following behavior (in pseudocode)
> 
> int crappychip_init() {
>     lock host adapter i2c bus -- if bus is already locked, then block 
> until it is unlocked.
> 
>     do initialization (many calls to i2c_transfer)
> 
>     unlock host adapter i2c bus.
> }
> 
> 
> ...so I basically need the ability to host a mutex on the i2c adapter, 
> have a way for the i2c client to lock and unlock the mutex, and all 
> OTHER i2c clients on the bus must not be able to do i2c transactions 
> while the mutex is locked.
> 
> ...but there is a gotcha -- the other i2c client drivers will not know 
> anything about the host adapter, nor will they know that they need to 
> use a locking mechanism before handling i2c transactions -- the locking 
> needs to be built-in to the host adapter's handling of i2c_transfer.
> 
> So, what I *really* need is for the i2c host adapter itself to lock or 
> unlock the i2c bus, based on a signal from a given i2c client module 
> that a series of i2c transactions are volatile and no other i2c traffic 
> is allowed until this long block of transactions are complete.  The 
> "large blocks of transactions" can be a large series of multiple calls 
> to i2c_transfer, and can be directed to more than just one i2c address.
> 
> I think you made a suggestion a few months back, but I don't remember 
> exactly what you had in mind.  One idea that I can think of is that the 
> i2c client module should request some uniquely generated id, and pass 
> this id into the call to i2c_transfer so that it knows that this 
> particular transaction is allowed to occur regardless of the state of 
> the lock on the i2c bus.
> 
> Making matters more complicated, the "do initialization" pseudocode part 
> above involves i2c transactions to two different IC's, but we must not 
> allow any communication to these IC's to occur other than the 
> transactions occurring in the "do initialization" sequence.  ie, no 
> probing allowed during this time, not even probing of IC's being 
> initialized.  The part being initialized is behind an i2c gate of 
> another part, and the i2c gate _must_ be closed after each i2c write and 
> opened before the next i2c write, due to a bug in the silicon.
> 
> 
> I hope that describes the situation well enough -- Please let me know if 
> you need any clarification.

Thanks for the detailed explanation. It's not clear to me that pre/post
transaction hooks are the way to solve your problem, so let's not try
to come up with a generic solution now, that would only slow down
everything. Instead, I'll commit David's i2c-algo-pcf-specific hooks
(or actually a modified version thereof, see the conditional vs. empty
callbacks discussion elsewhere in this thread) now, and we can
generalize it later if and only if it seems appropriate.

As far as your bus exclusivity problem is concerned, there might
already a solution to it. I am a bit hesitant to tell you because it
would make you use structure members which so far were meant for
internal use of i2c-core. But OTOH, if you only need it for one
specific driver, it may be better to do that than add a new
full-fledged API.

The adapter-hosted mutex you wish to add already exists. It's called
i2c_adapter.bus_lock. It's currently used by i2c_transfer() and
i2c_smbus_xfer(). This is how we serialize access to each I2C bus. So,
you could take this mutex in your code, do the device initialization,
and then release the mutex.

Of course, while you hold the mutex, you can't use i2c_transfer (nor
i2c_master_send nor i2c i2c_master_recv, as these functions call
i2c_transfer) so you would instead have to call
adapter->algo->master_xfer() directly. Not exactly elegant, but it
should work.

The alternative is to implement a new API granting exclusive access to
an I2C bus. Something like:

void i2c_adapter_exclusive_get(struct i2c_adapter *adapter);
void i2c_adapter_exclusive_put(struct i2c_adapter *adapter);
int i2c_transfer_exclusive(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num);

These would essentially be wrappers around adapter->bus_lock and
adapter->algo->master_xfer. This should work, but I'm not sure if the
additional overhead is worth it. I guess it depends on how many drivers
need to do that kind of things in the future.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
