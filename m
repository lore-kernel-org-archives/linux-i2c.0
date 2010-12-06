From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Mon, 6 Dec 2010 17:56:50 +0000 (GMT)
Message-ID: <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com> <20101206173040.GA18372@ericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20101206173040.GA18372@ericsson.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Matt Turner <mattst88@gmail.com>, Jean Delvare <khali@linux-fr.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 6 Dec 2010, Guenter Roeck wrote:

> > From: Maciej W. Rozycki <macro@linux-mips.org>
> > 
> > This is a rewrite of large parts of the driver mainly so that it uses
> > SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> > As a part of the overhaul of the init and exit calls, all accesses to the
> > hardware got converted to use accessory functions via an ioremap() cookie.
> > 
> > Minimally rebased by Matt Turner.
> > 
> > Tested-by: Matt Turner <mattst88@gmail.com>
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> 
> I applied the patch to my 1480 tree. Unfortunately, it doesn't work with 
> my system. As far as I can see, the driver does not get any interrupts.
> 
> My tree is 2.6.32, though. Do you know if I might be missing some other 
> relevant patch ?

 As the original author I apologise for the lack of response about these 
changes -- I've had a really, really hectic time recently and will 
continue to suffer from that for several weeks yet at the very least.

 As to the patches -- these I submitted originally back in 2008 as a 
series.  There may have been more than one series actually, but I can't 
recall the details offhand.  There were some discussions and concerns 
about some of the patches which in the end I did not fully address owing 
to various disruptions and the lack of time, which is why they did not go 
in.  I do remember some bits about interrupt handling as the original 
implementation of the I2C host interface used polling only and I saw it as 
a gross inefficiency.  Obviously with all the bits in place they used to 
work at least for me.

 Matt, thanks for keeping your eye on these bits and reviving them; I've 
meant to do so for a long time now, but never came to it.  Please note 
however, as I'm the original author, my original Signed-off-by markups 
continue to apply and you should be quoting them with the submissions.  
You should only add your own Signed-off-by annotation if you made any 
changes and it would make sense to state what these changes were.

 I'll do my best to provide some aid with these bits, but won't be able to 
do anything but plain code review up till January at the very least, and 
then maybe not even that.  My SWARM board has been stuck with 2.6.27-ish 
for a long while now.  Sorry.

  Maciej
