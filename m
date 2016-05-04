From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v7 16/24] i2c: allow adapter drivers to override the
 adapter locking
Date: Wed, 4 May 2016 12:01:17 +0200
Message-ID: <0b4136b2-e555-9bc0-9003-898d686de7a1@axentia.se>
References: <1461165484-2314-1-git-send-email-peda@axentia.se>
 <1461165484-2314-17-git-send-email-peda@axentia.se>
 <20160503213807.GA2018@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160503213807.GA2018@tetsubishi>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt Ranostay <matt.ranostay-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.koz>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 2016-05-03 23:38, Wolfram Sang wrote:
> On Wed, Apr 20, 2016 at 05:17:56PM +0200, Peter Rosin wrote:
>> Add i2c_lock_bus() and i2c_unlock_bus(), which call the new lock_bus and
>> unlock_bus ops in the adapter. These funcs/ops take an additional flags
>> argument that indicates for what purpose the adapter is locked.
>>
>> There are two flags, I2C_LOCK_ADAPTER and I2C_LOCK_SEGMENT, but they are
>> both implemented the same. For now. Locking the adapter means that the
>> whole bus is locked, locking the segment means that only the current bus
>> segment is locked (i.e. i2c traffic on the parent side of mux is still
>> allowed even if the child side of the mux is locked.
>>
>> Also support a trylock_bus op (but no function to call it, as it is not
>> expected to be needed outside of the i2c core).
>>
>> Implement i2c_lock_adapter/i2c_unlock_adapter in terms of the new locking
>> scheme (i.e. lock with the I2C_LOCK_ADAPTER flag).
>>
>> Annotate some of the locking with explicit I2C_LOCK_SEGMENT flags.
> 
> Can you explain a little why it is SEGMENT and not ADAPTER here? That
> probably makes it easier to get into this patch.
> 
> And to double check my understanding: I was surprised to not see any
> i2c_lock_adapter() or I2C_LOCK_ADAPTER in action. This is because muxes
> call I2C_LOCK_SEGMENT on their parent which in case of the parent being
> the root adapter is essentially the same as I2C_LOCK_ADAPTER. Correct?

Correct. Locking the ADAPTER and the SEGMENT is the same thing for
the root adapter and for traditional muxes (i.e. not mux-locked).
Traditional muxes simply feed the locking request upwards to the
root adapter. The new mux-locked muxes behave the same for ADAPTER
locking; all locks all the way up to the root adapter are grabbed
instantly. If you instead lock SEGMENT on a mux-locked mux, only
the new mux lock in the parent adapter is grabbed right away, but
when the mux then fires off accesses on its parent adapter, that
triggers SEGMENT locks one level up in the tree and the process
recurses.

So, SEGMENT locking is the normal thing that happens when e.g. normal
i2c_transfer calls are made. ADAPTER locking is used for transactions.
The patch enables muxes to use more relaxed locking compared to
locking the ADAPTER for its transations.

The naming can probably be improved. SEGMENT made more sense when
it did not lock all mux accesses one level up (that changed in v6,
but I didn't change the I2C_LOCK_SEGMENT name at that time), so it
is kind of outdated. I2C_LOCK_ROOT_ADAPTER and I2C_LOCK_MUXES instead
of I2C_LOCK_ADAPTER and L2C_LOCK_SEGMENT perhaps?

But I don't really like I2C_LOCK_MUXES as I find it a bit too specific,
and people not thinking about i2c muxes at all (most people I gather,
ignorance is bliss) will not think that it is something for them...

It is also the case that the two flags are mutually exclusive, and
at this point there is no valid uses of using neither flag, nor for
using both. It is a binary decision and one flag would technically be
enough. So, not setting e.g. I2C_LOCK_ADAPTER could in theory imply
I2C_LOCK_SEGMENT. I did it as two separate flags since there might
be a third (or fourth even) option in the future (I don't see what
it would be though, I have no crystal ball...)

So maybe there should be only one flag, e.g. I2C_LOCK_ROOT_ADAPTER?
I.e. perhaps leave the future for later?

Hmmm, I just now realized that you were not really suggesting any
changes other than to the commit message. Oh well, I can perhaps
rephrase some of the above in the commit message if you think that
we should not unnecessarily touch the code at this point...

>>
>> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>> ---
>>  drivers/i2c/i2c-core.c | 46 ++++++++++++++++++++++++++++------------------
>>  include/linux/i2c.h    | 28 ++++++++++++++++++++++++++--
>>  2 files changed, 54 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 0f2f8484e8ec..21f46d011c33 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -960,10 +960,12 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
>>  }
>>  
>>  /**
>> - * i2c_lock_adapter - Get exclusive access to an I2C bus segment
>> + * i2c_adapter_lock_bus - Get exclusive access to an I2C bus segment
>>   * @adapter: Target I2C bus segment
>> + * @flags: I2C_LOCK_ADAPTER locks the root i2c adapter, I2C_LOCK_SEGMENT
>> + *	locks only this branch in the adapter tree
>>   */
> 
> I think this kerneldoc should be moved to i2c_lock_adapter and/or
> i2c_lock_bus() which are now in i2c.h. This is what users will use, not
> this static, adapter-specific implementation. I think it is enough to
> have a comment here explaining what is special in handling adapters.

Yes, I was not really satisfied with having documentation on static
functions. But if I move it, there is no natural home for the current
i2c_trylock_adapter docs, and I'd hate killing documentation that
still applies. Do you have a suggestion? Maybe keep that one doc at
the static i2c_trylock_adapter for now and move it to ->trylock_bus
when someone decides to write kerneldoc for struct i2c_adapter?

Cheers,
Peter
