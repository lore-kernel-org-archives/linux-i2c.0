From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping global state
Date: Sun, 31 Oct 2010 11:33:34 +0100
Message-ID: <20101031113334.3d48c3ad@endymion.delvare>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	<20101030182458.0849f295@endymion.delvare>
	<1288481663.4570.19.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288481663.4570.19.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sat, 30 Oct 2010 19:34:23 -0400, David Woodhouse wrote:
> On Sat, 2010-10-30 at 18:24 +0200, Jean Delvare wrote:
> > An explanation why this change is needed would be nice.
> 
> Um, does it really need explaining? It's really poor form to keep driver
> state in global variables rather than per-instance, even if you *don't*
> actually have more than one device.

True enough. I've even been thinking of sending a similar patch long
ago. The problem is that it's hard to justify the additional cost of
dynamic memory allocation if there's no technical need for it. And
until Sandy Bridge, there wasn't.

> > > (...)
> > > @@ -429,22 +439,23 @@ static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
> > >   	/* Experience has shown that the block buffer can only be used for
> > >   	   SMBus (not I2C) block transactions, even though the datasheet
> > >   	   doesn't mention this limitation. */
> > > -	if ((i801_features & FEATURE_BLOCK_BUFFER)
> > > -	 && command != I2C_SMBUS_I2C_BLOCK_DATA
> > > -	 && i801_set_block_buffer_mode() == 0)
> > > -		result = i801_block_transaction_by_block(data, read_write,
> > > -							 hwpec);
> > > +	if ((priv->features & FEATURE_BLOCK_BUFFER)
> > > +	    && command != I2C_SMBUS_I2C_BLOCK_DATA
> > > +	    && i801_set_block_buffer_mode(priv) == 0)
> > 
> > Gratuitous reindentation of code.
> 
> The two continuation lines? I just fixed them to conform to the normal
> kernel indentation,

Normal according to who? I don't see anything wrong with them as they
were before, and it's used in other places of the driver, so it's not
an accident.

> while I was modifying the lines before and after.
> That's entirely normal practice, and not particularly gratuitous,
> surely?

When you send a patch to the wrong person at the wrong time, if you
want it accepted still, you should make it change as little things as
possible.

> > > @@ -457,81 +468,83 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
> > >   	int hwpec;
> > >   	int block = 0;
> > >   	int ret, xact = 0;
> > > +	struct i801_priv *priv = (void *)adap;
> > 
> > This is horrible and only works by accident (or misdesign if you
> > prefer). Please don't do this. I'm glad I insisted to review this
> > patch...
> > 
> > We have i2c_set/get_adapdata() for this. If you really care about the
> > extra cost, please use the proper container_of() construct. But I don't
> > think the cost is problematic.
> 
> It wasn't the cost I was thinking of; it was the simplicity. One
> allocation, one failure case, one error path. That's why this method is
> fairly common within the kernel.
> 
> However, I have no particular objection to doing separate allocations,
> even though it's not what I'd normally do. I'll send another version.

You got me wrong apparently. I have no objection to the single
structure allocation, this is indeed fairly common and a good thing to
avoid memory fragmentation. I have a strong objection on random casts
from one structure to another on the undocumented assumption that one
contains the other as its first member.

All you have to do to make me happy is:

	i2c_set_adapdata(adap, priv);

in the probe function and

	priv = i2c_get_adapdata(adap);

in this function (and i801_func).

-- 
Jean Delvare
