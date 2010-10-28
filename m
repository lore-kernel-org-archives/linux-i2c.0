From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] I2C driver supporting Moorestown and Medfield platform
Date: Thu, 28 Oct 2010 09:58:57 +0100
Message-ID: <20101028085856.GL21564@trinity.fluff.org>
References: <20101027114205.11696.76731.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101027114205.11696.76731.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 27, 2010 at 12:44:03PM +0100, Alan Cox wrote:
> (Updated to address Ben's comments. With regard to the message segment
>  restriction it's not something we hit on the actual platform so while
>  I will investigate that further I don't think its a blocker to submission.
>  At worst its a spot over-restrictive)

ok, that's not so much of a problem. I'll add that to -next and then
look at pusing it at the end of the week.

-- 
Ben
