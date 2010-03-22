From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-pnx: Improvements and fixes
Date: Mon, 22 Mar 2010 10:09:11 -0700
Message-ID: <a08234131003221009j1ec74009jc2eb289386455b65@mail.gmail.com>
References: <1268780138-10019-1-git-send-email-wellsk40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268780138-10019-1-git-send-email-wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vitaly.wool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Vitaly,

Can you please ack these patches for the i2c-pnx driver? These are all
important changes for the i2c-pnx.

thanks,
Kevin

On Tue, Mar 16, 2010 at 3:55 PM,  <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> This patch set fixes a stop condition issue with transfers, caps
> the maximum computed divider generated from the parent clock,
> and disables the I2C peripheral clock when the I2C bus isn't in
> use (to save power).
>
> Patch 3 was previously posted a few months ago, but I didn't
> follow up on getting it into the driver.
>
> All code is tested on the lpc3250.
>
