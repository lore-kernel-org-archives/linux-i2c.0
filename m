From: srinivas kandagatla <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Thu, 17 Oct 2013 10:33:33 +0100
Message-ID: <525FAEED.7030207@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <525F915D.9020501@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime COQUELIN <maxime.coquelin@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Stephen GALLIMORE <stephen.gallimore@st.com>, Stuart MENEFY <stuart.menefy@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 17/10/13 08:27, Maxime COQUELIN wrote:
> ...
>>> >> +
>>> >> +static struct of_device_id st_i2c_match[] = {
>>> >> +     { .compatible = "st,comms-ssc-i2c", },
>> > the rules is to put the first soc that use the ip in the compatible
>> > as st,sti7100-scc-i2c
> Ok. There are no plans to upstream the SH4 platforms, it will only 
> remains in stlinux.com.
> Maybe I can set the first ARM platform (STiH415)?
> That would give st,stih415-ssc-i2c.
NAK, for st,stih415-ssc-i2c naming.

IMO, this makes sense when the same IP integration done on different SOC
changes slightly/very differently.

But in this case the "comms" IP remains unchanged across all the SOCs.

I would still prefer "st,comms-ssc-i2c", allowing a single device driver
to match against several SoCs. ST "comms" IP it is integrated across all
the STi series of SoCs, so we don't want to add new entry in compatible
for every new SOC.


Thanks,
srini

> 
> Thanks for the review,
> Maxime
> 
>> >
