From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 26 Sep 2013 08:04:09 +0300
Message-ID: <1380171849.4671.13.camel@localhost>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
	 <3A0F4153-1C55-4008-8EB1-D6FA60D87CEA@codeaurora.org>
	 <1377797186.30358.14.camel@localhost>
	 <767E9FBB-2975-4795-9C7E-69E302511FF2@codeaurora.org>
	 <1378814937.960.37.camel@iivanov-dev.int.mm-sol.com>
	 <20130910135907.GP808@joshc.qualcomm.com>
	 <1378824205.960.41.camel@iivanov-dev.int.mm-sol.com>
	 <20130925160606.GA3377@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130925160606.GA3377@katana>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Josh Cartwright <joshc@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, grant.likely@linaro.org, gavidov@codeaurora.org, sdharia@codeaurora.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Hi,

On Wed, 2013-09-25 at 18:06 +0200, Wolfram Sang wrote:
> > > I agree with Kumar on removing this.  If we decide it is something worth
> > > keeping, logic to support it doesn't belong in the QUP driver, but in
> > > the i2c core.
> > 
> > I don't have strong objection here, will remove aliases support.
> 
> When resubmitting, please test against v3.12-rcX.
> of_i2c_register_devices() is in the core meanwhile and alias support for
> of is in the core for a while, too. Check i2c_add_adapter().

Thanks, I will.

Regards,
Ivan
