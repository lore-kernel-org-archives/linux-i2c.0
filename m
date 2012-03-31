From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Sat, 31 Mar 2012 08:23:46 +0200
Message-ID: <20120331082346.26cc95cb@endymion.delvare>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
	<20110903103036.161616a5@endymion.delvare>
	<20111031105354.4b888e44@endymion.delvare>
	<20120110153834.531664db@endymion.delvare>
	<CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 12 Jan 2012 16:19:49 -0500, Matt Turner wrote:
> On Tue, Jan 10, 2012 at 9:38 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Mon, 31 Oct 2011 10:53:54 +0100, Jean Delvare wrote:
> >> On Sat, 3 Sep 2011 10:30:36 +0200, Jean Delvare wrote:
> >> > Please address my concerns where you agree and send an updated patch.
> >>
> >> Matt, care to send an updated patch addressing my concerns? Otherwise
> >> it will be lost again.
> >
> > It's been 3 more months. Matt (or anyone else who cares and has access
> > to the hardware), please send an updated patch or I'll have to drop it.
> 
> I'll fix it up and resend the next time I'm working on the related mips stuff.
> 
> It's hard to prioritize volunteer work for hardware you and two other
> people have. :)

Matt, Maciej, does any of you have an updated patch ready by now? If I
don't receive anything by the end of April I'll just drop it.

-- 
Jean Delvare
