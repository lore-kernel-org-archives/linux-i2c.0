From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
Date: Tue, 5 Feb 2013 16:23:41 -0800
Message-ID: <CAD=FV=W+rCOADrSYoP9wzXuq1ftLYqbbSUT1KKgEc7WfVMojMA@mail.gmail.com>
References: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <w.sang@pengutronix.de>, Grant Grundler <grundler@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Simon Glass <sjg@chromium.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, naveen krishna <ch.naveen@samsung.com>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-i2c@vger.kernel.org

Yavaraj,

On Mon, Feb 4, 2013 at 1:03 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>
> This RFC patch is w.r.t multimaster bus arbitration which is already
> being discussing in the mainline.
> This patch provides hooks for the i2c multimaster bus arbitration
> and to have the arbitration parameters.

I may have missed something in all the threads, but my recollection
was that the request was that this should be implemented without
touching the i2c core code.  Your patch modifies the i2c core code.

My impression was that the best solution was to use the infrastructure
in place for i2c multiplexing.  ...but in your case you would only
multiplex one thing.  This was suggested by Grant Likely and seems the
cleanest...


[apologies for double-email; darn gmail and HTML email]

-Doug
