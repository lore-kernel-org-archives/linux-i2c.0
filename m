From: Frank Seidel <frank@f-seidel.de>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Sun, 08 Feb 2009 14:11:52 +0100
Message-ID: <498EDA18.1090300@f-seidel.de>
References: <498C3EEA.5060508@suse.de> <20090208000553.059a0732@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753534AbZBHNMd@vger.kernel.org>
In-Reply-To: <20090208000553.059a0732@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Frank Seidel <fseidel@suse.de>, linux kernel <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, ben-linux@fluff.org, linux-i2c@vger.kernel.org, w.sang@pengutronix.de, "David S. Miller" <davem@davemloft.net>, ukleinek@informatik.uni-freiburg.de, Frans Pop <elendil@planet.nl>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

Jean Delvare wrote:
>> +	printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n"
>>  	       "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
>>  	for (i = 0; i < i2c->irqlogidx; i++)
>>  		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
> 
> This last printk also lacks a log level. You can't add it in the loop,
> but you could add one printk before the loop, printing just the log level.

Isn't the last printk just a followup of the previous KERN_ERR which
doesn't have a newline? And i'm told only on new line beginnings the
loglevel should be set.

> I second Uwe's comments: it would be much better to add the log level
> in the DEBx macros. Additionally, some discussion is needed as to what
> log level would be appropriate. You put KERN_WARNING for all but some
> of these messages are clearly debugging messages. As a matter of fact,
> DEBx macros are all about debugging.
> 
> So I think that a good patch would 1* add KERN_DEBUG to the DEBx macros
> and 2* check for all usage of these DEBx macros and turn all messages
> which aren't actual debug messages to raw printks. As this will require
> some more work, you may want to split these changes off your initial
> patch.

Ok, i fully agree with you. So, i'll redo the patch asap.

Thanks for your feedback,
Frank
