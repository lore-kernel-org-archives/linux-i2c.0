From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Fri, 27 Mar 2009 14:13:32 +0100
Message-ID: <49CCD0FC.9030500@gmx.de>
References: <49CB43E0.2050503@gmx.de>	<49CCA82F.90106@gmx.de> <20090327134034.754908b5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090327134034.754908b5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> Hi Michael,
> 
> On Fri, 27 Mar 2009 11:19:27 +0100, Michael Lawnick wrote:
>> could you give it a look?
>> If you at least ACK the interface, I could do the patch for the
>> documentation.
> 
> Come on, which part of "this should be implemented in sysfs" did you
> not understand? I'm a little tired of you trying to implement it using
> _all_ other possible ways except the one we agreed on. If you need this
> feature faster than I can implement it, please stick to the plan and
> implement it using sysfs. If not, then just stay quiet and wait for it
> to happen.

Huh - don't bite me!

This step I wanted to discuss next:
AFAICS I2C subsystem doesn't implement any sysFs-entry itself. They are
all either from client or device-driver system. I not even dared to ask
for a comment to this before adding the feature on i2c-dev, a way that
does not change the visible interface.
I can't wait too long for implementation on sysFs. I'm ready to do it
now, if we agree on the place where to create the entries, naming and
interface.
What is your time line?
Naming IMHO should be probe/remove, parameters could be
"<client-name>,<id>" / "<id>", just as done in i2c-dev implementation,
if created per adapter.
But where to place?

-- 
*Kind* regards,
Michael
