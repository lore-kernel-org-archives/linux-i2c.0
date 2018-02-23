From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Date: Fri, 23 Feb 2018 08:52:20 +0100
Message-ID: <CAMRc=MdE_LX276mjXCHaNgAthKyzaKPW-eWBfEuCcG187X7wvQ@mail.gmail.com>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato>
 <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
 <20180221094009.2zql6gbzkcklbakk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180221094009.2zql6gbzkcklbakk@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

2018-02-21 10:40 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
>> one? It's part of a bigger series, do you want me to apply it to my
>> tree and provide you with an immutable branch?
>
> Well, I would accept it for 4.16 using the "plain new id" rule. So, if
> you add it on top of Peter's sorting patch, totally fine by me.
>
> If you want it in v4.17, ok, too. I'd think an immutable branch is not
> needed. There is a fallback property in the DTS. So at worst, there will
> be a DTS warning during the merge window which will be fixed at rc1 time.
>
> Unless I overlooked something.
>

Ok, I'll have some time during the weekend, so I'll send a PR for rc3.

Bart
