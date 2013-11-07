From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [RESEND PATCH 2/4] i2c: i2c-bcm-kona: Add support for high-speed mode
Date: Thu, 7 Nov 2013 12:16:11 -0800
Message-ID: <CAAYSxhp6bY==tyHXCUz4zYVS+Nc=hDBscf_QBrkxwY28AOA=ig@mail.gmail.com>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
	<1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
	<20131101130835.GC6734@katana>
	<CAAYSxhrrkSvOJpYPz7txVsot1you3fFzkXJ6fqaS4OgRM0Z2gA@mail.gmail.com>
	<20131107201332.GA7119@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131107201332.GA7119@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Device Tree List <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 7, 2013 at 12:13 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> OK. Then please change the error message for unsupported bus speeds to
> contain the supported ones. I don't think it is good practice to force
> users to look into the sourcecode to find this information.

That works for me.  Thanks.

-Tim
