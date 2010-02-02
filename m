From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/highlander: remover superflous variable
Date: Tue, 2 Feb 2010 23:31:48 +0900
Message-ID: <20100202143148.GB9325@linux-sh.org>
References: <20100201101509.GB3288@pengutronix.de> <1265113063-22894-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1265113063-22894-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 02, 2010 at 01:17:43PM +0100, Wolfram Sang wrote:
> When cppcheck found this flaw
> 
> [./i2c/busses/i2c-highlander.c:284]: (style) Warning - using char variable in bit operation
> 
> it was noted that the 'read'-variable could just be removed as read_write can
> only be 0 or 1 anyhow. So, we remove the flaw by simplifying the code.
> 
> Reported-by: d binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Fine with me.

Acked-by: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
