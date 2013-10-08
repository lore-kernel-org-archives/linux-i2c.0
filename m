From: Peter Korsgaard <peter.korsgaard@barco.com>
Subject: Re: [PATCH] i2c-mux-gpio: use deferred probing with the device tree
Date: Tue, 8 Oct 2013 15:30:49 +0200
Message-ID: <87ob6znb3q.fsf@thor.barco.com>
References: <52540692.9080208@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52540692.9080208@nsn.com> (Ionut Nicu's message of "Tue, 8 Oct
	2013 15:20:18 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Ionut Nicu <ioan.nicu.ext@nsn.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nsn.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "IN" == Ionut Nicu <ioan.nicu.ext@nsn.com> writes:

IN> If the i2c-parent bus driver is not loaded, returning
IN> -EINVAL will force people to unload and then reload the
IN> module again to get it working.

IN> Also of_get_named_gpio could return -E_PROBE_DEFER or
IN> another error code. This error should be passed further
IN> instead of being ignored.

Two different fixes, so should be 2 separate patches. Other that that,
it looks good.

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

--
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
