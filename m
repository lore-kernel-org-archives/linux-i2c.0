From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PROBLEM: modprobe hang at startup (3.8.x, 3.9.x, IBM x3550)
Date: Fri, 17 May 2013 11:47:04 +0200
Message-ID: <20130517114704.442f1368@endymion.delvare>
References: <1368408152.29197.140661229821177.2C1CC406@webmail.messagingengine.com>
	<20130514231626.GA12961@pyro.melbourne.osa>
	<20130515112044.753bb7bb@endymion.delvare>
	<20130515112741.GA23766@pyro.melbourne.osa>
	<20130515214923.036dabdb@endymion.delvare>
	<20130516034455.GA19452@pyro.melbourne.osa>
	<20130517103622.5000d277@endymion.delvare>
	<5195F6C9.5050200@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5195F6C9.5050200-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Mokrejs <mmokrejs-08dBlVkRsZWoiTQjSSYKZesEoJ4y9sgM@public.gmane.org>
Cc: Robert Norris <robn-4vTceeIZeJ0AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 17 May 2013 11:22:17 +0200, Martin Mokrejs wrote:
> Hi,
>   while you are chasing some problem with i2c_801 I would like to mention
> that I never got an answer on the thread https://lkml.org/lkml/2013/1/23/405
> about a kmemleak reported by kernel . Maybe this could give you a hint?
> If these do not overlap I would be anyways glad to receive an answer via
> the original thread I have started.
> Thank you,
> Martin

I have no clue what the problem is nor how to investigate it, and in
fact I strongly suspect that this is either a false positive or a
problem in lower layers - driver core, sysfs etc. so nothing I can help
with.

So until someone comes with an evidence that there is an actual memory
leak in the i2c-i801 driver itself I'm not going to pay any attention
to your report, sorry.

-- 
Jean Delvare
