From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 23 Jan 2014 20:50:24 +0100
Message-ID: <201401232050.25134.arnd@arndb.de>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Matt Porter <matt.porter@linaro.org>, Matthew Locke <mlocke@codeaurora.org>, Wolfram Sang <wsa@the-dreams.de>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Grant Likely <grant.likely@linaro.org>, James Ralston <james.d.ralston@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Landley <rob@landley.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bill Brown <bill.e.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@>
List-Id: linux-i2c@vger.kernel.org

On Thursday 23 January 2014, Matthew Locke wrote:
> The QUP IP block is the same across chips.  Its possible there could be different versions of the IP block but its pretty stable now. 

Do you know the version numbers of the IP block? That would be the ideal case. We just
fall back to using the SoC name in most cases because that's all that is publically
known.

	Arnd
