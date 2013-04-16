From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v5 1/3] i2c: mux: Add i2c-arb-gpio-challenge 'mux' driver
Date: Tue, 16 Apr 2013 11:44:56 +0200
Message-ID: <87wqs2kdwn.fsf@dell.be.48ers.dk>
References: <1363192583-26363-1-git-send-email-dianders@chromium.org>
	<1365543270-10736-1-git-send-email-dianders@chromium.org>
	<20130416093633.GC16978@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130416093633.GC16978@the-dreams.de> (Wolfram Sang's message of
	"Tue, 16 Apr 2013 11:36:33 +0200")
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Doug Anderson <dianders@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Glass <sjg@chromium.org>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, grant.likely@secretlab.ca, yuvaraj.cd@gmail.com, ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de, broonie@opensource.wolfsonmicro.com, girish.shivananjappa@linaro.org, bhushan.r@samsung.com, sreekumar.c@samsung.com, prashanth.g@samsung.com, olof@lixom.net, djkurtz@chromium.org, swarren@wwwdotorg.org, linux@roeck-us.net, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Stephen Warren <swarren@nvidia.com>, Jean Delvare <khali@linux-fr.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <guenter.roeck@ericsson.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.orglinux-
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

Hi,

 >> +- their-claim-gpios: The GPIOs that the other sides use the claim the bus.
 >> +  Note that some implementations may only support a single other master.

 Wolfram> Stronger? "Currently, only one other master is supported"?

Also there's a typo: s/use the claim/use to claim/

-- 
Bye, Peter Korsgaard
