From: Robert Abel <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: Re: [PATCH 5/6] i2c: Xilinx IIC: make reset after TX error configurable
Date: Mon, 3 Aug 2015 09:50:58 +0200
Message-ID: <CAMdRc4F__S-dQOOsZv0pUtER5+-kwH=Mt+wfanvJXHWqS=YRMA@mail.gmail.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1438344034-20211-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<55BEFD63.6090108@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BEFD63.6090108-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michal,

On Mon, Aug 3, 2015 at 7:34 AM, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> Datasheet? version.
>
> Make it DT configurable.

I'm not sure what you're asking here. This errata isn't covered by any
datasheets and I don't have the time to confirm whether it actually
exists.
I'm thinking it might have been an issue with the old ISR and not the
IP itself (it works fine in simulation when I cause a TX error, then
transmit only SLA afterwards).
I cannot test exhaustively on hardware right now, as I'm not able to
monitor the bus directly on my development platform.

Because of the above 'hunch', I didn't make this DT configurable,
because I feel either the bug is present and thus the code should
always be run, or the bug doesn't exist.
I don't think it depends on the hardware device, so hence no DT binding.

Regards

Robert
