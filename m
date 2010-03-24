From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]I2C device - release cleanup
Date: Wed, 24 Mar 2010 14:16:58 +0100
Message-ID: <20100324141658.382209c3@hyperion.delvare>
References: <20100323172143.6b078b2e@hyperion.delvare>
	<0016e6d977228ec35704827c94c6@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0016e6d977228ec35704827c94c6-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 23 Mar 2010 19:11:26 +0000, jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > Yes, that would be better. If you do that, please make sure to run your
> 
> > patch through scripts/checkpatch.pl before sending it.
> 
> I will take the time to do it. I can't say when :p.
> I did run checkpatch.pl, and I can't remove the 3 "trailing whitespace"  
> errors...

You'll have to, otherwise I won't apply your patches (nobody will).

> Plus the fact that gmail is changing tabs and spaces...

Check the options. At least attaching the patch should work. Or you can
use a "real" e-mail client for sending patches.

-- 
Jean Delvare
