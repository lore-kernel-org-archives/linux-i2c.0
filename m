From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mux-gpio: don't ignore of_get_named_gpio errors
Date: Tue, 8 Oct 2013 16:46:29 +0200
Message-ID: <877gdnn7lm.fsf@thor.barco.com>
References: <52540DF9.3050802@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52540DF9.3050802-OYasijW0DpE@public.gmane.org> (Ionut Nicu's message of "Tue, 8 Oct
	2013 15:51:53 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "IN" == Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org> writes:

IN> of_get_named_gpio could return -E_PROBE_DEFER or another
IN> error code. This error should be passed further instead
IN> of being ignored.

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

--
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
