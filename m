From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 2/2] i2c: New bus driver for the QUP I2C controller
Date: Thu, 16 Jan 2014 16:33:14 -0800
Message-ID: <20140117003314.GB13785@codeaurora.org>
References: <1389659437-16406-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389659437-16406-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20140115164604.GI14405@codeaurora.org>
 <20140117001833.GL30911@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140117001833.GL30911@sonymobile.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Matt Porter <matt.porter@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, James Ralston <james.d.ralston@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Landley <rob@landley.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bill Brown <bill.e.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>"linux-kernel@vger.kernel.org" <linux->
List-Id: linux-i2c@vger.kernel.org

On 01/16, Bjorn Andersson wrote:
> On Wed 15 Jan 08:46 PST 2014, Stephen Boyd wrote:
> 
> > On 01/13, Bjorn Andersson wrote:
> > > +
> > > +static int
> > > +qup_i2c_poll_state(struct qup_i2c_dev *qup, u32 req_state, bool only_valid)
> > > +{
> > > +	int retries = 0;
> > > +	u32 state;
> > > +
> > > +	do {
> > > +		state = readl(qup->base + QUP_STATE);
> > > +
> > > +		/*
> > > +		 * If only valid bit needs to be checked, requested state is
> > > +		 * 'don't care'
> > > +		 */
> > 
> > It looks like req_state == 0 means only_valid == true. Can we
> > drop the only_valid argument to this function?
> > 
> 
> In all cases but the reset in the beginning of qup_i2c_xfer, so it seems that
> it has to stay.

Oh that's because QUP_RESET_STATE is equal to 0? It looks like
bits 0 and 1 are the state field and bit 2 is a flag indicating
that bits 0 and 1 are valid. Why not OR in the QUP_STATE_VALID
flag into the macros that are passed to this function? Then the
logic would simply be looping looking for a match of the
req_state (which is really a mask now).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
