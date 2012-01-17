From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C_RDRW_IOCTL_MAX_MSGS
Date: Tue, 17 Jan 2012 14:09:54 +0100
Message-ID: <20120117140954.05dd30ef@endymion.delvare>
References: <464859D4BE03A84686BA47749242C1D0317B66EC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <464859D4BE03A84686BA47749242C1D0317B66EC-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Srinivasan, Nageswari" <nageswari-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Nageswari,

On Tue, 17 Jan 2012 10:56:43 +0000, Srinivasan, Nageswari wrote:
> Is there any specific reason to limit no of i2c messages 
> to 42 in i2c-dev.c file
> 
> /* Put an arbitrary limit on the number of messages that can
>          * be sent at once */
>         if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
>                 return -EINVAL;

No, as the comment says there is no good reason, it's purely arbitrary.
If this limitation is a problem for you it can be raised.

But you should also keep in mind that pushing many messages at once
increases the I2C bus latency so other devices on the same bus might
become unresponsive.

As a matter of fact the limitation has been there for over 10 years and
nobody ever complained about it, so you must be doing something quite
unusual. I invite you to explain your case in details if you need
I2C_RDRW_IOCTL_MAX_MSGS to be increased.

-- 
Jean Delvare
