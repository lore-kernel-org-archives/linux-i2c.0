From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mux-gpio: use deferred probing with the device tree
Date: Wed, 9 Oct 2013 08:14:25 +0200
Message-ID: <87vc17km2m.fsf@thor.barco.com>
References: <52540DF6.6050407@nsn.com> <20131008213642.GB29121@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131008213642.GB29121@katana> (Wolfram Sang's message of "Tue,
	8 Oct 2013 23:36:43 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "WS" == Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:

WS> On Tue, Oct 08, 2013 at 03:51:50PM +0200, Ionut Nicu wrote:
>> If the i2c-parent bus driver is not loaded, returning
>> -EINVAL will force people to unload and then reload the
>> module again to get it working.
>>
>> Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>

WS> Doesn't the non-DT case need fixing, too?

Arguably yes.

--
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
