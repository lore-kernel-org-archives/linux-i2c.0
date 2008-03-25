From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/6] Blackfin I2C/TWI driver: Add repeat start
	feature to avoid break of a bundle of i2c master xfer operation.
Date: Tue, 25 Mar 2008 11:01:18 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA01B17710@chinexm1.ad.analog.com>
References: <1205479360-25240-2-git-send-email-cooloney@kernel.org>
	<20080324192045.2343293c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080324192045.2343293c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

I have already discussed your questions with you in attached email. See
bellow. The twi controller is designed to support SMBus protocol in
hardware. That's why we implement bfin_twi_smbus_xfer().


Sonic
=====================================
from	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
to	Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
date	Wed, Nov 14, 2007 at 9:20 PM
subject	Re: [PATCH 1/4] Blackfin I2C/TWI driver: Add repeat start
feature to avoid break of a bundle of i2c master xfer operation.
	
hide details 11/14/07
	
	
Reply
	
	
Hi Sonic,
- Hide quoted text -

On Thu, 8 Nov 2007 13:14:56 +0800, Sonic Zhang wrote:
> TWI_I2C_MODE_REPEAT:
> static int bfin_twi_master_xfer(struct i2c_adapter *adap, struct
> i2c_msg *msgs, int num);
>
> From transaction 1 to N do simple read or write
> {
> start,
> read or write,
> address,
> data,
> if Not N
> { restart }
> else
> { stop }
> }
>
> TWI_I2C_MODE_COMBINED:
> static int bfin_twi_master_xfer(struct i2c_adapter *adap, struct
> i2c_msg *msgs, int num);
>
> Write then read transactions in SMBus
> {
> start,
> write,
> address,
> data,
> restart,
> read,
> address,
> data,
> stop.
> - Hide quoted text -
> }
>

OK, thanks for the clarification. The above looks OK to me, if that's
what the driver implements then there's no problem. However, please
realize that TWI_I2C_MODE_COMBINED is a subset of TWI_I2C_MODE_REPEAT
(with N = 2, first message is a write and second message is a read.)
This means that TWI_I2C_MODE_COMBINED is not strictly needed and could
be implemented using TWI_I2C_MODE_REPEAT. As a matter of fact most I2C
master drivers in Linux do that, i.e. they implement .master_xfer and
not .smbus_xfer. i2c-core can emulate .smbus_xfer from .master_xfer.

I don't know the i2c-bfin-twi driver in details so there might be a
reason why you implemented both methods that I don't understand, but
from my point of view, you should be able to delete
bfin_twi_smbus_xfer() and your driver would still work the exact same
as it does today. The advantage would be a smaller driver, so a lower
risk to have hidden bugs.

Thanks,
--
Jean Delvare
Reply
		
Forward
		
	
Sonic Zhang to Jean
	
show details 11/15/07
	
	
Reply
	
	
	from	Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
to	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
date	Thu, Nov 15, 2007 at 10:50 AM
subject	Re: [PATCH 1/4] Blackfin I2C/TWI driver: Add repeat start
feature to avoid break of a bundle of i2c master xfer operation.
mailed-by	gmail.com
	
hide details 11/15/07
	
	
Reply
	
	
Thank you for your great advises.

Sonic

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
Sent: Tuesday, March 25, 2008 2:21 AM
To: Bryan Wu
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org; Sonic Zhang
Subject: Re: [PATCH 1/6] Blackfin I2C/TWI driver: Add repeat start
feature to avoid break of a bundle of i2c master xfer operation.

Hi Bryan,

On Fri, 14 Mar 2008 00:22:35 -0700, Bryan Wu wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
>  - Create a new mode TWI_I2C_MODE_REPEAT.
>  - No change to smbus operation.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Just one Signed-off-by per person, please.

> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |  183 
> +++++++++++++++++++++++--------------
>  1 files changed, 113 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c 
> b/drivers/i2c/busses/i2c-bfin-twi.c
> index 7dbdaeb..ea15125 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> (...)

It seems that this patch is the exact same as the one you posted back in
November 2007:
http://lists.lm-sensors.org/pipermail/i2c/2007-November/002119.html

I did review this patch:
http://lists.lm-sensors.org/pipermail/i2c/2007-November/002121.html

So I would appreciate if you could take my comments into account and
post an updated version.

Thanks,
