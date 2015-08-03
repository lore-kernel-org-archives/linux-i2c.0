From: Robert Abel <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: Xilinx IIC: add DT Endianness support
Date: Mon, 3 Aug 2015 09:46:21 +0200
Message-ID: <CAMdRc4ED6YcuAitpDPR+eSp9+5uK0sSfO3GvLtYvo+NbuK=KwQ@mail.gmail.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1438344034-20211-8-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<55BEFCE5.70109@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BEFCE5.70109-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michal,

On Mon, Aug 3, 2015 at 7:32 AM, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> NACK for this. Previous driver version did automatic detection directly
> on the IP. You are changing it to be OF driven with is error prone and
> highly depends on user.

I beg do differ. Using the appropriate dt binary attributes is not
error prone. On the contrary, it gives the user much tighter control.

I find the solution I replaced more of a hack than anything. It writes
to reserved bits, which -- while unlikely -- might become used in
future versions of this IP.
If there was some fixed identification register, sure, this might be okay.

If you want to retain this functionality, we might put it in using
another CONFIG_I2C_XILINX_XXX option. How's that?

Regards,

Robert
