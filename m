From: "Srinivasan, Nageswari" <nageswari-l0cyMroinI0@public.gmane.org>
Subject: RE: I2C_RDRW_IOCTL_MAX_MSGS
Date: Tue, 17 Jan 2012 14:49:01 +0000
Message-ID: <464859D4BE03A84686BA47749242C1D0317B6E7A@DBDE01.ent.ti.com>
References: <464859D4BE03A84686BA47749242C1D0317B66EC@DBDE01.ent.ti.com>
 <20120117140954.05dd30ef@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120117140954.05dd30ef-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean,

On Tue, Jan 17, 2012 at 18:39:54, Jean Delvare wrote:
> Hi Nageswari,
> 
>
[...] 
> No, as the comment says there is no good reason, it's purely arbitrary.
> If this limitation is a problem for you it can be raised.
> 
> But you should also keep in mind that pushing many messages at once
> increases the I2C bus latency so other devices on the same bus might
> become unresponsive.
> 
> As a matter of fact the limitation has been there for over 10 years and
> nobody ever complained about it, so you must be doing something quite
> unusual. I invite you to explain your case in details if you need
> I2C_RDRW_IOCTL_MAX_MSGS to be increased.
> 
> -- 

We have a slave device which requires more than 500 registers
to be configured. (kind of bulk write) So, looking for an option
of configuring all of them in single command.

> Jean Delvare
> 

Nageswari
