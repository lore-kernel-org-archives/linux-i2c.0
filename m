From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Thu, 16 Oct 2008 18:17:07 +0200
Message-ID: <20081016181707.4878bf31@hyperion.delvare>
References: <20080821.024322.35962617.davem@davemloft.net>
	<20081015141914.7d6c3dd5@hyperion.delvare>
	<48F662A5.4050303@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48F662A5.4050303-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Wed, 15 Oct 2008 17:37:41 -0400, Michael Krufky wrote:
> Jean Delvare wrote:
> > Hi David,
> >
> > On Thu, 21 Aug 2008 02:43:22 -0700 (PDT), David Miller wrote:
> >   
> >> i2c-pcf: Add adapter hooks around xfer begin and end.
> >>
> >> Some I2C bus implementations need to synchronize with external
> >> entities, such as system firmware, which might also be programming the
> >> same I2C bus.
> >>
> >> In order to facilitate this add ->xfer_begin() and ->xfer_end() hooks
> >> which are invoked around pcf_xfer().
> >>     
> >
> > I get the idea, but I'm not sure about the implementation. I had a
> > request several months ago for something similar for the i2c-algo-bit
> > driver. I don't think we want to duplicate this mechanism in every
> > i2c-algo driver, so it would probably make sense to implement it
> > at the i2c-core level?
> >
> > Michael, do you still need this for i2c-algo-bit? We did not discuss
> > this again recently, so I admit I don't know what is the status of this
> > request.
> 
> Jean,
> 
> Yes, the problem still exists, and I still need a way to lock the i2c 
> adapter during certain volitile operations at driver start-up.
> 
> Right now I have an artificial delay in place as a workaround, but 
> that's only because there currently is no other choice.

I'm really sorry. As you didn't come back to me about this issue, I
wrongly assumed that you had solved it in another way and you were no
longer interested in adding these hooks to i2c-algo-bit. If you still
need it then let's get this sorted out.

> Basically, I have a single piece of silicon that is capable of bringing 
> down the entire i2c bus if somebody attempts to communicate with any 
> other IC during initialization of this silicon.

Can you clarify your requirements? I'm not sure I understand exactly
what you need. Do you need exclusive access to the I2C bus for a number
of transactions? Or do you need exclusive access to the I2C bus for an
arbitrary period of time? Or do you need to block access to the I2C bus
entirely? How do you know when to start the blackout period, and when
to end it?

We have to design a new mechanism so I would like to make sure that
whatever I come up with, fits at least your needs and those of David.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
