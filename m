From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: [PATCH] [OF] request_module() use format string
Date: Thu, 12 Jun 2008 09:22:59 +0200
Message-ID: <20080612072259.GZ7212@baikonur.stro.at>
References: <1213246926-10043-1-git-send-email-max@stro.at>
	<20080612082726.0f495687@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080612082726.0f495687-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

hello jean,

On Thu, Jun 12, 2008 at 08:27:26AM +0200, Jean Delvare wrote:
> Hi Maximilian,
> 
> On Thu, 12 Jun 2008 07:02:06 +0200, maximilian attems wrote:
> > similar to 326f6a5c9c9e1a62aec37bdc0c3f8d53adabe77b,
> > maybe writable by root thus worth fixing.
> 
> I don't think root can affect the value of the string, but the file it
> is read from could be broken. So yes it seems worth fixing.

thanks for check.
 
> > 
> > Signed-off-by: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
> > ---
> >  drivers/of/of_i2c.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> > index b2ccdcb..117de8b 100644
> > --- a/drivers/of/of_i2c.c
> > +++ b/drivers/of/of_i2c.c
> > @@ -100,7 +100,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> >  
> >  		info.addr = *addr;
> >  
> > -		request_module(info.type);
> > +		request_module("%s", info.type);
> >  
> >  		result = i2c_new_device(adap, &info);
> >  		if (result == NULL) {
> 
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> I think you want to send this fix to Jochen Friedrich and Paul
> Mackerras (both Cc'd) as they are the ones working on this driver.

will do in a minute, with fixed desc.

-- 
maks

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
