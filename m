From: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Thu, 16 Oct 2008 14:32:32 -0400
Message-ID: <48F788C0.10300@linuxtv.org>
References: <20080821.024322.35962617.davem@davemloft.net>	<20081015141914.7d6c3dd5@hyperion.delvare>	<48F662A5.4050303@linuxtv.org>
	<20081016181707.4878bf31@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081016181707.4878bf31-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
>>> Michael, do you still need this for i2c-algo-bit? We did not discuss
>>> this again recently, so I admit I don't know what is the status of this
>>> request.
>>>       
>> Jean,
>>
>> Yes, the problem still exists, and I still need a way to lock the i2c 
>> adapter during certain volitile operations at driver start-up.
>>
>> Right now I have an artificial delay in place as a workaround, but 
>> that's only because there currently is no other choice.
>>     
>
> I'm really sorry. As you didn't come back to me about this issue, I
> wrongly assumed that you had solved it in another way and you were no
> longer interested in adding these hooks to i2c-algo-bit. If you still
> need it then let's get this sorted out.
>   

It's not my top priority right now.  I have been able to work around the 
issue by sacrificing efficiency, although a real fix would be better for 
the long run.


>> Basically, I have a single piece of silicon that is capable of bringing 
>> down the entire i2c bus if somebody attempts to communicate with any 
>> other IC during initialization of this silicon.
>>     
>
> Can you clarify your requirements? I'm not sure I understand exactly
> what you need. Do you need exclusive access to the I2C bus for a number
> of transactions? Or do you need exclusive access to the I2C bus for an
> arbitrary period of time? Or do you need to block access to the I2C bus
> entirely? How do you know when to start the blackout period, and when
> to end it?
>
> We have to design a new mechanism so I would like to make sure that
> whatever I come up with, fits at least your needs and those of David.
I need to block access to the i2c bus for the duration of a long series 
of i2c_transfer calls from anybody other than the client module 
currently being initialized.

Basically, I have an i2c client that must not be interrupted during 
initialization of the part.  I need to be able to implement the 
following behavior (in pseudocode)

int crappychip_init() {
    lock host adapter i2c bus -- if bus is already locked, then block 
until it is unlocked.

    do initialization (many calls to i2c_transfer)

    unlock host adapter i2c bus.
}


...so I basically need the ability to host a mutex on the i2c adapter, 
have a way for the i2c client to lock and unlock the mutex, and all 
OTHER i2c clients on the bus must not be able to do i2c transactions 
while the mutex is locked.

...but there is a gotcha -- the other i2c client drivers will not know 
anything about the host adapter, nor will they know that they need to 
use a locking mechanism before handling i2c transactions -- the locking 
needs to be built-in to the host adapter's handling of i2c_transfer.

So, what I *really* need is for the i2c host adapter itself to lock or 
unlock the i2c bus, based on a signal from a given i2c client module 
that a series of i2c transactions are volatile and no other i2c traffic 
is allowed until this long block of transactions are complete.  The 
"large blocks of transactions" can be a large series of multiple calls 
to i2c_transfer, and can be directed to more than just one i2c address.

I think you made a suggestion a few months back, but I don't remember 
exactly what you had in mind.  One idea that I can think of is that the 
i2c client module should request some uniquely generated id, and pass 
this id into the call to i2c_transfer so that it knows that this 
particular transaction is allowed to occur regardless of the state of 
the lock on the i2c bus.

Making matters more complicated, the "do initialization" pseudocode part 
above involves i2c transactions to two different IC's, but we must not 
allow any communication to these IC's to occur other than the 
transactions occurring in the "do initialization" sequence.  ie, no 
probing allowed during this time, not even probing of IC's being 
initialized.  The part being initialized is behind an i2c gate of 
another part, and the i2c gate _must_ be closed after each i2c write and 
opened before the next i2c write, due to a bug in the silicon.


I hope that describes the situation well enough -- Please let me know if 
you need any clarification.

Regards,

Mike

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
