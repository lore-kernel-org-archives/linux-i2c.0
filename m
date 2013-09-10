From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/5] i2c: rcar: get clock rate only once and simplify calculation
Date: Wed, 11 Sep 2013 07:37:37 +0900
Message-ID: <CANqRtoRF8CD4hO4m23dqAtNCKvAqHo-+JhZud43SYePB4w5Ong@mail.gmail.com>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
	<1378742120-11135-3-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1378742120-11135-3-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> There is no need to repeatedly query clock frequency, where it is not
> expected to change. The complete loop can also trivially be replaced with
> a simple division. A further loop below the one, being simplified, could
> also be replaced, but that would get more complicated.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks for your efforts. What makes you think that you should assume
that the clock frequency doesn't change?

As you already know, we want drivers to be reusable across multiple
SoCs. Assuming it that it would be fixed based on one particular SoC
doesn't guarantee that that's the case on other SoCs. Which SoCs did
you take into consideration?

Thanks,

/ magnus
