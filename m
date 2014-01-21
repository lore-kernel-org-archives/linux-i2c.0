From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
Date: Mon, 20 Jan 2014 18:40:07 -0800
Message-ID: <20140121024007.GE13785@codeaurora.org>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389999819-10648-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Matt Porter <matt.porter@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Grant Likely <grant.likely@linaro.org>, James Ralston <james.d.ralston@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bill Brown <bill.e.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

On 01/20, Rob Herring wrote:
> On Fri, Jan 17, 2014 at 5:03 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> 
> >  .../devicetree/bindings/i2c/qcom,i2c-qup.txt       | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
> > new file mode 100644
> > index 0000000..a99711b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
> > @@ -0,0 +1,41 @@
> > +Qualcomm Universal Peripheral (QUP) I2C controller
> > +
> > +Required properties:
> > + - compatible: Should be "qcom,i2c-qup".
> 
> Seems a bit generic. All versions of the IP are exactly the same?
> "qcom,<chip>-i2c-qup" would be better.
> 

There are different versions of the IP in different SoCs. The
versions for platforms supported upstream are:

	1.1.1 (MSM8660, MSM8960)
	2.2.1 (MSM8974v2)

so how about one of "qcom,i2c-qup-v1.1.1" or
"qcom,i2c-qup-v2.2.1" should be specified as more specific
compatible strings in addition to "qcom,i2c-qup"?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
