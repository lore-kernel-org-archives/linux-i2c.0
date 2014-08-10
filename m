From: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ddc/ci over i2c
Date: Sun, 10 Aug 2014 03:08:07 -0700
Message-ID: <53E74487.8020809@minsoft.com>
References: <53BBC97B.5020805@minsoft.com>	<20140709002017.4c2b332e@endymion.delvare>	<53BD6E61.8070101@minsoft.com>	<20140728125248.5bbc0f89@endymion.delvare>	<53E6902B.9000104@minsoft.com> <20140810110528.1b5a825f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140810110528.1b5a825f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/10/2014 02:05 AM, Jean Delvare wrote:
> Hi Sanford,
>
> Thanks for all the explanations.
>
> On Sat, 09 Aug 2014 14:18:35 -0700, Sanford Rockowitz wrote:
>> Lastly, a question.  I have one monitor, a relatively recent
>> "professional" quality Dell P2411H, which has a propensity to return
>> duplicated bytes on read(), .e.g.  0x01020203 instead of 0x010203. The
>> DDC protocol works, but has high retry counts.   Any thoughts on what I
>> might do here as a workaround?
> I'm a bit confused by the question, as I don't understand how you could
> read more bytes than you actually decided. Or do you mean that, when
> reading for example six bytes, you get "1, 2, 2, 3, 4, 5" instead of
> the expected "1, 2, 3, 4, 5, 6", i.e. the byte count is good but you're
> missing the last one (and you have one duplicate)?

The byte count is correct.   There's a duplicate and so I'm missing the 
last byte.  The duplicate can be anywhere in the sequence. I detect the 
problem when some field value is invalid, or more commonly the checksum 
calculation fails.
>
> I have two Dell monitors here, U2312HM and P2414H, I can try to
> reproduce the problem if you give me the code to run.

I'll have to build a simple test case.   Won't be able to get to it for 
a few days.
>
> I can't remember seeing this before, so I have no immediate explanation.
> However some I2C chips use an internal pointer register to select which
> register is being read. Whenever you read a byte, the pointer gets
> increased to point to the next register. I can imagine that, if the
> master reads faster than the slave is able to process, then maybe the
> next read could happen before the pointer register is actually
> increased. That being said, with such a race condition, I'd expect the
> pointer to eventually catch up so you'd get something like "1, 2, 2, 4,
> 5, 6". Is the duplicate byte always early in the sequence, or can it be
> anywhere?

As noted, the duplicate can be anywhere in the sequence.   I'll have to 
study the traces to see if there's a corresponding dropped byte.

> I suggest that you verify that the master properly handles clock
> stretching (to give the slave the opportunity to slow down the
> transfer.) Or simply lower the DDC bus clock speed and see if it helps.
>
I'm using write() and read() on /dev/i2c-n to communicate with the 
monitor.  Is there some way to control clock stretching or DDC bus clock 
speed from userspace?

I just built a custom kernel (first time in years), with the following 
lines in config-local:

CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_ALGO=y

I was puzzling over why I wasn't seeing any output in /var/log/messages 
when your email came in.  I would have thought I'd  be overwhelmed by 
output.  But when communicating with the P2411H, I do see repeated lines 
of the form:

Aug 10 02:55:34 banner kernel: [ 5006.692794] i2c i2c-0: sendbytes: NAK 
bailout.

Sanford
