From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 23 Jan 2014 12:22:12 -0800
Message-ID: <CAJAp7OhvFdC2OR_YO5Gh6x1q8TPWEDY58d-BQ5jw=B=31i5V2w@mail.gmail.com>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389999819-10648-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
 <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthew Locke <mlocke@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Matt Porter <matt.porter@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Grant Likely <grant.likely@linaro.org>, James Ralston <james.d.ralston@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Landley <rob@landley.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bill Brown <bill.e.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>linu
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 23, 2014 at 11:11 AM, Matthew Locke <mlocke@codeaurora.org> wrote:
> Rob,
>
> On Jan 20, 2014, at 8:10 AM, Rob Herring wrote:
>
>> On Fri, Jan 17, 2014 at 5:03 PM, Bjorn Andersson
[...]
>>> +Required properties:
>>> + - compatible: Should be "qcom,i2c-qup".
>>
>> Seems a bit generic. All versions of the IP are exactly the same?
>> "qcom,<chip>-i2c-qup" would be better.
>
> The QUP IP block is the same across chips.  Its possible there could be different versions of the IP block but its pretty stable now.

I have not been able to find any differences in this block between
8960 and 8074 and I have successfully tested the driver on both
platforms.

So the reason for making it more specific would be to handle any
future crazyness. Not sure what to do about this though, I have never
heard about the version numbers Stephen gave us and I can't find them
in the documentation available to us, so I wouldn't know which of the
two to select...

Regards,
Bjorn
