From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mux-gpio: Change log level to debug for probe deferrals
Date: Wed, 25 Mar 2015 20:48:09 +0100
Message-ID: <87wq24zwna.fsf@thor.barco.com>
References: <20150325174351.GB5209@ulegcpding.emea.nsn-net.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150325174351.GB5209-w/hiR2Wfoz+b6vRP15A4uhaOaYmgohGe0e7PPNI6Mm0@public.gmane.org> (Ioan Nicu's
	message of "Wed, 25 Mar 2015 18:43:51 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ioan Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mathias Rulf <mathias.rulf-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "IN" == Ioan Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org> writes:

IN> Probe deferral is not an error case. It happens only when
IN> the necessary dependencies are not there yet.

IN> The driver core is already printing a message when a driver
IN> requests probe deferral, so this can be traced in the logs
IN> without these error prints.

IN> This patch changes the error messages from these deferral cases
IN> to debug messages.

IN> Signed-off-by: Ionut Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

--
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
