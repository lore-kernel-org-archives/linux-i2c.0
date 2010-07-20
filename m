From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 20 Jul 2010 11:58:09 +0200
Message-ID: <87bpa2jwzy.fsf@macbook.be.48ers.dk>
References: <1278285584-13632-1-git-send-email-peter.korsgaard@barco.com>
	<87fwzejz1v.fsf@macbook.be.48ers.dk>
	<20100720115005.3b3fa865@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100720115005.3b3fa865-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's
	message of "Tue, 20 Jul 2010 11:50:05 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

Hi,

 Jean> Michael and myself are in the process of adding core support for
 Jean> bus multiplexing to the i2c subsystem. There is no point in
 Jean> reviewing more specific implementations until the core part is
 Jean> merged (which is scheduled to happen in kernel 2.6.36.)

But this patch is independent from that work as the mux access isn't
through I2C, hence no changes to i2c-core needed.

Do you want me to resend or do you still have the original patch?

-- 
Bye, Peter Korsgaard
