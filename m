From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C driver supporting Moorestown and Medfield platform
Date: Tue, 26 Oct 2010 10:08:00 +0200
Message-ID: <20101026100800.017c5aaa@endymion.delvare>
References: <20101022140431.3545.37799.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101022140431.3545.37799.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 22 Oct 2010 15:05:30 +0100, Alan Cox wrote:
> I think this now addresses all the points raised in previous review, as well
> as adding runtime power management support which is needed for MID
> platforms.

Ben, this driver has been floating around for quite some time, I think
we really want to have it in kernel 2.6.37. This is for an embedded
system so it would be one for you to merge, however if you can't make
it on time (where "on time" is "by the end of the week" aka "before
Sunday October 31st, 2010") , please let me know and I will take care.
At least I can build this one ;)

Thanks,
-- 
Jean Delvare
