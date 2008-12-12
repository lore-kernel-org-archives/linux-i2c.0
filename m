From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Calling an I2C camera sensor with SMBUS API?
Date: Fri, 12 Dec 2008 08:46:48 -0800
Message-ID: <200812120846.48960.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE894415E6E424@dlee02.ent.ti.com> <20081212164426.27b4f5cd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081212164426.27b4f5cd-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 12 December 2008, Jean Delvare wrote:
> > So, should this automatically discard using SMBUS api for my case, or am
> > I missing something else? (like a SMBUS 16-bit expansion or so)
> 
> You are correct, SMBus messaging implies an 8-bit command field (which
> is most frequently used for register addressing.) There are no 16-bit
> command variants.

How about the "proc call" ... 16 bits to the slave, 16 bits back?
That would be like a "read 16 bit register with 16 bit address".

ISTR we had that a routine supporting that at one point (and the
infrastructure for it is still there, emulation and all) but it was
removed because it was still seeking its first use.


> For writes, we can cheat because there is no 
> direction change between the address and the data,

Cheat how?


>	 but for reads
> there's simply nothing we can do to work around this limitation. So,
> unless your device is write-only, you indeed can't use the SMBus-level
> API for 16-bit register addresses and you have to stick to the
> I2C-level API.

If addresses and data are both 16 bits, I only see how to do reads,
not writes, within the scope of the SMBus calls.  Of course, SMBus
also supports byte and (small-)counted-array data too.

- Dave

 
> -- 
> Jean Delvare
> 
> 
