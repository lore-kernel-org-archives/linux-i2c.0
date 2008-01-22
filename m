From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_adapter.class and new style drivers
Date: Tue, 22 Jan 2008 20:25:35 +0100
Message-ID: <20080122202535.2167fc08@hyperion.delvare>
References: <9e4733910801211549v74ca13c4ya07179d36b35bff0@mail.gmail.com>
	<20080122152347.1ebd0f4c@hyperion.delvare>
	<9e4733910801220755j45b4c48m467679ebdd2ef911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910801220755j45b4c48m467679ebdd2ef911-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Tue, 22 Jan 2008 10:55:37 -0500, Jon Smirl wrote:
> On 1/22/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Hi Jon,
> >
> > On Mon, 21 Jan 2008 18:49:34 -0500, Jon Smirl wrote:
> > > Is i2c_adapter.class relevant anymore with new style drivers?
> >
> > No, it's not. The class is meant to limit the probing scope of
> > legacy i2c chip drivers. New-style i2c chip drivers shouldn't care.
> >
> > Note that these classes aren't going away anytime soon though: some
> > chip types just have to be probed (e.g. hardware monitoring chips or
> > EEPROMs on PC motherboards) so even if these drivers are eventually
> > converted to new-style i2c chip drivers, some (possibly external)
> > probing will still be necessary, and the class will be there to limit
> > the scope of this probing.
> >
> > > On 1/2/08, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org> wrote:
> > > > IMHO, there should be a node attribute to override
> > > > i2c_adapter.class. Legacy i2c drivers (in particular v4l and dvb
> > > > drivers) use this class to decide which adapter to bind to.
> > > > dbox2 needs I2C_CLASS_TV_DIGITAL (4).
> >
> > I am fine with a node attribute allowing control of this attribute,
> > that could be handy for testing and debugging purposes. If someone
> > submits a patch implementing this, I'll review and merge it.
> 
> Wouldn't it be better to convert the v4l and dvd drivers to new style

I'm so glad that you volunteered to convert them all. Let me know when
you're done with it ;)

> and make progress on getting rid of class? It only takes about half an
> hour to convert a driver and the conversion mostly involves deleting
> code.

Converting the chip drivers is one thing. Adjusting the adapter
drivers so that they instantiate the new-style i2c devices is another
one, and that's where the real difficulty is. Because the original code
expects probing to take place, it doesn't tell you what chip is
supposed to be at what address for every given adapter model. On top of
that, many adapters share chip drivers, so you'd need to convert them
all at once, unless you make all modules register two drivers (one
new-style, one legacy). This is more work and effort than I personally
want to spend on that.

Anyway, as I wrote above, classes are not going away anytime soon, if
ever: some drivers need to rely on probing, and some adapters don't like
being probed. So we need a way to restrict probes to a subset of i2c
adapters, and classes are the right way to do this. I'm not sure why
you want to get rid of them.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
