From: Michele Da Rold <michele.darold-jTUIOkKm3KASWr57yraSmw@public.gmane.org>
Subject: Re: ack/nack in write operation
Date: Fri, 15 Jul 2011 10:03:44 +0200
Message-ID: <4E1FF460.1000908@ecsproject.com>
References: <4E1F10B9.3080507@ecsproject.com> <20110714182607.3a3d710f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110714182607.3a3d710f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Il 14/07/2011 18:26, Jean Delvare ha scritto:
> On Thu, 14 Jul 2011 17:52:25 +0200, Michele Da Rold wrote:
>> Hello everybody,
>> I'm new to i2c development some don't kill me if my questions are stupid!!
>>
>> I'm using bitbanging i2c driver for an AT91 devices,
>> the AT91 is master and I have a slave that reply, during a write, with a
>> NAK after last byte.
>> The i2c specification permit this solution but i2c linux driver no.
>
> Can you please quote the part of the I2C specification which you think
> says this? I read it differently (page 10 of I2C 2.1 specification,
> section 7.2: Acknowledge):
>
> "Usually, a receiver which has been addressed is obliged to
> generate an acknowledge after each byte has been
> received, except when the message starts with a CBUS
> address."
>
> "If a master-receiver is involved in a transfer, it must signal
> the end of data to the slave-transmitter by not generating
> an acknowledge on the last byte that was clocked out of
> the slave. The slave-transmitter must release the data line
> to allow the master to generate a STOP or repeated
> START condition."
>
> So, a master-receiver must nack the last byte, but a slave-receiver must
> not. So your slave device is misbehaving - or you are actually trying
> to write more bytes to it than it can handle.
>

Refer to fig.11 of specification 2.1.
But I think that I was wrong. I agree with your opinion.

>> (i have see the possibility to set the I2C_M_IGNORE_NAK but ignore all
>> NAK and isn't right!)
>
> This should indeed be avoided unless you really have to use it.
>
>> There is a solution or I have to modify the code?
>
> First ensure that you are sending the right number of bytes to the
> device, with the correct sequence. If you think you're really doing the
> right think, get in touch with the vendor of the slave device and ask
> them why their device misbehaves.
>

I'm in touch with vendor, I'm waiting for his reply.

Thank you
Michele
