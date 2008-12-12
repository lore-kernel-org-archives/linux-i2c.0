From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Calling an I2C camera sensor with SMBUS API?
Date: Fri, 12 Dec 2008 18:07:04 +0100
Message-ID: <20081212180704.7727a58f@hyperion.delvare>
References: <A24693684029E5489D1D202277BE894415E6E424@dlee02.ent.ti.com>
	<20081212164426.27b4f5cd@hyperion.delvare>
	<200812120846.48960.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200812120846.48960.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 12 Dec 2008 08:46:48 -0800, David Brownell wrote:
> On Friday 12 December 2008, Jean Delvare wrote:
> > > So, should this automatically discard using SMBUS api for my case, or am
> > > I missing something else? (like a SMBUS 16-bit expansion or so)
> > 
> > You are correct, SMBus messaging implies an 8-bit command field (which
> > is most frequently used for register addressing.) There are no 16-bit
> > command variants.
> 
> How about the "proc call" ... 16 bits to the slave, 16 bits back?
> That would be like a "read 16 bit register with 16 bit address".

No, the SMBus process call is 8 bits command, 16 bits data from master
to slave, then 16 bits data from slave to master. So total 24 bits from
master to the slave, not 16.

> ISTR we had that a routine supporting that at one point (and the
> infrastructure for it is still there, emulation and all) but it was
> removed because it was still seeking its first use.

Actually i2c_smbus_process_call() is back in 2.6.28 already, for an
upcoming driver which needs it. But it doesn't help there.

> > For writes, we can cheat because there is no 
> > direction change between the address and the data,
> 
> Cheat how?

You can use SMBus write word as 16 bits for register address and 8 bits
for data, even though it is originally designed as 8 bits for register
address and 16 bits for data. More generally, you can use I2C block
writes (which are often supported by SMBus controllers up to 32 bytes)
by simply passing the 8 extra register address bits as the first data
byte, and all other data bytes are shifted by one. This allows for up
to 31 data bytes to be written.

> >	 but for reads
> > there's simply nothing we can do to work around this limitation. So,
> > unless your device is write-only, you indeed can't use the SMBus-level
> > API for 16-bit register addresses and you have to stick to the
> > I2C-level API.
> 
> If addresses and data are both 16 bits, I only see how to do reads,
> not writes, within the scope of the SMBus calls.  Of course, SMBus
> also supports byte and (small-)counted-array data too.

-- 
Jean Delvare
