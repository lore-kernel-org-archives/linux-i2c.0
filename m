From: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Tue, 7 Dec 2010 14:30:27 +0000 (GMT)
Message-ID: <alpine.LFD.2.00.1012070740130.17185@eddie.linux-mips.org>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com> <20101206173040.GA18372@ericsson.com> <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org> <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com> <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
 <20101207051438.GA20144@ericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101207051438.GA20144-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 6 Dec 2010, Guenter Roeck wrote:

> A quick look through sb1250 vs. sb1480 code shows that the 1480 uses different
> interrupt numbers. The patch assigns the sb1250 interrupt numbers, so unless
> I am missing something the code as written can not work for sb1480.

 That well could be -- I never had access to a BigSur board.  The 
board-specific interrupt numbers should either be available from the board 
manual (I haven't checked if one has been released; I certainly have one 
for my SWARM) or quoted somewhere in our tree.  Otherwise figuring them 
out by trial and error should be a trivial exercise for someone with 
actual hardware at hand.

  Maciej
