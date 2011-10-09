From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: boilerplate function for byte swapped
 smbus_write/read_word_data
Date: Sun, 9 Oct 2011 09:41:18 +0200
Message-ID: <20111009094118.44b616bf@endymion.delvare>
References: <1316699294-6936-1-git-send-email-jic23@cam.ac.uk>
	<20111008231005.41161836@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111008231005.41161836-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 8 Oct 2011 23:10:05 +0200, Jean Delvare wrote:
> On Thu, 22 Sep 2011 14:48:14 +0100, Jonathan Cameron wrote:
> > @@ -88,6 +89,23 @@ extern s32 i2c_smbus_read_word_data(const struct i2c_client *client,
> >  				    u8 command);
> >  extern s32 i2c_smbus_write_word_data(const struct i2c_client *client,
> >  				     u8 command, u16 value);
> > +
> > +static inline s32
> > +i2c_smbus_read_word_data_swapped(const struct i2c_client *client,
> > +				 u8 command)
> > +{
> > +	s32 value = i2c_smbus_read_word_data(client, command);
> > +
> > +	return (value < 0) ? value : swab16(value);
> > +}
> > +
> > +static inline s32
> > +i2c_smbus_write_word_data_swapped(const struct i2c_client *client,
> > +				  u8 command, u16 value)
> > +{
> > +	return i2c_smbus_write_word_data(client, command, swab16(value));
> > +}
> > +
> >  /* Returns the number of read bytes */
> >  extern s32 i2c_smbus_read_block_data(const struct i2c_client *client,
> >  				     u8 command, u8 *values);
> 
> It might make sense to change the _data_swapped suffix to just
> _swapped, for the sake of avoiding overly long function names (_data
> was never meaningful for the original functions anyway as there is no
> ambiguity.)
> 
> Other than these minor details, I like the patch very much, I tested if
> with 9 hwmon drivers and it indeed makes the drivers cleaner/smaller.
> I'll be happy to commit it when I am able to do this again.

Oh, and I think the new functions should be listed in
Documentation/i2c/smbus-protocol. Maybe not as separate entries, as
they are not new fundamental types, nor part of the SMBus protocol, but
at least as as notes in the SMBus Read Word and SMBus Write Word
sections.

-- 
Jean Delvare
