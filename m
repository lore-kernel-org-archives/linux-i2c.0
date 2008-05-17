From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc1] i2c: kerneldoc for most i/o calls
Date: Sat, 17 May 2008 07:33:36 -0700
Message-ID: <200805170733.36937.david-b@pacbell.net>
References: <200805031751.26920.david-b@pacbell.net>
	<20080517142011.1493e584@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080517142011.1493e584-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 17 May 2008, Jean Delvare wrote:
> Hi David,
> 
> On Sat, 3 May 2008 17:51:26 -0700, David Brownell wrote:
> > Provide kerneldoc for most of the I2C and SMBus I/O calls.  Add a
> > summarizing some fault reporting issues which affect the ability to
> > provide clean fault reports through I2C master transfer calls.
> 
> There's a word or two missing somewhere in that sentence.

"Add a comment summarizing ..."

> > (Making it hard to precisely specify their return values...)


> > +/**
> > + * i2c_transfer - execute a single or combined I2C message
> > + * @adap: Identifies an I2C bus
> 
> For client, you use "Handle to slave device", so maybe for consistency
> adap would be "Handle to I2C bus"?

That would be more consistent, yes.


> > + * @msgs: One or more messages to execute before STOP is issued to
> > + *	terminate the operation; each message begins with a START.
> > + * @num: Number of messages to be executed.
> > + *
> > + * Returns negative errno, else the number of messages executed.
> > + *
> > + * Note that there is no requirement that each message be sent to
> > + * the same slave address, although that is the most common model.
> > + */
> >  int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
> >  {
> >  	int ret;
> >  
> > +	/* REVISIT the fault reporting model here is weak:
> > +	 *
> > +	 *  - When we get an error after receiving N bytes from a slave,
> > +	 *    there is no way to report "N".

This matters somewhat, because the most common convention is
for higher level code to see the "N" not an error code.

> > +	 *
> > +	 *  - When we get a NAK after transmitting N bytes to a slave,
> > +	 *    there is no way to report "N" ...

Ditto.

> > 						 or to let the master  
> > +	 *    continue executing the rest of this combined message, if
> > +	 *    that's the appropriate response.
> > +	 *
> > +	 *  - When for example "num" is two and we successfully complete
> > +	 *    the first message but get an error part way through the
> > +	 *    second, it's unclear whether that should be reported as
> > +	 *    one (discarding status on the second message) or errno
> > +	 *    (discarding status on the first one).
> > +	 *
> > +	 *  - In multi-master cases, there's no consistent way to report
> > +	 *    lost arbitration (and properly decide to reissue messages
> > +	 *    that need it).
> > +	 */
> 
> I agree, but I don't really know how I would address these issues. I am
> also not sure if they are worth addressing in practice.

Re how to address, "struct i2c_msg" has 16 bits of padding that
could be used to hold a status code without loss of binary
compatibility ... that could address the first cases, albeit at
the price of limiting "N" to 2^15 (ditto errno values).  Maybe
initialize to "-EINPROGRESS" and if it doesn't change, then the
caller will know that the underlying adapter isn't reporting such
fault details.

If the desire were to continue executing after NAK, there are
unused flag bits.  (Though to be sure, we're not yet ready to
support code sophisticated enough to care ...)

That last comment was written before you got me to write up
that "fault-codes" document, which now says the way to do so
is to report "-EAGAIN" ... that's one of the few cases there
which was written without any current usage.  So you could
strike that chunk.

Re worth addressing in practice, this is one of those chicken
vs egg issues.  It doesn't work, so people don't design things
to expect it to work, and it bubbles up the stack.  For now
I'm content to start seeing "-EPERM" vanish, but since that
analysis was fresh in mind I thought it fair to capture some
of the remaining fault reporting issues.



> > +/**
> > + * i2c_smbus_write_quick - SMBus "quick command" protocol
> > + * @client: Handle to slave device
> > + * @value: I2C_SMBUS_READ or I2C_SMBUS_WRITE
> 
> From the users' perspective, the value is really 0 or 1. For SMBus, the
> "quick command" is always a "write transaction". It just happens that
> the single bit of data is carried in what is the direction bit for all
> other transactions, but that's an implementation detail the user
> doesn't need to know about.

... and that at least the in-kernel usage I saw used a symbol
about half the time.  Though I'm not sure I'd agree that it's
only an implementation detail.  It's easier for me to think of
this as a normal I2C transaction that's aborted very early, in
which case knowing that it was a READ or WRITE matters in terms
of the slave's hardware or software state machine.


> (I think the world would be better if Intel had never included this
> "quick command" in their SMBus specification. It's clearly incompatible
> with I2C and I never saw a device using it anyway.)

I tend to agree about "better"; though as for "incompatible",
no more than any other transfer that's aborted too early.  ;)


> It's probably not worth arguing on this anyway: I've just removed the
> last in-kernel user of this function, so we are going to drop it...

Sounds like a good way to discourage this ...


> > @@ -1504,6 +1600,14 @@ s32 i2c_smbus_write_byte_data(struct i2c
> >  }
> >  EXPORT_SYMBOL(i2c_smbus_write_byte_data);
> >  
> > +/**
> > + * i2c_smbus_read_word_data - SMBus "read word" protocol
> > + * @client: Handle to slave device
> > + * @command: Byte interpreted by slave
> > + *
> > + * This executes the SMBus "read word" protocol, returning negative errno
> > + * else a sixteen bit unsigned "word" received from the device.
> 
> I'd rather spell it "16-bit", that's what developers are used to I
> think.

ISTR some "how 2 right gud inglish" style guide, maybe the
Univerity of Chicago one (or Turabian, or Strunk and White),
saying to use the word form, not the digit form, except when
the text is really about numbers/dates.  Certainly *mixing*
two forms would be bad, and having only one digit-format
number is a degenerate case of mixing.  (Ergo my scribble.)


> > + * @addr: Address of SMBus slave on that bus
> > + * @flags: I2C_CLIENT_* flags (usually zero or I2C_CLIENT_PEC)
> > + * @read_write: I2C_SMBUS_READ or I2C_SMBUS_WRITE
> > + * @command: Byte interpreted by slave, for protocols which use such bytes
> > + * @protocol: SMBus protocol operation to execute, such as I2C_PROC_CALL
> 
> I2C_PROC_CALL doesn't exist, I guess you mean I2C_SMBUS_PROC_CALL.

Right.


> Please send an updated patch, or if you prefer I can adjust it myself.

It'll go faster if you make these last changes ...

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
