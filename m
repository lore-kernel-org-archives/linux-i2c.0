From: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Thu, 19 Jul 2012 22:01:08 +0100 (BST)
Message-ID: <alpine.LFD.2.00.1207160208570.12288@eddie.linux-mips.org>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com> <20110903103036.161616a5@endymion.delvare> <20111031105354.4b888e44@endymion.delvare> <20120110153834.531664db@endymion.delvare> <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
 <20120331082346.26cc95cb@endymion.delvare> <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com> <CAEdQ38EDKndUcdBu1tZ_dOuhweVRW6aA=YKb6kUE3gUQJiwWoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEdQ38EDKndUcdBu1tZ_dOuhweVRW6aA=YKb6kUE3gUQJiwWoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 30 Jun 2012, Matt Turner wrote:

> I'm not going to have time to do this. :(
> 
> I had another look at the code, and I'm not sure I really understand
> it well enough to address your concerns.

 I'll try then, as soon as I can.

> Good thing there are only about three users with this motherboard.

 Really?  I've thought Debian used them for MIPS distribution builds if 
nobody else.  AFAIK, ten years on and these systems (I mean the whole 
family) are still about the only ones reasonably widely available that 
provide performance decent enough for native use these days (yes, I did 
make serious use of an R3k DECstation natively once -- waiting for a GCC 
bootstrap to complete after the expected four weeks of computing time only 
to see it choke on a Makefile typo three weeks into was all but fun).

  Maciej
