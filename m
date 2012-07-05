From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c i.MX: Fix divider table
Date: Thu, 5 Jul 2012 23:36:27 +0530
Message-ID: <CAM=Q2csv3rEs-xseGd6NHxR3wRSZp82ZqNB1mn-_C4=5=nOc6g@mail.gmail.com>
References: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341493826-13861-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 5, 2012 at 6:40 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Measurements on i.MX1 and i.MX53 have shown that the divider values
> in the datasheets are wrong.
How were the measurements made?

> the values from first, third and fourth
> column were all measured to be 8 higher than in the datasheet. It
> should be safe to assume that the SoCs between i.MX1 and i.MX53 behave
> the same as the i2c unit is unchanged since the i.MX1.

Also does it vary board to board or is fixed by the ip?
What I mean is that the external cap etc.



>
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
