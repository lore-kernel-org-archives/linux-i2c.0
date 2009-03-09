From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Mon, 09 Mar 2009 15:13:16 +0100
Message-ID: <gp385s$a2i$1@ger.gmane.org>
References: <gngvea$eqj$1@ger.gmane.org>	<20090218173645.GD3049@pengutronix.de>	<gnjplc$hqd$1@ger.gmane.org>	<20090220135300.353cd53a@hyperion.delvare>	<go12jd$ec4$1@ger.gmane.org>	<20090225090002.2c31dbf1@hyperion.delvare>	<go5ta2$rtu$1@ger.gmane.org>	<20090226142854.2b6f72e4@hyperion.delvare>	<go8c65$o7g$1@ger.gmane.org> <20090305155713.46ac1968@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090305155713.46ac1968-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

I have now got a 2.6.28.7 Kernel to play with on my board.
I assume I have to patch some files to get the same play ground as you,
right? Could you give me the msgIds/links?

Jean Delvare said the following:
> Hi Michael,
(...)
>> > This is one of the 3 ways the new model can work, yes.
>>
>> And the other 2?
> 
> I wrote a document explaining the 3 available methods. I am attaching
> it to this mail. Please read it. If it is clear enough, I plan to add
> it to Documentation/i2c. If it's no clear enough, well, ask your
> additional questions and I'll try to improve the document.
> 
Reads good. I'll ack your post from today.

(...)
> I2C bus control (such as declaration of which devices are there)
> through sysfs doesn't exist today, but could be added for cases such as
> yours. I also can see the value of making mux drivers have a standard
> sysfs interface to disable some channels, to allow hot-plug scenarios
> such as yours. But I'd rather integrate Rodolfo's work as is first, and
> add features later. Even that promises to be slow...

I'm currently thinking about making a module that allows to trigger
probing of buses, something like
insmod i2cDevProbe.ko "modname",busNo,devNo
Could finally be integrated into subsystem if there are more folks that
like it.
-- 
Regards,
Michael
