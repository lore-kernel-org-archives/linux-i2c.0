From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
Date: Thu, 19 Apr 2012 23:18:39 +0200
Message-ID: <4F90812F.5090106@antcom.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de>
 <20120419160715.GD24987@pengutronix.de> <4F903E0C.6010604@antcom.de>
 <20120419203915.GB28005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120419203915.GB28005@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: srinivas.bakki@nxp.com, vitalywool@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, arm@kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org, kevin.wells@nxp.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi!

On 19/04/12 22:39, Wolfram Sang wrote:
>> If we have a solution soon, I will prepare a new version of the 
>> patch, of course, in the next days.
> 
> Thanks. One question, though: Will it really block dt-conversion? 
> The whole conversion should not be depending on the i2c-driver?

Technically, it would certainly be possible to convert some drivers
and leave others. But I would highly prefer to convert i2c also. With
LPC32xx, there are typically many I2C clients depending on DT on a
reasonable DT enabled mach.

I'm fine with "timeout" also, when you accept it into pnx-i2c.c and
will certainly provide a "timeout" patch update so you can pick the
version which suits best.

Another solution would be to not use timeout with the dt enabled
i2c-pnx for now (using the hard coded default timeout as the current
i2c-pnx.c does) and possibly introduce the (anyway optional) "timeout"
later.

Actually, that would be my favour.

What do you think?

>>> Did you change this, too? Timeouts are better readable in dec
>>> :)
>> 
>> Right. But even when removing the "0x" in the timeout line
>> above, it's still hex, see 
>> Documentation/devicetree/booting-without-of.txt
>> 
>> Or did I get sth. wrong?
> 
> I think the document is probably outdated :( "clock-frequency" is 
> also without 0x and dec.

Interesting! When the documentation is outdated - how does the parser
actually decide between hex (e.g. regs/addresses) and dec (e.g.
clock-frequency) in the absence of "0x"?

Thanks in advance,

Roland
