From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-powermac: Refactor i2c_powermac_smbus_xfer
Date: Thu, 22 Oct 2009 15:25:28 +0200
Message-ID: <20091022152528.45e24f3d@hyperion.delvare>
References: <20091010141908.0be884a5@hyperion.delvare>
	<1255215931.2192.11.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1255215931.2192.11.camel@pasglop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Sun, 11 Oct 2009 10:05:31 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2009-10-10 at 14:19 +0200, Jean Delvare wrote:
> > I wanted to add some error logging to the i2c-powermac driver, but
> > found that it was very difficult due to the way the
> > i2c_powermac_smbus_xfer function is organized. Refactor the code in
> > this function so that each low-level function is only called once.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> > Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
> > ---
> > This needs testing! Thanks.
> 
> Ok, will give it a go next week.

Did you finally find some time to test my i2c-powermac patches?

Thanks,
-- 
Jean Delvare
