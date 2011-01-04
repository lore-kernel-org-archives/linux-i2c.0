From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from PM
	operations
Date: Tue, 4 Jan 2011 23:10:21 +0000
Message-ID: <20110104231021.GA18024@sirena.org.uk>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4D23A839.6030205@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D23A839.6030205-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Abhijeet Dharmapurikar <adharmap-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 04, 2011 at 03:07:37PM -0800, Abhijeet Dharmapurikar wrote:
> Mark Brown wrote:

>> device op. The PM core provides pm_generic_ functions implementing this
>> behaviour - use them to reduce coupling with future PM updates.

> pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?

Yes, there's a patch in -next for this already so this patch would need
to either wait for later in the merge window or go in via the PM tree
with the preceeding one (the original version of this patch was posted
as part of a series with the export patch).
