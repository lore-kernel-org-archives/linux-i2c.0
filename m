From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mux-gpio: use deferred probing
Date: Wed, 9 Oct 2013 12:14:13 +0200
Message-ID: <87mwmilpje.fsf@thor.barco.com>
References: <525526F5.5030107@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525526F5.5030107-OYasijW0DpE@public.gmane.org> (Ionut Nicu's message of "Wed, 9 Oct
	2013 11:50:45 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "IN" == Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org> writes:

IN> If the i2c-parent bus driver is not loaded, returning
IN> -ENODEV will force people to unload and then reload the
IN> module again to get it working.

IN> Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

--
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
