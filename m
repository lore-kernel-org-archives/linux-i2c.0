From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Mon, 9 Mar 2009 15:38:51 +0100
Message-ID: <20090309153851.6d92729e@hyperion.delvare>
References: <gngvea$eqj$1@ger.gmane.org>
	<20090218173645.GD3049@pengutronix.de>
	<gnjplc$hqd$1@ger.gmane.org>
	<20090220135300.353cd53a@hyperion.delvare>
	<go12jd$ec4$1@ger.gmane.org>
	<20090225090002.2c31dbf1@hyperion.delvare>
	<go5ta2$rtu$1@ger.gmane.org>
	<20090226142854.2b6f72e4@hyperion.delvare>
	<go8c65$o7g$1@ger.gmane.org>
	<20090305155713.46ac1968@hyperion.delvare>
	<gp385s$a2i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <gp385s$a2i$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 09 Mar 2009 15:13:16 +0100, Michael Lawnick wrote:
> Hi Jean,
> 
> I have now got a 2.6.28.7 Kernel to play with on my board.
> I assume I have to patch some files to get the same play ground as you,
> right? Could you give me the msgIds/links?

Sorry but I don't quire follow you here. What play ground are you
talking about?

> Jean Delvare said the following:
> > Hi Michael,
> (...)
> >> > This is one of the 3 ways the new model can work, yes.
> >>
> >> And the other 2?
> > 
> > I wrote a document explaining the 3 available methods. I am attaching
> > it to this mail. Please read it. If it is clear enough, I plan to add
> > it to Documentation/i2c. If it's no clear enough, well, ask your
> > additional questions and I'll try to improve the document.
>
> Reads good. I'll ack your post from today.

Thank you!

> (...)
> > I2C bus control (such as declaration of which devices are there)
> > through sysfs doesn't exist today, but could be added for cases such as
> > yours. I also can see the value of making mux drivers have a standard
> > sysfs interface to disable some channels, to allow hot-plug scenarios
> > such as yours. But I'd rather integrate Rodolfo's work as is first, and
> > add features later. Even that promises to be slow...
> 
> I'm currently thinking about making a module that allows to trigger
> probing of buses, something like
> insmod i2cDevProbe.ko "modname",busNo,devNo
> Could finally be integrated into subsystem if there are more folks that
> like it.

I don't like the idea at all. Module parameters are not exactly a
convenient interface. As a matter of fact this is what we have today,
with the difference that the parameters are passed to relevant driver
directly rather than to a dedicated module (see the I2C_CLIENT_INSMOD*
macros in include/linux/i2c.h), and we are trying to move away from it
because they are highly user-unfriendly. What you propose is slightly
better than what we have in some respects, but that's not a significant
enough improvement to justify the move.

And your proposal has many drawbacks/lacks, too. For example, how do
you remove a device instance which you have created by mistake? How do
you create a new device instance when the i2cDevProbe.ko module is
already loaded? Just two problems off the top of my head, but there are
probably more.

I definitely prefer a sysfs-based approach as I initially mentioned,
this is much more flexible. If you have an urgent need for this
feature, we can add an action point to the wiki and start working on an
implementation. I suggest you start with creating your wiki account
then.

-- 
Jean Delvare
